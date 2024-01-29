/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240104@Helios
	Task: Collect Data To Temp Table [#199368]
		https://nexdev.net/issues/199368
	DB: DBCust/CustDB 
*/
	SET NOCOUNT ON

	TRUNCATE TABLE Tmp_CleanUpCustomerSetting

	---------------------------------------COLLECTED DATA TEMP TABLE--------------------------------------
	
	-- CustPTSetting3rd_Agent : Remark = 0
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 0 , cpm.CustID
	FROM CustPTSetting3rd_Agent cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL


	-- CustPTSetting3rd_Member : Remark = 1
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 1 , cpm.CustID
	FROM CustPTSetting3rd_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustBetSetting3rd_Agent : Remark = 2
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 2 , cpm.CustID
	FROM CustBetSetting3rd_Agent cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustBetSetting3rd_Member : Remark = 3
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 3 , cpm.CustID
	FROM CustBetSetting3rd_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustDiscount3rd_Agent : Remark = 4
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 4 , cpm.CustID
	FROM CustDiscount3rd_Agent cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustDiscount3rd_Member : Remark = 5
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 5 , cpm.CustID
	FROM CustDiscount3rd_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustWinLossLimit_Agent : Remark = 6
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 6 , cpm.CustID
	FROM CustWinLossLimit_Agent cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustWinLossLimit_Member : Remark = 7
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 7 , cpm.CustID
	FROM CustWinLossLimit_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustStakeLevel_Agent : Remark = 8
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 8 , cpm.CustID
	FROM CustStakeLevel_Agent cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustStakeLevel_Member : Remark = 9
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 9 , cpm.CustID
	FROM CustStakeLevel_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustSettingMode3rd : Remark = 10
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 10 , cpm.CustID
	FROM CustSettingMode3rd cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustProductStatus : Remark = 11
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 11 , cpm.CustID
	FROM CustProductStatus cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.CustID = c.custid
	WHERE  c.custid IS NULL

	-- CustPTGroupSetting3rd_Member : Remark = 12
	INSERT INTO Tmp_CleanUpCustomerSetting (Remark, CustID)
	SELECT DISTINCT 12 , cpm.AgentID
	FROM CustPTGroupSetting3rd_Member cpm WITH (NOLOCK)
	LEFT JOIN Customer c WITH (NOLOCK) ON cpm.AgentID = c.custid
	WHERE  c.custid IS NULL


	SELECT * FROM Tmp_CleanUpCustomerSetting