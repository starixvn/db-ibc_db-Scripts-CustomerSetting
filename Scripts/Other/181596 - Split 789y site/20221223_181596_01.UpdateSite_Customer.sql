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
	DECLARE @srecommend INT, @mrecommend INT, @recommend INT

	IF @roleid<>4
	BEGIN
		SELECT  @srecommend=srecommend,
				@mrecommend=mrecommend,
				@recommend=recommend
		FROM custInfo WITH (NOLOCK)
		WHERE custid=@CustID
	END

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
		SELECT @srecommend, 4 AS roleid		--Headline
	END
	ELSE IF @roleid=2
	BEGIN
		INSERT INTO #tblCust(custid, roleid)
		SELECT custid, roleid		--Downline
		FROM custinfo c WITH(NOLOCK)				
		WHERE c.recommend = @CustID
			AND c.enabled = 1
		UNION ALL
		SELECT @srecommend, 4 AS roleid		--Headline
		UNION ALL
		SELECT @mrecommend, 3 AS roleid
	END
	ELSE IF @roleid=1
	BEGIN
		INSERT INTO #tblCust(custid, roleid)
		SELECT @CustID, @roleid
		UNION ALL
		SELECT @srecommend, 4 AS roleid		--Headline
		UNION ALL
		SELECT @mrecommend, 3 AS roleid
		UNION ALL
		SELECT @recommend, 2 AS roleid
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
		INNER JOIN @tmpCust t ON t.custid=c.custid
		WHERE t.roleid=2

		UPDATE c
		SET site = @site
		FROM Customer c WITH(ROWLOCK)
		INNER JOIN @tmpCust t ON t.custid=c.custid

		DELETE @tmpCust
		
		WAITFOR DELAY '00:00:0.100'
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
		newSite			VARCHAR(50),
		isfinished		BIT DEFAULT(0))


DECLARE @HeadlineID INT, @site VARCHAR(50), @roleid TINYINT
/*
	- @site='yUT', @Headline_List='ZU01'
	- @site='y789', @Headline_List='ET789HL'
	- @site='y889', @Headline_List='BC1,SD67,DTF233,8U01,V3901,8K01,DTE113,DTE131,ET889HL,DTE249,XU1,9S'
	- @site='yOther'
*/

INSERT INTO #Cust_Headline (custid, roleid, headline, newSite)
SELECT  ca.custid, cu.roleid, ch.username headline,		CASE	WHEN ch.username='ZU01'				THEN 'yUT'              --Group 1
				WHEN ch.username='ET789HL'			THEN 'y789'             --Group 3
				WHEN ch.username IN ('BC1','SD67','DTF233','8U01','V3901','8K01','DTE113','DTE131','ET889HL','DTE249','XU1','9S')
                                                    THEN 'y889'             --Group 2
                                                    ELSE 'yOther'			--Group 4		END AS newSite FROM custAccount ca WITH (NOLOCK)						INNER JOIN customer  c WITH (NOLOCK) ON c.custid=ca.custid					INNER JOIN custinfo cu WITH (NOLOCK) ON cu.custid=ca.custid					LEFT JOIN CustGroupHeadline h WITH (NOLOCK) ON h.GroupID = ca.groupID					LEFT JOIN Customer ch WITH (NOLOCK) ON ch.custid = h.CustID				WHERE c.site='789y'						AND c.currency<>20					AND cu.enabled=1

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
		,@site=newSite
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