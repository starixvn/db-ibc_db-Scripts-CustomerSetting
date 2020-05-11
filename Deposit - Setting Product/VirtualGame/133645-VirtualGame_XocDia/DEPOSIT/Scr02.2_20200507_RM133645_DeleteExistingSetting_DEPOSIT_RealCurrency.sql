/*
	Created: Eden
	Date: 20200507
	Task: DELETE existed setting for Virtual game DEPOSIT - Real Currency -XocDia
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
 AND c.currency IN ( 	2	--RM
					, 	71	--KHR
					, 	56	--PLN
					, 	67	--HKK
					, 	16	--Yen
					, 	64	--UT
					, 	35	--$US
					, 	3	--US$
					, 	69	--MMK
					, 	70	--MKK
					--, 	72	--YNG
					, 	13	--RMB
					, 	81	--CY
					, 	66	--YUN
					, 	5	--HK$
					, 	47	--DDD
					, 	22	--IND
					, 	34	--IDR
					, 	33	--IDD
					, 	15	--IN
					, 	43	--THB
					, 	4	--TB
					, 	45	--Won
					, 	51	--INH
					, 	61	--INR
					, 	55	--RUB
					, 	6	--EURO
					, 	12	--GBP
					, 	32	--JPY
					,   20 --UUS
					) --Offered Currencies
 AND s.site IN (
				 N'e8casino'
				,N'CGame'
				,N'Axiawin'
				,N'88Goals'
				,N'BoAPI05'
				,N'9Club'
				,N'Aplus'
				,N'HonorW'
				,N'ID88'
				,N'sbt88'
				,N'11bet'
				,N'VWIN66'
				,N'24AVIA'
				,N'Spark'
				,N'FLC'
				,N'TitanCraft'
				,N'Sunwin'
				,N'Mayayule'
				,N'Yunji'
				,N'NBCbet'
				,N'XTDGT'
				,N'Zowin'
				,N'Sin88'
				,N'Lucky88'
				,N'JIBET'
				,N'Liga'
				,N'633esports'
				,N'SV88'
				,N'erhaozhan'
				,N'Jumbo88'
				,N'TCbet'
				,N'MICL'
				,N'Raisetech'
				,N'Uwoniwin'
				,N'Siamgame'
				,N'Athena000'
				,N'Leng4D'
				,N'Taipanbet'
				,N'18Luck'
				,N'AnvoFH'
				,N'ALPHA88'
				,N'Senibet'
				,N'skykey'
				,N'ISC888'
				,N'MARS'
				,N'Xinbo'
				,N'ECLBET'
				,N'9bet'
				,N'Kraton'
				,N'UwinY'
				,N'CGame4'
				,N'IONclub'
				,N'BE7'
				,N'JZFortune'
				,N'Champion'
				,N'IBG'
				,N'Kudatogel'
				,N'Red88'
				,N'VN88'
				,N'Fabet'
				,N'INSERTGAME'
				,N'Sunrise'
				,N'396Club'
				,N'Hong88'
				,N'IvoryBet'
				,N'Royal'
				,N'TitanOne'
				,N'Newhonbet'
				,N'Bobo88'
				,N'BPLE'
				,N'ITCbet'
				,N'BWGaming'
				,N'MTech'
				,N'TLC'
				,N'3star88'
				,N'BigGaming'
				,N'Okada'
				,N'haifa'
				,N'Datang001'
				,N'BETSUN'
				,N'Bonanza88'
				,N'Pinbo'
				,N'BBIN3'
				,N'UN168'
				,N'Starnet'
				,N'BoAPI06'
				,N'WBS'
				,N'Callmeboss'
				,N'Heji888'
				,N'afb99'
				,N'ig128'
				,N'12Bet'
				,N'Luckywin88'
				,N'BBIN2'
				,N'Hecbet'
				,N'OneSports'
				,N'Unobet'
				,N'KUTECH'
				,N'Monstergol'
				,N'Wanfang'
				,N'HuangMa'
				,N'Boma365'
				,N'AG'
				,N'DTGW'
				,N'N8G'
				,N'Bolanation'
				,N'starsoccer'
				,N'Sunriseb2b'
				,N'Yibo'
				,N'Zbet'
				,N'OLE777'
				,N'JIDU'
				,N'IBO'
				,N'HONBET'
				,N'zt828'
				,N'AMG'
				,N'Five88'
				,N'Opal88'
				,N'TYCgame'
				,N'368Cash'
				,N'Soon88'
				,N'BOSSB'
				,N'TangChao'
				,N'A1game'
				,N'GamingSoft'
				,N'Lagadewa'
				,N'YongBao'
				,N'alog'
				,N'WKPHIL'
				,N'shengboyun'
				,N'webet88'
				,N'N8B'
				,N'FB88'
				,N'DingTai'
				,N'K8VN'
				,N'Aoncash'
				,N'Gampag'
				,N'N88'
				,N'YAYOU'
				,N'Heaven'
				,N'365online'
				,N'OCMS'
				,N'Xtu168'
				,N'Happy8'
				,N'XTD3'
				,N'ZhiFeng032'
				,N'B24VN'
				,N'Gameroom'
				,N'Ratugg'
				,N'AEUG'
				,N'Happy1668'
				,N'Ｗin88   '
				,N'Apollo'
				,N'IGPTech'
				,N'Dawoo'
				,N'GMASTER'
				,N'KingBet'
				,N'OPEBET'
				,N'Wanbo'
				,N'Abcasino'
				,N'Boying'
				,N'Macaubet'
				,N'Mopgaming'
				,N'WINCLUB88'
				,N'Winn69'
				,N'iBET'
				,N'GPIGAME'
				,N'Gaobet'
				,N'ANGbet'
				,N'Bodog'
				,N'ENT22'
				,N'W88'
				,N'YTX'
				,N'PanguGame'
				,N'HBO999'
				,N'DEWA'
				,N'WKIBPH'
				,N'HCVIP'
				,N'Lode88'
				,N'ENTAPLAY'
				,N'asiabet88'
				,N'GESAB'
				,N'XinYo'
				,N'VCBA'
				,N'WUYICP'
				,N'weicai'
				,N'MAX88'
				,N'Ae88'
				,N'Monaco'
				,N'BOG22'
				,N'DBP'
				,N'M8bola'
				,N'mansion88'
				,N'SunGame'
				,N'TGO'
				,N'88Macao'
				,N'Debet'
				,N'Onegaming'
				,N'YBTech'
				,N'TopGame'
				,N'MFgame'
				,N'GGBOOK'
				,N'818Bet'
				,N'PKbet'
				,N'Q8bola'
				,N'TaoCai'
				,N'hjccasino'
				,N'Swin'
				,N'Nbbet'
				,N'One88'
				,N'txwl002'
				,N'Mybet88'
				,N'Yabo3'
				,N'Tianbo'
				,N'Datang'
				,N'allwincity'
				,N'Tripleone'
				,N'Bobbet'
				,N'WKCUR'
				,N'gbkj'
				,N'HL8'
				,N'Weiwei'
				,N'spondemo'
				,N'KeenOcean'
				,N'G2Win'
				,N'SSSGaming'
				,N'KhmerG'
				,N'Sun988'
				,N'Jarvis'
				,N'Bsdbet'
				 )
	AND NOT (s.site IN('Athena000') AND c.currency = 20)
ORDER BY custid

DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype(SportType, BetType) VALUES (245, 4601)
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

DROP TABLE #Dep_CustStakeLevel_Agent
DROP TABLE #Dep_CustStakeLevel_Member