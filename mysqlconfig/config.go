package mysqlconfig

import (
	"database/sql/driver"
	"time"
	"encoding/json"
)


// job存储job信息
// target存储具体的target，关联group_id

type Target struct {
	ID        uint      `gorm:"primary_key"`
	CreatedAt time.Time `json:"create_at"`
	UpdatedAt time.Time `json:"update_at"`

	Target   string `gorm:"type:varchar(200);not null" json:"target"`
	Labels   JSON   `sql:"type:json" json:"type"`
	GroupId  int    `gorm:"type:integer;not null" json:"group_id"`
	Describe string `gorm:"type:varchar(200);not null" json:"describe"`
}

func (self *Target) TableName() string {
	return "target"
}

type Job struct {
	ID        uint      `gorm:"primary_key"`
	GroupId  int    `gorm:"primary_key;type:integer;not null" json:"group_id"`
	CreatedAt time.Time `json:"create_at"`
	UpdatedAt time.Time `json:"update_at"`

	Name         string `gorm:"type:varchar(200);not null" json:"name"`
	MetricsPath  string `gorm:"type:varchar(200);not null" json:"metrics_path"`
	Scheme       string `gorm:"type:varchar(200);not null" json:"scheme"`
	Interval     int    `gorm:"type:integer;not null" json:"interval"`
	Timeout      int    `gorm:"type:integer;not null" json:"timeout"`
	Describe     string `gorm:"type:varchar(200);not null" json:"describe"`
	AuthUser     string `gorm:"type:varchar(200)" json:"auth_user"`
	AuthPassword string `gorm:"type:varchar(200)" json:"auth_password"`
	AuthToken    string `gorm:"type:varchar(200)" json:"auth_token"`
}

func (self *Job) TableName() string {
	return "job"
}



type JSON struct {
	Key string `json:"key"`
	Values string `json:"value"`
}

func (c JSON) Value() (driver.Value, error) {
	b, err := json.Marshal(c)
	return string(b), err
}

func (c *JSON) Scan(input interface{}) error {
	return json.Unmarshal(input.([]byte), c)
}

