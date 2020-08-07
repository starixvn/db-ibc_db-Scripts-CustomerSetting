/*
	Created: 20200803@Johnson
	Task: EXT - Arrange sub account for headline	
*/

--step 1: run this script to create structure 
--on DBPOL-NAP_UserControl
ALTER TABLE eaGroup ADD ParentID INT
GO

--step 2: run this script on DBLOG/bodb_CustomerLog for log action
INSERT INTO [bodb_CustomerLog].[dbo].[LogAction]
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
SELECT 95031, 4, 'EAS_CustomerUpdSubGroup', 'Assign Super to Sub Group', 'Assign Super to Sub Group', 'Assign Super to Sub Group', 'Assign Super to Sub Group', 'Assign Super to Sub Group', 'Assign Super to Sub Group', 'Assign Super to Sub Group', NULL, 1, 'Assign Super to Sub Group', 'Assign Super to Sub Group'

