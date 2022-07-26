/*<info serverAlias="DBARCCUST-Bodb_Archive_Customer_Licensee"></info>*/
/*
    Created: Eden@20220725
    Task: delete archived data of members: [#175813]
		50648534,
		40348279,
		44289059,
		45853454,
		46304695,
		46392499,
		47139591,
		47499246,
		50326036,
		50529438,
		51824964,
		51883489,
		52157851

    DB: DBARCCUST/Bodb_Archive_Customer_Licensee
*/ 
	CREATE TABLE #TblCust(CustID INT)
	INSERT INTO #TblCust
	SELECT  50648534 UNION ALL
	SELECT	40348279 UNION ALL
	SELECT	44289059 UNION ALL
	SELECT	45853454 UNION ALL
	SELECT	46304695 UNION ALL
	SELECT	46392499 UNION ALL
	SELECT	47139591 UNION ALL
	SELECT	47499246 UNION ALL
	SELECT	50326036 UNION ALL
	SELECT	50529438 UNION ALL
	SELECT	51824964 UNION ALL
	SELECT	51883489 UNION ALL
	SELECT	52157851

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