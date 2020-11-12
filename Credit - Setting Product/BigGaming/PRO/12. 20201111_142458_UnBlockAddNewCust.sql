/*
	Created: 20201111@Tina
	Task: Unblock add new cust for Big Gaming [Redmine: #142458]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
	
---- Setting UMConfig . GMT -4
DECLARE  @SiteID INT,@FunctionType INT , @BeginTime SMALLDATETIME,  @EndTime SMALLDATETIME, @ShowTime SMALLDATETIME
DECLARE @Currency TABLE(currency INT)
DECLARE @ProductID INT = 41, @SportType INT = 243, @BetType INT = 0 --AE Casino

SELECT  @SiteID =  0, @FunctionType = 1
SELECT @EndTime = DATEADD(MINUTE,45,@BeginTime) 
SELECT @EndTime = DATEADD(MINUTE,10,@EndTime) 

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

DELETE UM 
FROM UMConfig UM
	INNER JOIN  @Currency C 
			ON UM.ProductID = @ProductID
			AND UM.SportType = @SportType
			AND UM.BetType = @BetType
			AND UM.IsLive = 0
			AND UM.SettingType = 0
			AND UM.FunctionType = @FunctionType 
			AND UM.SiteID = @SiteID
			AND UM.currency = C.Currency
			AND UM.SuperID = 0

--select * from UMConfig with (nolock)