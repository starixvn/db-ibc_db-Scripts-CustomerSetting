/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240108@Eden
	Task: Create log action for Update PT function[#RedmineID:#193083]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

 ---INSERT NEW LOG ACTION FOR UPDATE PT
DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE ActionID BETWEEN 511 AND 522

--Insert data
DECLARE @Log TABLE ( 
		  ActionID INT
		, ActionNameEN NVARCHAR(256)
		, ActionNameCS NVARCHAR(256)
		, ActionNameCH NVARCHAR(256)
		, ActionNameTH NVARCHAR(256)
		, SPName VARCHAR(50)
	)
DECLARE @ActionTypeID INT = 1, @IsInternal BIT = 0

INSERT INTO @Log (ActionID, SPName, ActionNameEN,ActionNameCS,ActionNameCH,ActionNameTH)
SELECT 511,'Acc_CustSetting_SuperPT_153_Upd','Update Sportsbook Position Taking for Super',N'',N'',N'' UNION ALL
SELECT 512,'Acc_CustSetting_MasterPT_153_Upd','Update Sportsbook Position Taking for Master',N'',N'',N'' UNION ALL
SELECT 513,'Acc_CustSetting_AgentPTOnMember_153_MultiUpd','Update Sportsbook Position Taking for Member (Multiple)',N'',N'',N'' UNION ALL
SELECT 514,'Acc_CustSetting_MasterPTOnMember_153_MultiUpd','Update Master''s Sportsbook Position Taking for Member (Multiple)',N'',N'',N'' UNION ALL
SELECT 515,'Acc_CustSetting_SuperPTOnMember_153_MultiUpd','Update Super''s Sportsbook Position Taking for Member (Multiple)',N'',N'',N'' UNION ALL
SELECT 516,'Acc_CustSetting_AgentPTOnMember_153_Upd','Update Sportsbook Position Taking for Member',N'',N'',N'' UNION ALL
SELECT 517,'Acc_CustSetting_AgentPT_153_Upd','Update Sportsbook Position Taking for Agent',N'',N'',N'' UNION ALL
SELECT 518,'Acc_CustSetting_SuperPTOnMember_153_Upd','Update Super''s Sportsbook Position Taking for Member',N'',N'',N'' UNION ALL
SELECT 519,'Acc_CustSetting_MasterPTOnMember_153_Upd','Update Master''s Sportsbook Position Taking for Member',N'',N'',N'' UNION ALL
SELECT 520,'Acc_CustSetting_SuperMinPT_153_Upd','Update Sportsbook Min Position Taking for Super',N'',N'',N'' UNION ALL
SELECT 521,'Acc_CustSetting_MasterMinPT_153_Upd','Update Sportsbook Min Position Taking for Master',N'',N'',N'' UNION ALL
SELECT 522,'Acc_CustSetting_AgentMinPT_153_Upd','Update Sportsbook Min Position Taking for Agent',N'',N'',N''
 
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID BETWEEN 511 AND 522
GO