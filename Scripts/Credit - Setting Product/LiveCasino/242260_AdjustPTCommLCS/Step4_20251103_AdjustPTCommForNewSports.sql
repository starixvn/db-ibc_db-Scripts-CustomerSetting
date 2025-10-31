/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Johnson@20251030
	Description: Adjust Max PT 90% and Comm 0.8% for Live Casino Product [redmine: #242260]
	DB: DBCust/CustDB	
*/
DECLARE @__delaytime VARCHAR(10)
SELECT @__delaytime = dbo.f_DelayTime('CS_Adhoc')

CREATE TABLE #tblSMA(CustID INT, roleid TINYINT, srecommend INT, mrecommend INT, recommend INT, isfinished BIT DEFAULT(0))
CREATE TABLE #tblDirectMember (CustID INT PRIMARY KEY,srecommend INT, mrecommend INT, recommend INT)
CREATE TABLE #tblCust(CustID INT PRIMARY  KEY)
DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)

--PhoneBetting
CREATE TABLE #PhoneBetting(mrecommend INT, recommend INT)
CREATE TABLE #DummySuper(custid INT)

--115 rows affected
INSERT INTO #PhoneBetting(mrecommend,recommend)	
SELECT DISTINCT mrecommend,recommend
FROM dbo.PhoneBettingCustomerList p WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON p.username = c.username
	
-- get dummy super list
INSERT INTO #DummySuper(custid)
SELECT DISTINCT srecommend 
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN customer ci WITH(NOLOCK) ON da.CustID = ci.custid	 
WHERE  ci.roleid IN (1, 2, 3) 	
	AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')				
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
--Get supers normal
INSERT INTO #tblSMA(CustID,roleid)
SELECT DISTINCT ci.custid, ci.roleid 
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site	
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid		
WHERE ci.roleid = 4 
	AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT custid FROM #dummySuper)
	AND cu.Enabled = 1
	AND s.islicensee = 0	
	AND cs.IsInternal=0
	AND ci.custid>=100
	AND ci.username not like '3rdSuper%' 	

--Direct masters exclude who has  phone betting	members
INSERT INTO #tblSMA(CustID,roleid,srecommend)
SELECT DISTINCT ci.custid, ci.roleid, ci.srecommend 
	FROM customer ci with(nolock)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
	WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 
		AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')		
		AND c.Enabled=1				
		AND c.custid NOT IN (SELECT mrecommend FROM #PhoneBetting)		
		
--Direct agents exclude who has  phone betting	members
INSERT INTO #tblSMA(CustID,roleid,srecommend,mrecommend)
SELECT DISTINCT ci.custid, ci.roleid, ci.srecommend, ci.mrecommend
FROM customer ci WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
WHERE  EXISTS (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid = 2 
	AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')		
	AND c.Enabled=1		
	AND c.custid NOT IN (SELECT recommend FROM #PhoneBetting)		
	
--Direct members 
INSERT INTO #tblDirectMember(CustID,srecommend,mrecommend,recommend)
SELECT DISTINCT ci.custid, ci.srecommend, ci.mrecommend, ci.recommend
FROM customer ci WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
WHERE  EXISTS (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid = 1 
	AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')		
	AND c.Enabled=1			
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0, @custid INT, @roleid TINYINT, @srecommend INT, @mrecommend INT, @recommend INT

DECLARE @PT SMALLMONEY = 90,
		@Discount DECIMAL(9,8) = 0.008,
        @xmlDiscount VARCHAR(MAX),
        @xmlPT VARCHAR(MAX)

SELECT @xmlPT = '<ROOT><PT SportType="9917" BetType="2400" IsLive="0"/></ROOT>',
	@xmlDiscount = '<ROOT><Discount SportType="9916" BetType="2400" Discount="0.008"/></ROOT>'

SET @super_cnt = (SELECT COUNT(*) FROM #tblSMA )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tblSMA
	SET isfinished = 1
		,@custid = custid
		,@srecommend = srecommend
		,@mrecommend = mrecommend
		,@roleid = roleid		
	WHERE isfinished = 0
		
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT

    IF @roleid = 4
    BEGIN		
        UPDATE cs
		SET cs.SuperPT = @PT
			,cs.MasterPT = @PT
			,cs.AgentPT = @PT
			,cs.MinPT = @PT
			,RepUpdateTime = dbo.f_GetDateTime2()
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
        WHERE SportType = 9917
            AND BetType = 2400
            AND custid = @custid

		--update MinPT
        EXEC dbo.Acc_DynamicCustSetting3rd_07 
				@SuperID = @custid
				,@RoleID = 4
				,@SportBettypeXML = @xmlPT  
		
		--update SuperPT
        EXEC dbo.Acc_DynamicCustSetting3rd_04 
            @SuperID = @custid
            ,@RoleID = 4
            ,@SportBettypeXML = @xmlPT
    END
	ELSE IF @roleid = 3
	BEGIN
		UPDATE cs
		SET cs.MasterPT = @PT			
			,cs.MinPT = @PT
			,RepUpdateTime = dbo.f_GetDateTime2()
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		WHERE SportType = 9917
            AND BetType = 2400
            AND custid = @custid

		--update MinPT
		EXEC dbo.Acc_DynamicCustSetting3rd_04 
					@MasterID = @custid
					,@SuperID = @srecommend
					,@RoleID = 3
					,@SportBettypeXML = @xmlPT
		
		--update MasterPT
		EXEC dbo.Acc_DynamicCustSetting3rd_07
				@SuperID = @srecommend
				,@MasterID = @custid
				,@RoleID = 3
				,@SportBettypeXML = @xmlPT			
	END
	ELSE IF @roleid = 2
	BEGIN
		UPDATE cs
		SET cs.AgentPT = @PT
			,cs.MinPT = @PT
			,RepUpdateTime = dbo.f_GetDateTime2()	
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		WHERE SportType = 9917
            AND BetType = 2400
            AND custid = @custid

		--update MinPT
		EXEC dbo.Acc_DynamicCustSetting3rd_04 
				@AgentID = @custid
				,@MasterID = @mrecommend
				,@SuperID = @srecommend
				,@RoleID = 2
				,@SportBettypeXML = @xmlPT

		--update AgentPT  
		EXEC dbo.Acc_DynamicCustSetting3rd_07 
			@SuperID = @Srecommend
			,@MasterID = @mrecommend
			,@AgentID = @custid
			,@RoleID = 2
			,@SportBettypeXML = @xmlPT
	END

	--Update Comm
	EXEC dbo.Acc_DynamicCustSetting3rd_06
			@CustId			= @custid,
			@RoleId			= @RoleId,
			@SettingType		= 19,
			@Discount_XML		= @xmlDiscount

	WAITFOR DELAY @__delaytime
END    

--update PT for dummy supers
;WITH t AS (
	SELECT DISTINCT srecommend AS CustID
	FROM #tblSMA
	WHERE roleid IN (2,3)	
	UNION 
	SELECT DISTINCT srecommend AS CustID
	FROM #tblDirectMember
)
UPDATE cs
SET cs.SuperPT = @PT
	,cs.MasterPT = @PT
	,cs.AgentPT = @PT	
	,RepUpdateTime = dbo.f_GetDateTime2()
FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)	
WHERE SportType = 9917
	AND BetType = 2400	
	AND cs.custid IN (SELECT DISTINCT CustID FROM t)

--update Comm for dummy supers
;WITH t AS (
	SELECT DISTINCT srecommend AS CustID
	FROM #tblSMA
	WHERE roleid IN (2,3)	
	UNION 
	SELECT DISTINCT srecommend AS CustID
	FROM #tblDirectMember
)
UPDATE cs
SET Discount = @Discount	
	,RepUpdateTime = dbo.f_GetDateTime2()
FROM CustDiscount3rd_Agent cs WITH(UPDLOCK,ROWLOCK)	
WHERE SportType = 9916
	AND BetType = 2400	
	AND cs.custid IN (SELECT DISTINCT CustID FROM t)

--update PT for dummy masters
;WITH t AS (
	SELECT DISTINCT mrecommend AS CustID
	FROM #tblSMA
	WHERE roleid IN (2)		
)
UPDATE cs
SET cs.SuperPT = 0
	,cs.MasterPT = @PT	
	,RepUpdateTime = dbo.f_GetDateTime2()
FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)	
WHERE SportType = 9917
	AND BetType = 2400		
	AND cs.custid IN (SELECT CustID FROM t)

--update Comm for dummy masters
;WITH t AS (
	SELECT DISTINCT mrecommend AS CustID
	FROM #tblSMA
	WHERE roleid IN (2)		
)
UPDATE cs
SET Discount = @Discount	
	,RepUpdateTime = dbo.f_GetDateTime2()
FROM CustDiscount3rd_Agent cs WITH(UPDLOCK,ROWLOCK)	
WHERE SportType = 9916
	AND BetType = 2400	
	AND cs.custid IN (SELECT DISTINCT CustID FROM t)