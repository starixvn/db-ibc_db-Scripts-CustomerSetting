/*<info serverAlias="DBLOG-bodb_CustomerLog" executers="" viewers=""></info>*/
/*
      Task:         Init new action for agent bank account update indirectly [#236430]
      DB:           DBLOG-bodb_CustomerLog
      Created:      20250822@Helios
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;


IF NOT EXISTS (
    SELECT TOP 1 1 FROM dbo.LogAction WITH (NOLOCK) WHERE ActionID = 300010
)
BEGIN
    INSERT INTO dbo.LogAction (
        ActionID,
        ActionTypeID,
        SPName,
        ActionNameEN,
        ActionNameCH,
        ActionNameCS,
        ActionNameJP,
        ActionNameIT,
        ActionNameTH,
        ActionNameKO,
        XsltContent,
        IsInternal,
        ActionNameVI,
        ActionNameCN
    )
    VALUES (
        300010, -- ActionID mới
        101, -- ActionTypeID
        'Age_CashService_BankAccountAgent_Upd',
        N'Update Agent Bank Account Info Indirectly',
        N'間接更新代理銀行帳戶資訊',
        N'间接更新代理银行账户信息',
        N'代理店の銀行口座情報を間接的に更新',
        NULL,
        N'อัปเดตข้อมูลบัญชีธนาคารตัวแทนโดยอ้อม',
        NULL,
        NULL,
        0,
        NULL,
        NULL
    );
END;

-- Init new action for agent bank account delete indirectly (ActionID 300011)
IF NOT EXISTS (
    SELECT TOP 1 1 FROM dbo.LogAction WITH (NOLOCK) WHERE ActionID = 300011
)
BEGIN
    INSERT INTO dbo.LogAction (
        ActionID,
        ActionTypeID,
        SPName,
        ActionNameEN,
        ActionNameCH,
        ActionNameCS,
        ActionNameJP,
        ActionNameIT,
        ActionNameTH,
        ActionNameKO,
        XsltContent,
        IsInternal,
        ActionNameVI,
        ActionNameCN
    )
    VALUES (
        300011, -- ActionID
        101, -- ActionTypeID
        'Age_CashService_BankAccountAgent_Del',
        N'Remove Agent Bank Account Info Indirectly',
        N'間接刪除代理銀行帳戶資訊',
        N'间接删除代理银行账户信息',
        N'代理店の銀行口座情報を間接的に削除',
        NULL,
        N'ลบข้อมูลบัญชีธนาคารตัวแทนโดยอ้อม',
        NULL,
        NULL,
        0,
        NULL,
        NULL
    );
END;

IF NOT EXISTS (
    SELECT TOP 1 1 FROM dbo.LogActionDetail WITH (NOLOCK) WHERE ActionID = 300010
)
BEGIN
    INSERT INTO LogActionDetail 
	(
		ActionID
	    , ProductID
	    , Level
	)
    SELECT 300010 , NULL , 2
END

IF NOT EXISTS (
    SELECT TOP 1 1 FROM dbo.LogActionDetail WITH (NOLOCK) WHERE ActionID = 300011
)
BEGIN
    INSERT INTO LogActionDetail 
	(
		ActionID
	    , ProductID
	    , Level
	)
    SELECT 300011 , NULL , 2
END
