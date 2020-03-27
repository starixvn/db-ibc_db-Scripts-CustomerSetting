/*
	Created: Elodie
	Date: 20200327
	Task: DELETE existed setting for Lottery DEPOSIT - Real Currency
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
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON ci.currency = e.exchangeid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND (e.Code IN ('GBP','EUR','CHF','USD','AUD','BND','CAD','MKK','NZD','SGD','PEN','MYR','PLN','RON','BRL','KHR','TRY','GHS','CNY',
				'DKK','HKD','NOK','SEK','ZAR','IDR','MXN','CZK','INH','THB','TWD','UYU','ARS','PHP','INR','RUB','KES','JPY',
				'CLP','KRW','COP','VES','VND','PYG','UUS') OR e.exchangeid = 20)
 AND s.site IN ('12B','18Luck','24TECH','365online','368Cash','3star88','568Win','633esports','818Bet','88Macao','9Club','9Wsports',
				'A1game','Abcasino','AEUG','afb99','AG','alog','ALPHA88','AMG','AnvoFH','Aplus','Apollo','asiabet88','Asian88',
				'B24VN','BBIN2','BBIN3','BBIN4','BetDeal','BETSUN','BigGaming','Bobbet','Bobo88','Bodog','BOG22','BoinGroup',
				'Boma365','Bonanza88','BOSSB','Boying','BPLE','BWGaming','Cali','Calibet','Callmeboss','CGame','CGame4','Champion',
				'dabo88','Dachen','Dade','Datang','Datang001','Dawoo','DBP','DEWA','DF88','DingTai','DTGW','e8casino','ECLBET',
				'ENT22','ENTAPLAY','erhaozhan','FB88','Five88','FLC','G2Win','Gameroom','GamingSoft','Gampag','Gaobet','gbkj',
				'GESAB','GGBOOK','GGBOOKES','GMASTER','GPgaming88','GPIGAME','haifa','Happy1668','Happy8','HBO999','HCVIP',
				'Heaven','Hecbet','Heji888','HeleThai','Hengcai88','hjccasino','HJTK','HL8','HONBET','HonorW','HOT88','HuangMa',
				'IBG','IBO','ID88','ig128','IGPTech','INSERTGAME','ISC888','IvoryBet','JGQP8','JIBET','JIDU','Jinyazhou',
				'JZFortune','K8VN','KeenOcean','KhmerG','Kraton','Kudatogel','KUTECH','Leng4D','Liga','LLGAME','Man1878',
				'mansion88','MARS','MAX88','Mayayule','Mayfair','Mbet','MFgame','MICL','Monaco','Mopgaming','MRCATSB','MTech',
				'mtegames','Mybet88','N88','N8B','N8G','Nbbet','Newbet','NewFuture','NextBet','Nova88','OCMS','Okada','OLE777',
				'Onegaming','OneSports','Opadmin','Opal88','OPEBET','PanguGame','Pinbo','PKbet','PKKing','Raisetech','Royal',
				'Salon365','sbt88','shengboyun','Siamgame','skykey','Soon88','Spark','SSSGaming','Starnet','Sun988','Sunbet138',
				'Sunrise','Sunriseb2b','Sunwin','Swin','TangChao','TaoCai','TCbet','TGO','TitanCraft','TitanOne','TLC','TopGame',
				'Tripleone','TXG','txwl002','TYCgame','UN168','UwinY','VCBA','VN88','VWIN66','W88','Wanbo','Wanfang','WB101',
				'WBG88','WBS','webet88','weicai','Weiwei','Win68Club','Win88','WINCLUB88','WKCUR','WKIBPH','WKPHIL','WUYICP',
				'Xinbo','XinYo','XTD3','XTDGT','Xtu168','YAYOU','YBTech','Yibo','YongBao','YTX','Yunji','ZhiFeng032',
				'ZhiFeng035','Zowin','zt828')

DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype(SportType, BetType) VALUES (220, 1021)

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

-------------------------------------------------BetSetting----------------------------------------------------------------
SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustBetSetting_Agent
FROM Dep_CustBetSetting_Agent a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid 
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK)
INNER JOIN #Dep_CustBetSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustBetSetting_Member
FROM Dep_CustBetSetting_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid 
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustBetSetting_Member a WITH(ROWLOCK)
INNER JOIN #Dep_CustBetSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

-------------
SELECT dl.CustID,dl.ProductSettingID
INTO #Dep_LicenseeProductSetting
FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
		INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
		INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
		INNER JOIN #supers s ON ci.custid = s.custid
WHERE dp.ProductID = 28

DELETE a
FROM Dep_LicenseeProductSetting a WITH(ROWLOCK)
INNER JOIN #Dep_LicenseeProductSetting t ON a.CustID = t.CustID AND a.ProductSettingID = t.ProductSettingID

DROP TABLE #Dep_CustPTGroupSetting_Member
DROP TABLE #Dep_CustPTSetting_Agent
DROP TABLE #Dep_CustPTSetting_Member
DROP TABLE #Dep_CustBetSetting_Agent
DROP TABLE #Dep_CustBetSetting_Member
DROP TABLE #Dep_LicenseeProductSetting