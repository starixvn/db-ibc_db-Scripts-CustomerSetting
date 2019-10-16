 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for CustSettingGame
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #tmpCust (custid int, PT smallmoney default 0.85, isfinished bit default(0))
    
DECLARE @custid INT, @PT smallmoney

----CustomerList
INSERT INTO #tmpCust(custid)					
	  SELECT '5603319'				--BHK
UNION ALL SELECT '1146496'				--BNE


------------- PROCESS --------------------
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tmpCust
	SET isfinished = 1
		,@custid = custid	
		,@PT = PT			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @custid = @custid					
			,@PT = @PT
			,@target = 'REPLICATED'

	--WAITFOR DELAY '00:00:0.100'
END			

 DROP TABLE #tmpCust
GO		
-- END STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------
-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------

-- END STEP 2: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------
