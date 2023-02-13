/*<info serverAlias="DBCUST-CUSTDB"></info>*/
 /*
	Created: 20230213@Eden
	Task: Delete BLC of Deposit Customer with type "New Account Bet Limit by Performance" - BetLimitTypeID = 25 [Redmine:#183732]	
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
AS
BEGIN	
	CREATE TABLE #Temp_BLC_25_Deposit(CustID INT)
	CREATE TABLE #Temp_BLC_25(CustID INT)
	CREATE TABLE #TempCustBatch(CustID INT)
	DECLARE @BatchNum INT = 5000

	--Get all BLC type = 25 
	INSERT INTO #Temp_BLC_25(CustID)
	SELECT t.CustID 
	FROM BetLimitControlCustSetting t WITH(NOLOCK) 
	WHERE t.BetLimitTypeID = 25

	--Get all BLC type = 25 - Deposit customer only
	INSERT INTO #Temp_BLC_25_Deposit(CustID)
	SELECT t.CustID
	FROM #Temp_BLC_25 t WITH(NOLOCK) 
		INNER JOIN custinfo c WITH(NOLOCK) 
			ON t.CustID = c.custid
	WHERE c.srecommend IN( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	UNION ALL
	SELECT t.custid
	FROM #Temp_BLC_25 t WITH(NOLOCK) 
		INNER JOIN Dep_Customer_Archived c WITH(NOLOCK) 
			ON t.CustID = c.custid

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #TempCustBatch

		DELETE TOP(@BatchNum) t
		OUTPUT deleted.CustID INTO #TempCustBatch(CustID)
		FROM #Temp_BLC_25_Deposit t

		IF @@ROWCOUNT = 0
			RETURN

		DELETE c
		FROM BetLimitControlCustSetting c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #TempCustBatch t ON c.CustID = t.CustID
		WHERE c.BetLimitTypeID = 25
	END

	DROP TABLE #Temp_BLC_25
	DROP TABLE #Temp_BLC_25_Deposit
	DROP TABLE #TempCustBatch
END
GO
EXEC Acc_Dep_DynamicCustSetting_09