/*
	Created: Johnson
	Date: 2020-04-11
	Task: Delete existing Allbet comm setting
	DB: DBCUST/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09] 	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0		
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0
		)
	RETURN
		
	DELETE Dep_CustDiscountGroupSetting_Member WITH(UPDLOCK,ROWLOCK)

	DELETE Dep_CustDiscountSetting_Member WITH(UPDLOCK,ROWLOCK)
END

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST/CustDB
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09

---
---
-- END STEP 2: RUN THIS SCRIPT AT DBCUST/CustDB
--------------------------------------------------------------------------------------
