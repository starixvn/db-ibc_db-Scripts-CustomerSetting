/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221223@Tacy
	Task: Update new sites (yUT, y789, y889, yOther) for customers
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@CustID INT,
	@roleid		TINYINT,
	@site		VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustAgent') = 0 RETURN	
		
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT, isfinished BIT DEFAULT(0))
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY, roleid TINYINT)

	IF @roleid=4
	BEGIN
		INSERT INTO #tblCust(custid, roleid)
		SELECT custid, roleid		--Downline
		FROM custinfo c WITH(NOLOCK)				
		WHERE c.srecommend = @CustID
			AND c.enabled = 1
	END
	ELSE IF @roleid=3
	BEGIN
		INSERT INTO #tblCust(custid, roleid)
		SELECT custid, roleid		--Downline
		FROM custinfo c WITH(NOLOCK)				
		WHERE c.mrecommend = @CustID
			AND c.enabled = 1
		UNION ALL
		SELECT custid, roleid		--Headline
		FROM custinfo c WITH(NOLOCK)				
		WHERE c.custid IN (SELECT srecommend FROM custInfo t WITH (NOLOCK)
							WHERE c.custid = @CustID)
			AND c.enabled = 1 
	END
	ELSE IF @roleid=2
	BEGIN
		INSERT INTO #tblCust(custid, roleid)
		SELECT custid, roleid		--Downline
		FROM custinfo c WITH(NOLOCK)				
		WHERE c.recommend = @CustID
			AND c.enabled = 1
		UNION ALL
		SELECT custid, roleid		--Headline
		FROM custinfo c WITH(NOLOCK)				
		WHERE c.custid IN (SELECT srecommend FROM custInfo t WITH (NOLOCK)
							WHERE c.custid = @CustID)
			OR c.custid IN (SELECT mrecommend FROM custInfo t WITH (NOLOCK)
							WHERE c.custid = @CustID)
			AND c.enabled = 1 
	END
	ELSE IF @roleid=1
	BEGIN
		INSERT INTO #tblCust(custid, roleid)
		SELECT @CustID, @roleid
	END 

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
IF	OBJECT_ID('tempdb..#Cust_Headline') IS NOT NULL
	DROP TABLE	#Cust_Headline;

CREATE TABLE #Cust_Headline (
		custid			INT, 
		roleid			TINYINT, 
		headline		VARCHAR(100),
		groupID			SMALLINT,
		IsGroupHeadLine BIT,
		isfinished		BIT DEFAULT(0))

DECLARE @Headlines TABLE (headline VARCHAR(100))

DECLARE @HeadlineID INT, @site VARCHAR(50), @roleid TINYINT, @Headline_List VARCHAR(500)

/*
	- @site='yUT', @Headline_List='ZU01'
	- @site='y789', @Headline_List='ET789HL'
	- @site='y889', @Headline_List='BC1,SD67,DTF233,8U01,V3901,8K01,DTE113,DTE131,ET889HL,DTE249,XU1,9S'
	- @site='yOther', @Headline_List=NULL
*/

SELECT @Headline_List = xxx
	, @site = xxx

IF @Headline_List IS NOT NULL
BEGIN
	INSERT INTO @Headlines (headline)
	SELECT VALUE
	FROM STRING_SPLIT(@Headline_List,',') 

	INSERT INTO #Cust_Headline (custid, roleid, headline, groupID, IsGroupHeadLine)
	SELECT  ca.custid, cu.roleid, ch.username headline, ca.groupID, ca.IsGroupHeadLine						FROM custAccount ca WITH (NOLOCK)							INNER JOIN customer  c WITH (NOLOCK) ON c.custid=ca.custid						INNER JOIN custinfo cu WITH (NOLOCK) ON cu.custid=ca.custid						LEFT JOIN CustGroupHeadline h WITH (NOLOCK) ON h.GroupID = ca.groupID						LEFT JOIN Customer ch WITH (NOLOCK) ON ch.custid = h.CustID					WHERE c.site='789y'							AND c.currency<>20						AND cu.enabled=1				
		AND ch.username IN (SELECT headline FROM @Headlines)
END
ELSE
BEGIN
	INSERT INTO @Headlines (headline)
	SELECT 'ZU01'		UNION
	SELECT 'ET789HL'	UNION
	SELECT 'BC1'		UNION
	SELECT 'SD67'		UNION
	SELECT 'DTF233'		UNION
	SELECT '8U01'		UNION
	SELECT 'V3901'		UNION
	SELECT '8K01'		UNION
	SELECT 'DTE113'		UNION
	SELECT 'DTE131'		UNION
	SELECT 'ET889HL'	UNION
	SELECT 'DTE249'		UNION
	SELECT 'XU1'		UNION
	SELECT '9S'		

	INSERT INTO #Cust_Headline (custid, roleid, headline, groupID, IsGroupHeadLine)
	SELECT  ca.custid, cu.roleid, ch.username headline, ca.groupID, ca.IsGroupHeadLine						FROM custAccount ca WITH (NOLOCK)							INNER JOIN customer  c WITH (NOLOCK) ON c.custid=ca.custid						INNER JOIN custinfo cu WITH (NOLOCK) ON cu.custid=ca.custid						LEFT JOIN CustGroupHeadline h WITH (NOLOCK) ON h.GroupID = ca.groupID						LEFT JOIN Customer ch WITH (NOLOCK) ON ch.custid = h.CustID					WHERE c.site='789y'							AND c.currency<>20						AND cu.enabled=1				
		AND ch.username NOT IN (SELECT headline FROM @Headlines)
END
-- For DEPLOYER info
DECLARE @headline_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, HeadlineID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Headlines: %d.'

SET @headline_cnt = (SELECT COUNT(*) FROM #Cust_Headline)
RAISERROR (@msg_total, 0, 1, @headline_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Cust_Headline
	SET isfinished = 1
		,@HeadlineID = custid
		,@roleid=roleid
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @HeadlineID) WITH NOWAIT

	EXEC dbo.Acc_CustomerInfo_Execrep_09
			 @CustID=@HeadlineID,
			 @roleid=@roleid,
			 @site=@site
			
	WAITFOR DELAY '00:00:0.100'
END

DROP TABLE #Cust_Headline
GO