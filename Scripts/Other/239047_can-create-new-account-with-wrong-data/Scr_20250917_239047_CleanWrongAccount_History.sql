/*<info serverAlias="DBCUST-CustDB_History"></info>*/
/*
	Created: 20250917@Eden
	Task : Delete accounts who incorrect data created during account registration - History table [#239047]
	DB: DBCUST-CustDB_History
*/
	USE CustDB_History
	GO
	DECLARE @CustIDList NVARCHAR(MAX) = '262459222,262463511,262465540,262549463';
	DECLARE @Date DATE -- use index of history table
	DECLARE @Deleted BIT = 1 -- 0: :Select mode, 1: Deleted Mode
	CREATE TABLE #CustIDList (CustID INT)

	INSERT INTO #CustIDList(CustID)
	SELECT t.value AS CustID
	FROM STRING_SPLIT(@CustIDList, ',') t
		INNER JOIN CustDB.dbo.Custinfo ci WITH(NOLOCK)
			ON t.value = ci.custid
		INNER JOIN GlobCustDB.dbo.CustInfoMini cm WITH(NOLOCK)
			ON ci.custid = cm.CustID
			AND ci.recommend <> cm.recommend

	IF NOT EXISTS(SELECT * FROM #CustIDList)
		RETURN

	SELECT @Date = MIN(creatdate) 
	FROM custdb.dbo.customer WITH(NOLOCK) 
	WHERE CustID IN (SELECT CustID FROM #CustIDList)

	-----------SELECT DATA--------------------
	SELECT * FROM CustInfo_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM Customer_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM CustWinLossLimit_Member_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM CustVirtualSetting_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM VRCustLockStatus_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM CustDiscount3rd_Member_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM CustMaxPayoutSetting_Member_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM CustProductStatus_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM BetSetting_Member_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM BetSetting3rd_Member_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM CustPTSetting3rd_Member_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM CustSettingMode3rd_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	SELECT * FROM CustStakeLevel_Member_History WITH (NOLOCK)
	WHERE CustID IN (SELECT CustID FROM #CustIDList)
	  AND UpdateTime >= @Date;

	-----------------------DELETE DATA----------------------------
	IF @Deleted = 1
	BEGIN
		DELETE FROM CustInfo_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM Customer_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM CustWinLossLimit_Member_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM CustVirtualSetting_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM VRCustLockStatus_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM CustDiscount3rd_Member_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM CustMaxPayoutSetting_Member_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;


		DELETE FROM CustProductStatus_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM BetSetting_Member_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM BetSetting3rd_Member_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM CustPTSetting3rd_Member_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM CustSettingMode3rd_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;

		DELETE FROM CustStakeLevel_Member_History WITH (ROWLOCK)
		WHERE CustID IN (SELECT CustID FROM #CustIDList)
		  AND UpdateTime >= @Date;
	END

	DROP TABLE #CustIDList;