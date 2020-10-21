package mysqlconfig

import (
	"fmt"
	config_util "github.com/prometheus/common/config"
	"github.com/prometheus/common/model"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	"github.com/prometheus/prometheus/config"
	//"github.com/prometheus/prometheus/config"
	sd_config "github.com/prometheus/prometheus/discovery/config"
	"github.com/prometheus/prometheus/discovery/targetgroup"
	"time"
)

func Sqltarget(conf *config.Config,db_user,db_pwd,db_host,db_port,db_db string)error{
	//初始化数据库连接
	db_url:=fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=true&loc=Local",db_user,db_pwd,db_host,db_port,db_db)
	conn, err := gorm.Open("mysql", db_url)
	defer conn.Close()
	if err != nil {
		return err
	}
	var jobs []Job
	// 获取所有的JOB
	err = conn.Model(&Job{}).Scan(&jobs).Error
	if err != nil {
		panic(err)
	}
	for _, job := range jobs {
		var targets []Target
		// 获取指定job所包含的targets
		err = conn.Model(&Target{}).Where("group_id = ?", job.GroupId).Scan(&targets).Error
		if err != nil {
			panic(err)
		}
		var targetgroups = []*targetgroup.Group{}
		for _, target := range targets {
			var labels model.LabelSet = map[model.LabelName]model.LabelValue{}
			key := model.LabelName(target.Labels.Key)
			value := model.LabelValue(target.Labels.Values)
			labels[key] = value
			/*r := strings.NewReader(target.Labels)
			scanner  := bufio.NewScanner(r)
			for scanner.Scan() {
				nameParts := strings.Fields(scanner.Text())
				i := 1
				key := model.LabelName(nameParts[i])
				value := model.LabelValue(nameParts[i+1])
				labels[key] = value
			}*/
			targetgroups = append(targetgroups, &targetgroup.Group{
				Targets: []model.LabelSet{
					model.LabelSet{
						"__address__": model.LabelValue(target.Target),
					},
				},
				Labels: labels,
				Source: fmt.Sprint(target.ID),
			})
		}
		//生成对应组的scrapeConfig
		scrapeConfig := &config.ScrapeConfig{
			JobName:        job.Name,
			Scheme:         job.Scheme,
			ScrapeInterval: model.Duration(time.Duration(job.Interval) * time.Second),
			ScrapeTimeout:  model.Duration(time.Duration(job.Timeout) * time.Second),
			MetricsPath:    job.MetricsPath,
			HTTPClientConfig: config_util.HTTPClientConfig{
				TLSConfig: config_util.TLSConfig{
					InsecureSkipVerify: true,
				},
			},
			ServiceDiscoveryConfig: sd_config.ServiceDiscoveryConfig{
				StaticConfigs: targetgroups,
			},
		}
		//生成对应组的scrapeConfig的认证方式
		if job.AuthUser != "" && job.AuthPassword != "" {
			scrapeConfig.HTTPClientConfig.BasicAuth = &config_util.BasicAuth{
				Username: job.AuthUser,
				Password: config_util.Secret(job.AuthPassword),
			}
		} else if job.AuthToken != "" {
			scrapeConfig.HTTPClientConfig.BearerToken = config_util.Secret(job.AuthToken)
		}
		conf.ScrapeConfigs = append(conf.ScrapeConfigs, scrapeConfig)
	}
	return nil
}