/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221223@Tacy
	Task: UUS Account - Update new sites (yUT, y789, y889, yOther) for customers
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@CustID INT,
	@site		VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustAgent') = 0 RETURN	
		
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT, isfinished BIT DEFAULT(0))
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY, roleid TINYINT)

	INSERT INTO #tblCust(custid, roleid)
	SELECT custid, roleid
	FROM custinfo c WITH(NOLOCK)				
	WHERE c.srecommend = @CustID
		AND c.enabled = 1
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid, deleted.roleid INTO @tmpCust(custid, roleid)
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE c
		SET site = @site
		FROM CustAgent c WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust WHERE roleid=2)

		UPDATE c
		SET site = @site
		FROM Customer c WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust)

		DELETE @tmpCust
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
IF	OBJECT_ID('tempdb..#Supers') IS NOT NULL
	DROP TABLE	#Supers;

CREATE TABLE #Supers (custid INT, newSite VARCHAR(50), isfinished BIT DEFAULT(0))

DECLARE @CustID INT, @site VARCHAR(50)

;WITH tmp AS (
	SELECT c.srecommend as custid, COUNT(ci.custid) cnt
	FROM Customer c WITH (NOLOCK)
	INNER JOIN custInfo ci WITH (NOLOCK) ON c.custid=ci.custid
	INNER JOIN CustSuper cs WITH (NOLOCK) ON cs.custid=c.srecommend
	WHERE ci.currency=20 AND ci.Enabled=1 AND C.site='789y'
	GROUP BY c.srecommend
)
INSERT INTO #Supers (custid)
SELECT TOP 20 custid
FROM tmp
ORDER BY cnt DESC

;WITH cte AS (
	SELECT custid, 
		ROW_NUMBER() OVER(ORDER BY custid) rn
	FROM #Supers 
)
UPDATE s
SET s.newSite = CASE WHEN rn BETWEEN 1 AND 5	THEN 'yUT'
					 WHEN rn BETWEEN 6 AND 10	THEN 'y789'
					 WHEN rn BETWEEN 11 AND 15	THEN 'y889'
												ELSE 'yOther' END
FROM #Supers s 
INNER JOIN cte c ON c.custid=s.custid

-- For DEPLOYER info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #Supers)
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@CustID = custid
		,@site=newSite
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @CustID) WITH NOWAIT

	EXEC dbo.Acc_CustomerInfo_Execrep_09
			 @CustID=@CustID,
			 @site=@site
			
	WAITFOR DELAY '00:00:0.100'
END

DROP TABLE #Supers
GO