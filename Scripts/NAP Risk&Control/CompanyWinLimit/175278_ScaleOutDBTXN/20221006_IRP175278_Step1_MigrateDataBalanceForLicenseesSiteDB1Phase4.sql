/*<info serverAlias="DBSIG-bodb02"></info>*/
/*
	Created: 20221006@Johnson
	Task: Migrate data for balance game tables for SITEDB1 to scale out DBTXN for CWL phase 4 [#RedmineID:#175278]
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
WHERE site IN ('allwincity',
				'allwinCV',
				'bdtt',
				'bdtt2',
				'GB888CV',
				'Bobbet',
				'Tianbo',
				'DingTai',
				'MTech',
				'Omni88',
				'e8casino',
				'e8casinoCV',
				'GoldenF',
				'LEIHUO',
				'DongYing',
				'bmwbet',
				'HIDZ',
				'HONBET',
				'Newhonbet',
				'HOT99',
				'XTDGT',
				'LLgaming',
				'AEUG',
				'UG2',
				'JJBGAME',
				'VKGAME',
				'JJBGAMECV',
				'VKGAMECV',
				'KOKVN',
				'KOKVN2',
				'Lucky88',
				'11bet',
				'Fabet',
				'One88',
				'Debet',
				'Zbet',
				'Sin88',
				'Sunwin',
				'Five88',
				'Red88',
				'Lode88',
				'Zowin',
				'SV88',
				'Nbet',
				'OXbet',
				'Sky88',
				'SM88',
				'SL88SW',
				'Okada',
				'BPLE',
				'OkadaSW',
				'SunGame',
				'Sun988',
				'SSSSEA',
				'Ty777',
				'Mopgaming',
				'Raisetech',
				'TopGame',
				'ZFRT143',
				'ZFRT166',
				'ZhiFeng055',
				'ZFRT156',
				'ZhiFeng106',
				'ZhiFeng122',
				'ZFRT129',
				'ZhiFeng098',
				'ZFRT165',
				'ZFRT144',
				'ZhiFeng147',
				'ZFRT155',
				'ZhiFeng026',
				'ZFRT186',
				'ZhiFeng156',
				'ZhiFeng133',
				'ZFRT126CV',
				'ZFRT126',
				'CENTRAL168',
				'ZFRT090',
				'ZF055PMW',
				'ZFRT195',
				'ZhiFeng138',
				'ZhiFeng183',
				'ZhiFeng013',
				'ZFRT167',
				'ZF138THB',
				'ZFRT144CV',
				'ZF138VND',
				'ZFRT161',
				'ZhiFeng201',
				'ZFRT158CV',
				'Zhifeng215',
				'ZhiFeng208',
				'ZFRT213',
				'ZhiFeng222',
				'Zzun88',
				'Man1878',
				'iBET',
				'Xinbo',
				'HonorW',
				'M8Credit',
				'FLC',
				'OCMS',
				'dj888',
				'JIBET',
				'awc2',
				'YongBao',
				'Datang001',
				'infini88',
				'Hecbet',
				'Royal',
				'vssports',
				'DEWA',
				'88Macao',
				'9wickets',
				'LSM99',
				'Leng4D',
				'Bonanza88',
				'Senibet',
				'WBS',
				'OPEBET',
				'DFGame',
				'OYO',
				'awc',
				'loc',
				'wmcasino',
				'OESports',
				'yuanbao',
				'Rakyat4DSW',
				'GBET',
				'Towin',
				'C7YOUXICV',
				'SEAL888',
				'ZF026',
				'starsoccer',
				'24AVIASL',
				'H1royal',
				'HFYX',
				'ZhiFeng142',
				'ZFRT218',
				'KSTECH',
				'WLSTAR',
				'ZFRT198',
				'F88IN1SW',
				'ZhiFeng084',
				'GoldenF2CV',
				'WGAMING',
				'DMsports',
				'12B',
				'Riverich',
				'ZF215aTR',
				'AKYL99',
				'Lucklotter',
				'Niu8gaming'
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
	FROM bodb02_tmp.dbo.Winlimit_DebitGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)
END		   

DROP TABLE #tmp_cust