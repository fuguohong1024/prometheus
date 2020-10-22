package rules


import (
"time"
)




type AlertRule struct {
	ID        uint `gorm:"primary_key"`
	CreatedAt time.Time
	UpdatedAt time.Time
	Group       string    `json:"group,omitempty"`   // 存储报警规则的组名
	Alert       string    `json:"alert,omitempty"`  // 存储报警规则的名称
	Expr        string    `json:"expr,omitempty"`  // 存储报警规则的表达式
	For         int    `json:"for,omitempty"` // 存储报警规则的延迟时间
	Labels      string `gorm:"type:varchar(200)" json:"labels,omitempty"`// 存储报警规则的label
	Annotations string `gorm:"type:varchar(200)" json:"annotations,omitempty"` // 存储报警规则的注释
}

func (self *AlertRule) TableName() string {
	return "alert_rule"
}