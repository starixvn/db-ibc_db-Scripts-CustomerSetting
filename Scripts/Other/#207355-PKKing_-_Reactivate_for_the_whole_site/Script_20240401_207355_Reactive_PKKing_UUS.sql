/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
Created: 20240701@Eden
Task: Reactive manually for site = 'PKKing' - UUS
DB: DBCUST.CustDB
*/
USE CustDB
GO
DECLARE @count INT = 100 -- reactive for xx accs

CREATE TABLE #Dep_Customer_Archived (custid INT, ClosingBalance	money, CustIDBalanceDummy	int, isfinished bit default 0)
CREATE TABLE #ErrorTbl (ErrCode int, ErrMsg nvarchar(2000))

DECLARE @AgentTbl TABLE (recommend INT PRIMARY KEY)
INSERT INTO @AgentTbl(recommend)
SELECT custid
FROM VW_customer WITH(NOLOCK) 
WHERE roleid = 2 and site = 'PKKing'
and currency = 20 ---------------UUS

INSERT INTO #Dep_Customer_Archived(custid,ClosingBalance,CustIDBalanceDummy)
SELECT TOP (@count) ar.CustID,ar.ClosingBalance,ar.CustIDBalanceDummy
FROM Dep_Customer_Archived ar WITH(NOLOCK) 
	INNER JOIN @AgentTbl ag ON ar.Recommend = ag.Recommend
WHERE ar.status = 'completed'
AND ar.CustID NOT IN(
		46515391
		,46533713
		,46538852
		,46538885
		,46542088
		,46553864
		,46573019
	)

DECLARE @custid INT
	, @ClosingBalance	money
	, @CustIDBalanceDummy	int
	, @ErrCode int = 0    
	, @ErrMsg nvarchar(2000) = ''
	, @ReinitOldBalance BIT 

WHILE (1 = 1)
BEGIN
	SELECT @ErrCode = 0, @ErrMsg = ''

	UPDATE TOP(1) t
	SET isfinished = 1,
		@custid = t.custid,
		@ClosingBalance = t.ClosingBalance,
		@CustIDBalanceDummy = t.CustIDBalanceDummy,
		@ReinitOldBalance = CASE WHEN @ClosingBalance <> 0 THEN 1 ELSE 0 END
	FROM #Dep_Customer_Archived t
	WHERE isfinished = 0

	IF @@ROWCOUNT = 0
		BREAK

	--Reactive main server
	EXEC [Dot_Dep_Customer_Archive_ReactiveCustomer]
		 @CustID =  @custid
		,@ReinitOldBalance = @ReinitOldBalance
		,@CheckUniqueUsername2 = 1
		,@SubsidiaryID = 0
		,@ErrCode = @ErrCode OUTPUT
		,@ErrMsg = @ErrMsg OUTPUT
		,@CustIDBalanceDummy = @CustIDBalanceDummy
		,@ClosingBalance = @ClosingBalance

	IF @ErrCode <> 0
	BEGIN
		INSERT INTO #ErrorTbl(ErrCode,ErrMsg)
		SELECT @ErrCode, @ErrMsg
	END
	ELSE
	BEGIN
		--Reactive on sitedb02
		EXEC _tmpDBSite2.bodb02.dbo.[Dot_Dep_Customer_Archive_ReactiveCustomer_Trans]
			 @CustID = @custid
			,@CustIDBalanceDummy = @CustIDBalanceDummy
			,@ClosingBalance = @ClosingBalance
			,@ErrCode = @ErrCode OUTPUT
			,@ErrMsg = @ErrMsg OUTPUT

		IF @ErrCode <> 0
		BEGIN
			INSERT INTO #ErrorTbl(ErrCode,ErrMsg)
			SELECT @ErrCode, @ErrMsg
		END
	END
END
SELECT * FROM #ErrorTbl
SELECT * FROM #Dep_Customer_Archived

DROP TABLE #Dep_Customer_Archived
DROP TABLE #ErrorTbl