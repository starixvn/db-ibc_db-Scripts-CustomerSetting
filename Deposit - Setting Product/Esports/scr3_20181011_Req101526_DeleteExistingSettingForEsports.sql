/*
	Created: Winnie
	Date: 20181011
	Task: Delete existing data of Deposit Esports
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN		

	DELETE cg
	FROM Dep_CustPTSetting_Agent cg 		
	WHERE SportType =43
						
	DELETE cg
	FROM Dep_CustPTSetting_Member cg
	WHERE SportType  =43  
		
	DELETE cg
	FROM Dep_CustPTGroupSetting_Member cg 
	WHERE SportType  =43  		
				
	DELETE cg
	FROM Dep_CustBetSetting_Agent cg
	WHERE SportType  =43  		

	DELETE cg
	FROM Dep_CustBetSetting_Member cg	
	WHERE SportType  =43  		

END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'
