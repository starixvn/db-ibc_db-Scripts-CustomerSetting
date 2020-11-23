/*
	Created: Tina
	Date: 20201117
	Task: Delete redundant setting for Big Gaming Deposit [Redmine: 142458]
	DB: DBCUST/CustDB
*/

USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
(@maxcustID INT)
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

	DECLARE @SportType SMALLINT = 239
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		OR  (cs.site IN('spondemo','Athena000') AND ci.currency NOT IN (20,72)))
		AND ci.currency IN (13,-- CNY(RMB)
							66,-- CNY(YUN)
							15,-- IDR(IN)
							51,-- VND(INH) 
							7,-- VND(DON)
							2,-- MYR(RM)
							4,-- THB(TB)
							70,-- MMK(MMK)
							94,-- MMK(MK)   
							32,-- JPY(JPY)
							3,-- USD(US$)
							96,-- USD(USDT)
							6,-- EUR(EURO)
							12,-- GBP(GBP)
							61,-- INR(INR)
							55, -- RUB(RUB)
							20, --UUS(UUS)
							72 --YNG(YNG)
							)

	DELETE cg
	FROM Dep_CustPTSetting_Agent cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid	
	WHERE SportType =@SportType AND cg.custid > @maxcustID
						
	DELETE cg
	FROM Dep_CustPTSetting_Member cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid	
	WHERE SportType =@SportType AND cg.custid > @maxcustID
		
	DELETE cg
	FROM Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType =@SportType AND c.custid > @maxcustID
				
	DELETE cg
	FROM Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType =@SportType AND c.custid > @maxcustID

	DELETE cg
	FROM Dep_CustStakeLevel_Member cg WITH(ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType =@SportType AND c.custid > @maxcustID

END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
