/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created by: Luke
    Date: 2023/05/17
	Task:  Initial data for status lock Basketball [redmine : #185991]
	DB: DBCUST/CustDB

    Revisions: 

	Param's Explanation:  

*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]  

AS

BEGIN
	SET NOCOUNT ON

-----------------------------------Check Replicate---------------------------------
	IF NOT dbo.f_CheckRepTable('VRCustLockStatus') = 1 
		RETURN
-----------------------------------------------------------------------------------
	CREATE TABLE #tmpCust(
		CustID INT
	)

	CREATE TABLE #batchTmpCust(
		CustID INT
	)

	INSERT INTO #tmpCust(CustID)
	SELECT custid
	FROM dbo.VRCustLockStatus WITH (NOLOCK)
	WHERE Type = 2

	DECLARE @BatchSize INT = 5000

	WHILE (1=1)
	BEGIN
		DELETE TOP (@BatchSize)
		FROM #TmpCust OUTPUT DELETED.CustID INTO #batchTmpCust

		IF @@ROWCOUNT = 0
			BREAK

		INSERT INTO dbo.VRCustLockStatus(CustID, Type)
		SELECT CustID, 3
		FROM #batchTmpCust WITH (NOLOCK)
		
		TRUNCATE TABLE #batchTmpCust
	END
	DROP TABLE #tmpCust, #batchTmpCust
END	
GO

EXECUTE dbo.Acc_DynamicCustSetting3rd_09 --Run this script at DBCUST--
