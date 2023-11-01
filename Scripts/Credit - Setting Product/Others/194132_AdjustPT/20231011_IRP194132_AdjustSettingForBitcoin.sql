/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231011@Johnson
	Task: update minPT/comm for Bitcoin for 611111
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
    @custid int,	
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	

	DECLARE @roleid INT, 
			@srecommend INT, 
			@mrecommend INT, 
			@PT smallmoney = 0.93
	
	SELECT @roleid = roleid, @srecommend=srecommend, @mrecommend = mrecommend
	FROM customer WITH (NOLOCK) 
	WHERE custid = @custid		
		
	DECLARE @xml XML;
	SET @xml = (
				SELECT (
						SELECT SportType AS '@SportType'
							, BetType AS '@BetType'
							, IsLive AS '@IsLive'
						FROM dbo.ProductSettingDetail WITH(NOLOCK)
						WHERE settingtype = 1 
							  AND SportType IN (175)
						FOR XML PATH('PT')
							, TYPE
						)
				FOR XML PATH('ROOT')
					, TYPE
				);
	DECLARE @SportBettypeXML NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX),@xml);
	
	IF @roleid = 4
	BEGIN
		UPDATE cs 
		SET cs.MaxPT = CASE WHEN cs.MaxPT < @PT * 100 THEN @PT*100 ELSE cs.MaxPT END,
			cs.MinPT = CASE WHEN cs.MinPT < @PT * 100 THEN @PT*100 ELSE cs.MinPT END,
			cs.SuperPT  =  @PT * 100 ,
			cs.MasterPT =  cs.MasterPT + @PT * 100 - cs.SuperPT ,
			cs.AgentPT  =  cs.AgentPT + @PT * 100 - cs.SuperPT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)		
		WHERE cs.SportType IN (175) 
			AND custid = @custid
	END
	ELSE 
	BEGIN
		--update direct account & dummy
		UPDATE cs 
		SET 
			cs.AgentPT = CASE WHEN (custid = @srecommend) THEN @PT * 100  ELSE cs.AgentPT END,
			cs.MasterPT = CASE WHEN (@roleid = 3 AND custid = @custid) OR (custid = @srecommend) THEN @PT * 100  ELSE cs.MasterPT END,
			cs.SuperPT = CASE WHEN custid = @srecommend THEN @PT*100 ELSE 0 END,
			MinPT = CASE WHEN custid = @custid AND cs.MinPT < @PT*100 THEN @PT*100 ELSE cs.MinPT END,
			MaxPT = CASE WHEN MaxPT < 100*@PT THEN @PT*100 ELSE MaxPT END
		FROM CustPTSetting3rd_Agent cs WITH (UPDLOCK,ROWLOCK)			
		WHERE cs.SportType IN (175)
			AND custid IN (@custid, @srecommend)
	END
	
	--update PT
	EXEC dbo.Acc_DynamicCustSetting3rd_09 
				@AgentID = 0
				,@MasterID = @mrecommend
				,@SuperID = @srecommend
				,@roleid = @roleid
				,@SportBettypeXML = @SportBettypeXML
				,@Target = @Target
	
	--Update comm
	DECLARE @Discount VARCHAR(MAX)='<ROOT><Discount SportType="175" BetType="7901" Discount="0.01"/></ROOT>'
	
	IF @roleid = 4
	BEGIN
		EXEC dbo.Acc_DynamicCustSetting3rd_10
					@CustId			= @custid
					, @RoleId		= @RoleId
					, @SettingType  = 3
					, @Discount_XML = @Discount	
					,@Target = @Target
	END
	ELSE 
	BEGIN
		EXEC dbo.Acc_DynamicCustSetting3rd_10
					@CustId			= @srecommend
					, @RoleId		= 4
					, @SettingType  = 3
					, @Discount_XML = @Discount
					, @Target = @Target					
		
		EXEC dbo.Acc_DynamicCustSetting3rd_10
					@CustId			= @custid
					, @RoleId		= 3
					, @SettingType  = 3
					, @Discount_XML = @Discount	
					, @Target = @Target					
	END
END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @custid INT,		
		@Target VARCHAR(20)
	
CREATE TABLE #tblSMA(CustID INT, isfinished BIT DEFAULT(0))

IF @@SERVERNAME  IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SELECT @Target = 'DBCUST'
ELSE 	
	SELECT @Target = 'REPLICATED'
	
--PhoneBetting
CREATE TABLE #PhoneBetting(mrecommend INT)

INSERT INTO #PhoneBetting(mrecommend)	
SELECT DISTINCT mrecommend
FROM dbo.PhoneBettingCustomerList p WITH(NOLOCK)
	INNER JOIN vw_Customer c WITH(NOLOCK) ON p.username = c.username
	
--Get supers normal/direct masters/direct agents
INSERT INTO #tblSMA(custid)	
SELECT DISTINCT ci.custid
FROM vw_customer ci WITH (NOLOCK) 
    INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
    INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site 
    INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid      
WHERE ci.roleid = 4     
    AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
    AND s.islicensee = 0    
    AND cs.IsInternal=0
    AND ci.custid>=100   
    AND ci.username not like '3rdSuper%'   
    AND ci.site = '611111' 
    AND cu.Enabled = 1
    AND cu.currency NOT IN (20,72)
UNION
--direct master
SELECT ci.custid
FROM CustDirectAccount ca WITH(NOLOCK)
	INNER JOIN vw_customer ci WITH(NOLOCK) ON ca.CustID = ci.custid
	INNER JOIN custinfo cu WITH(NOLOCK) ON ci.custid = cu.custid
WHERE ci.site = '611111'
	AND ci.currency NOT IN (20,72)
	AND ci.roleid = 3
	AND cu.enabled = 1 
	AND ci.custid NOT IN (SELECT mrecommend FROM #PhoneBetting)	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #tblSMA )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tblSMA
	SET isfinished = 1
		,@custid = custid		
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	--RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	DECLARE @__msgtemp VARCHAR(200) = @msg + '- curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
	RAISERROR (@__msgtemp, 0, 1, @index, @custid) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting_19] 
			@custid = @custid, 			
			@target = @target	
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #tblSMA	
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------	
				