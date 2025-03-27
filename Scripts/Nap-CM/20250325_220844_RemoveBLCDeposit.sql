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

CREATE TABLE #Cust (CustID INT, BetLimitTypeID INT, PRIMARY KEY(CustID ,BetLimitTypeID))
CREATE TABLE #CustTemp (CustID INT, BetLimitTypeID INT, PRIMARY KEY(CustID ,BetLimitTypeID))
-- SMA
INSERT INTO #Cust(CustID, BetLimitTypeID)
SELECT a.CustID, BetLimitTypeID 
FROM Customer a WITH(NOLOCK) 
CROSS APPLY (SELECT TOP (@LimitRow) BetLimitTypeID FROM BetLimitControlCustSetting WITH(NOLOCK) WHERE custid = a.CustID) kq
WHERE roleid  > 1 
	AND Site IN ('asiabet88','haifa','KUTECH','AEUG','awc','awc2','wmcasino','Winbox','N8BK','win365','Diamond','ZFRT144','win365','TGAA0813','VKGAME','SL88SW','WINHX1') 
	AND srecommend IN (932181,4359240,38469043,39640832,42676337,42713130,43194384,43454879,45250318,47585951,48508238,49145458,52761432,54329925,55254111,55539328,64605456)
	AND NOT EXISTS( SELECT TOP 1 1 FROM #Cust where custid = a.CustID)

INSERT INTO #Cust(CustID, BetLimitTypeID)
SELECT a.CustID, BetLimitTypeID 
FROM Customer a WITH(NOLOCK) 
CROSS APPLY (SELECT TOP (@LimitRow) BetLimitTypeID FROM BetLimitControlCustSetting WITH(NOLOCK) WHERE custid = a.CustID) kq
WHERE roleid = 1 
	AND Site IN ('asiabet88','haifa','Athena000','W88','OLE777','IBO','365online','Gampag','BigGaming','Dawoo','GPIGAME','VWIN66','Happy8','allwincity','KUTECH','MANBETX','Diamond','18LuckV2','W88') 
	AND recommend IN (932255,4359308,10063439,10580724,12252959,16379948,37973122,21536367,22773653,24509705,26241485,35562403,36003658,38103527,38469045,43054417,48508240,79573319,81953911)
	AND NOT EXISTS( SELECT TOP 1 1 FROM #Cust where custid = a.CustID)

INSERT INTO #Cust(CustID, BetLimitTypeID)
SELECT a.CustID, a.BetLimitTypeID 
FROM BetLimitControlCustSetting a WITH(NOLOCK) 
WHERE NOT EXISTS( SELECT TOP 1 1 FROM #Cust where custid = a.CustID)
  AND NOT EXISTS( SELECT TOP 1 1 FROM CustInfo where custid = a.CustID)


WHILE EXISTS(SELECT TOP 1 1 FROM #Cust)
BEGIN
	DELETE TOP (@batch) #Cust 
	OUTPUT DELETED.CustID,DELETED.BetLimitTypeID 
	INTO #CustTemp(CustID,BetLimitTypeID)

	IF @@ROWCOUNT=0
		BREAK		

	DELETE cg
	OUTPUT DELETED.CustID, DELETED.BetLimitTypeID, [dbo].[f_GetDateTime2]()
	INTO [dbo].[BetLimitControlCustSetting_Del_InHouse]([CustID], [BetLimitTypeID], [RepUpdateTime])
	FROM dbo.BetLimitControlCustSetting cg WITH(ROWLOCK)		
		INNER JOIN #CustTemp t ON cg.CustID=t.CustID AND cg.BetLimitTypeID=t.BetLimitTypeID

	TRUNCATE TABLE #CustTemp

	WAITFOR DELAY '00:00:00.100'

END


DROP TABLE #Cust
DROP TABLE #CustTemp