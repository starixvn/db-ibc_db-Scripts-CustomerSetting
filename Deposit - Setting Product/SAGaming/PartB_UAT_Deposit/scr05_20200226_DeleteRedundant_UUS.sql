/*
	Created: 20200226@Tiara
	Date: 20200226
	Task: Delete redundant setting for SA Gaming Deposit - UUS [Redmine: 128058]
	DB: DBCUST/CustDB
*/

USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
(@MaxCustID INT)
AS
BEGIN			
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN

	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.CustID > @MaxCustID
		AND ci.Enabled=1				
		AND cs.site IN('spondemo','Athena000')
		AND ci.currency=20



	DELETE cg
	FROM Dep_CustPTSetting_Agent cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid	
	WHERE SportType =244 AND cg.custid > @maxcustID
						
	DELETE cg
	FROM Dep_CustPTSetting_Member cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid	
	WHERE SportType =244 AND cg.custid > @maxcustID
		
	DELETE cg
	FROM Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType =244 AND c.custid > @maxcustID
				
	DELETE cg
	FROM Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType =244 AND c.custid > @maxcustID

	DELETE cg
	FROM Dep_CustStakeLevel_Member cg WITH(ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType =244 AND c.custid > @maxcustID

END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_DynamicCustSetting3rd_09 @MaxCustID=@MaxCustID
