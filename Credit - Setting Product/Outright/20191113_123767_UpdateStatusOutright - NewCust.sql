/*
	Created: 20191113@Winnie
	Task : new customer, Update status Outright RedmineID:#123676 
	DB:  DBCUST/CustDB
*/
 

DECLARE @srecommend INT,
		@max_custid INT

CREATE TABLE #Super(CustID INT)

SELECT @max_custid = xxx


INSERT INTO #Super(custid)
SELECT c.custid 
FROM dbo.customer c WITH (Nolock) 
WHERE c.username IN('SDGB','SDGD','SDGH','SDGI','SDGJ','SDGM','SDGR','SDGU','SDGV','SDGW',
'SDGY','SDP3','SDP4','SDP6','SDP7','SDP8','SDP9','SDPA','SDPB','SDPC','SDPD',
'SDPQ','SDPR','SDPS','SDPT','SJK9','TV0','TV42','TV46','TV4A','TV4B','TV4U',
'TV50','TV74','TV7D','TV7U','TV8F','TV8G','TV8H','TV8I','TV8J','TVA2U','TVA47',
'TVA5','TVA58','TVA82','TVA8A','TVA8H','TVA8Z','TVA92','TVA93','TVA98','TVBA','TVG2',
'TVS2','TVSR','TVST','TVSU','TVSV','TVSX','TVUD','TVUJ','TVUS','TVUU','TVUV',
'TVV7','TVVD','TVVM','TVVX','TVW2','TVW8','TVWK','TVWN','TVWP','TVWS','TVWU',
'TVWV','XTV1N','XTV1U','XTV1V','XTV1W','XTV1X','XTV27','XTV2A','XTV2B','XTV34','XTV37','XTV38','XTV40','XTV42')

UPDATE c
SET DisableOutright = 0
FROM Custinfo c WITH(ROWLOCK,UPDLOCK)
WHERE srecommend IN(SELECT custid FROM #Super)
AND custid>@max_custid AND c.roleid IN(2,3,4) AND DisableOutright = 1

	