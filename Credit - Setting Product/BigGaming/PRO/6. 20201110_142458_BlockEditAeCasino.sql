/*
	Created: 20201110@Tina
	Task: Block add new cust and restore DB for Big Gaming [Redmine: #142458]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

--> Step 1 add config to block add new cust
DECLARE @UnblockTime VARCHAR(50) = '11:35 AM (GMT+8)' -- time unblock add new cust

-- Setting UMConfig . GMT -4
DECLARE  @SiteID INT,@FunctionType INT , @BeginTime SMALLDATETIME,  @EndTime SMALLDATETIME, @ShowTime SMALLDATETIME
DECLARE @Currency TABLE(currency INT)
DECLARE @ProductID INT = 41, @SportType INT = 243, @BetType INT = 3101 --AE Casino

SELECT  @SiteID =  0, @FunctionType = 1, @BeginTime = '2020-xx-xx 22:50:00' , @ShowTime = '2020-xx-xx 22:15:00'
SELECT @EndTime = DATEADD(MINUTE,45,@BeginTime)

INSERT INTO @Currency (currency)
SELECT 13 -- CNY(RMB)
UNION ALL SELECT 15-- IDR(IN)
UNION ALL SELECT 22-- IDR(IND)
UNION ALL SELECT 33-- IDR(IDD)
UNION ALL SELECT 34-- IDR(IDR)
UNION ALL SELECT 47-- IDR(DDD)
UNION ALL SELECT 51-- VND(INH)
UNION ALL SELECT 2-- MYR(RM)
UNION ALL SELECT 43-- THB(THB)
UNION ALL SELECT 69-- MMK(MMK)
UNION ALL SELECT 3-- USD(US$)
UNION ALL SELECT 16-- USD(Yen)
UNION ALL SELECT 35-- USD($US)
UNION ALL SELECT 64-- USD(UT)
UNION ALL SELECT 95-- USD(USD)
UNION ALL SELECT 6-- EUR(EURO)
UNION ALL SELECT 12-- GBP(GBP)

INSERT INTO UMConfig(ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID,BeginTime,EndTime,ShowTime,LockAddingNew)
SELECT  @ProductID AS ProductID , 
		@SportType AS SportType , 
		@BetType AS BetType , 
		0 AS  IsLive, 
		0 AS SettingType, 
		@FunctionType AS FunctionType , 
		@SiteID AS SiteID ,
		C.Currency , 
		0 AS SuperID, 
		@BeginTime AS BeginTime,
		@EndTime AS EndTime,
		@ShowTime AS ShowTime,
		1 AS LockAddingNew
FROM @Currency C


--> Step 2 : Restore DB to DBNOTI.CustDB_AdjustCS
