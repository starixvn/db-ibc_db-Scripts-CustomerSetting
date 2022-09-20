﻿﻿/* <info serverAlias="DBLOG-bodb_CustomerLog"></info> */
/*
	Created: 20220920@Eden
	Task: Create log action [#RedmineID:#175297]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE ActionID BETWEEN 2219 AND 2220
--Insert data
DECLARE @Log TABLE ( 
		  ActionID INT
		, ActionNameEN NVARCHAR(256)
		, SPName VARCHAR(50)
	)
DECLARE @ActionTypeID INT = NULL, @IsInternal BIT = 1

INSERT INTO @Log (ActionID, SPName, ActionNameEN)
SELECT 2219,'Dot_Dep_CreateLicensee','Create Licensee parameter output' UNION ALL
SELECT 2220,'Dot_Dep_CreateCurrencyLicensee','Create Currency parameter output'
 
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN,  ActionNameEN,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID BETWEEN 2219 AND 2220
GO

