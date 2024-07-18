/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240429@Tacy
	Task: Exchange - Insert new actionID into table LogAction [redmine:#201239]
	DB: DBLOG.bodb_CustomerLog 
*/
USE bodb_CustomerLog
GO

INSERT INTO LogAction 
		(ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
VALUES (256,2,N'Acc_Dep_CustSetting_ChargeCommUpd',N'Update Exchange Product Commission For Deposit Customers By Admin',N'Update Exchange Product Commission For Deposit Customers By Admin',N'Update Exchange Product Commission For Deposit Customers By Admin',N'Update Exchange Product Commission For Deposit Customers By Admin',N'Update Exchange Product Commission For Deposit Customers By Admin',N'Update Exchange Product Commission For Deposit Customers By Admin',1,'Update Exchange Product Commission For Deposit Customers By Admin')
	 , (487,1,N'Acc_Dep_CustSetting_ChargePTUpd',N'Update Position Taking DCS Producs For Deposit Customers By Admin',N'Update Position Taking DCS Producs For Deposit Customers By Admin',N'Update Position Taking DCS Producs For Deposit Customers By Admin',N'Update Position Taking DCS Producs For Deposit Customers By Admin',N'Update Position Taking DCS Producs For Deposit Customers By Admin',N'Update Position Taking DCS Producs For Deposit Customers By Admin',1,'Update Position Taking DCS Producs For Deposit Customers By Admin')
	 , (488,1,N'Acc_Dep_LicenseeSetting_ChargePTUpd',N'Update Position Taking DCS Products for Licensee Customers by LA',N'Update Position Taking DCS Products for Licensee Customers by LA',N'Update Position Taking DCS Products for Licensee Customers by LA',N'Update Position Taking DCS Products for Licensee Customers by LA',N'Update Position Taking DCS Products for Licensee Customers by LA',N'Update Position Taking DCS Products for Licensee Customers by LA',1,'Update Position Taking DCS Products for Licensee Customers by LA')

GO
