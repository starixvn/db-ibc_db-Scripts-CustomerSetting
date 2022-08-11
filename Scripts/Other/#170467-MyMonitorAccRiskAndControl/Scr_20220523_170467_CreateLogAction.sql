﻿﻿/* <info serverAlias="DBLOG-bodb_CustomerLog"></info> */
/*
	Created: 20220523@Eden
	Task: Create log action for Alpha - My Monitor Accounts for Risk & Control [#RedmineID:#170467]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE ActionID BETWEEN 31801 AND 31804
--Insert data
DECLARE @Log TABLE ( 
		  ActionID INT
		, ActionNameEN NVARCHAR(256)
		, ActionNameCS NVARCHAR(256)
		, ActionNameCH NVARCHAR(256)
		, ActionNameTH NVARCHAR(256)
		, SPName VARCHAR(50)
	)
DECLARE @ActionTypeID INT = NULL, @IsInternal BIT = 0

INSERT INTO @Log (ActionID, SPName, ActionNameEN,ActionNameCS,ActionNameCH,ActionNameTH)
SELECT 31801,'Acc_WLMonitored_Global_Upd','Updated Global Threshold for customer(s)',N'已更新客户的总体限額',N'已更新客戶的總體限額',N'อัปเดตเกณฑ์การชนะ/แพ้สากลสำหรับลูกค้า' UNION ALL
SELECT 31802,'Acc_WLMonitored_Personal_Ins','Inserted Personal Threshold for customer(s)',N'已输入客户的个人限額',N'已輸入客戶的個人限額',N'แทรกค่าที่ตั้งไว้สำหรับรายบุคคล' UNION ALL
SELECT 31803,'Acc_WLMonitored_Personal_Upd','Updated Personal Threshold for customer(s)',N'已更新客户的个人限額',N'已更新客戶的個人限額',N'อัปเดตค่าที่ตั้งไว้สำหรับรายบุคคล' UNION ALL
SELECT 31804,'Acc_WLMonitored_Personal_Del','Deleted Personal Threshold for customer(s)',N'已删除客户的个人限額',N'已删除客戶的個人限額',N'ลบค่าที่ตั้งไว้สำหรับรายบุคคล' 
 
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID BETWEEN 31801 AND 31804
GO

