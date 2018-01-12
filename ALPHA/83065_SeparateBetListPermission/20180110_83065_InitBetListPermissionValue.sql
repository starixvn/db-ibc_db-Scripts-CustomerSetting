/*
	Created: 20180110@Vicky
	Task: Initiate Bet List permission value for sub account
	DB: DBCUST/CustDB
*/
USE CustDB
GO

IF OBJECT_ID('tempdb..#Selected') IS NOT NULL DROP TABLE #Selected
GO
IF OBJECT_ID('tempdb..#Batch') IS NOT NULL DROP TABLE #Batch
GO
CREATE TABLE #Selected (subaccid integer PRIMARY KEY, PageAccess varchar(50));
CREATE TABLE #Batch (subaccid integer PRIMARY KEY, PageAccess varchar(50));

INSERT #Selected (subaccid, PageAccess)
SELECT subaccid, PageAccess
FROM dbo.custSub AS c
WHERE PageAccess LIKE '%[E]%' OR PageAccess LIKE '%[D]%'

WHILE 1 = 1
BEGIN

    INSERT #Batch (subaccid, PageAccess)
    SELECT s.subaccid, s.PageAccess 
    FROM 
    (
        DELETE TOP (5000) #Selected
        OUTPUT DELETED.subaccid,DELETED.PageAccess
    ) AS s;


    IF @@ROWCOUNT = 0 BREAK;


    UPDATE dbo.custSub WITH (rowlock)
    SET PageAccess = PageAccess + '[L]'
    WHERE subaccid IN (SELECT b.subaccid FROM #Batch AS b)

    TRUNCATE TABLE #Batch;
END


