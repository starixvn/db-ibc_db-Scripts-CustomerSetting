/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250725@Johnson	
	Task: Update OfferOption = 0 for customers [redmine:#230652]
	DB: DBCUST-CustDB
*/
set NOCOUNT on ;

CREATE TABLE #supers (custid int,isfinished bit default(0))
CREATE TABLE #tblCust(CustID INT PRIMARY KEY CLUSTERED)
CREATE TABLE #tmpCust (CustID INT PRIMARY KEY CLUSTERED)

DECLARE @__waiforDelayStr VARCHAR(50)
SELECT @__waiforDelayStr = [dbo].[f_DelayTime]('CS_Adhoc')

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	--AND ci.currency = 20

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
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	INSERT INTO #tblCust (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend 	
		AND Enabled = 1 
		AND custid <= @max_custid

    WHILE(1=1)
    BEGIN
        DELETE TOP (1000) t
        OUTPUT DELETED.CustID INTO #tmpCust(custid)
        FROM #tblCust t        

        IF @@ROWCOUNT = 0 BREAK 

        UPDATE CustPotentialWinLimit WITH (ROWLOCK)
        SET OfferOption = 0,
			RepUpdateTime = dbo.f_GetDateTime2()
        WHERE custid IN (SELECT CustID FROM #tmpCust)           

        DELETE FROM #tmpCust   

		WAITFOR DELAY @__waiforDelayStr -- waifor adhoc script 
    END
			    		
END
DROP TABLE #tblCust
DROP TABLE #tmpCust
DROP TABLE #supers
GO

