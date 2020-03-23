/*
	Created: Elodie
	Date: 20200323
	Task: DELETE existed stake level for Virtual game DEPOSIT
	DB: DBCust/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN

	DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
	INSERT INTO @SportBettype(SportType, BetType) VALUES (245, 4601)
	DECLARE @CustTmp TABLE (CustID INT, SportType SMALLINT, BetType SMALLINT)
	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	WHILE (1 = 1)
	BEGIN		
		INSERT INTO @CustTmp (CustID, SportType, BetType) 		
		SELECT TOP (4000) a.CustID,a.SportType,a.BetType
		FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
			INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
		
		IF @@ROWCOUNT = 0 BREAK	

		DELETE csa
		FROM dbo.Dep_CustStakeLevel_Agent csa WITH(ROWLOCK)
			INNER JOIN @CustTmp cs ON cs.custid = csa.custid AND csa.bettype = cs.BetType AND csa.sporttype = cs.SportType
	END

	WHILE (1 = 1)
	BEGIN		
		INSERT INTO @CustTmp (CustID, SportType, BetType) 		
		SELECT TOP (4000) a.CustID,a.SportType,a.BetType
		FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
			INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
		
		IF @@ROWCOUNT = 0 BREAK	

		DELETE csm
		FROM dbo.Dep_CustStakeLevel_Member csm WITH(ROWLOCK)
			INNER JOIN @CustTmp cs ON cs.custid = csm.custid AND csm.bettype = cs.BetType AND csm.sporttype = cs.SportType
	END
END

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'