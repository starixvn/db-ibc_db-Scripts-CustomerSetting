/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date:26/06/2024
	Task: Delete Data Redundant Product Status [#204358] 
	DB: DBCust/CustDB
*/

-- REMOVE ProductStatusSiteCurrency : Lottery

IF EXISTS (SELECT TOP 1 1 FROM ProductStatusSiteCurrency pssc WITH (NOLOCK) WHERE pssc.SportType  = 220)
BEGIN
	DELETE pssc FROM ProductStatusSiteCurrency pssc WITH (ROWLOCK) WHERE pssc.SportType  = 220
END


-- REMOVE ProductStatusSiteCurrency : Table Games

IF EXISTS (SELECT TOP 1 1 FROM ProductStatusSiteCurrency pssc WITH (NOLOCK) WHERE pssc.SportType  = 222)
BEGIN

	DELETE pssc FROM ProductStatusSiteCurrency pssc WITH (ROWLOCK) WHERE pssc.SportType  = 222
END



-- REMOVE ProductStatusProfile : RNG Keno

IF EXISTS (SELECT TOP 1 1 FROM ProductStatusProfile pssc WITH (NOLOCK) WHERE pssc.SportType  = 202)
BEGIN

	DELETE pssc FROM ProductStatusProfile pssc WITH (ROWLOCK) WHERE pssc.SportType  = 202
END

-- REMOVE ProductStatusProfile : Lottery

IF EXISTS (SELECT TOP 1 1 FROM ProductStatusProfile pssc WITH (NOLOCK) WHERE pssc.SportType  = 220)
BEGIN

	DELETE pssc FROM ProductStatusProfile pssc WITH (ROWLOCK) WHERE pssc.SportType  = 220
END

-- REMOVE ProductStatusProfile : Table Games

IF EXISTS (SELECT TOP 1 1 FROM ProductStatusProfile pssc WITH (NOLOCK) WHERE pssc.SportType  = 222)
BEGIN

	DELETE pssc FROM ProductStatusProfile pssc WITH (ROWLOCK) WHERE pssc.SportType  = 222
END
