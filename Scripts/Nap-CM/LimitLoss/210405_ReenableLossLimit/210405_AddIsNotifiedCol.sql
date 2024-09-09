/*<info serverAlias="DBAGE-bodb_Age"></info>*/
/*
	Created by: Elodie
	Date: 20240905
	Task: Add IsNotified Col in LimitLoss_Setting, LimitLoss_HeadlineSetting [Redmine:#210405]	
*/
USE bodb_Age
GO

ALTER TABLE LimitLoss_Setting ADD IsNotified BIT NULL
GO
ALTER TABLE LimitLoss_HeadlineSetting ADD IsNotified BIT NULL


