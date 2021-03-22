/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210319@Eden
	Task: Turn on Dep UM config for 1st deposit [RM#151213]
	DB: DBCUST/CustDB
*/
USE CustDB
GO
DECLARE @BeginTime DATETIME = '2021/03/23 10:00'
DECLARE @EndTime DATETIME = '2021/03/23 10:05'
SELECT @BeginTime = DATEADD(hh,-11,@BeginTime)
SELECT @EndTime = DATEADD(hh,-11,@EndTime)

DELETE FROM Dep_UMConfig WITH(ROWLOCK)

INSERT INTO Dep_UMConfig (FunctionType,ProductID,SettingType,LicenseeID,BeginTime,EndTime)
SELECT 1,0,0,0,@BeginTime,@EndTime
