USE [CustDB]
GO

/*
	Modified: 20190408Percy
	DB: DBCUST.CustDB
	Task: Update transfer option of CustSuper/CustMaster/CustAgent
*/

ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@CustIdList VARCHAR(MAX)
	,@tableName	SYSNAME
AS
BEGIN
	SET NOCOUNT ON

	IF dbo.f_CheckRepTable(@tableName) = 0
		RETURN

	DECLARE @CustIdXML XML
	SELECT  @CustIdXML = CAST(@CustIdList AS XML)

	SELECT t.c.value('@c', 'INT') AS CustId
	INTO #tmpCustId
	FROM @CustIdXML.nodes('/r') AS t(c)

	IF @tableName = 'CustSuper'
	BEGIN
		UPDATE c
		SET c.TransferOption = 0
		FROM dbo.CustSuper c WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustId t ON c.custid = t.CustId
	END

	IF @tableName = 'CustMaster'
	BEGIN
		UPDATE c
		SET c.TransferOption = 0
		FROM dbo.CustMaster c WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustId t ON c.custid = t.CustId
	END

	IF @tableName = 'CustAgent'
	BEGIN
		UPDATE c
		SET c.TransferOption = 0
		FROM dbo.CustAgent c WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustId t ON c.custid = t.CustId
	END
END
GO