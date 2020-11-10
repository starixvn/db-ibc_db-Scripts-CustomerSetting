/*
	Created: Winfred
	Date: 20200828
	Task: Block add new cust and restore DB for WM [Redmine: 131589]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

--> Step 1 add config to block add new cust
DECLARE @UnblockTime VARCHAR(50) = '11:35 AM (GMT+8)' -- time unblock add new cust

UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 1,
	UnblockTime = @UnblockTime

-- Setting UMConfig . GMT -4
DECLARE  @SiteID INT,@FunctionType INT , @BeginTime SMALLDATETIME,  @EndTime SMALLDATETIME, @ShowTime SMALLDATETIME
DECLARE @Currency TABLE(currency INT)

SELECT  @SiteID =  0, @FunctionType = 2, @BeginTime = '2020-11-09 22:50:00' , @ShowTime = '2020-11-09 22:15:00'
SELECT @EndTime = DATEADD(MINUTE,45,@BeginTime)

INSERT INTO @Currency (currency)
SELECT 15 --IN
UNION ALL SELECT 45 --Won
UNION ALL SELECT 2  --RM
UNION ALL SELECT 5  --HK$
UNION ALL SELECT 13 --RMB
UNION ALL SELECT 66 --YUN
UNION ALL SELECT 43 --THB
UNION ALL SELECT 3  --US$
UNION ALL SELECT 16 --Yen
UNION ALL SELECT 35 --$US
UNION ALL SELECT 64 --UT
UNION ALL SELECT 95 --USD
UNION ALL SELECT 51 --INH
UNION ALL SELECT 67 --HKK
UNION ALL SELECT 4  --TB
UNION ALL SELECT 22 --IND
UNION ALL SELECT 33 --IDD
UNION ALL SELECT 34 --IDR
UNION ALL SELECT 47 --DDD

INSERT INTO UMConfig(ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID,BeginTime,EndTime,ShowTime,LockAddingNew)
SELECT  0 AS ProductID , 0 AS SportType , 0 AS BetType , 0 AS  IsLive, 0 AS SettingType, @FunctionType AS FunctionType , @SiteID AS SiteID ,Currency , 0 AS SuperID, 
@BeginTime AS BeginTime,
@EndTime AS EndTime,
@ShowTime AS ShowTime,
1 AS LockAddingNew
FROM @Currency


--> Step 2 : Restore DB to DBNOTI.CustDB_AdjustCS
