/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20231129@Luke
	Task: Alpha - Enhance auto transfer function (phase 2) [Redmine: #195135] 
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

--Insert new actionIDs
IF NOT EXISTS (
	SELECT TOP 1 1
	FROM dbo.LogAction
	WHERE ActionID BETWEEN 95110 AND 95115
)

BEGIN
	DECLARE @Log AS TABLE(
		ActionID INT
		,ActionNameEN NVARCHAR(256)
		,ActionNameCH NVARCHAR(256)
		,ActionNameCS NVARCHAR(256)
		,ActionNameTH NVARCHAR(256)
		,SPName VARCHAR(50)
	)

	DECLARE @ActionTypeID INT = 4,
			@IsInternal BIT = 1

	INSERT INTO @Log(ActionID, ActionNameEN, SPName, ActionNameCS, ActionNameCH, ActionNameTH)
	SELECT 95110, 'Disable Auto Transfer because Super changed Transfer Condition', 'EAS_CustomerUpdTransferOption', N'禁用自动转账，因为超级总代理更改了转账设定', N'禁用自動轉賬，因爲超級總代理更改了轉賬設定', N'ปิดการใช้งานระบบโอนอัตโนมัติเนื่องจากซุปเปอร์เปลี่ยนเงื่อนไขการโอน'
	UNION ALL
	SELECT 95111, 'Disable Auto Transfer because Master changed Transfer Condition', 'EAS_CustomerUpdTransferOption', N'禁用自动转账，因为总代理更改了转账设定', N'禁用自動轉賬，因爲總代理更改了轉賬設定', N'ปิดการใช้งานระบบโอนอัตโนมัติเนื่องจากมาสเตอร์เปลี่ยนเงื่อนไขการโอน'
	UNION ALL
	SELECT 95112, 'Disable Auto Transfer because Agent changed Transfer Condition', 'EAS_CustomerUpdTransferOption', N'禁用自动转账，因为代理更改了转账设定', N'禁用自動轉賬，因爲代理更改了轉賬設定', N'ปิดการใช้งานระบบโอนอัตโนมัติเนื่องจากเอเย่นต์เปลี่ยนเงื่อนไขการโอน'
	UNION ALL
	SELECT 95113, 'Update Auto Transfer schedule because Super changed Transfer Condition', 'EAS_CustomerUpdTransferOption', N'更新自动转账日程， 因为超级总代理更改转账设定', N'更新自動轉賬日程， 因爲超級總代理更改轉帳設定', N'อัปเดตตารางการโอนอัตโนมัติเนื่องจากซุปเปอร์เปลี่ยนเงื่อนไขการโอน'
	UNION ALL
	SELECT 95114, 'Update Auto Transfer schedule because Master changed Transfer Condition', 'EAS_CustomerUpdTransferOption', N'更新自动转账日程， 因为总代理更改转账设定', N'更新自動轉賬日程， 因爲總代理更改轉帳設定', N'อัปเดตตารางการโอนอัตโนมัติเนื่องจากมาสเตอร์เปลี่ยนเงื่อนไขการโอน'
	UNION ALL
	SELECT 95115, 'Update Auto Transfer schedule because Agent changed Transfer Condition', 'EAS_CustomerUpdTransferOption', N'更新自动转账日程， 因为代理更改转账设定', N'更新自動轉賬日程， 因爲代理更改轉帳設定', N'อัปเดตตารางการโอนอัตโนมัติเนื่องจากเอเย่นต์เปลี่ยนเงื่อนไขการโอน' 

	INSERT INTO dbo.LogAction (
		ActionID
		,ActionTypeID
		,SPName
		,ActionNameEN
		,ActionNameCH
		,ActionNameCS
		,ActionNameJP
		,ActionNameIT
		,ActionnameTH
		,ActionNameKO
		,XsltContent
		,IsInternal
		,ActionNameVI
		,ActionNameCN
	)
	SELECT	ActionID
			,@ActionTypeID
			,SPName
			,ActionNameEN
			,ActionNameCH
			,ActionNameCS
			,ActionNameEN
			,ActionNameEN
			,ActionNameTH
			,ActionNameEN
			,NULL
			,@IsInternal
			,ActionNameEN
			,ActionNameEN
	FROM @Log
END
ELSE
	RAISERROR('ActionID(s) has already been used.', 16, 1)

