/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20250827@Virgil
	Task: Revise core function report to use SportBettypeMatrix [Redmine: #235369]
	DB: DBPRO-bodb02
*/

CREATE TABLE #t_Sporttype (
	[ProductID] [tinyint],
	[SBM_SportType] [smallint],
	[SWL_SportType] [smallint],
	[Min_Sporttype] [smallint]
)

-- SportTypeRef mapping from Task_Sum_Winloss
INSERT INTO #t_Sporttype (ProductID, SBM_SportType, SWL_SportType, Min_Sporttype)
SELECT  sp.productid
	, sp.SportType AS SBM_SportType
	, ck.swl_sporttype AS SWL_SportType
	, min.Min_Sporttype
FROM SportBettypeMatrix sp WITH(nolock)
cross apply (
	SELECT case WHEN bettype BETWEEN 81 AND 120 OR -- Number Game 
				bettype BETWEEN 8101 AND 8120 OR -- Happy 5 
				bettype BETWEEN 3601 AND 3610 THEN 161 -- Happy 5 Linked Games
			WHEN bettype BETWEEN 1201 AND 1299 THEN 180 -- Virtual Sport
			WHEN bettype BETWEEN 2700 AND 2899 THEN 190 -- Betradar Virtual Sport
			WHEN bettype IN (71, 72) THEN 251
			WHEN bettype BETWEEN 1501 AND 1599 THEN 202 -- Keno
			WHEN bettype BETWEEN 1021 AND 1099 THEN 220 -- Keno Lottery
			WHEN bettype BETWEEN 1700 AND 1799 THEN 255 -- Gold Deluxe
			WHEN bettype BETWEEN 1800 AND 1899 THEN 250 --- AG Casino 
			WHEN bettype = 1900 THEN 249 --- Vegas Games 
			WHEN bettype BETWEEN 18000 AND 18099 THEN 204 --- Colossus Bets
			WHEN bettype BETWEEN 2101 AND 2199 THEN 208
			WHEN bettype BETWEEN 2201 AND 2299 THEN 209
			WHEN bettype BETWEEN 2301 AND 2399 OR
				bettype BETWEEN 2901 AND 2999 THEN 210
			WHEN bettype BETWEEN 2401 AND 2499 THEN 211 --- Allbet
			WHEN bettype BETWEEN 4001 AND 4100 OR 
				bettype BETWEEN 5800 AND 5999 THEN 212 -- Voidbridge
			WHEN bettype BETWEEN 4101 AND 4300 OR 
				bettype BETWEEN 6701 AND 7000 OR 
				bettype BETWEEN 14000 AND 14999 THEN 248 -- PP
			WHEN bettype BETWEEN 2501 AND 2699 THEN 213 --NG2 -
			WHEN bettype BETWEEN 1011 AND 1020 THEN 219 --Fishing World -
			WHEN bettype BETWEEN 8000 AND 8099 THEN 221 -- Exchange
			WHEN bettype BETWEEN 1901 AND 1999 THEN 165 -- Card Club
			WHEN bettype BETWEEN 4301 AND 4600 THEN 247 -- Spadegaming
			WHEN bettype BETWEEN 4601 AND 4900 THEN 245 -- Virtual Games
			WHEN bettype BETWEEN 1611 AND 1699 OR
				 bettype BETWEEN 13200 AND 13499 THEN 200 -- Saba.Club
			WHEN bettype BETWEEN 3001 AND 3099 THEN 244 -- SA Gaming
			WHEN bettype BETWEEN 3101 AND 3150 THEN 243 -- AE Casino
			WHEN bettype BETWEEN 5001 AND 5099 THEN 223 -- Indo 4D
			WHEN bettype BETWEEN 4901 AND 5000 THEN 222 -- Table Games	
			WHEN bettype BETWEEN 3300 AND 3399 THEN 241 -- BBIN	
			WHEN bettype BETWEEN 3201 AND 3299 THEN 242 -- IBCBet Live Casino		
			WHEN bettype BETWEEN 5601 AND 5699 THEN 225 -- ION					
			WHEN bettype BETWEEN 5500 AND 5599 THEN 224 -- RNG War		
			WHEN bettype BETWEEN 6001 AND 6300 THEN 232 -- PG Soft
			WHEN bettype BETWEEN 6401 AND 6700 THEN 234-- Joker
			WHEN bettype BETWEEN 3401 AND 3499 THEN 233 -- WM
			WHEN bettype BETWEEN 5701 AND 5799 THEN 236 -- GDG
			WHEN bettype = 5301 THEN 231 -- Virtual Sports 3
			WHEN bettype BETWEEN 3501 AND 3599 THEN 239 -- BG
			WHEN bettype BETWEEN 5401 AND 5499 THEN 237 -- MaxGame
			WHEN bettype BETWEEN 17000 AND 17099 THEN 246 -- Saba promotion
			WHEN bettype BETWEEN 3611 AND 3620 THEN 169 -- Sports Lottery
			WHEN bettype BETWEEN 3701 AND 3799 THEN 170 -- PP Live Casino
			WHEN bettype BETWEEN 7001 AND 7300 THEN 238 -- Habanero
			WHEN bettype BETWEEN 7301 AND 7600 THEN 167 -- Creative Gaming
			WHEN bettype BETWEEN 3801 AND 3899 OR
				 bettype BETWEEN 13500 AND 13799 THEN 171 -- VGaming 
			WHEN bettype BETWEEN 7801 AND 7899 THEN 174 -- AdvantPlay Mini
			WHEN bettype BETWEEN 7701 AND 7799 THEN 172 -- AdvantPlay Product
			WHEN bettype BETWEEN 7901 AND 7999 THEN 175 -- Bitcoin Product
			WHEN bettype BETWEEN 8201 AND 8299 THEN 176 -- FGG Product
			WHEN bettype BETWEEN 8900 AND 8999 THEN 156 -- SEAL Entertainment
			WHEN bettype BETWEEN 8400 AND 8699 THEN 155 -- Microgaming
			WHEN bettype BETWEEN 5100 AND 5299 THEN 158 -- Jili
			WHEN bettype BETWEEN 3151 AND 3200 THEN 159 -- YeeBet
			WHEN bettype BETWEEN 5302 AND 5399 THEN 178 -- VS3-LeapGaming(New)
			WHEN bettype BETWEEN 7601 AND 7700 THEN 227 -- Live22
			WHEN bettype BETWEEN 10300 AND 10399 THEN 228 -- WE Live Casino
			WHEN bettype BETWEEN 10400 AND 10449 THEN 188 -- VS4-Virtual Cock Fighting
			WHEN bettype BETWEEN 10000 AND 10299 THEN 216 -- UU Slots
			WHEN bettype BETWEEN 10801 AND 11000 THEN 240 -- SABAxD
			WHEN bettype BETWEEN 11100 AND 11299 THEN 230 -- FastSpin
			WHEN bettype BETWEEN 11300 AND 11399 THEN 146 -- FA CHAI
			WHEN bettype BETWEEN 10450 AND 10750 THEN 229 -- Nextspin
			WHEN bettype BETWEEN 11050 AND 11099 THEN 147 -- VS5
			WHEN bettype BETWEEN 11850 AND 11899 THEN 138 -- ON Casino
			WHEN bettype BETWEEN 12500 AND 12999 THEN 148 -- Playtech
			WHEN bettype BETWEEN 11400 AND 11499 OR
				 bettype BETWEEN 15900 AND 16099 THEN 145 -- GPI RNG Casino
			WHEN bettype BETWEEN 11500 AND 11599 THEN 144 -- GPI Live Casino
			WHEN bettype BETWEEN 11600 AND 11699 THEN 143 -- PLAY STAR RNG Casino
			WHEN bettype BETWEEN 12300 AND 12499 THEN 133 -- SABA Keno
			WHEN bettype BETWEEN 15000 AND 15199 THEN 130 -- ASKMESLOT
			WHEN bettype BETWEEN 15200 AND 15399 THEN 131 -- Funky Games - FG
			WHEN bettype BETWEEN 11900 AND 11999 THEN 139 -- HOTDOG - FG
			WHEN bettype BETWEEN 15400 AND 15499 THEN 128 -- ODIN GAMING - ODG
			WHEN bettype BETWEEN 13900 AND 13999 THEN 124 -- Microgaming Live - MGLC
			WHEN bettype BETWEEN 13800 AND 13899 THEN 132 -- GPI Lottery - GPILT
			WHEN bettype BETWEEN 15600 AND 15799 THEN 129 -- Playtech Live Casino - PTLC
			WHEN bettype BETWEEN 15500 AND 15599 THEN 125 -- VS7
			WHEN bettype BETWEEN 15800 AND 15899 THEN 123 -- RichGaming - RGRNG
			WHEN bettype BETWEEN 12000 AND 12099 THEN 136 -- W Casino - WLC
			WHEN bettype BETWEEN 16200 AND 16299 THEN 121 -- AI Gaming
			WHEN bettype BETWEEN 16100 AND 16199 THEN 122 -- ClotPlay
			WHEN bettype BETWEEN 12150 AND 12249 THEN 135 -- Smartsoft
			WHEN bettype BETWEEN 12250 AND 12299 THEN 119 -- OFA Live				
			ELSE 0
		END swl_sporttype
) ck
cross apply (
	SELECT ProductId, MIN(SportType) Min_Sporttype
	FROM SportBettypeMatrix sp2 WITH(nolock)
	WHERE sp2.ProductID = sp.ProductID
	GROUP BY ProductID
) min
where ck.swl_sporttype > 0
group by sp.ProductID
	, sp.sporttype
	, ck.swl_sporttype
	, min.Min_Sporttype
order by sp.ProductID ASC, sp.sporttype ASC


CREATE TABLE #SBMTemp (
	[ProductId] [tinyint],
	[SportType] [smallint],
	[BetType] [smallint],
	IsFinishedStatus BIT DEFAULT(0)
)	

CREATE CLUSTERED INDEX CIX_SBMTemp ON #SBMTemp (ProductId, SportType, BetType)

INSERT INTO #SBMTemp (ProductId, SportType, BetType)
SELECT sbm.ProductId, sbm.SportType, sbm.BetType
FROM SportBettypeMatrix sbm WITH(NOLOCK)
JOIN #t_Sporttype ts
	ON sbm.ProductID = ts.ProductID
	AND sbm.SportType = ts.SBM_SportType


-- SELECT * FROM #t_Sporttype ORDER BY ProductID, SBM_SportType, SWL_SportType
-- SELECT * FROM #SBMTemp ORDER BY ProductID, SportType, BetType

-- Update ExtraInfo column
DECLARE @SBMBatch TABLE(ProductID tinyint, SportType smallint, BetType smallint)

WHILE(1=1)
BEGIN
	UPDATE TOP (5000) t 		 
	SET t.IsFinishedStatus = 1
	OUTPUT INSERTED.ProductID, INSERTED.SportType, INSERTED.BetType INTO @SBMBatch
	FROM #SBMTemp t
	WHERE IsFinishedStatus = 0
	
	IF @@ROWCOUNT = 0
		BREAK

	UPDATE sbm
	SET sbm.ExtraInfo = JSON_MODIFY(ISNULL(sbm.ExtraInfo, '{}'), '$.SportTypeRef', ts.SWL_SportType)
	FROM SportBettypeMatrix sbm WITH(ROWLOCK, UPDLOCK)
	JOIN @SBMBatch batch ON sbm.ProductID = batch.ProductID AND sbm.SportType = batch.SportType AND sbm.BetType = batch.BetType
	JOIN #t_Sporttype ts ON sbm.ProductID = ts.ProductID AND sbm.SportType = ts.SBM_SportType

	DELETE @SBMBatch
END

/*
SELECT sbm.*, ts.SWL_SportType AS SportTypeRef
FROM SportBettypeMatrix sbm (NOLOCK)
JOIN #t_Sporttype ts
	ON sbm.ProductID = ts.ProductID
	AND sbm.SportType = ts.SBM_SportType
*/	


DROP TABLE IF EXISTS #t_Sporttype, #SBMTemp