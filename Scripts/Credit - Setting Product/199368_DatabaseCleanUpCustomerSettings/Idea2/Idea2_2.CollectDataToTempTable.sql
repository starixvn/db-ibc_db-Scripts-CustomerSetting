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


	SELECT * FROM Tmp_CleanUpCustomerSetting