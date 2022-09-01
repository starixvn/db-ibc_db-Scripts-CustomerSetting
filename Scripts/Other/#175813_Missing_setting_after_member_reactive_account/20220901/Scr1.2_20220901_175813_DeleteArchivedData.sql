/*<info serverAlias="DBARCCUST-Bodb_Archive_Customer_Licensee"></info>*/
/*
    Created: Eden@20220825
    Task: delete archived data of members: [#175813]
			49270221,
			49337414,
			49427319,
			50587594,
			50807646,
			50855025,
			50910044,
			51082271,
			51509257,
			51841875,
			52100533,
			52516775,
			52573558,
			52643970,
			52736086

    DB: DBARCCUST/Bodb_Archive_Customer_Licensee
*/ 
USE Bodb_Archive_Customer_Licensee
GO
	CREATE TABLE #TblCust(CustID INT)
	INSERT INTO #TblCust
	SELECT custid
	FROM custinfo WITH(NOLOCK) 
	WHERE CustID IN (
			49270221,
			49337414,
			49427319,
			50587594,
			50807646,
			50855025,
			50910044,
			51082271,
			51509257,
			51841875,
			52100533,
			52516775,
			52573558,
			52643970,
			52736086
	)

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