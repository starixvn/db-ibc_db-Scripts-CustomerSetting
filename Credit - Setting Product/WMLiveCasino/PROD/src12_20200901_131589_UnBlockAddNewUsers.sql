/*
	Created: Winfred
	Date: 20200828
	Task: Unblock add new cust for WM [Redmine: 131589]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL
	
---- Setting UMConfig . GMT -4
--DECLARE  @SiteID INT,@FunctionType INT , @BeginTime SMALLDATETIME,  @EndTime SMALLDATETIME, @ShowTime SMALLDATETIME
--DECLARE @Currency TABLE(currency INT)

--SELECT  @SiteID =  0, @FunctionType = 2, @BeginTime = '2020-11-09 22:50:00' , @ShowTime = '2020-11-09 22:15:00'
--SELECT @EndTime = DATEADD(MINUTE,45,@BeginTime) 
--SELECT @EndTime = DATEADD(MINUTE,10,@EndTime) 

--INSERT INTO @Currency (currency)
--SELECT 15 --IN
--UNION ALL SELECT 45 --Won
--UNION ALL SELECT 2  --RM
--UNION ALL SELECT 5  --HK$
--UNION ALL SELECT 13 --RMB
--UNION ALL SELECT 66 --YUN
--UNION ALL SELECT 43 --THB
--UNION ALL SELECT 3  --US$
--UNION ALL SELECT 16 --Yen
--UNION ALL SELECT 35 --$US
--UNION ALL SELECT 64 --UT
--UNION ALL SELECT 95 --USD
--UNION ALL SELECT 51 --INH
--UNION ALL SELECT 67 --HKK
--UNION ALL SELECT 4  --TB
--UNION ALL SELECT 22 --IND
--UNION ALL SELECT 33 --IDD
--UNION ALL SELECT 34 --IDR
--UNION ALL SELECT 47 --DDD

DELETE FROM UMConfig
--INNER JOIN  @Currency b ON A.Currency = b.currency AND a.SiteID = @SiteID AND a.FunctionType =  @FunctionType AND  a.BeginTime = @BeginTime AND a.EndTime = @EndTime AND a.ShowTime = @ShowTime
