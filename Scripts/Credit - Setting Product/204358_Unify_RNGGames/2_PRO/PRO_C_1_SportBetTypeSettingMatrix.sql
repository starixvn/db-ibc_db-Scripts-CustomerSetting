/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 03/05/2024
	Task: Inital Data SportBettypeSettingMatrix  [#204358]   
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Number Games : 3
UPDATE sbsm
	SET 
		sbsm.SportTypeRefPT			= 9909 ,
		sbsm.BetTypeRefPT				= 3700 ,
		sbsm.SporttypeRefWinlossLimit		= CASE WHEN Sporttype = 161 AND sbsm.BetType = 81 THEN 9909 ELSE sbsm.SporttypeRefWinlossLimit END  ,
		sbsm.BettypeRefWinlossLimit		= CASE WHEN Sporttype = 161 AND sbsm.BetType = 81 THEN 3700 ELSE sbsm.BettypeRefWinlossLimit  END   ,
		sbsm.TableBetSetting			= 'BetSetting3rd_Member' ,
		sbsm.ProductID				= 44,
		sbsm.SportTypeRefBetSetting		= 161 , -- 164 : Happy 5 || 168 : Happy 5 Link Game
		sbsm.BetTypeRefBetSetting		= 81 ,
		sbsm.RepUpdateTime			= SYSDATETIME ()
FROM SportBettypeSettingMatrix sbsm WITH (ROWLOCK , UPDLOCK)
WHERE isDeleted = 0  
AND sbsm.isLicensee = 0  
AND sbsm.Site = 'ALL'  
AND sbsm.RealProductId = 3
AND sbsm.SportType  IN (161,164,168)


-- Virtual Sports : 5
UPDATE sbsm
	SET 
		sbsm.SportTypeRefPT			= 9909 ,
		sbsm.BetTypeRefPT				= 3700 ,
		sbsm.TableBetSetting			= 'BetSetting3rd_Member' ,
		sbsm.ProductID				= 44,
		sbsm.RepUpdateTime			= SYSDATETIME ()
FROM SportBettypeSettingMatrix sbsm WITH (ROWLOCK , UPDLOCK)
WHERE isDeleted = 0  
AND sbsm.isLicensee = 0  
AND sbsm.Site = 'ALL'  
AND sbsm.ProductID = 5


-- RNG Keno : 8
UPDATE sbsm
	SET 
		sbsm.SportTypeRefPT			= 9909 ,
		sbsm.BetTypeRefPT				= 3700 ,
		sbsm.SportTypeRefBetSetting		= 9919 ,
		sbsm.BetTypeRefBetSetting		= 1501 ,
		sbsm.TableBetSetting			= 'BetSetting3rd_Member' ,
		sbsm.ProductID				= 44,
		sbsm.RepUpdateTime			= SYSDATETIME ()
FROM SportBettypeSettingMatrix sbsm WITH (ROWLOCK , UPDLOCK)
WHERE isDeleted = 0  
AND sbsm.isLicensee = 0  
AND sbsm.Site = 'ALL'  
AND sbsm.RealProductId = 8

-- Lottery : 28
UPDATE sbsm
	SET 
		sbsm.SportTypeRefPT			= 9909 ,
		sbsm.BetTypeRefPT				= 3700 ,
		sbsm.SportTypeRefBetSetting		= 9919 ,
		sbsm.BetTypeRefBetSetting		= 1501 ,
		sbsm.TableBetSetting			= 'BetSetting3rd_Member' ,
		sbsm.ProductID				= 44,
		sbsm.RepUpdateTime			= SYSDATETIME ()
FROM SportBettypeSettingMatrix sbsm WITH (ROWLOCK , UPDLOCK)
WHERE isDeleted = 0  
AND sbsm.isLicensee = 0  
AND sbsm.Site = 'ALL'  
AND sbsm.RealProductId = 28


-- Table Game : 40
UPDATE sbsm
	SET 
		sbsm.SportTypeRefPT			= 9909 ,
		sbsm.BetTypeRefPT				= 3700 ,
		sbsm.SportTypeRefBetSetting		= 9919 ,
		sbsm.BetTypeRefBetSetting		= 1501 ,
		sbsm.TableBetSetting			= 'BetSetting3rd_Member' ,
		sbsm.ProductID				= 44,
		sbsm.RepUpdateTime			= SYSDATETIME ()
FROM SportBettypeSettingMatrix sbsm WITH (ROWLOCK , UPDLOCK)
WHERE isDeleted = 0  
AND sbsm.isLicensee = 0  
AND sbsm.Site = 'ALL'  
AND sbsm.RealProductId = 40

-- Table Game : 63
UPDATE sbsm
	SET 
		sbsm.SportTypeRefPT			= 9909 ,
		sbsm.BetTypeRefPT				= 3700 ,
		sbsm.TableBetSetting			= 'BetSetting3rd_Member' ,
		sbsm.ProductID				= 44,
		sbsm.RepUpdateTime			= SYSDATETIME ()
FROM SportBettypeSettingMatrix sbsm WITH (ROWLOCK , UPDLOCK)
WHERE isDeleted = 0  
AND sbsm.isLicensee = 0  
AND sbsm.Site = 'ALL'  
AND sbsm.RealProductId = 63

IF NOT EXISTS (	SELECT TOP 1 1
			FROM SportBettypeSettingMatrix sbsm
			WHERE isDeleted = 0  
			AND sbsm.isLicensee = 0  
			AND sbsm.Site = 'ALL'  
			AND (
				   (sbsm.RealProductId = 5 AND sbsm.SportType = 9908 AND sbsm.BetType = 1201)
				OR (sbsm.RealProductId = 8 AND sbsm.SportType = 202 AND sbsm.BetType = 1501)
			)
		)
BEGIN
	INSERT INTO SportBettypeSettingMatrix 
	(
		SportType
	    , BetType
	    , isLicensee
	    , isLive
	    , Site
	    , isActive
	    , SportTypeRefPT
	    , BetTypeRefPT
	    , isLivePT
	    , TablePT
	    , SportTypeRefComm
	    , BetTypeRefComm
	    , TableComm
	    , SportTypeRefBetSetting
	    , BetTypeRefBetSetting
	    , TableBetSetting
	    , IsLiveComm
	    , IsLiveBetSetting
	    , TableBettrans
	    , SporttypeRefWinlossLimit
	    , BettypeRefWinlossLimit
	    , RealProductId
	    , isDeleted
	    , ProductID
	)
	-- Virtual Sports
	SELECT
		9908				  AS SportType
	    , 1201				  AS BetType
	    , 0				  AS isLicensee
	    , 0				  AS isLive
	    , 'All'				  AS Site
	    , 1				  AS isActive
	    , 9909				  AS SportTypeRefPT
	    , 3700				  AS BetTypeRefPT
	    , 0				  AS isLivePT
	    , 'CustPTSetting3rd_member' AS TablePT
	    , NULL				  AS SportTypeRefComm
	    , NULL				  AS BetTypeRefComm
	    , NULL				  AS TableComm
	    , 9908				  AS SportTypeRefBetSetting
	    , 1201				  AS BetTypeRefBetSetting
	    , 'BetSetting3rd_Member'	  AS TableBetSetting
	    , 0				  AS IsLiveComm
	    , 0				  AS IsLiveBetSetting
	    , 'bettrans'			  AS TableBettrans
	    , 9908				  AS SporttypeRefWinlossLimit
	    , 1201				  AS BettypeRefWinlossLimit
	    , 5				  AS RealProductId
	    , 0				  AS isDeleted
	    , 44				  AS ProductID
	UNION ALL
	-- RNG Keno
	SELECT
		202				  AS SportType
	    , 1501				  AS BetType
	    , 0				  AS isLicensee
	    , 0				  AS isLive
	    , 'All'				  AS Site
	    , 1				  AS isActive
	    , 9909				  AS SportTypeRefPT
	    , 3700				  AS BetTypeRefPT
	    , 0				  AS isLivePT
	    , 'CustPTSetting3rd_Member' AS TablePT
	    , NULL				  AS SportTypeRefComm
	    , NULL				  AS BetTypeRefComm
	    , NULL				  AS TableComm
	    , 9919				  AS SportTypeRefBetSetting
	    , 1501				  AS BetTypeRefBetSetting
	    , 'BetSetting3rd_Member'	  AS TableBetSetting
	    , 0				  AS IsLiveComm
	    , 0				  AS IsLiveBetSetting
	    , 'translog'			  AS TableBettrans
	    , 9909				  AS SporttypeRefWinlossLimit
	    , 3700				  AS BettypeRefWinlossLimit
	    , 8				  AS RealProductId
	    , 0				  AS isDeleted
	    , 44				  AS ProductID
END
