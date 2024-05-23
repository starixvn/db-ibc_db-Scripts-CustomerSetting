/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240408@Tacy
	Task: Turn on Dep UM config for 1st deposit [RM#202273]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @BeginTime DATETIME = '2024/05/22 10:00'		--release date
DECLARE @EndTime DATETIME = '2024/05/22 10:05'
SELECT @BeginTime = DATEADD(hh,-11,@BeginTime)	--GMT -4
SELECT @EndTime = DATEADD(hh,-11,@EndTime)

DELETE FROM Dep_UMConfig WITH(ROWLOCK)

INSERT INTO Dep_UMConfig (FunctionType,ProductID,SettingType,LicenseeID,BeginTime,EndTime)
SELECT 1,0,0,0,@BeginTime,@EndTime
GO