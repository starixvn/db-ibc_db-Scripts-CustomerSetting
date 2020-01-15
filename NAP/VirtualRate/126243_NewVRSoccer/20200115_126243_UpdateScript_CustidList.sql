USE [CustDB]
GO

/*
	Modified: 20200115@Tiara
	DB: DBCUST.CustDB
	Task: Update New VR Soccer by provided Custid list [#Redmine: 126243]
*/

ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
	@CustIdList VARCHAR(MAX),
	@virtualmultiplier	VARCHAR(MAX) = ''
AS
BEGIN
	SET NOCOUNT ON
	IF dbo.f_CheckRepTable('VRCustSetting') = 0 RETURN

	CREATE TABLE #tmpCustId (Custid INT)
	DECLARE @DocHandlerCustid INT	

	EXEC sp_xml_preparedocument @DocHandlerCustid OUTPUT, @CustIdList

	INSERT INTO #tmpCustId(Custid)
	SELECT Data.Custid
	FROM OPENXML (@DocHandlerCustid, '/Root/Row',1) 
	WITH (
			Custid	INT		
		 ) AS Data

	EXEC sp_xml_removedocument @DocHandlerCustid


	CREATE TABLE #New_VRCustSetting (LevelID INT, ValueIDLive TINYINT, ValueIDNonLive TINYINT)
	DECLARE @DocHandlerSoccer INT	

	IF @VirtualMultiplier <> ''
	BEGIN				
		EXEC sp_xml_preparedocument @DocHandlerSoccer OUTPUT, @virtualmultiplier

		INSERT INTO #New_VRCustSetting(LevelID, ValueIDLive, ValueIDNonLive)
		SELECT Data.LevelID,
			Data.ValueIDLive,
			Data.ValueIDNonLive
		FROM OPENXML (@DocHandlerSoccer, '/Root/Row',1) 
		WITH (
			LevelID	INT,
			ValueIDLive TINYINT,
			ValueIDNonLive TINYINT	
		) AS Data

		EXEC sp_xml_removedocument @DocHandlerSoccer
	END

	UPDATE MAIN
	SET MAIN.ValueIDLIVE = vr.ValueIDLive
		, MAIN.ValueIDNonLIVE = vr.ValueIDNonLIVE
	FROM VRCustSetting MAIN
		INNER JOIN #New_VRCustSetting vr ON  vr.LevelID = MAIN.LevelID
		INNER JOIN #tmpCustId T ON T.CustId = MAIN.CustID

	DELETE MAIN
	FROM VRCustSetting MAIN INNER JOIN #tmpCustId T ON MAIN.CustID = T.CustId
	WHERE MAIN.LevelID NOT IN (SELECT LevelID FROM #New_VRCustSetting)
	
	INSERT INTO [dbo].[VRCustSetting]
       ([CustID]
       ,[LevelID]
       ,[ValueIDLIVE]
       ,[ValueIDNonLIVE])
	SELECT T.CustId [CustID]
        ,[LevelID]
        ,[ValueIDLIVE]
        ,[ValueIDNonLIVE]
	FROM #New_VRCustSetting V CROSS JOIN #tmpCustId T 
	WHERE [LevelID] NOT IN (SELECT LevelID FROM [VRCustSetting] V INNER JOIN #tmpCustId T ON T.CustId = V.CustID)

END
GO
