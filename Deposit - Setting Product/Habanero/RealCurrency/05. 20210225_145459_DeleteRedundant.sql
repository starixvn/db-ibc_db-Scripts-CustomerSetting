/*
	Created: 20210224@Tina
	Task: Delete redundant setting for Habanero - Deposit - Real Currency
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/
USE [CustDB]
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

	DECLARE @SportType SMALLINT = 238
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		OR  (cs.site IN('spondemo','Athena000') AND ci.currency NOT IN (20, 72)))
		AND Ci.currency IN (13,	--CNY(RMB)
							66,	--CNY(YUN)
							6,	--EUR(EURO)
							12,	--GBP(GBP)
							92,	--HKD(HID)
							5,	--HKD(HK$)
							15,	--IDR(IN)
							61,	--INR(INR)
							32,	--JPY(JPY)
							45,	--KRW(Won)
							94,	--MMK(MK)
							70,	--MMK(MKK)
							2,	--MYR(RM)
							55,	--RUB(RUB)
							4,	--THB(TB)
							3,	--USD(US$)
							96,	--USD(USDT)
							7,	--VND(DON)
							51,	--VND(INH)
							20, --UUS
							72  --YNG
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
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
