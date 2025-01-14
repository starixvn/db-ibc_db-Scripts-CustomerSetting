/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240321@Helios
	Task: Incorporate Saba New Number Game - Init for UUS - Deposit [#202590] 
		https://nexdev.net/issues/202590
	DB: DBCust/CustDB

	Revision:
		- 20250114@Tacy: PROD - Enable Saba xD for Yes888 site [#216789]
*/
	--Dep_ProductStakeLevelGroup
	INSERT INTO Dep_ProductStakeLevelGroup 
	(
		Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , LicenseeGroupID
		, SiteID
		, RepUpdateTime
	)
	SELECT 240 , 2 , 0.01 , 300000 , 6 , 0, dbo.f_GetDateTime2()