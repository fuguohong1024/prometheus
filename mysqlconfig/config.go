package mysqlconfig

import (
	"time"
)


// job存储job信息
// target存储具体的target，关联group_id

type Target struct {
	ID        uint      `gorm:"primary_key"`
	CreatedAt time.Time `json:"create_at"`
	UpdatedAt time.Time `json:"update_at"`

	Target   string `gorm:"type:varchar(200);not null" json:"target"`
	Labels   string  `gorm:"type:varchar(200)" json:"labels"`
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

