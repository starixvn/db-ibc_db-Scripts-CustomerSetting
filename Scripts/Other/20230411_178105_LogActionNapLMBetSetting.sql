/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230224@Winfred
	Task: Log Action - Enhance Bet Setting function for AM to use [#RM:178105]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

DELETE FROM LogAction where ActionID BETWEEN 5574 AND 5575
--Insert data
DECLARE @Log TABLE (ActionID INT, ActionNameEN NVARCHAR(256), SPName VARCHAR(50))
DECLARE @IsInternal BIT = 0

INSERT INTO @Log (ActionID, ActionNameEN, SPName)
SELECT 5574,'Update Currency Bet Setting','NAP_LM_LicenseeBetLimitUpd' UNION ALL
SELECT 5575,'Update Player Bet Setting','NAP_LM_LicenseeBetLimitUpd'

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, 3, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN,  ActionNameEN,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

SELECT * FROM LogAction  WHERE ActionID BETWEEN 5574 AND 5575


DELETE FROM LogAction_Lic WHERE ActionID BETWEEN 12 AND 17
INSERT INTO dbo.LogAction_Lic (ActionId,ActionTypeId,ActionName,SPName,Items,IsInternal)
SELECT 12, 1,'Update Default Bet Setting from Licensee Bet Setting','NAP_LM_LicenseeBetLimitUpd' , Null , @IsInternal UNION ALL
SELECT 13, 1,'Add Default Bet Setting from Licensee Bet Setting','NAP_LM_LicenseeBetLimitUpd' , Null , @IsInternal UNION ALL
SELECT 14, 1,'Delete Default Bet Setting from Licensee Bet Setting','NAP_LM_LicenseeBetLimitUpd' , Null , @IsInternal UNION ALL
SELECT 15, 1,'Add Licensee Hardcode Setting','NAP_SpecialCustSetting_Add' , Null , @IsInternal UNION ALL
SELECT 16, 1,'Update Licensee Hardcode Setting','NAP_SpecialCustSetting_Upd' , Null , @IsInternal UNION ALL
SELECT 17, 1,'Delete Licensee Hardcode Setting','NAP_SpecialCustSetting_Del' , Null , @IsInternal


select * from LogAction_Lic WHERE ActionID BETWEEN 12 AND 17