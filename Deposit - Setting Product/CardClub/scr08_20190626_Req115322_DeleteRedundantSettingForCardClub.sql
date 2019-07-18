/*
	Created: Winnie
	Task: Delete redundant setting CardClub
	DB: DBCUST/CustDB
	Date: 20190626
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
		AND ci.CustID <= @MaxCustID
		AND ci.Enabled=1				
		AND cs.site IN('11bet','12Bet','368Cash','3star88','88Macao','9bet','9Club','9wickets','Ae88','AG','Aoncash','asiabet88','Athena000','Axiawin','BE7','Bolanation','Boma365','Brown888','Debet','DEWA','Fabet',
			'FB88','GamingSoft','Happy1668','Heaven','Hengcai88','HONBET','Hong88','HonorW','iBET','IONclub','ISC888','ITCbet','Kraton','Kudatogel','Liga','Lucky88','Luckywin88','M8bola','Macaubet',
			'Mayfair','NBCbet','Newhonbet','OLE777','One88','Q8bola','Salon365',
			'Senibet','Sin88','Taipanbet','TLC','UN168','Unobet','Uwoniwin','Vwin','WeBet168','webet88','Winn69','XTD3','Zbet','Zzun88')

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.CustID <= @MaxCustID
		AND ci.Enabled=1				
		AND cs.site IN('spondemo')
		AND ci.currency<>20

	DELETE cg
	FROM Dep_CustPTSetting_Agent cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid	
	WHERE SportType =165 AND cg.custid > @maxcustID
						
	DELETE cg
	FROM Dep_CustPTSetting_Member cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid	
	WHERE SportType =165 AND cg.custid > @maxcustID
		
	DELETE cg
	FROM Dep_CustPTGroupSetting_Member cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType =165 AND c.custid > @maxcustID
				
	DELETE cg
	FROM Dep_CustStakeLevel_Agent cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType =165 AND c.custid > @maxcustID

	DELETE cg
	FROM Dep_CustStakeLevel_Member cg WITH(UPDLOCK,ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType =165 AND c.custid > @maxcustID

END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_DynamicCustSetting3rd_09 @MaxCustID=@MaxCustID