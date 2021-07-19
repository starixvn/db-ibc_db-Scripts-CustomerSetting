/*
	Created: 20181015@Vicky
	Task: Insert data for custgametype table
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_CustSetting_09]
			@target VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	----------------------------------------------------------------------------

	DECLARE @tblCustID 		TABLE (CustID INT, GameTypeID INT)
	DECLARE @tblGameTypeID  TABLE (GameTypeID INT)
	DECLARE @srecommend INT
	----------------------------------------------------------------------------
	
	
	SELECT @srecommend = srecommend 
	FROM CustInfo WITH (NOLOCK)
	WHERE custid = 1176086
	
	INSERT INTO @tblGameTypeID(GameTypeID)
	VALUES (16), (17), (19), (20), (21), (22), (24)
	
	
	INSERT INTO @tblCustID(CustID, GameTypeID)
	SELECT ci.custid, tbl.GameTypeID
	FROM CustInfo ci WITH (NOLOCK)
		CROSS APPLY(
			SELECT g.GameTypeID
			FROM @tblGameTypeID g
				LEFT JOIN CustGameType cg WITH (NOLOCK) ON cg.GameTypeID = g.GameTypeID AND cg.CustID = ci.CustID
			WHERE cg.GameTypeID IS NULL
		) AS tbl
	WHERE ci.srecommend = @srecommend
	
	/*
	-----check data---
	SELECT *  
	FROM @tblCustID c
		INNER JOIN CustGameType cg ON cg.CustID = c.CustID AND c.GameTypeID = cg.GameTypeID
	*/
	
	----INSERT DATA
	INSERT INTO CustGameType (CustID,	  GameTypeID,	 StakeLevelList,	MaxPerGameType,	   MinBet,	  MaxBet,	 IsDisabled)
	SELECT 					  c.CustID, c.GameTypeID, cg.StakeLevelList, cg.MaxPerGameType, cg.MinBet, cg.MaxBet, cg.IsDisabled
	FROM @tblCustID c
		INNER JOIN CustGameType cg ON cg.CustID = c.CustID
	WHERE cg.GameTypeID = 1
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB -------------------
----------------------------------------------------------------





-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
----------------------------------------------------------------
EXEC dbo.[Acc_CustSetting_09] @target = 'REPLICATED'





-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----------------------
------------------------------------------------------------------
EXEC dbo.[Acc_CustSetting_09] @target = 'DBCUST'

