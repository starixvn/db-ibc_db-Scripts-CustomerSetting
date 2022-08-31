/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20220831
	Task:  Adjust bet limit soccer parlay  [RedmineID:#177263]
	DB: DBCUST-CUSTDB and custdb_custsetting publication
*/
USE CUSTDB
GO
--> Alter SP
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
AS
BEGIN	
	SET NOCOUNT ON
	IF (
		dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0 
	   )
		RETURN

	DECLARE @BatchNum INT = 5000
	CREATE TABLE #TmpWrongBetlimit_Cust (CustID INT, sporttype smallint, bettype smallint)
	CREATE TABLE #TmpCust_Batch (CustID INT, sporttype smallint, bettype smallint)

	INSERT INTO #TmpWrongBetlimit_Cust(CustID,sporttype,bettype)
	SELECT CustID,SportType,BetType
	FROM dbo.Dep_CustBetSettingGame_Member WITH(NOLOCK) 
	WHERE maxbet > MaxPerMatch and Maxbet<> 0 and MaxPerMatch <> 0

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #TmpCust_Batch

		DELETE TOP(@BatchNum) a
		OUTPUT deleted.CustID,deleted.sporttype,deleted.bettype INTO #TmpCust_Batch(CustID,sporttype,bettype)
		FROM #TmpWrongBetlimit_Cust a WITH(ROWLOCK, UPDLOCK)

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE a
		SET a.MaxBet = a.MaxPerMatch
		FROM Dep_CustBetSettingGame_Member a WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TmpCust_Batch t 
				ON a.CustID = t.CustID 
				AND a.SportType = t.sporttype 
				AND a.BetType= t.bettype
		WHERE a.MaxBet > a.MaxPerMatch and a.Maxbet<> 0 and a.MaxPerMatch <> 0
	END

	DROP TABLE #TmpCust_Batch
	DROP TABLE #TmpWrongBetlimit_Cust
END
GO
--> Run SP
EXEC dbo.[Acc_Dep_DynamicCustSetting_09]
