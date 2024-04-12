/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Config UM for RNG Casino & Other RNG Casino [#198960] 
	DB: DBCust/CustDB
*/

DECLARE @CurrentDTS	smalldatetime = GETDATE()

IF NOT EXISTS( SELECT 1 FROM UMConfig WITH(NOLOCK) WHERE ProductID = 53)
BEGIN
	INSERT INTO UMConfig(
		 ProductID
		,SportType
		,BetType
		,IsLive
		,SettingType
		,FunctionType
		,SiteID
		,Currency
		,SuperID
		,BeginTime
		,EndTime
		,ShowTime
		,LockAddingNew
	)
	SELECT ProductID = 53
		,SportType
		,BetType
		,IsLive
		,SettingType
		,FunctionType
		,SiteID
		,Currency
		,SuperID
		,BeginTime = @CurrentDTS
		,EndTime
		,ShowTime = @CurrentDTS
		,LockAddingNew
	FROM UMConfig WITH(NOLOCK)
	WHERE ProductID = 18
END