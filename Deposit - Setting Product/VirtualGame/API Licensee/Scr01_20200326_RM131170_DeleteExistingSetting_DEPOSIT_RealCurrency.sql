/*
	Created: Elodie
	Date: 20200326
	Task: DELETE existed setting for Virtual game DEPOSIT - Real Currency
	DB: DBCust/CustDB
*/

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT
SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency NOT IN (72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)
 AND s.site IN ('KeenOcean','Champion','Sunrise','GESAB','Mayayule','CGame4','ID88','ANGbet','ALPHA88','SSSGaming','YBTech','JIBET','JGQP8','MICL','afb99','DTGW',
				'WUYICP','Siamgame','gbkj','BPLE','TLC','BWGaming','ENTAPLAY','Lucky88','HCVIP','PKbet','MRCATSB','G2Win','ZhiFeng035','Webet88','Sunriseb2b','Aoncash',
				'Huangma','Taipanbet','TaoCai','818Bet','erhaozhan','Brown888','mtegames','Happy1668','allwincity','BetDeal','12bet','Bobbet','Lagadewa','Datang','Haifa',
				'AEUG','Fabet','Zowin','GGBOOKES','Hecbet','18Luck','Uwoniwin','NewFuture','WKCUR','NewHonbet','Lode88','396Club','Callmeboss','DEWA','368Cash','TYCgame',
				'365online','9wickets','GamingSoft','hjccasino','TitanOne','Win88','Mopgaming','GMASTER','ALog','Soon88','Boma365','Wanbo','Onegaming','Dade','BOSSB',
				'Mbet','IBO','Debet','WKPHIL','IvoryBet','sbt88','Liga','Happy8','Hong88','Opadmin','MAX88','A1game','VCBA','9Bet','9Wsports','FLC','HonorW','FB88',
				'Raisetech','VN88','TitanCraft','PanguGame','B24VN','Xtu168','Winn69','Heaven','Sin88','Bodog','MTech','INSERTGAME','Mybet88','Nbbet','BETSUN','PKKing',
				'VWIN66','KhmerG','ig128','shengboyun','Bonanza88','UN168','TopGame','Boying','ECLBET','Gampag','JIDU','Q8Bola','GGBOOK','m8bola','NBCbet','Monaco',
				'Apollo','Bolanation','OCMS','Gameroom','Yabo3','Mansion88','txwl002','KUTECH','BOG22','XTD3','OPEBET','e8casino','DingTai','HBO999','Okada','Yibo',
				'Luckywin88','Five88','Senibet','Monstergol','N8G','Bobo88','MARS','88Macao','Ratugg','AE88','Sunwin','UwinY','AsiaBet88','88Goals','XTDGT','dabo88',
				'Yunji','Kudatogel','ZhiFeng032','zt828','W88','Pinbo','BBIN2','Sun988','JZFortune','Kraton','Heji888','ABcasino','Newbet','WBG88','Aplus','YongBao',
				'One88','Red88','MFgame','Athena000','Unobet','YTX','633esports','Royal','ISC888','CGame','BE7','OneSports','12B','Macaubet','SampleSite','K8VN',
				'WKIBPH','AnvoFH','starsoccer','Sunbet138','XinYo','iBET','Starnet','IONclub','Salon365','Xinbo','weicai','Leng4D','9Club','WBS','NextBet','HJTK',
				'Sungame','ITCBET','Spondemo','Dawoo','3Star88','Gaobet','Storm88','Tianbo','IGPTech','BigGaming','Nova88','Axiawin','TCbet','WINCLUB88','AMG','HL8',
				'TGame','Swin','Wanfang','Jarvis','KingBet','24AVIA','BBIN3','Honbet','GPIgame','11bet','DBP','LLGAME','N88','Ole777','Zbet','IBG','TangChao',
				'Tripleone','YAYOU','N8B','skykey','Weiwei','Datang001','Opal88','QASite','AG','Spark','Jumbo88','ENT22','TGO','DF88')

DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype(SportType, BetType) VALUES (245, 4601)

------------------------------------PT Setting-------------------------------------------------	
SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustPTSetting_Agent
FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_CustPTSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustPTSetting_Member
FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_CustPTSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.AgentID,a.SportType,a.BetType
INTO #Dep_CustPTGroupSetting_Member
FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.AgentID = ci.custid
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustPTGroupSetting_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_CustPTGroupSetting_Member t ON a.AgentID = t.AgentID AND a.SportType = t.SportType and a.BetType = t.BetType 

-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustStakeLevel_Agent
FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid 
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_CustStakeLevel_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustStakeLevel_Member
FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_CustStakeLevel_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

-------------
SELECT dl.CustID,dl.ProductSettingID
INTO #Dep_LicenseeProductSetting
FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
		INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
		INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
		INNER JOIN #supers s ON ci.custid = s.custid
WHERE dp.ProductID = 38

DELETE a
FROM Dep_LicenseeProductSetting a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_LicenseeProductSetting t ON a.CustID = t.CustID AND a.ProductSettingID = t.ProductSettingID

DROP TABLE #Dep_CustPTGroupSetting_Member
DROP TABLE #Dep_CustPTSetting_Agent
DROP TABLE #Dep_CustPTSetting_Member
DROP TABLE #Dep_CustStakeLevel_Agent
DROP TABLE #Dep_CustStakeLevel_Member
DROP TABLE #Dep_LicenseeProductSetting