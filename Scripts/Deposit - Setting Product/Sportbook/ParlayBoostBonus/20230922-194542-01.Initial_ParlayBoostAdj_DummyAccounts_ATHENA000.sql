/*<info serverAlias="DBCust-CustDB"></info>*/

/*
	Created by: Tacy@20230922
	Task: Create Member Dummy ParlayBoostAdj for ATHENA000
	DB: DBCust/CustDB
	
	Revisions:
		- 20230922@Tacy: Integration - Parlay Boost Bonus [RedmineID: #194542]
*/  
/*
	DBCUST to SITEDB01/02
	
	Linked server name:	_tmpDBSite1
						_tmpDBSite2
*/
USE CustDB
GO

CREATE TABLE #supers (srecommend	INT PRIMARY KEY,
					  mrecommend	INT,
					  recommend		INT,
					  currency		NVARCHAR(50), 
					  SiteName		NVARCHAR(50),
					  SiteDBGroupID	TINYINT
					  )

CREATE TABLE #supers_batch
					 (srecommend	INT PRIMARY KEY,
					  mrecommend	INT,
					  recommend		INT,
					  currency		NVARCHAR(50), 
					  SiteName		NVARCHAR(50),
					  SiteDBGroupID	TINYINT
					  )

DECLARE @tbError TABLE (srecommend	INT PRIMARY KEY,
						ErrCode		INT,
						ErrMsg		NVARCHAR(4000)
						)

INSERT INTO #supers(srecommend,currency,SiteName, SiteDBGroupID)
SELECT ci.custid, c.currency, c.site, s.SiteDBGroupID
FROM Customer c WITH(NOLOCK)
INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
INNER JOIN Site s WITH (NOLOCK) ON s.site=c.site
WHERE ci.roleid = 4 	
AND ci.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)) 
AND ci.Enabled=1 AND s.isActive=1
AND c.site NOT IN ('Saba789', 'SEAL888')
AND c.site IN ('ATHENA000')

--Delete: existed dummy account
DELETE s
FROM #supers s
CROSS APPLY (SELECT TOP 1 1 AS VAL FROM Customer c WITH (NOLOCK)
			 WHERE roleid=1 AND s.srecommend=c.srecommend
			 AND (username LIKE '%ParlayBoostAdj%'
				OR username2 LIKE '%ParlayBoostAdj%')) c

--Update info
UPDATE s
SET s.mrecommend=c.mrecommend, s.recommend=c.custid
FROM #supers s
CROSS APPLY (SELECT TOP 1 c.custid, c.mrecommend
			 FROM Customer c WITH (NOLOCK)
			 WHERE roleid=2 AND c.srecommend=s.srecommend
			 AND (username LIKE '%Acc%01')
			 ORDER BY c.custid ASC) c

--Create dummy account
DECLARE @CustIdParlayBoostAdj INT
	,	@UsernameParlayBoostAdj VARCHAR(30)
	,	@srecommend INT
	,	@recommend	INT
	,	@SiteDBGroupID	TINYINT
	,	@Userpwd	VARCHAR(40)
	,	@ErrCode	INT
	,	@ErrMsg		NVARCHAR(4000)
	,   @Batch		INT = 100
	
SELECT @srecommend = NULL
	,  @Userpwd = '8058095B7DDB08A608811097E5DB8D'

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
DECLARE @cnt INT

SELECT @cnt = COUNT(1)
FROM #supers

DECLARE @msg_total NVARCHAR(200) = 'Total of Supers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT
	
WHILE EXISTS (SELECT TOP 1 1 FROM #supers)
BEGIN	
	TRUNCATE TABLE #supers_batch

	DELETE TOP (@Batch) S
	OUTPUT deleted.srecommend,deleted.mrecommend,deleted.recommend,deleted.currency,deleted.SiteName, deleted.SiteDBGroupID
	INTO #supers_batch (srecommend,mrecommend,recommend,currency,SiteName,SiteDBGroupID)
	FROM #supers S

	WHILE EXISTS (SELECT TOP 1 1 FROM #supers_batch)
	BEGIN
		SELECT TOP 1 @srecommend=srecommend
			, @recommend=recommend
			, @UsernameParlayBoostAdj= SiteName + 'ParlayBoostAdj' + currency
			, @SiteDBGroupID=SiteDBGroupID
		FROM #supers_batch
	
		IF ISNULL(@srecommend,0)=0 BREAK

		EXEC Acc_Dep_CustomerInsMember_Ag 
		@custid			=	@CustIdParlayBoostAdj output,
		@creator		=	10278938, --starixIT
		@username		=	@UsernameParlayBoostAdj,
		@userpwd		=	@Userpwd,
		@recommend		=	@recommend,
		@IP				=	'10.3.11.200',
		@Language		=	DEFAULT,
		@SubAccID		=	DEFAULT,
		@ErrCode		=	@ErrCode output,
		@ErrMsg			=	@ErrMsg output

		IF @ErrCode = 0 AND @SiteDBGroupID=1
		BEGIN
			EXEC _tmpDBSite1.bodb02.dbo.Task_Cust_CheckBalance_Exception_Ins @custid = @CustIdParlayBoostAdj, @username = @UsernameParlayBoostAdj
		END
		ELSE IF @ErrCode = 0 AND @SiteDBGroupID=2
		BEGIN
			EXEC _tmpDBSite2.bodb02.dbo.Task_Cust_CheckBalance_Exception_Ins @custid = @CustIdParlayBoostAdj, @username = @UsernameParlayBoostAdj
		END

		IF @ErrCode<>0
		BEGIN
			INSERT INTO @tbError (srecommend, ErrCode, ErrMsg)
			SELECT @srecommend, @ErrCode, @ErrMsg
		END

		DELETE FROM #supers_batch WHERE srecommend=@srecommend

		SET @srecommend=NULL
	END
	
	WAITFOR DELAY '00:00:0.20'
END

IF EXISTS (SELECT TOP 1 1 FROM @tbError)
BEGIN
	SELECT * FROM @tbError
END

PRINT N'End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';