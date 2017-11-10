/*
	Created: Johnson
	Date: 2017-11-06
	Task: Initial setting for licensees
	DB: DBCUST/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @max_custid INT
	, @target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at DBCUST only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0		 		 
		OR dbo.f_CheckRepTable('CustInfo') = 0
		)
	RETURN
	
	CREATE TABLE #tblCust(CustID INT PRIMARY KEY, roleid TINYINT)
	DECLARE @BatchCust TABLE (CustID INT)
	
	INSERT INTO #tblCust(Custid,roleid)
	SELECT custid, roleid
	FROM dbo.CustInfo WITH(NOLOCK)
	WHERE srecommend = @srecommend 
		AND mrecommend NOT IN (SELECT custid 
								FROM dbo.custinfo WITH(NOLOCK)
								WHERE srecommend=@srecommend 
									AND username like '%Acc%' 
									AND roleid=3
							)
		AND custid <= @max_custid
	
	--insert group comm setting
	INSERT INTO dbo.Dep_CustDiscountGroupSetting_Member 
		(AgentID
		,SportType
		,BetType
		,PlayerDiscount
		,AgentDiscount
		,MasterDiscount
		,SuperDiscount		
		)
	SELECT custid, 211, 2401, 0, 0, 0, 0
	FROM #tblCust 
	WHERE roleid = 2
	
	WHILE (1=1)
	BEGIN
		DELETE TOP (20000) t
		OUTPUT deleted.custid INTO @BatchCust
		FROM #tblCust t
		WHERE roleid = 1
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		UPDATE cs
		SET isGroupedComm = 1
		FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchCust)
		
		DELETE @BatchCust
	END
	
	DROP TABLE #tblCust
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT, 
		@max_custid INT

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx

INSERT INTO #Super(custid)
SELECT custid
FROM dbo.Dep_CustSuper WITH(NOLOCK)
WHERE site IN ('Athena000','12Bet','9bet','ABB688','Aoncash','Aragon88','BE7','Bolanation','Brown888','GooBet','Indowin','ISC888','ITCBet','Liga','Lucky88','M8bola','Macaubet','May88','NBCbet','Q8bola','sbcbet','UN168','Unobet','Uwoniwin','Webet138')

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend
			,@max_custid = @max_custid
			,@target = 'REPLICATED'
	
	waitfor delay '00:00:0.280'
END			
GO	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) -----
-----------------------------------------------------------------------------------	


---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
DECLARE @srecommend INT, 
		@max_custid INT

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx

INSERT INTO #Super(custid)
SELECT custid
FROM dbo.Dep_CustSuper WITH(NOLOCK)
WHERE site IN ('Athena000','12Bet','9bet','ABB688','Aoncash','Aragon88','BE7','Bolanation','Brown888','GooBet','Indowin','ISC888','ITCBet','Liga','Lucky88','M8bola','Macaubet','May88','NBCbet','Q8bola','sbcbet','UN168','Unobet','Uwoniwin','Webet138')

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend			
			,@max_custid = @max_custid
			,@target = 'DBCUST'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------