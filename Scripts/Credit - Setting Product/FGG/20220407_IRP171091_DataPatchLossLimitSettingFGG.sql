/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20220407
	Task:  data patch Max Loss Limit setting for FGG [RedmineID:#171091]
	DB: DBCust/CustDB
*/
--step 1: run at @DBCust/CustDB

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]	
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('LossLimit_GlobalSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN

	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY (custid))
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY (custid))
	
	--66809 rows affected
	INSERT INTO #tblCust(custid)
	SELECT cs.custid
	FROM CustWinLossLimit_Member cs WITH(NOLOCK) 	
		INNER JOIN CustWinLossLimit_Member cs1 WITH(NOLOCK) on cs.custid = cs1.custid	
	WHERE cs.sporttype = 243
		AND cs.MaxLossLimit = 0
		and cs1.sporttype = 176
		AND cs1.MaxLossLimit <> 0
		
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid
		INTO @tmpCust 
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0 
			BREAK;
			
		UPDATE cs
		SET cs.MaxLossLimit = 0
		FROM CustWinLossLimit_Member cs WITH(ROWLOCK) 
			INNER JOIN @tmpCust t ON cs.custid = t.custid 
									AND cs.sporttype = 176
		
		DELETE @tmpCust
	END
	
	--18740 rows affected
	INSERT INTO #tblCust(custid)
	SELECT cs.custid
	FROM  CustWinLossLimit_Agent cs WITH(NOLOCK) 	
		INNER JOIN CustWinLossLimit_agent cs1 WITH(NOLOCK) on cs.custid = cs1.custid	
	WHERE cs.sporttype = 243
		AND cs.MaxLossLimit = 0
		and cs1.sporttype = 176
		AND cs1.MaxLossLimit <> 0
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid
		INTO @tmpCust
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0 
			BREAK;
			
		UPDATE cs
		SET cs.MaxLossLimit = 0
		FROM CustWinLossLimit_Agent cs WITH(ROWLOCK) 
			INNER JOIN @tmpCust t ON cs.custid = t.custid 
									AND cs.sporttype = 176
		
		DELETE @tmpCust
	END
END
GO
------------------------------------------------

--step 2: run at DBCust/CustDB ONLY
EXEC Acc_DynamicCustSetting3rd_09
GO
