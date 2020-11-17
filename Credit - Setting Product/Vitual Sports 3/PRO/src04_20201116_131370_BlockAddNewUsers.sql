/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201116
	Task: Block add new cust [RedmineID:#131370]
	DB: DBCust/CustDB
*/
------------------------------------------------------
USE CustDB
GO

PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
--> Step 1 add config to block add new cust
-- Setting UMConfig . GMT -4
DECLARE  @SiteID INT,@FunctionType INT , @BeginTime SMALLDATETIME,  @EndTime SMALLDATETIME, @ShowTime SMALLDATETIME ,@Currency INT

SELECT  @SiteID =  0,@Currency = 0, @FunctionType = 1, @BeginTime = '2020-11-09 22:50:00' , @ShowTime = '2020-11-09 22:15:00'
SELECT @EndTime = DATEADD(MINUTE,45,@BeginTime)


INSERT INTO UMConfig(ProductID,SportType,BetType,IsLive,SettingType,FunctionType,SiteID,Currency,SuperID,BeginTime,EndTime,ShowTime,LockAddingNew)
SELECT  5 AS ProductID , 180 AS SportType , 1201 AS BetType , 0 AS  IsLive, 0 AS SettingType, @FunctionType AS FunctionType , @SiteID AS SiteID ,@Currency AS Currency , 0 AS SuperID, 
@BeginTime AS BeginTime,
@EndTime AS EndTime,
@ShowTime AS ShowTime,
1 AS LockAddingNew

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
