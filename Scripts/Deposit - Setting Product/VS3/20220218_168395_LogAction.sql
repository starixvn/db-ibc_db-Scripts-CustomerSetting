/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Winfred
	Date: 20220221
	Task: Insert new LogAction Integration for Cash Redmine: 168395
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO


USE bodb_CustomerLog
GO
DELETE FROM LogAction WHERE SPName IN ('Acc_Dep_CustSetting_NewBetLimitUpd') AND ActionID IN (2048,394)
GO
INSERT INTO LogAction (ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI, IsInternal)
VALUES (2048,3,'Acc_Dep_CustSetting_NewBetLimitUpd'
		,'Update New Bet Settings for Deposit Customers for DCS Products'
		,'Update New Bet Settings for Deposit Customers for DCS Products'
		,'Update New Bet Settings for Deposit Customers for DCS Products'
		,'Update New Bet Settings for Deposit Customers for DCS Products'
		,'Update New Bet Settings for Deposit Customers for DCS Products'
		,'Update New Bet Settings for Deposit Customers for DCS Products'
		,0
		,'Update New Bet Settings for Deposit Customers for DCS Products'
		,0
		)
GO
INSERT INTO LogAction (ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI, IsInternal)
VALUES (220020,3,'Acc_Dep_CustSetting_NewBetLimitFullLineUpd'
		,'Update New Bet Settings DCS Products for Deposit Customers by Admin'
		,'Update New Bet Settings DCS Products for Deposit Customers by Admin'
		,'Update New Bet Settings DCS Products for Deposit Customers by Admin'
		,'Update New Bet Settings DCS Products for Deposit Customers by Admin'
		,'Update New Bet Settings DCS Products for Deposit Customers by Admin'
		,'Update New Bet Settings DCS Products for Deposit Customers by Admin'
		,0
		,'Update New Bet Settings DCS Products for Deposit Customers by Admin'
		,1
		)
GO
