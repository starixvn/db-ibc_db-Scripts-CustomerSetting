/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200924@Eden
	Task: Insert testing for  Dep_UMConfig table [Redmine:#136741]	
		FunctionType : 1.FirstDeposit
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO
DELETE FROM Dep_UMConfig WITH(ROWLOCK)

DECLARE @BeginDate SMALLDATETIME, @EndDate SMALLDATETIME

SELECT @BeginDate = GETDATE(), @EndDate = DATEADD(hour,4,@BeginDate)

INSERT INTO Dep_UMConfig(FunctionType,ProductID,SettingType,LicenseeID,BeginTime,EndTime)
VALUES (1,0,0,0,@BeginDate,@EndDate)

SELECT * FROM Dep_UMConfig WITH(NOLOCK)
