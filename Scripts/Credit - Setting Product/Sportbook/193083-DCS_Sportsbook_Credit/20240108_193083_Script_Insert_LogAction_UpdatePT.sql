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
		, ActionNameVI NVARCHAR(256)
		, SPName VARCHAR(50)
	)
DECLARE @ActionTypeID INT = 1, @IsInternal BIT = 0

INSERT INTO @Log (ActionID, SPName, ActionNameEN,ActionNameCS,ActionNameCH,ActionNameTH,ActionNameVI)
SELECT 511,'Acc_CustSetting_SuperPT_153_Upd','Update Sportsbook Position Taking for Super',N'更新超级总代理体育博彩占成数',N'更新超級總代理體育博彩占成數',N'อัปเดตค่าแบ่งสู้งกีฬาสำหรับซุปเปอร์',N'Cập nhật Position Taking Sportsbook cho Super' UNION ALL
SELECT 512,'Acc_CustSetting_MasterPT_153_Upd','Update Sportsbook Position Taking for Master',N'更新总代理体育博彩占成数',N'更新總代理體育博彩占成數',N'อัปเดตค่าแบ่งสู้กีฬาสำหรับมาสเตอร์',N'Cập nhật Position Taking Sportsbook cho Master' UNION ALL
--SELECT 513,'Acc_CustSetting_AgentPTOnMember_153_MultiUpd','Update Sportsbook Position Taking for Member (Multiple)',N'',N'',N'',N'' UNION ALL
--SELECT 514,'Acc_CustSetting_MasterPTOnMember_153_MultiUpd','Update Master''s Sportsbook Position Taking for Member (Multiple)',N'',N'',N'',N'' UNION ALL
--SELECT 515,'Acc_CustSetting_SuperPTOnMember_153_MultiUpd','Update Super''s Sportsbook Position Taking for Member (Multiple)',N'',N'',N'',N'' UNION ALL
SELECT 516,'Acc_CustSetting_AgentPTOnMember_153_Upd','Update Sportsbook Position Taking for Member',N'更新会员体育博彩占成数',N'更新會員體育博彩占成數',N'อัปเดตค่าแบ่งสู้กีฬาสำหรับสมาชิก',N'Cập nhật Position Taking Sportsbook cho Member' UNION ALL
SELECT 517,'Acc_CustSetting_AgentPT_153_Upd','Update Sportsbook Position Taking for Agent',N'更新代理体育博彩占成数',N'更新代理體育博彩占成數',N'อัปเดตค่าแบ่งสู้กีฬาสำหรับเอเย่นต์',N'Cập nhật Position Taking Sportsbook cho Agent' UNION ALL
SELECT 518,'Acc_CustSetting_SuperPTOnMember_153_Upd','Update Super''s Sportsbook Position Taking for Member',N'更新超级总代理旗下会员的体育博彩占成数',N'更新超級總代理旗下會員的體育博彩占成數',N'อัปเดตค่าแบ่งสู้กีฬาของซุปเปอร์สำหรับสมาชิก',N'Cập nhật Position Taking Sportsbook của Super cho Member' UNION ALL
SELECT 519,'Acc_CustSetting_MasterPTOnMember_153_Upd','Update Master''s Sportsbook Position Taking for Member',N'更新总代理旗下会员的体育博彩占成数',N'更新總代理旗下會員的體育博彩占成數',N'อัปเดตค่าแบ่งสู้กีฬาของมาสเตอร์สำหรับสมาชิก',N'Cập nhật Position Taking Sportsbook của Master cho Member' UNION ALL
SELECT 520,'Acc_CustSetting_SuperMinPT_153_Upd','Update Sportsbook Min Position Taking for Super',N'更新超级总代理体育博彩最低占成数',N'更新超級總代理體育博彩最低占成數',N'อัปเดตค่าแบ่งสู้ขั้นต่ำสำหรับซุปเปอร์',N'Cập nhật Position Taking Sportsbook Nhỏ Nhất cho Super' UNION ALL
SELECT 521,'Acc_CustSetting_MasterMinPT_153_Upd','Update Sportsbook Min Position Taking for Master',N'更新总代理体育博彩最低占成数',N'更新總代理體育博彩最低占成數',N'อัปเดตค่าแบ่งสู้ขั้นต่ำสำหรับมาสเตอร์',N'Cập nhật Position Taking Sportsbook Nhỏ Nhất cho Master' UNION ALL
SELECT 522,'Acc_CustSetting_AgentMinPT_153_Upd','Update Sportsbook Min Position Taking for Agent',N'更新代理体育博彩最低占成数',N'更新代理體育博彩最低占成數',N'อัปเดตค่าแบ่งสู้ขั้นต่ำสำหรับเอเย่นต์',N'Cập nhật Position Taking Sportsbook Nhỏ Nhất cho Agent'
 
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN, @IsInternal, ActionNameVI
FROM @Log

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID BETWEEN 511 AND 522
GO