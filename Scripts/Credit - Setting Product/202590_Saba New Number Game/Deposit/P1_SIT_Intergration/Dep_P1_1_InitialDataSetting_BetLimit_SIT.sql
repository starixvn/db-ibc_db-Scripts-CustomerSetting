/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240321@Helios
	Task: Incorporate Saba New Number Game - Init for UUS - Deposit [#202590] 
		https://nexdev.net/issues/202590
	DB: DBCust/CustDB
*/
	--Dep_ProductStakeLevelGroup
	INSERT INTO Dep_ProductStakeLevelGroup 
	(
		Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , LicenseeGroupID
	    , Remark
	)
	SELECT @Sporttype , 1 , 0.01 , 300000 , 6 , ''