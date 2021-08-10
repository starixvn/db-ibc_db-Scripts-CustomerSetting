/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20210810
	Task:  Disable TableGame for njp1996 RedmineID:#159956
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @BitmapOrder TINYINT = 16

UPDATE cs
SET cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1)) 	
FROM Dep_CustProductStatus cs WITH(ROWLOCK)
WHERE cs.custid = 44824108