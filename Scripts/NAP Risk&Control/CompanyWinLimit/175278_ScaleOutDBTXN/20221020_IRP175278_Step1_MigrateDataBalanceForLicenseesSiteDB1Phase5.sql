/*<info serverAlias="DBSIG-bodb02"></info>*/
/*
	Created: 20221020@Johnson
	Task: Migrate data for balance game tables for SITEDB1 to scale out DBTXN for CWL phase 5 [#RedmineID:#175278]
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
WHERE site IN ('NLDSports',
				'XmenSW',
				'OCMSS',
				'LIGAWLHKB',
				'DTGJZ',
				'TXJT',
				'3star88',
				'ECLBET',
				'Mybet88',
				'WINCLUB88',
				'INSERTGAME',
				'Alphalota',
				'Barcelo9',
				'Aladdin99',
				'BVCLLC',
				'Jiuyou',
				'Yintai',
				'Letian',
				'WRServices',
				'Xiaoxiang',
				'YakaGaming',
				'5ATech',
				'IGSW',
				'HBPT',
				'TSLA',
				'WRSeamless',
				'TYgaming',
				'KSTECH2',
				'De365',
				'UGaming',
				'0sServices',
				'ZhiFeng019',
				'mbxusdt',
				'GoldenF2',
				'ZhiFeng173',
				'UNOGAMING',
				'ZTech',
				'XLMEDIA',
				'AEUGSW',
				'24aviaCV',
				'ACsports',
				'FLCSW',
				'GoldenFCV',
				'HaHaGaming',
				'HOroyal',
				'IDNSPORT',
				'IDNUPVND',
				'JDJDAPI',
				'JUNBOVN',
				'KzingP88',
				'KZSW',
				'MultiSL88',
				'OXPLAY',
				'SGM88',
				'STEBBCBI',
				'TYgamingSW',
				'WSlots',
				'yuanbaoCV',
				'ZF133FIN2',
				'ZF215CNY',
				'ZF267SW',
				'ZF271SW',
				'ZFRT155new',
				'ZFRT159',
				'ZFRT175',
				'ZFRT179',
				'ZFRT219',
				'ZFRT240',
				'ZFRT242',
				'ZFRT259',
				'ZFRT263',
				'ZFRT80GPGT',
				'ZhiFeng041',
				'ZhiFeng050',
				'ZhiFeng051',
				'ZhiFeng094',
				'ZhiFeng107',
				'ZhiFeng116',
				'ZhiFeng132',
				'ZhiFeng168',
				'ZhiFeng176',
				'ZhiFeng200',
				'ZhiFeng204',
				'ZhiFeng221',
				'ZhiFeng223',
				'ZhiFeng228',
				'ZhiFeng242',
				'ZhiFeng248',
				'ZhiFeng253',
				'ZhiFeng255',
				'ZhiFeng262',
				'ZhiFeng266',
				'ZhiFeng267',
				'ZhiFeng271',
				'ZhiFeng030'
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