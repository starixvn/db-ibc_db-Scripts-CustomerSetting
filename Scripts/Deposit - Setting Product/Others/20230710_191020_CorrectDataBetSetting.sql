/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230710
	Task:  Delete existing data for Dep_CustBetSettingGame_Member  RedmineID:#191020
	DB: DBCUST/CustDB
	
	P/s : Step Licensee Bet Setting - Correct data in Dep_CustBetSettingGame_Member 
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN('iBET','Baji','IGPTech','AEUG','Athena000')

	CREATE TABLE #Dep_CustBetSettingGame_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	
	CREATE TABLE #Dep_CustBetSettingGame_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))

	INSERT INTO #Dep_CustBetSettingGame_Member(CustID,Sporttype,Bettype)
	SELECT S.CustID,s.SportType,s.BetType 
	FROM Dep_CustBetSettingGame_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		CROSS APPLY (select top 1 v.CustID from Dep_CustSettingMode v (nolock) where v.CustID = s.CustID AND IsGroupedBetLimit = 1 ) b
	WHERE c.srecommend IN(SELECT CustID FROM #supers) AND c.roleid = 1

	DECLARE @batch int = 5000
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustBetSettingGame_Member)
	BEGIN	
	
		DELETE TOP (@batch) #Dep_CustBetSettingGame_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustBetSettingGame_MemberTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSettingGame_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustBetSettingGame_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)
		
		TRUNCATE TABLE #Dep_CustBetSettingGame_MemberTemp
				
	END  
		
	DROP TABLE #Dep_CustBetSettingGame_Member
	DROP TABLE #Dep_CustBetSettingGame_MemberTemp
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'
