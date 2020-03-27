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
 AND s.site IN ('Happy8','GamingSoft','DBP','HL8','TLC','368Cash','Senibet','HonorW','W88','12Bet','alog','asiabet88','mansion88',
				'OLE777','SunGame','HAIFA','Bodog','Boma365','Happy1668','KeenOcean','ISC888','3star88','Newhonbet','Abcasino',
				'Hecbet ','iBET','Royal','XTD3','IBO','Liga','88Macao','9Club','Ae88','AG','HONBET','TGO','KhmerG','365online',
				'IONclub','Mayayule','Sun988','DEWA','Gampag','HuangMa','Boying','webet88','PKbet','BigGaming','VCBA','Taipanbet',
				'Dawoo','FLC','Sunrise','Uwoniwin','ECLBET','PanguGame','818Bet','Heaven','IGPTech','K8VN','GPIGAME','Swin','396Club',
				'e8casino','Lucky88','MAX88','OPEBET','BBIN2','Bobo88','GMASTER','Opal88','Sunriseb2b','YongBao','ALPHA88','11bet',
				'Aplus','zt828','ENTAPLAY','MICL','Tripleone','Yibo','TangChao','WBS','CGame','Xinbo','FB88','YBTech','Monaco','BETSUN',
				'Mybet88','JIBET','Gameroom','Fabet','WINCLUB88','Callmeboss','SSSGaming','ANGbet','One88','Nbbet','Bobbet','TitanOne',
				'18Luck','AEUG','XinYo','VWIN66','AMG','Starnet','gbkj','VN88','ig128','MARS','YAYOU','UwinY','Hong88','Gaobet',
				'Five88','Zbet','A1game','IBG','Raisetech','txwl002','sbt88','WKCUR','WKPHIL','GESAB','Win88','AnvoFH','Xtu168',
				'weicai','HCVIP','Kraton','BBIN3','Mopgaming','pinbo','ID88','DingTai','ENT22','BOSSB','allwincity','TopGame',
				'Onegaming','24AVIA','B24VN','Sunwin','Apollo','YTX','BOG22','Wanfang','MTech','JIDU','Leng4D','G2Win','erhaozhan',
				'Okada','KUTECH','Siamgame','Datang001','hjccasino','BWGaming','Champion','shengboyun','Spark','afb99','Debet',
				'633esports','Wanbo','Jarvis','Tianbo','WUYICP','CGame4','TitanCraft','TaoCai','ZhiFeng032','TYCgame','HBO999',
				'Yunji','JZFortune','OneSports','TCbet','Soon88','GGBOOK','INSERTGAME')

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