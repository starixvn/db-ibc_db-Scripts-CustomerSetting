/*
	Created: Winnie
	Task: Delete redundant setting
	DB: DBCUST/CustDB
	Date: 20181002
*/ 
USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
(@MaxCustID INT)
AS
BEGIN			
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN

	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
				AND ci.username NOT LIKE '3rdSuper%'
				AND cs.isinternal = 0
				AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
				AND s.islicensee = 0
				AND ci.currency<>20

	DELETE cg
	FROM CustPTSetting3rd_Agent cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid	
	WHERE SportType =43 AND cg.custid > @maxcustID
						
	DELETE cg
	FROM CustPTSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid	
	WHERE SportType =43 AND cg.custid > @maxcustID
		
	DELETE cg
	FROM CustPTGroupSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType =43 AND c.custid > @maxcustID
				
	DELETE cg
	FROM CustBetSetting3rd_Agent cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType =43 AND c.custid > @maxcustID

	DELETE cg
	FROM CustBetSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType =43 AND c.custid > @maxcustID

END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_DynamicCustSetting3rd_09 @MaxCustID=@MaxCustID