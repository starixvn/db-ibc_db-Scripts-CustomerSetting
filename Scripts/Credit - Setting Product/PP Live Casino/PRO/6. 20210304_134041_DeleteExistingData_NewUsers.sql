/*
	Created: 20210304@Tina
	Task: Delete existing data of PP Live Casino - Real Currency
	DB: DBCUST/CustDB
	
*/
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
USE CustDB
GO

PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @SportType SMALLINT = 170
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #supers (custid int)

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
	AND ci.Site<>'CN88'
	AND ci.currency IN (13, --CNY(RMB)
						6, --EUR(EURO)
						12, --GBP(GBP)
						5, --HKD(HK$)
						67, --HKD(HKK)
						47, --IDR(DDD)
						33, --IDR(IDD)
						34, --IDR(IDR)
						15, --IDR(IN)
						22, --IDR(IND)
						45, --KRW(Won)
						69, --MMK(MMK)
						2, --MYR(RM)
						43, --THB(THB)
						35, --USD($US)
						3, --USD(US$)
						95, --USD(USD)
						64, --USD(UT)
						16, --USD(Yen)
						51 --VND(INH)
					) --supported currencies

DELETE cg
FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID= c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType = @SportType
	AND cg.AgentID > @maxcustID


DELETE cg
FROM dbo.CustDiscount3rd_Agent cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustDiscount3rd_Member cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType = @SportType
	AND cg.custid > @maxcustID


DELETE cg
FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType = @SportType
	AND cg.custid > @maxcustID



PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
