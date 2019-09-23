
/*
	Created: Winnie	
	Task:  Insert LogAction
	DB: DBLOG/bodb_CustomerLog
	Date: 20190919
*/ 
INSERT INTO bodb_CustomerLog.dbo.LogAction
           (ActionID
           ,ActionTypeID
           ,SPName
           ,ActionNameEN
           ,ActionNameCH
           ,ActionNameCS
           ,ActionNameJP
           ,ActionNameIT
           ,ActionNameTH
           ,ActionNameKO
           ,XsltContent
           ,IsInternal
           ,ActionNameVI)
     VALUES
           (2215
           ,NULL
           ,'Acc_Dep_CustomerInsLicenseeSubsidiary'
           ,'Create Licensee Subsidiary'
           ,'Create Licensee Subsidiary'
           ,'Create Licensee Subsidiary'
           ,'Create Licensee Subsidiary'
           ,'Create Licensee Subsidiary'
           ,'Create Licensee Subsidiary'
           ,'Create Licensee Subsidiary'
           ,'Create Licensee Subsidiary'
           ,0
           ,'Create Licensee Subsidiary')
GO

