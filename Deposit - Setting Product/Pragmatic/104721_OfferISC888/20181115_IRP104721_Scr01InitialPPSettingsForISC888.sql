/*
	Created: Johnson
	Date: 2018-11-15
	Task: Initial PP settings for licensees
	DB: DBCUST/CUSTDB
*/

-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT
	,@currency INT 
	,@max_custid INT 
	,@target VARCHAR(20) 
AS
BEGIN	
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at DBCUST only
	
	IF (dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('custinfo') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 			
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0
		OR dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0
		OR dbo.f_CheckRepTable('Dep_StakeLevel') = 0		
	   )
	RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY,roleid TINYINT, mrecommend INT, ID INT IDENTITY(1,1))
	DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)
	DECLARE @bitmapOrder INT = 8,--PP
			@StakeLevelID VARCHAR(10)
	
	CREATE NONCLUSTERED INDEX inx_tmp ON #tblCust (ID)
	
	INSERT INTO #tblCust (custid,roleid,mrecommend)			
	SELECT custid,roleid,mrecommend
	FROM dbo.Customer WITH(NOLOCK)
	WHERE srecommend =@srecommend
		AND custid <= @max_custid
	OPTION( optimize for (@srecommend = 0))
	
	DELETE #tblCust 
	WHERE mrecommend IN (SELECT custid 
						FROM dbo.custinfo WITH(NOLOCK)
						WHERE srecommend=@srecommend and username like '%Acc%' and roleid=3)
	OPTION( optimize for (@srecommend = 0))	
	
	INSERT INTO Dep_LicenseeProductSetting (CustID,ProductSettingID)	
	SELECT @srecommend,ps.ProductSettingID
	FROM dbo.Dep_ProductSetting ps WITH (NOLOCK)
	WHERE productid = 32
			
	--PT
	INSERT INTO [dbo].[Dep_CustPTSetting_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT])
	SELECT t.custid,
		s.SportType,
		s.Bettype,
		s.IsLive,
		s.SuperPT,
		s.MasterPT,
		s.AgentPT
	FROM #tblCust t
		INNER JOIN (SELECT 4 roleid, 248 as SportType, 4101 as Bettype, 0 isLive, 92 SuperPT, 92 MasterPT, 92 AgentPT
					UNION SELECT 3 roleid, 248 as SportType, 4101 as Bettype, 0 isLive, 0 SuperPT, 92 MasterPT, 0 AgentPT
					UNION SELECT 2 roleid, 248 as SportType, 4101 as Bettype, 0 isLive, 0 SuperPT, 0 MasterPT, 92 AgentPT
					) s ON t.roleid = s.roleid
		
	--PT group for member
	INSERT INTO [dbo].[Dep_CustPTGroupSetting_Member]
           ([AgentID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT])
	SELECT t.custid,
		248 SportType,
		4101 Bettype,
		0 IsLive,
		0 SuperPT,
		0 MasterPT,
		92 AgentPT
	FROM #tblCust t
	WHERE roleid = 2	   
	
	DELETE #tblCust
	OUTPUT DELETED.custID
	INTO @tmpCust
	WHERE roleid > 1
	
	--enable status for SMA dummy
	UPDATE dbo.Dep_CustProductStatus WITH(UPDLOCK,ROWLOCK)
	SET bitmapIsHidden = dbo.f_GenerateProductStatus(bitmapIsHidden,@bitmapOrder,0),
		bitmapIsDisabled = dbo.f_GenerateProductStatus(bitmapIsDisabled,@bitmapOrder,0)
	WHERE custID IN (SELECT custid FROM @tmpCust)
	
	--Initial stakelevel for SMA dummy
	SELECT @StakeLevelID = StakeLevelID
	FROM dbo.Dep_StakeLevel WITH(NOLOCK)
	WHERE ExchangeID = @currency
		AND GameTypeID = 4101
	
	INSERT INTO [dbo].[Dep_CustStakeLevel_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList])
	SELECT custID, 248 as sporttype, 4101 as BetType, @StakeLevelID
	FROM @tmpCust
	
	DECLARE @Threshold INT = 5000,@fromID INT , @toID INT, @maxID INT
	
	SELECT @maxID = max(ID) FROM #tblCust
	SELECT @fromID = 0, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
		
	--Initial status/stakelevel for member level	
	WHILE(1=1)
	BEGIN		
		DELETE @tmpCust

		DELETE #tblCust
		OUTPUT DELETED.custID
		INTO @tmpCust
		WHERE ID BETWEEN @fromID AND @toID

		--Enable for PP
		UPDATE cs
		SET bitmapIsHidden = dbo.f_GenerateProductStatus(bitmapIsHidden,@bitmapOrder,0),
			bitmapIsDisabled = dbo.f_GenerateProductStatus(bitmapIsDisabled,@bitmapOrder,0)	
		FROM dbo.Dep_CustProductStatus cs WITH(UPDLOCK,ROWLOCK)			
		WHERE custid IN (SELECT custid FROM @tmpCust)

		--Initial stakelevel
		INSERT INTO [dbo].[Dep_CustStakeLevel_Member]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList]
           ,[LastUpdated])
		SELECT custID, 248 as sporttype, 4101 as BetType, @StakeLevelID, GetDate()
		FROM @tmpCust
				
		SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold + 1

		IF @fromID > @maxID
			BREAK;			
			
		WAITFOR DELAY '00:00:00.200'		
	END
	
	DROP TABLE #tblCust
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT, currency INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT, @currency INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid, currency)
SELECT custid, currency
FROM  Dep_CustSuper with(nolock) 
WHERE custid <= @max_custid
	AND Site IN ('ISC888')
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
		,@currency = currency
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
			@srecommend = @srecommend, 
			@currency = @currency,
			@max_custid=@max_custid,
			@target = 'REPLICATED' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO		

---
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------

CREATE TABLE #supers (custid INT, currency INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT, @currency INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid, currency)
SELECT custid, currency
FROM  Dep_CustSuper WITH(NOLOCK) 
WHERE custid <= @max_custid
	AND Site IN ('ISC888')
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
		,@currency = currency
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
			@srecommend = @srecommend, 
			@currency = @currency,
			@max_custid=@max_custid,
			@target = 'DBCUST' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO		

-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------








	