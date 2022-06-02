/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220419@Winfred
	Task: Delete existing Data - Athena000  [Redmine: #145337]   
	DB: DBCUST/CUSTDB

	Notes: 
	ProductID	SportType	BetType	ProductName
	49			231			5301	Virtual Sports 3
	62			167			7301	CG
	67			172			7701	AdvantPlay
	68			174			7801	AdvantPlay Mini
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09] 	
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
	WHERE dc.sporttype IN (231, 167, 172, 174) AND cs.site IN ('Athena000')
	
	DELETE dc
	FROM Dep_CustDiscountSetting_Member dc WITH(UPDLOCK,ROWLOCK)
		INNER JOIN CustInfo ci WITH (NOLOCK) ON dc.custid = ci.custid
		INNER JOIN dbo.Dep_CustSuper cs WITH(NOLOCK) ON cs.custid = ci.srecommend
	WHERE dc.sporttype IN (231, 167, 172, 174) AND cs.site IN ('Athena000')
	
END
GO
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
