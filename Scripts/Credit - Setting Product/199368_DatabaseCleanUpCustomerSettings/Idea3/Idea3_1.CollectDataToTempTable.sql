/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240110@Helios
	Task: Collect Data To Temp Table [#199368]
		https://nexdev.net/issues/199368
	DB: DBCust/CustDB 

	----RUN AT DBTEST----
*/
	SET NOCOUNT ON

	TRUNCATE TABLE Tmp_CleanUpCustomerSetting

	---------------------------------------COLLECTED DATA TEMP TABLE--------------------------------------
	
	---- CustPTSetting3rd_Agent : Remark = 1
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustPTSetting3rd_Agent cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	---- CustPTSetting3rd_Member : Remark = 2
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustPTSetting3rd_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)

	---- CustBetSetting3rd_Agent : Remark = 3
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustBetSetting3rd_Agent cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)

	---- CustBetSetting3rd_Member : Remark = 4
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustBetSetting3rd_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)

	---- CustDiscount3rd_Agent : Remark = 5
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustDiscount3rd_Agent cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)

	---- CustDiscount3rd_Member : Remark = 6
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustDiscount3rd_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)

	---- CustWinLossLimit_Agent : Remark = 7
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustWinLossLimit_Agent cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)

	---- CustWinLossLimit_Member : Remark = 8
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustWinLossLimit_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)

	---- CustStakeLevel_Agent : Remark = 9
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustStakeLevel_Agent cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)

	---- CustStakeLevel_Member : Remark = 10
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustStakeLevel_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)

	---- CustPTGroupSetting3rd_Member : Remark = 11
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.AgentID
	FROM CustPTGroupSetting3rd_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.AgentID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.AgentID)

	---- CustSettingMode3rd : Remark = 12
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustSettingMode3rd cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)

	---- CustProductStatus : Remark = 13
	INSERT INTO Tmp_CleanUpCustomerSetting (CustID)
	SELECT DISTINCT cpm.CustID
	FROM CustProductStatus cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL
	AND NOT EXISTS (SELECT 1 FROM Tmp_CleanUpCustomerSetting tcucs  WITH (NOLOCK) WHERE tcucs.CustID = cpm.CustID)


	-- SELECT COUNT(1) FROM Tmp_CleanUpCustomerSetting WITH (NOLOCK)