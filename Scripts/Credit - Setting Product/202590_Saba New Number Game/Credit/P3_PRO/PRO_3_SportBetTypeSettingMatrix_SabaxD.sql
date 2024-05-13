/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024/04/16
	Task: Inital Data Setting SportBettypeSettingMatrix [#202590] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------- Initial For Saba xD : Bettype range: [10801 - 11000] ---------------------------------------------
DECLARE @temp TABLE (SportType SMALLINT, BetType INT IDENTITY(10801,1))
DECLARE @i INT = 1


WHILE (@i < 201)
BEGIN
	INSERT INTO @temp( Sporttype)
	SELECT 240

	SELECT @i = @i + 1
END

IF NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix sbsmu WITH (NOLOCK) 
				INNER JOIN @temp t ON sbsmu.SportType = t.SportType AND sbsmu.BetType = t.BetType
				WHERE sbsmu.RealProductId = 86 AND sbsmu.isLicensee = 0 AND sbsmu.isLive = 0)
BEGIN
	INSERT INTO SportBettypeSettingMatrix
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
	SELECT
			86		   AS RealProductId
		    , 53		   AS ProductID
		    , t.SportType	   AS SportType
		    , t.BetType	   AS BetType
		    , 0		   AS isLicensee
		    , 0		   AS isLive
		    , 'ALL'		   AS Site
		    , 1		   AS isActive
		    , 9918		   AS SportTypeRefPT
		    , 4601		   AS BetTypeRefPT
		    , NULL		   AS SportTypeRefComm
		    , NULL		   AS BetTypeRefComm
		    , 240		   AS SportTypeRefBetSetting
		    , 10801		   AS BetTypeRefBetSetting
		    , NULL		   AS SporttypeRefWinlossLimit
		    , NULL		   AS BettypeRefWinlossLimit
		    , 0		   AS isDeleted
		    , 0		   AS isLivePT
		    , 0		   AS IsLiveComm
		    , 0		   AS IsLiveBetSetting
		    , 'CustPTSetting3rd_member'		   AS TablePT
		    , 'CustDiscount3rd_member'		   AS TableComm
		    , 'CustStakeLevel_Member'			   AS TableBetSetting
		    , 'bettransRNG'				   AS TableBettrans
		    , SYSDATETIME () AS RepUpdateTime
	FROM @temp AS t
END

