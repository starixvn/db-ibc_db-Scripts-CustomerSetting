/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210602
	Task: Delete existing Data  - Athena000 [Redmine: #154048]   
	DB: DBCUST/CUSTDB

	Notes: 
	ProductID	SportType	BetType	ProductName
	51	233	3401	WM
	56	234	6401	Joker
	57	239	3501	BG
	63	169	3611	Sports Lottery
	59	236	5701	GDG
	61	238	7001	Habanero
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
	WHERE dc.sporttype IN (233,234,239,169,236,238) AND cs.site IN ('Athena000')
	
	DELETE dc
	FROM Dep_CustDiscountSetting_Member dc WITH(UPDLOCK,ROWLOCK)
		INNER JOIN CustInfo ci WITH (NOLOCK) ON dc.custid = ci.custid
		INNER JOIN dbo.Dep_CustSuper cs WITH(NOLOCK) ON cs.custid = ci.srecommend
	WHERE dc.sporttype IN (233,234,239,169,236,238) AND cs.site IN ('Athena000')
	
END
GO
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


