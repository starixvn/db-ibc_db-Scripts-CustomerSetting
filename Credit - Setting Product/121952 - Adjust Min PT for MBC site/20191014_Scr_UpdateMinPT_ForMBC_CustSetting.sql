 /*
	Created: Eden
	Date: 2019/10/14
	Task: Update MaxPT = NewPT for CustSetting (SportBook and SportBook2)
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */

-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
BEGIN

	EXEC dbo.[Acc_CustSetting_17] @target = 'REPLICATED'

	--WAITFOR DELAY '00:00:0.100'
END			
GO		
-- END STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST----
--------------------------------------------------------------------------------------
BEGIN

	EXEC dbo.[Acc_CustSetting_17] @target = 'DBCUST'

	--WAITFOR DELAY '00:00:0.100'
END			
GO	
-- END STEP 2: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------