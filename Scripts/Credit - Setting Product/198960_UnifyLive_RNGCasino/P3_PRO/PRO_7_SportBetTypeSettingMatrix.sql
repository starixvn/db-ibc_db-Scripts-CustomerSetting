/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Inital Data Setting SportBetTypeSettingMatrix [#198960] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- FGG (70)  
--SELECT * 
UPDATE sm
	SET 
		sm.SportTypeRefPT = 9911
	,	sm.BetTypeRefPT = 2400
	,	sm.SporttypeRefWinlossLimit = 9911
	,	sm.BettypeRefWinlossLimit = 2400
	,	sm.ProductId = 41
	,	sm.RepUpdateTime = SYSDATETIME ()
FROM SportBettypeSettingMatrix_UAT AS sm WITH (ROWLOCK , UPDLOCK)
WHERE
	isLicensee = 0
	AND
	Site = 'ALL'
	AND
	RealProductId = 70
	AND
	SportType = 176
	AND
	bettype = 8201

-- Saba Casino (6)  
--SELECT * 
UPDATE sm
	SET
		sm.SportTypeRefPT = 9918
	,	sm.BetTypeRefPT = 4601
	,	sm.SporttypeRefWinlossLimit = 9918
	,	sm.BettypeRefWinlossLimit = 4601
	,	sm.ProductId = 53
	,	sm.RepUpdateTime = SYSDATETIME ()
FROM SportBettypeSettingMatrix_UAT AS sm WITH (ROWLOCK , UPDLOCK)
WHERE
	isLicensee = 0
	AND
	Site = 'ALL'
	AND
	RealProductId = 6
	AND
	SportType = 208
	AND
	bettype = 2101

-- RNG Slot (18) 
-- Macau Games (22), PP (32), Arcadia Gaming (34), SG (36), PG Soft (55),  Joker (56), MaxGame (60), Habanero (61),  CG (62), AdvantPlay (67), AdvantPlay Mini (68), SEAL Entertainment (72), MG-RNG (73), Jili (75), UU Slots (78), Yolo Play (84)  
--SELECT * 
UPDATE sm
	SET 
		sm.SportTypeRefPT = 9906
	,	sm.BetTypeRefPT = 4001
	,	sm.ProductId = 53
	,	sm.RepUpdateTime = SYSDATETIME ()
FROM SportBettypeSettingMatrix_UAT AS sm WITH (ROWLOCK , UPDLOCK)
WHERE
	isLicensee = 0
	AND
	Site = 'ALL'
	AND
	ProductID = 18

-- Virtual Games (38)
--SELECT * 
UPDATE sm
	SET 
		sm.SportTypeRefPT = 9918
	,	sm.BetTypeRefPT = 4601
	,	sm.ProductId = 53
	,	sm.RepUpdateTime = SYSDATETIME ()
FROM SportBettypeSettingMatrix_UAT AS sm WITH (ROWLOCK , UPDLOCK)
WHERE
	isLicensee = 0
	AND
	Site = 'ALL'
	AND
	RealProductId = 38
	AND
	SportType = 245
	AND
	bettype IN (4601 , 4602 , 4605)


-- Funky Games (50)
--SELECT * 
UPDATE sm
	SET 
		sm.SportTypeRefPT = 9906
	,	sm.BetTypeRefPT = 4001
	,	sm.SporttypeRefWinlossLimit = 9906
	,	sm.BettypeRefWinlossLimit = 4001
	,	sm.ProductId = 53
	,	sm.RepUpdateTime = SYSDATETIME ()
FROM SportBettypeSettingMatrix_UAT AS sm WITH (ROWLOCK , UPDLOCK)
WHERE
	isLicensee = 0
	AND
	Site = 'ALL'
	AND
	RealProductId = 50
	AND
	SportType = 224
	AND
	bettype = 5500


--------------- Initial For Vgaming , RNG Casino , Other RNG Casino ---------------

IF    NOT EXISTS
	(
		SELECT 1 
		FROM SportBettypeSettingMatrix_UAT WITH (NOLOCK)
		WHERE ProductID = 53 AND RealProductId IN (53 , 66) AND SportType IN (171 , 9906 , 9918) AND bettype IN (3801 , 4001 , 4601)
	)
BEGIN
	INSERT INTO SportBettypeSettingMatrix_UAT
				(
					RealProductId
				    , ProductID
				    , SportType
				    , bettype
				    , isLicensee
				    , isLive
				    , Site
				    , isActive
				    , SportTypeRefPT
				    , BetTypeRefPT
				    , SportTypeRefComm
				    , BetTypeRefComm
				    , SportTypeRefBetSetting
				    , BetTypeRefBetSetting
				    , SporttypeRefWinlossLimit
				    , BettypeRefWinlossLimit
				    , isDeleted
				    , isLivePT
				    , IsLiveComm
				    , IsLiveBetSetting
				    , TablePT
				    , TableComm
				    , TableBetSetting
				    , TableBettrans
				    , RepUpdateTime
				)
	-- Vgaming (66)
	SELECT
		66		   AS RealProductId
	    , 53		   AS ProductID
	    , 171		   AS SportType
	    , 3801		   AS BetType
	    , 0		   AS isLicensee
	    , 0		   AS isLive
	    , 'ALL'		   AS Site
	    , 1		   AS isActive
	    , 9918		   AS SportTypeRefPT
	    , 4601		   AS BetTypeRefPT
	    , NULL		   AS SportTypeRefComm
	    , NULL		   AS BetTypeRefComm
	    , NULL		   AS SportTypeRefBetSetting
	    , NULL		   AS BetTypeRefBetSetting
	    , NULL		   AS SporttypeRefWinlossLimit
	    , NULL		   AS BettypeRefWinlossLimit
	    , 0		   AS isDeleted
	    , 0		   AS isLivePT
	    , 0		   AS IsLiveComm
	    , 0		   AS IsLiveBetSetting
	    , NULL		   AS TablePT
	    , NULL		   AS TableComm
	    , NULL		   AS TableBetSetting
	    , NULL		   AS TableBettrans
	    , SYSDATETIME () AS RepUpdateTime
	UNION ALL

	-- RNG Casino  (53)  
	SELECT
		53		   AS RealProductId
	    , 53		   AS ProductID
	    , 9906		   AS SportType
	    , 4001		   AS BetType
	    , 0		   AS isLicensee
	    , 0		   AS isLive
	    , 'ALL'		   AS Site
	    , 0		   AS isActive
	    , 9906		   AS SportTypeRefPT
	    , 4001		   AS BetTypeRefPT
	    , 9906		   AS SportTypeRefComm
	    , 4001		   AS BetTypeRefComm
	    , 9906		   AS SportTypeRefBetSetting
	    , 4001		   AS BetTypeRefBetSetting
	    , 9906		   AS SporttypeRefWinlossLimit
	    , 4001		   AS BettypeRefWinlossLimit
	    , 0		   AS isDeleted
	    , 0		   AS isLivePT
	    , 0		   AS IsLiveComm
	    , 0		   AS IsLiveBetSetting
	    , NULL		   AS TablePT
	    , NULL		   AS TableComm
	    , NULL		   AS TableBetSetting
	    , NULL		   AS TableBettrans
	    , SYSDATETIME () AS RepUpdateTime

	UNION ALL

	--Other RNG Casino  (53)  
	SELECT
		53		   AS RealProductId
	    , 53		   AS ProductID
	    , 9918		   AS SportType
	    , 4601		   AS BetType
	    , 0		   AS isLicensee
	    , 0		   AS isLive
	    , 'ALL'		   AS Site
	    , 0		   AS isActive
	    , 9918		   AS SportTypeRefPT
	    , 4601		   AS BetTypeRefPT
	    , 9918		   AS SportTypeRefComm
	    , 4601		   AS BetTypeRefComm
	    , 9918		   AS SportTypeRefBetSetting
	    , 4601		   AS BetTypeRefBetSetting
	    , 9918		   AS SporttypeRefWinlossLimit
	    , 4601		   AS BettypeRefWinlossLimit
	    , 0		   AS isDeleted
	    , 0		   AS isLivePT
	    , 0		   AS IsLiveComm
	    , 0		   AS IsLiveBetSetting
	    , NULL		   AS TablePT
	    , NULL		   AS TableComm
	    , NULL		   AS TableBetSetting
	    , NULL		   AS TableBettrans
	    , SYSDATETIME () AS RepUpdateTime
END