/*<info serverAlias="DBSIG-bodb02"></info>*/
/*
	Created: 20220927@Johnson
	Task: Migrate data for balance game tables for SITEDB1 to scale out DBTXN for CWL phase 3 [#RedmineID:#175278]
	DB: DBSIG/bodb02 (sitedb1)
*/
CREATE TABLE #tmp_cust
		(
			custid INT PRIMARY KEY
		)
		
------------------------------------------------
INSERT INTO #tmp_cust (custid)
SELECT DISTINCT custid
FROM CustDB.dbo.Customer WITH (NOLOCK)
WHERE site IN ('24Tech',
				'MRCATSB',
				'24AVIA',
				'ig128',
				'A1game',
				'txwl002',
				'weicai',
				'shengboyun',
				'633esports',
				'pmwint',
				'Diamond',
				'ig128s',
				'442ball',
				'asiabet88',
				'TLC',
				'JBO',
				'Betway',
				'KingFun',
				'IBO',
				'Kzing2',
				'MANBETX',
				'LS88',
				'TH3',
				'V03',
				'XTSB',
				'KZO41',
				'kzsbxjCV',
				'Nexus',
				'IGPTech',
				'AJJCV',
				'KeenOcean',
				'K8VN',
				'Storm88',
				'liv66',
				'liv66SW',
				'win365',
				'livv88sw',
				'WINHX1',
				'KhmerG',
				'afb99',
				'khmer',
				'ManCity',
				'Mancity2',
				'N88',
				'N8B',
				'N8G',
				'NukeGaming',
				'Pay4d',
				'Weiwei',
				'Avia',
				'MARS',
				'AnvoFH',
				'erhaozhan',
				'TCbet',
				'TaoCai',
				'FHLMSABA',
				'Titank',
				'FHLMSABAS',
				'Sunrise',
				'Sunriseb2b',
				'SunriseCV',
				'Wanfang',
				'KUTECH',
				'GamingSoft',
				'Dade',
				'Nbbet',
				'BetDeal',
				'Xtu168',
				'GSCSW',
				'Yibo',
				'YiboCV',
				'JIDU',
				'Wanbo',
				'ZhiFeng032',
				'ZhiFeng036',
				'ZhiFeng035',
				'ZhiFeng021',
				'ZhiFeng009',
				'ZFRT082',
				'mtegames',
				'ZhiFeng037',
				'ZFRT125',
				'ZFRT133',
				'NewFuture',
				'ZFRT132',
				'ZhiFeng040',
				'ZFRT128',
				'ZFRT080',
				'JIB88',
				'ZhiFeng012',
				'ZFRT115',
				'ZFRT142',
				'SAGAME88',
				'ZFRT150',
				'ZFRT081',
				'NextBet',
				'IONclub',
				'Ae88',
				'Liga',
				'ISC888'
				)
	and roleid = 1
	
IF NOT EXISTS (SELECT TOP (1) 1 FROM bodb02_tmp.dbo.BalancePendingCreditGame WITH(NOLOCK))
	AND NOT EXISTS (SELECT TOP (1) 1 FROM bodb02_tmp.dbo.BalancePendingDebitGame WITH(NOLOCK))
BEGIN
	INSERT INTO [dbo].[Winlimit_CreditGame]
			   ([custid]
			   ,[winlostdate]
			   ,[Winlost]
			   ,[bettype])
	SELECT [custid]
		   ,[winlostdate]
		   ,[Winlost]
		   ,[bettype]
	FROM bodb02_tmp.dbo.Winlimit_CreditGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)
	
	INSERT INTO [dbo].[Winlimit_DebitGame]
			   ([custid]
			   ,[winlostdate]
			   ,[Winlost]
			   ,[bettype])
	SELECT [custid]
		   ,[winlostdate]
		   ,[Winlost]
		   ,[bettype]
	FROM bodb02_tmp.dbo.Winlimit_DebitGame_20221006 WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)
END		   

DROP TABLE #tmp_cust