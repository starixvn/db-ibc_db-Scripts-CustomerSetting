/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 2 - [Redmine: #139238]   
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
	WHERE dc.sporttype IN (243,247,220,180,190,222) AND cs.site IN ('Athena000')
	
	DELETE dc
	FROM Dep_CustDiscountSetting_Member dc WITH(UPDLOCK,ROWLOCK)
		INNER JOIN CustInfo ci WITH (NOLOCK) ON dc.custid = ci.custid
		INNER JOIN dbo.Dep_CustSuper cs WITH(NOLOCK) ON cs.custid = ci.srecommend
	WHERE dc.sporttype IN (243,247,220,180,190,222)	AND cs.site IN ('Athena000')
	
	
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
