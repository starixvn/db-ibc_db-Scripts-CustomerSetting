/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250807@Johnson	
	Task: Initial Bet Limit for Live Casino for customers [redmine:#235381]
	DB: DBCUST-CustDB
*/
set NOCOUNT on ;

CREATE TABLE #supers (custid int,isfinished bit default(0), currency INT)
CREATE TABLE #tblCust(CustID INT PRIMARY KEY CLUSTERED)
CREATE TABLE #tmpCust (CustID INT PRIMARY KEY CLUSTERED)
DECLARE @tmpStakeLevel TABLE (GameTypeID INT, currency INT, StakeLevelIDs VARCHAR(20))

DECLARE @__waiforDelayStr VARCHAR(50)
SELECT @__waiforDelayStr = [dbo].[f_DelayTime]('CS_Adhoc')

DECLARE @max_custid INT, @srecommend INT, @currency INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid,currency)
SELECT ci.custid, ci.currency
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
    AND ci.currency IN (15,22,33,34,47) --IN,IND,IDD,IDR,DDD
	AND ci.custid <= @max_custid

INSERT INTO @tmpStakeLevel (GameTypeID, currency, StakeLevelIDs)
SELECT GameTypeID, ExchangeId,  STRING_AGG(CAST(StakeLevelID AS VARCHAR), ',') AS StakeLevelIDs
FROM StakeLevel WITH (NOLOCK)
WHERE ExchangeId IN (15,22,33,34,47) --IN,IND,IDD,IDR,DDD
    AND 1 = CASE WHEN GameTypeID = 3151 AND MinStake IN (500,1000) AND MaxStake IN (200000,300000) THEN 1 --Yeebet
                WHEN GameTypeID = 3001 AND MinStake IN (2000) AND MaxStake IN (200000) THEN 1 --SA Gaming
                WHEN GameTypeID = 12000 AND MinStake IN (500,1000) AND MaxStake IN (100000,300000) THEN 1 --W Casino
                WHEN GameTypeID = 3101 AND MinStake IN (3000) AND MaxStake IN (300000) THEN 1 --AE Sexy
                ELSE 0 END
GROUP BY GameTypeID, ExchangeId				

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0, 
        @BeginTime DATETIME, @EndTime DATETIME, @ShowTime DATETIME,  @ConfigID INT
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
        ,@currency = currency
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	INSERT INTO #tblCust (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend 	
		AND Enabled = 1 
        AND roleid IN (2,3,4)
		AND custid <= @max_custid

    WHILE(1=1)
    BEGIN
        DELETE TOP (500) t
        OUTPUT DELETED.CustID INTO #tmpCust(custid)
        FROM #tblCust t        

        IF @@ROWCOUNT = 0 BREAK 

        UPDATE cs 
        SET cs.StakeLevelList = cs.StakeLevelList + ',' + t.StakeLevelIDs,			
			RepUpdateTime = dbo.f_GetDateTime2()
        FROM CustStakeLevel_Agent cs WITH (ROWLOCK) 
		CROSS APPLY (SELECT * FROM @tmpStakeLevel WHERE currency = @currency AND cs.Bettype = GameTypeID) t
        WHERE custid IN (SELECT CustID FROM #tmpCust)   
			AND StakeLevelList <> ''        

        DELETE FROM #tmpCust   

		WAITFOR DELAY @__waiforDelayStr -- waifor adhoc script 
    END
			    		
END
DROP TABLE #tblCust
DROP TABLE #tmpCust
DROP TABLE #supers
GO