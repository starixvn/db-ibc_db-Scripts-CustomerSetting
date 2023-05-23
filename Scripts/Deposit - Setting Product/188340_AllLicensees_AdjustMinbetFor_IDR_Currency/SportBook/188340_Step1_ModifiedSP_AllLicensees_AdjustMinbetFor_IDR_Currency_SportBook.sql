/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/05/17
	Task: All licensees - Adjust minbet for IDR currency [redmine : #188340]
	DB: DBCUST/CustDB
	Revisions: Modified SP Upd BetSetting
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]  
	@AffectedList	VARCHAR (MAX) 
,	@max_custid		INT 

AS
BEGIN
	SET NOCOUNT ON  

-----------------------------------Check Replicate---------------------------------
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 1
	   )
		RETURN

	--Convert XML format
	DECLARE @xml XML = NULL 
	,		@MinBet_new			MONEY = 10														-- MinBet adjusted : 10

	SET @xml = CONVERT(XML, @AffectedList)  
	
	--Parse XML   
	DECLARE @iDoc INT  
  
	EXEC sp_xml_preparedocument @iDoc OUTPUT , @xml

	CREATE TABLE #tmpCustList (  
	    CustID			INT ,
		SportType		INT ,
		BetType			INT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)  

	INSERT INTO #tmpCustList
	SELECT C , S , B
	FROM OPENXML(@iDoc, '/root/r', 1) WITH (  
	 C			INT					-- @CustID
	,S			INT					-- @SportType  
	,B			INT					-- @BetType
	)

	EXEC sp_xml_removedocument @iDoc  

	CREATE TABLE #BetSetting_Agent (
		CustID			INT ,
		SportType		INT ,
		BetType			INT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	-- Collect SMA BetSetting WITH MinBet> 10
	INSERT INTO #BetSetting_Agent (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType
	FROM Dep_CustBetSettingGame_Agent ca WITH (NOLOCK)
			INNER JOIN custInfo c WITH (NOLOCK)					ON ca.CustID = c.custid
			INNER JOIN #tmpCustList	cl							ON cl.CustID = c.srecommend AND ca.SportType  = cl.SportType AND ca.BetType = cl.BetType
	WHERE  c.roleid IN (2,3,4)
	AND c.Enabled = 1
	AND ca.MinBet > 10																	-- with licensee having minbet > 10: will adjust to 10 IDR.
	AND c.custid <= @max_custid
	GROUP BY ca.CustID , ca.SportType , ca.BetType

	DECLARE @sma_cnt INT , @Batch INT = 5000
	DECLARE @msg_total_sma NVARCHAR(200) = 'Total of SMA Affected: %d.'

	SET @sma_cnt = (SELECT COUNT(1) FROM #BetSetting_Agent )
	RAISERROR (@msg_total_sma, 0, 1, @sma_cnt) WITH NOWAIT

	CREATE TABLE #SMA_Affected (
	CustID			INT ,
	SportType		INT ,
	BetType			INT  )

	WHILE (1 = 1)
	BEGIN
		TRUNCATE TABLE #SMA_Affected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType 
			INTO #SMA_Affected (CustID , SportType , BetType )
		FROM #BetSetting_Agent s

		IF @@ROWCOUNT = 0 
			BREAK ;

		UPDATE c SET c.MinBet = @MinBet_new
		FROM Dep_CustBetSettingGame_Agent c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #SMA_Affected cust 
				ON  c.CustID = cust.CustID
				AND c.SportType = cust.SportType
				AND c.BetType = cust.BetType

		WAITFOR DELAY  '00:00:0.050'	
		
		SET @msg_total_sma = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_sma, 0, 1) WITH NOWAIT

	END

	DROP TABLE #tmpCustList
	DROP TABLE #BetSetting_Agent
	DROP TABLE #SMA_Affected

END
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
GO
