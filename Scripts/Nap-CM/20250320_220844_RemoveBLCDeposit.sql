/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250319@Winfred
	Task: [NAP CM] - Bet Limit Control Cleanup for 14 millions deposit members [RedmineID: #220844]
	DB: DBCUST-CustDB
	Description: Remove data Deposit Bet Limit Control
*/
USE CustDB
GO

DECLARE @batch INT, @LimitRow TINYINT;

SELECT @batch = 2000

select @LimitRow = count(BetLimitTypeID) from BetLimitControlType with(nolock)

CREATE TABLE #DownLine (CustID INT, BetLimitTypeID INT, PRIMARY KEY(CustID ,BetLimitTypeID))
CREATE TABLE #DownLineTemp (CustID INT, BetLimitTypeID INT, PRIMARY KEY(CustID ,BetLimitTypeID))

INSERT INTO #DownLine(CustID, BetLimitTypeID)
SELECT a.CustID, BetLimitTypeID 
FROM CustInfo a WITH(NOLOCK) 
CROSS APPLY (SELECT TOP (@LimitRow) BetLimitTypeID FROM BetLimitControlCustSetting WITH(NOLOCK) WHERE custid = a.CustID) kq
WHERE roleid  = 1 
	AND srecommend in (45250318 ) 
	AND NOT EXISTS( SELECT TOP 1 1 FROM #DownLine where custid = a.CustID)

INSERT INTO #DownLine(CustID, BetLimitTypeID)
SELECT a.CustID, BetLimitTypeID 
FROM CustInfo a WITH(NOLOCK) 
CROSS APPLY (SELECT TOP (@LimitRow) BetLimitTypeID FROM BetLimitControlCustSetting WITH(NOLOCK) WHERE custid = a.CustID) kq
WHERE roleid = 1 
	AND mrecommend in (39640833,101501461,94941478,60717589,55539329,49368694,49437990) 
	AND NOT EXISTS( SELECT TOP 1 1 FROM #DownLine where custid = a.CustID)

INSERT INTO #DownLine(CustID, BetLimitTypeID)
SELECT a.CustID, BetLimitTypeID 
FROM CustInfo a WITH(NOLOCK) 
CROSS APPLY (SELECT TOP (@LimitRow) BetLimitTypeID FROM BetLimitControlCustSetting WITH(NOLOCK) WHERE custid = a.CustID) kq
WHERE roleid = 1 
	AND recommend in (4833644,89188630) 
	AND NOT EXISTS( SELECT TOP 1 1 FROM #DownLine where custid = a.CustID)


WHILE EXISTS(SELECT TOP 1 1 FROM #DownLine)
BEGIN
	DELETE TOP (@batch) #DownLine 
	OUTPUT DELETED.CustID,DELETED.BetLimitTypeID 
	INTO #DownLineTemp(CustID,BetLimitTypeID)

	IF @@ROWCOUNT=0
		BREAK		

	DELETE cg
	OUTPUT DELETED.CustID, DELETED.BetLimitTypeID, [dbo].[f_GetDateTime2]()
	INTO [dbo].[BetLimitControlCustSetting_Del_InHouse]([CustID], [BetLimitTypeID], [RepUpdateTime])
	FROM dbo.BetLimitControlCustSetting cg WITH(ROWLOCK)		
		INNER JOIN #DownLineTemp t ON cg.CustID=t.CustID AND cg.BetLimitTypeID=t.BetLimitTypeID

	TRUNCATE TABLE #DownLineTemp

	WAITFOR DELAY '00:00:00.100'

END


DROP TABLE #DownLine
DROP TABLE #DownLineTemp