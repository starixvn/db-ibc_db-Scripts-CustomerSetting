/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240228
	Task: Initial data into Dep_ChargeInfoSetting [redmine: #201169]
	DB: DBCUST-CustDB
*/
DECLARE @SportType SMALLINT = 221 
		, @ProductID TINYINT = 31
		, @bitmapOrder TINYINT = 7

--Not launched in LA
INSERT INTO Dep_ChargeInfoSetting ([CustID], [SportType], [PT])
SELECT cs.custid, @SportType
	, CASE WHEN site IN ('A1game',
						'Bobo88',
						'Diamond',
						'DingTai',
						'ig128',
						'MTech',
						'ZF026',
						'ZF055PMW',
						'ZF301B',
						'ZhiFeng009',
						'ZhiFeng012',
						'ZhiFeng021',
						'ZhiFeng051',
						'ZhiFeng183',
						'ZhiFeng353',
						'ZhiFeng442',
						'ZhiFeng876',
						'ZhiFeng895',
						'ZhiFeng919',
						'ZF310b')		THEN 88

			WHEN site IN ('BigGaming',
						'bmwbet',
						'GoldenF',
						'IBO',
						'Jiuyou',
						'Kzing2',
						'Lucky99',
						'Mayibet',
						'PKbet',
						'SGM88',
						'TJGAME',
						'Yunji')		THEN 87.5
										
										ELSE 86.5
	END AS [PT]
FROM Dep_LicenseeProductSetting lps WITH (NOLOCK)
INNER JOIN Dep_CustSuper cs WITH (NOLOCK) ON lps.CustID=cs.custid
INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON ps.ProductSettingID=lps.ProductSettingID
CROSS APPLY (SELECT cps.CustID
			 FROM Dep_CustProductStatus cps WITH(NOLOCK) 
			 WHERE cps.custid = cs.custid
				AND dbo.f_GetProductStatus(cps.bitmapIsDisabled, @bitmapOrder)=0) cps
WHERE ps.ProductID=@ProductID AND ps.SettingType=4
AND site IN (	'9Club',
				'A1game',
				'Ae88',
				'AEUG',
				'alog',
				'Athena000',
				'BigGaming',
				'bmwbet',
				'Bobo88',
				'Dawoo',
				'Dawooxin',
				'Diamond',
				'DingTai',
				'DTGJZ',
				'Gaobet',
				'GoldenF',
				'IBO',
				'ig128',
				'Jiuyou',
				'khmer',
				'Kzing2',
				'Lucky99',
				'M8Credit',
				'mansion88',
				'Mayibet',
				'Monaco',
				'MTech',
				'OBGM',
				'OCMS',
				'Opal88',
				'PKbet',
				'Royal',
				'SampleSite',
				'SBCHOS',
				'SGM88',
				'Sky9',
				'spondemo',
				'TBETINR',
				'TCGINR',
				'TCGMASTER',
				'TJGAME',
				'W88',
				'win365',
				'YongBao',
				'Yunji',
				'ZF026',
				'ZF055PMW',
				'ZF301B',
				'ZhiFeng009',
				'ZhiFeng012',
				'ZhiFeng021',
				'ZhiFeng051',
				'ZhiFeng183',
				'ZhiFeng353',
				'ZhiFeng442',
				'ZhiFeng876',
				'ZhiFeng895',
				'ZhiFeng919',
				'zt828',
				'ZF310b')

---------------------------------------------------------------------------------------------------
--Launched in LA
INSERT INTO Dep_ChargeInfoSetting ([CustID], [SportType], [PT], [FromDate])
SELECT cs.custid, @SportType
	, CASE WHEN site IN ('ZFRT534',
						'ZFRT090',
						'ZhiFeng036',
						'ZhiFeng176')	THEN 88

			WHEN site IN ('12Bet',
						'365online',
						'Alphalota',
						'MYGAME',
						'XTSB',
						'TSEnter')		THEN 87.5
										
										ELSE 86.5
		END AS [PT]
	, CASE WHEN site IN ('12Bet')		THEN '2023/05/01'

			WHEN site IN ('ZFRT534')	THEN '2024/01/01'
										
										ELSE '2023/09/19'
		END AS [FromDate]
FROM Dep_LicenseeProductSetting lps WITH (NOLOCK)
INNER JOIN Dep_CustSuper cs WITH (NOLOCK) ON lps.CustID=cs.custid
INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON ps.ProductSettingID=lps.ProductSettingID
CROSS APPLY (SELECT cps.CustID
			 FROM Dep_CustProductStatus cps WITH(NOLOCK) 
			 WHERE cps.custid = cs.custid
				AND dbo.f_GetProductStatus(cps.bitmapIsDisabled, @bitmapOrder)=0) cps
WHERE ps.ProductID=@ProductID AND ps.SettingType=4
AND site IN ('12Bet',
			'ZFRT534',
			'24AVIA',
			'365online',
			'88Macao',
			'ab6688',
			'Alphalota',
			'BBIN3',
			'DFBET',
			'DFGame',
			'GamingSoft',
			'Heaven',
			'IONclub',
			'Mancity2',
			'MYGAME',
			'wmcasino',
			'XTSB',
			'Xtu168',
			'Yibo',
			'ZFRT090',
			'ZhiFeng036',
			'ZhiFeng176',
			'TSEnter')
GO