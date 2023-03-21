
    
/*
	Created: Helios@20230310
	Task: Initial New Data LogActionID 95085 [RM:#181791]
	DB: DBLOG/bodb_CustomerLog

	Revisions:
		- 20230310@Helios: Initial New Data LogActionID [redmine:#184858]
*/

use bodb_CustomerLog

INSERT INTO [dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT 95085 , 4 , 'Age_CustLanguageUsageUpd' , 'Update Display Language', 'Update Display Language', 'Update Display Language', 'Update Display Language', 'Update Display Language', 'Update Display Language', 'Update Display Language', NULL , 0, 'Update Display Language', 'Update Display Language' 

    
