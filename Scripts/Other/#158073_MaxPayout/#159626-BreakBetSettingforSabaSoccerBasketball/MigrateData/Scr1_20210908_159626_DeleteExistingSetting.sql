/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210908
	Task: Delete existing data of Saba Soccer and Saba Basketball [Redmine: #159626]   
	DB: DBCUST/CUSTDB and all subscribers of CustDB_CustSetting publication
*/

-- STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	 @target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting_Member') = 0 RETURN

	CREATE TABLE #CustBetSetting_Agent(CustID int, SportType smallint,BetType smallint)
	CREATE TABLE #CustBetSetting_Member(CustID int, SportType smallint,BetType smallint)
	CREATE TABLE #CustBetSetting_Agent_batch(CustID int, SportType smallint,BetType smallint)
	CREATE TABLE #CustBetSetting_Member_batch(CustID int, SportType smallint,BetType smallint)

	INSERT INTO #CustBetSetting_Agent(CustID,SportType,BetType)
	SELECT b.custid,b.sporttype,b.bettype 
	FROM CustBetSetting_Agent b WITH(NOLOCK)
	WHERE b.sporttype IN (9901,9902) AND b.BetType = 1

	INSERT INTO #CustBetSetting_Member(CustID,SportType,BetType)
	SELECT b.custid,b.sporttype,b.bettype 
	FROM CustBetSetting_Member b WITH(NOLOCK)
	WHERE b.sporttype IN (9901,9902) AND b.BetType = 1

	--Delete SMA Setting
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustBetSetting_Agent_batch

		DELETE TOP (5000) a
		OUTPUT deleted.custid,deleted.sporttype,deleted.bettype INTO #CustBetSetting_Agent_batch(custid,SportType,BetType)
		FROM #CustBetSetting_Agent a

		IF @@ROWCOUNT = 0
			BREAK

		DELETE b
		FROM CustBetSetting_Agent b WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustBetSetting_Agent_batch t 
				ON b.custid = t.CustID
				AND b.sporttype = t.SportType
				AND b.bettype = t.BetType

		WAITFOR DELAY '00:00:0.01'
	END

	--Delete Member Setting
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustBetSetting_Member_batch

		DELETE TOP (5000) a
		OUTPUT deleted.custid,deleted.sporttype,deleted.bettype INTO #CustBetSetting_Member_batch(custid,SportType,BetType)
		FROM #CustBetSetting_Member a

		IF @@ROWCOUNT = 0
			BREAK

		DELETE b
		FROM CustBetSetting_Member b WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustBetSetting_Member_batch t 
				ON b.custid = t.CustID
				AND b.sporttype = t.SportType
				AND b.bettype = t.BetType

		WAITFOR DELAY '00:00:0.01'
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = @target

GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------