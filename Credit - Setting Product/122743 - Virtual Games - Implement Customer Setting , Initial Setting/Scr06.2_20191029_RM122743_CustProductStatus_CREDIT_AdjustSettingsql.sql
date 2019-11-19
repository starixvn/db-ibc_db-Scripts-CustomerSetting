/*
	Created: Eden
	Task: Adjust CustProductStatus for Virtual games
	DB: DBCUST/CustDB
	Date: 20191031
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09] 
AS

BEGIN
	
	SET NOCOUNT ON
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN	

	DECLARE	  @fSportType SMALLINT	= 212
			, @fBetType SMALLINT	= 4001
			, @tSportType SMALLINT	= 245
			, @tBetType SMALLINT	= 4601

	-----------------------------------PRODUCT STATUS----------------------------------------------------
	;WITH tmpMacau AS
	(
		SELECT
			(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, PSP.bitmapOrder)) as isDisabled,
			c.CustID
		FROM CustProductStatus c WITH (NOLOCK)
			INNER JOIN dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @fBetType AND PSP.Sporttype = @fSportType
	)
	,tmpVG AS
	(
		SELECT
			(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, PSP.bitmapOrder)) as isDisabled,
			c.CustID
		FROM CustProductStatus c WITH (NOLOCK)
			INNER JOIN dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @tBetType AND PSP.Sporttype = @tSportType
	)
	SELECT a.isDisabled,a.CustID
	INTO #CustStatus
	FROM tmpMacau a 
		INNER JOIN tmpVG b ON a.CustID = b.CustID
	WHERE a.isDisabled <> b.isDisabled
	
	CREATE CLUSTERED INDEX PK_tempCustStatus_CustID ON #CustStatus(CustID)

	UPDATE c 
	SET  c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,isDisabled)
	FROM CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN  dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @tBetType AND PSP.Sporttype = @tSportType
		INNER JOIN  #CustStatus temp ON temp.CustID = c.custid

	DROP TABLE #CustStatus

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_09 

PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
 