/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date:26/06/2024
	Task: Delete Data Redundant ProductBetSetting [#204358] 
	DB: DBCust/CustDB
*/

-- REMOVE ProductBetSetting : RNG Keno (202)
IF EXISTS (SELECT TOP 1 1 FROM ProductBetSetting pbs WITH (NOLOCK) WHERE pbs.Sporttype = 202)
BEGIN
	DELETE pbs FROM ProductBetSetting pbs WITH (ROWLOCK) WHERE pbs.Sporttype = 202
END


-- REMOVE ProductBetSetting : Lottery (220)
IF EXISTS (SELECT TOP 1 1 FROM ProductBetSetting pbs WITH (NOLOCK) WHERE pbs.Sporttype = 220)
BEGIN
	DELETE pbs FROM ProductBetSetting pbs WITH (ROWLOCK) WHERE pbs.Sporttype = 220
END


-- REMOVE ProductBetSetting : Table Game (222)
IF EXISTS (SELECT TOP 1 1 FROM ProductBetSetting pbs WITH (NOLOCK) WHERE pbs.Sporttype = 222)
BEGIN
	DELETE pbs FROM ProductBetSetting pbs WITH (ROWLOCK) WHERE pbs.Sporttype = 222
END