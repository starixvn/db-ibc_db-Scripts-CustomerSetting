/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20210524@Winfred
	Task: Prepare for log status of Parlay Max Payout [#RM:154104]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

DELETE FROM LogAction where ActionID BETWEEN 220000 AND 220006
DELETE FROM LogActionDetail where ActionID BETWEEN 220000 AND 220006
--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT
		, ActionNameEN NVARCHAR(256)
		, ActionNameCS NVARCHAR(256)
		, ActionNameCH NVARCHAR(256)
		, ActionNameTH NVARCHAR(256)
		, SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 3, @IsInternal BIT = 0

INSERT INTO @Log (Level, ProductID, ActionID, ActionNameEN, SPName,ActionNameCS,ActionNameCH,ActionNameTH)
SELECT 4, 1, 220000,'Update Parlay Max Payout','Acc_CustSetting_MaxPayoutUpd',N'更新串关最高派彩',N'更新串關最高派彩',N'อัปเดตการจ่ายเงินสูงสุดของพาร์เลย์' UNION ALL
SELECT 4, 1, 220001,'Update Parlay Max Payout Indirectly','Acc_CustSetting_MaxPayoutUpd',N'更新串关非间接最高派彩',N'更新串關非間接最高派彩',N'อัปเดตการจ่ายเงินสูงสุดของพาร์เลย์โดยทางอ้อม' UNION ALL
-----------------------------
SELECT 3, 1, 220002,'Update Parlay Max Payout','Acc_CustSetting_MaxPayoutUpd',N'更新串关最高派彩',N'更新串關最高派彩',N'อัปเดตการจ่ายเงินสูงสุดของพาร์เลย์' UNION ALL
SELECT 3, 1, 220003,'Update Parlay Max Payout Indirectly','Acc_CustSetting_MaxPayoutUpd' ,N'更新串关非间接最高派彩',N'更新串關非間接最高派彩',N'อัปเดตการจ่ายเงินสูงสุดของพาร์เลย์โดยทางอ้อม' UNION ALL
-------------------
SELECT 2, 1, 220004,'Update Parlay Max Payout','Acc_CustSetting_MaxPayoutUpd',N'更新串关最高派彩',N'更新串關最高派彩',N'อัปเดตการจ่ายเงินสูงสุดของพาร์เลย์' UNION ALL
SELECT 2, 1, 220005,'Update Parlay Max Payout Indirectly','Acc_CustSetting_MaxPayoutUpd' ,N'更新串关非间接最高派彩',N'更新串關非間接最高派彩',N'อัปเดตการจ่ายเงินสูงสุดของพาร์เลย์โดยทางอ้อม' UNION ALL
---------------------
SELECT 1, 1, 220006,'Update Parlay Max Payout','Acc_CustSetting_MaxPayoutUpd',N'更新串关最高派彩',N'更新串關最高派彩',N'อัปเดตการจ่ายเงินสูงสุดของพาร์เลย์' 


INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

INSERT INTO dbo.LogActionDetail (ActionID, ProductID, Level)
SELECT ActionID, ProductID, Level
FROM @Log



select * from LogAction  where ActionID >= 220000
select * from LogActionDetail  where ActionID >= 220000
