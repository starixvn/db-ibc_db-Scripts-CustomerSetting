/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 3 - [Redmine: #145012]   
	DB: DBCUST/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_08] 	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0		
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0
		OR dbo.f_CheckRepTable('CustInfo') = 0
		OR dbo.f_CheckRepTable('Dep_CustSuper') = 0
		)
	RETURN
		
	DELETE dc
	FROM Dep_CustDiscountGroupSetting_Member dc WITH(UPDLOCK,ROWLOCK)
		INNER JOIN CustInfo ci WITH (NOLOCK) ON dc.agentID = ci.custid
		INNER JOIN dbo.Dep_CustSuper cs WITH(NOLOCK) ON cs.custid = ci.srecommend
	WHERE dc.sporttype IN (245,165,200,244,232, 211) AND cs.site NOT IN ('Athena000')
	
	DELETE dc
	FROM Dep_CustDiscountSetting_Member dc WITH(UPDLOCK,ROWLOCK)
		INNER JOIN CustInfo ci WITH (NOLOCK) ON dc.custid = ci.custid
		INNER JOIN dbo.Dep_CustSuper cs WITH(NOLOCK) ON cs.custid = ci.srecommend
	WHERE dc.sporttype IN (245,165,200,244,232, 211) AND cs.site NOT IN ('Athena000')
	
	
END

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST/CustDB
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_08

---
---
-- END STEP 2: RUN THIS SCRIPT AT DBCUST/CustDB
--------------------------------------------------------------------------------------
