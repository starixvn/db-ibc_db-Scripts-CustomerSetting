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
 AND (e.Code IN ('GBP','EUR','CHF','USD','AUD','BND','CAD','MMK','NZD','SGD','PEN','MYR','PLN','RON','BRL','KHR','TRY','GHS','CNY',
				'DKK','HKD','NOK','SEK','ZAR','IDR','MXN','CZK','THB','TWD','UYU','ARS','PHP','INR','RUB','KES','JPY',
				'CLP','KRW','COP','VES','PYG') OR e.exchangeid IN (51, 20))
 AND (s.site IN ('24TECH','365online','368Cash','3star88','568Win','633esports','818Bet','88Macao','9Club','A1game','Abcasino','AEUG',
				'afb99','AG','alog','ALPHA88','AMG','AnvoFH','Aplus','Apollo','asiabet88','Asian88','B24VN','BetDeal','BETSUN',
				'BigGaming','Bobbet','Bobo88','Bodog','BoinGroup','Boma365','Bonanza88','BOSSB','Boying','BPLE','BWGaming','Cali',
				'Calibet','Callmeboss','CGame','CGame4','Champion','Dachen','Datang001','Dawoo','DEWA','DF88','DingTai','DTGW',
				'e8casino','ECLBET','ENT22','ENTAPLAY','erhaozhan','FB88','Five88','FLC','G2Win','Gameroom','Gampag','Gaobet',
				'gbkj','GESAB','GGBOOK','GMASTER','GPgaming88','GPIGAME','Happy1668','Happy8','HCVIP','Heaven','Hecbet','HeleThai',
				'Hengcai88','hjccasino','HJTK','HL8','HONBET','HonorW','HOT88','HuangMa','IBG','IBO','ID88','IGPTech','INSERTGAME',
				'JIBET','JIDU','Jinyazhou','JZFortune','KeenOcean','KhmerG','Kraton','Kudatogel','KUTECH','Leng4D','Liga','Man1878',
				'MARS','MAX88','Mayayule','Mayfair','Mbet','MFgame','MICL','Mopgaming','MRCATSB','MTech','Mybet88','N88','N8B','N8G',
				'Nbbet','Newbet','NewFuture','OCMS','Okada','OLE777','Onegaming','Opadmin','OPEBET','PanguGame','Pinbo','PKbet',
				'Raisetech','Royal','Salon365','sbt88','shengboyun','Siamgame','skykey','Soon88','Spark','SSSGaming','Starnet',
				'Sun988','Sunbet138','Sunwin','Swin','TangChao','TaoCai','TCbet','TGO','TitanCraft','TitanOne','TLC','TopGame',
				'Tripleone','TXG','txwl002','TYCgame','UN168','UwinY','VCBA','VN88','VWIN66','W88','Wanbo','Wanfang','WB101',
				'WBG88','WBS','webet88','weicai','Weiwei','Win68Club','Win88','WINCLUB88','WKCUR','WKIBPH','WKPHIL','WUYICP',
				'Xinbo','XinYo','XTDGT','YAYOU','Yibo','YongBao','YTX','Yunji','Zowin','zt828')
			OR (s.site = 'Dade' AND e.exchangeid NOT IN (46))
			OR (s.site = 'Datang' AND e.exchangeid NOT IN (13))
			OR (s.site = 'GamingSoft' AND e.exchangeid NOT IN (46))
			OR (s.site = 'mansion88' AND e.exchangeid NOT IN (1,45)))

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