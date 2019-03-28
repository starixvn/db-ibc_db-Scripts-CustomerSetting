/*
	Created: Elodie
	Task: Update PT settings of SB for licensees [RedmineID: #110111]
	DB: DBTXN/bodb02
	Date: 20190313
*/ 
USE bodb02
GO 

DECLARE @MaxTransId BIGINT

SELECT @MaxTransId = xxx
CREATE TABLE #supers (custid INT, PT SMALLMONEY)
CREATE TABLE #tmpAgent (CustID INT PRIMARY KEY, PT SMALLMONEY)	
CREATE TABLE #tmpTrans (CustId INT, TransId BIGINT, PT SMALLMONEY)	
CREATE TABLE #tmpTable (TransId BIGINT, PT SMALLMONEY)	
CREATE TABLE #tmpSportBettypeMatrix (bettype SMALLINT)
DECLARE @TransIdList XML, @TransIdStr VARCHAR(MAX)

INSERT INTO #supers(custid, PT)
SELECT ci.custid, 
	CASE	WHEN cs.site IN ('BBIN2', 'HAIFA') THEN 0.925
			WHEN cs.site IN ('asiabet88', 'TLC', 'IBO', 'ZT828') THEN 0.91
			ELSE 0.88 END
FROM CustDB.dbo.custInfo ci WITH (NOLOCK) 	
	INNER JOIN CustDB.dbo.Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.Enabled=1
	AND cs.site IN(	'12Bet','asiabet88','mansion88','alog','spondemo','TLC','SunGame','MayFair','Zzun88','HAIFA','Bodog','Vwin','Macaubet',
					'Aoncash','ITCBet','Athena000','Avia','W88','9bet','3star88','OLE777','88Macao','Boma365','Salon365','Ae88','Hengcai88',
					'368Cash','Royal','Senibet','Happy1668','AG','M8bola','KeenOcean','9Club','XTD3','HONBET','Q8bola','BE7','iBET','ISC888',
					'Liga','NBCbet','HonorW','WeBet168','DEWA','IBO','Unobet','GamingSoft','Newhonbet','Hecbet','DBP','HL8','Abcasino','TGO',
					'Starnet','365online','NextBet','Bolanation','KhmerG','Gampag','IONclub','Sun988','Mayayule','HuangMa','Webet138','webet88',
					'BigGaming','Boying','Brown888','MrCat','CGame','PKbet','VCBA','Taipanbet','FLC','IGPTech','BetStar','TGame','Dawoo','Ty777',
					'IvoryBet','Uwoniwin','Opal88','Sunrise','Swin','UN168','PanguGame','K8VN','ECLBET','GPIGAME','818Bet','SSSSEA',
					'Heaven','Bobo88','OPEBET','Jinyazhou','Sunriseb2b','Okada','396Club','Mybet88','e8casino','HongChow','TangChao','MAX88',
					'BBIN2','YongBao','Fugui','GMASTER','ALPHA88','Tripleone','GWORLD','ENTAPLAY','MICL','zt828','9wickets','Aplus',
					'Arlocash','WBS','YBTech','Yibo','24TECH','Xinbo','BETSUN','HOT88','Monaco','Opadmin','Bonanza88','SSSGaming','JIBET',
					'WINCLUB88','MARS','Dade','Nbbet','Gameroom','ANGbet','Callmeboss','Hong88','BetDeal','SampleSite','VWIN66',
					'A1game','HJTK','TitanOne','gbkj','skykey','Dachen','Bobbet','laba360','AEUG','XinYo','18Luck','Mbet','Kudatogel','WinWin',
					'HCVIP','ig128','AMG','MRCATSB','VN88','TXG','Sin88','Zbet','Debet','Kraton','pinbo','Win68Club','Sunwin')


INSERT INTO #tmpAgent(CustID, PT)
SELECT ci.CustID, PT
FROM CustDB.dbo.custInfo ci WITH(NOLOCK)
	INNER JOIN #supers s ON ci.srecommend = s.custid
WHERE roleid = 2

INSERT INTO #tmpSportBettypeMatrix (bettype)
SELECT DISTINCT bettype FROM SportBettypeMatrix WITH (NOLOCK) WHERE productID = 1 

INSERT INTO #tmpTrans(CustId, TransId, PT)
SELECT b.CustID, TransId, PT
FROM dbo.bettrans b WITH (NOLOCK)
	INNER JOIN #tmpAgent a ON b.recommend = a.CustID
	INNER JOIN #tmpSportBettypeMatrix mt ON b.bettype = mt.BetType
WHERE b.winlostdate > '2019-04-01 00:00:00'
	AND b.statusID IN (0,1)
	AND TransId <= @MaxTransId
	AND b.apositiontaking <> 0

WHILE EXISTS(SELECT 1 FROM #tmpTrans)
BEGIN
	DELETE TOP (2500) #tmpTrans OUTPUT DELETED.TransId, Deleted.PT INTO #tmpTable

	SELECT @TransIdList = (SELECT (
									SELECT  bt.TransId	AS '@T',
											bt.PT		AS '@PT'
									FROM #tmpTable bt
									FOR XML PATH('C'), 
									TYPE
								)
						FOR XML PATH('R'), 
						TYPE)
	
	SELECT @TransIdStr = CONVERT(VARCHAR(MAX), @TransIdList)
	EXEC Acc_ExecRep_09 @TransIdList = @TransIdStr

	TRUNCATE TABLE #tmpTable
	WAITFOR DELAY '00:00:0.100'
END

/*
DROP TABLE #supers
DROP TABLE #tmpAgent
DROP TABLE #tmpSportBettypeMatrix
DROP TABLE #tmpTable
DROP TABLE #tmpTrans
*/