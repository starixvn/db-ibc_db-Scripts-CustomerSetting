/*<info serverAlias="DBARCCUST-Bodb_Archive_Customer_Licensee"></info>*/
/*
    Created: Eden@20220825
    Task: delete archived data of members: [#175813]
		(49392241,50323695,52752449,51300157,51101183,52949554,53912640)

    DB: DBARCCUST/Bodb_Archive_Customer_Licensee
*/ 
	CREATE TABLE #TblCust(CustID INT)
	INSERT INTO #TblCust
	SELECT  49392241
	UNION ALL SELECT 50323695
	UNION ALL SELECT 52752449
	UNION ALL SELECT 51300157
	UNION ALL SELECT 51101183
	UNION ALL SELECT 52949554
	UNION ALL SELECT 53912640

	--Delete existing settings in Archive DB
	DELETE custinfo
	WHERE CustID IN (SELECT CustID FROM #TblCust )

	DELETE customer
	WHERE CustID IN (SELECT CustID FROM #TblCust )

	DELETE [CustSettingGame]
	WHERE CustID IN (SELECT CustID FROM #TblCust )
	
	DELETE CustVirtualSetting
	WHERE CustID IN (SELECT CustID FROM #TblCust )
	
	
	DELETE Dep_CustBetSetting_Member
	WHERE CustID IN (SELECT CustID FROM #TblCust )
	
	DELETE Dep_CustCommRate
	WHERE CustID IN (SELECT CustID FROM #TblCust )
	
	DELETE Dep_CustDiscountSetting_Member
	WHERE CustID IN (SELECT CustID FROM #TblCust )
	
	DELETE Dep_CustProductSetting
	WHERE CustID IN (SELECT CustID FROM #TblCust )
	
	DELETE Dep_CustProductStatus
	WHERE CustID IN (SELECT CustID FROM #TblCust )
	
	DELETE Dep_CustPTSetting_Member
	WHERE CustID IN (SELECT CustID FROM #TblCust )
	
	DELETE Dep_CustSetting
	WHERE CustID IN (SELECT CustID FROM #TblCust )
	
	DELETE Dep_CustSetting_AGCasino
	WHERE CustID IN (SELECT CustID FROM #TblCust)
	
	DELETE Dep_CustSetting3rd
	WHERE CustID IN (SELECT CustID FROM #TblCust)
	
	DELETE Dep_CustSettingGame
	WHERE CustID IN (SELECT CustID FROM #TblCust)
	
	DELETE Dep_CustSettingMode
	WHERE CustID IN (SELECT CustID FROM #TblCust)
	
	DELETE Dep_CustSpecialLevel
	WHERE CustID IN (SELECT CustID FROM #TblCust)
	
	DELETE Dep_CustStakeLevel_Member
	WHERE CustID IN (SELECT CustID FROM #TblCust)
	
	DELETE CustGameType
	WHERE CustID IN (SELECT CustID FROM #TblCust)