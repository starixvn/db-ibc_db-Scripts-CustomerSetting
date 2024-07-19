/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20240628
	Task: trigger update for new History tables  [#204358]
	DB: DBCUST-CustDB
*/
USE CustDB
GO
/****** Object:  Trigger [CustSub_insert] ******/
IF EXISTS(SELECT 1 FROM sys.objects where name = 'Customer_insert' AND type = 'TR')
	DROP TRIGGER [dbo].Customer_insert
GO



/****** Object:  Trigger [dbo].[Customer_insert] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------
CREATE TRIGGER [dbo].Customer_insert ON [dbo].Customer
AFTER INSERT
AS
/*
    Created by: 20240628@Eden
    Task: Trigger for inserting [Customer] table 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240628@Eden: Newly Created Customer in GlobCustDB [redmine: #206823]
    
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	DECLARE @Reseek_CustID INT = 118834942 --If @custid < @Reseek_CustID --> UAT testing or Reactivate

	IF (SELECT Max(custid) FROM Inserted) < @Reseek_CustID
		RETURN;

    INSERT INTO dbo.CustinfoMini(
         CustID
		,username
		,username2
		,recommend
		,mrecommend
		,srecommend
		,roleid
    )
    SELECT CustID
		,username
		,username2
		,recommend
		,mrecommend
		,srecommend
		,roleid
    FROM Inserted t
END 
GO


-------------------
/****** Object:  Trigger [CustSub_insert] ******/
IF EXISTS(SELECT 1 FROM sys.objects where name = 'CustSub_insert' AND type = 'TR')
	DROP TRIGGER [dbo].CustSub_insert
GO



/****** Object:  Trigger [dbo].[CustSub_insert] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------
CREATE TRIGGER [dbo].CustSub_insert ON [dbo].CustSub
AFTER INSERT
AS
/*
    Created by: 20240628@Eden
    Task: Trigger for inserting [CustSub] table 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240628@Eden: Newly Created CustSub in GlobCustDB [redmine: #206823]
    
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	DECLARE @Reseek_SubaccID INT = 1979548 --If @SubaccID < @Reseek_CustID --> UAT testing or Reactivate

	IF (SELECT Max(SubaccID) FROM Inserted) < @Reseek_SubaccID
		RETURN;

    INSERT INTO dbo.CustSubMini(
         SubaccID
		,CustID
		,username
		,username2
    )
    SELECT SubaccID
		,CustID
		,username
		,username2
    FROM Inserted t
END 
GO

/****** Object:  Trigger [Customer_update] ******/
IF EXISTS(SELECT 1 FROM sys.objects where name = 'Customer_update' AND type = 'TR')
	DROP TRIGGER [dbo].Customer_update
GO

/****** Object:  Trigger [dbo].[Customer_update] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------
CREATE TRIGGER [dbo].Customer_update ON [dbo].Customer
AFTER UPDATE
AS
/*
    Created by: 20240628@Eden
    Task: Trigger for Update [Customer] table 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240628@Eden: Newly Created Customer in GlobCustDB [redmine: #206823]
    
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	DECLARE @Reseek_CustID INT = 118834942 --If @custid < @Reseek_CustID --> UAT testing or Reactivate

	IF (SELECT Max(custid) FROM deleted) < @Reseek_CustID
		RETURN;

	IF UPDATE (username) OR  UPDATE (username2) OR  UPDATE (srecommend) OR  UPDATE (mrecommend) OR  UPDATE (recommend) OR  UPDATE (roleid)
	BEGIN
		UPDATE c
		SET c.username = t.username,
			c.username2 = t.username2,
			c.srecommend = t.srecommend,
			c.RepUpdateTime = SYSDATETIME()
		FROM dbo.CustinfoMini c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN Inserted t ON t.custid = c.custid
		WHERE ISNULL(t.username,'')  <> ISNULL(c.username,'')
				OR ISNULL(t.username2,'')  <> ISNULL(c.username2,'')
				OR ISNULL(t.srecommend,0)  <> ISNULL(c.srecommend,0)
				OR ISNULL(t.mrecommend,0)  <> ISNULL(c.mrecommend,0)
				OR ISNULL(t.recommend,0)  <> ISNULL(c.recommend,0)
				OR ISNULL(t.roleid,0)  <> ISNULL(c.roleid,0)
	END
END 
GO
-------------------
/****** Object:  Trigger [CustSub_update] ******/
IF EXISTS(SELECT 1 FROM sys.objects where name = 'CustSub_update' AND type = 'TR')
	DROP TRIGGER [dbo].CustSub_update
GO



/****** Object:  Trigger [dbo].[CustSub_update] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------
CREATE TRIGGER [dbo].CustSub_update ON [dbo].CustSub
AFTER INSERT
AS
/*
    Created by: 20240628@Eden
    Task: Trigger for update [CustSub] table 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240628@Eden: Newly Created CustSub in GlobCustDB [redmine: #206823]
    
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	IF UPDATE (username) OR  UPDATE (username2)  OR  UPDATE (custid)
	BEGIN
		UPDATE c
		SET c.username = t.username,
			c.username2 = t.username2,
			c.RepUpdateTime = SYSDATETIME()
		FROM dbo.CustSubMini c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN inserted t ON t.subaccid = c.subaccid
		WHERE ISNULL(t.username,'')  <> ISNULL(c.username,'')
				OR ISNULL(t.username2,'')  <> ISNULL(c.username2,'')
				OR ISNULL(t.custid,0)  <> ISNULL(c.custid,0)
	END
END 
GO

/****** Object:  Trigger [Customer_delete] ******/
IF EXISTS(SELECT 1 FROM sys.objects where name = 'Customer_delete' AND type = 'TR')
	DROP TRIGGER [dbo].Customer_delete
GO

/****** Object:  Trigger [dbo].[Customer_delete] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------
CREATE TRIGGER [dbo].Customer_delete ON [dbo].Customer
AFTER DELETE
AS
/*
    Created by: 20240628@Eden
    Task: Trigger for delete [Customer] table 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240628@Eden: Newly Created Customer in GlobCustDB [redmine: #206823]
    
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	DECLARE @Reseek_CustID INT = 118834942 --If @custid < @Reseek_CustID --> UAT testing or Reactivate

	IF (SELECT Max(custid) FROM deleted) < @Reseek_CustID
		RETURN;

	DELETE c
	OUTPUT deleted.CustID, SYSDATETIME()  
	INTO dbo.CustInfoMini_Del_Inhouse(CustID,RepUpdateTime)
	FROM dbo.CustinfoMini c WITH(ROWLOCK,UPDLOCK)
		INNER JOIN deleted t ON t.custid = c.custid

END 
GO


-------------------
/****** Object:  Trigger [CustSub_delete] ******/
IF EXISTS(SELECT 1 FROM sys.objects where name = 'CustSub_delete' AND type = 'TR')
	DROP TRIGGER [dbo].CustSub_delete
GO



/****** Object:  Trigger [dbo].[CustSub_delete] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------
CREATE TRIGGER [dbo].CustSub_delete ON [dbo].CustSub
AFTER DELETE
AS
/*
    Created by: 20240628@Eden
    Task: Trigger for delete [CustSub] table 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240628@Eden: Newly Created CustSub in GlobCustDB [redmine: #206823]
    
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	DELETE c
	OUTPUT deleted.subaccid, SYSDATETIME()  
	INTO dbo.CustSubMini_Del_Inhouse(subaccid,RepUpdateTime)
	FROM dbo.CustSubMini c WITH(ROWLOCK,UPDLOCK)
		INNER JOIN deleted t ON t.subaccid = c.subaccid
END 
GO
/*
USE custdb
go
DISABLE TRIGGER dbo.CustSub_insert ON dbo.CustSub
GO
DISABLE TRIGGER dbo.Customer_insert ON dbo.Customer
GO
DISABLE TRIGGER dbo.CustSub_update ON dbo.CustSub
GO
DISABLE TRIGGER dbo.Customer_update ON dbo.Customer
GO
DISABLE TRIGGER dbo.CustSub_delete ON dbo.CustSub
GO
DISABLE TRIGGER dbo.Customer_delete ON dbo.Customer
GO


ENABLE TRIGGER dbo.CustSub_insert ON dbo.CustSub
GO
ENABLE TRIGGER dbo.Customer_insert ON dbo.Customer
GO
ENABLE TRIGGER dbo.CustSub_update ON dbo.CustSub
GO
ENABLE TRIGGER dbo.Customer_update ON dbo.Customer
GO
ENABLE TRIGGER dbo.CustSub_delete ON dbo.CustSub
GO
ENABLE TRIGGER dbo.Customer_delete ON dbo.Customer
GO
*/
