/*<info serverAlias="DBCust-CustDB"></info>*/

/*
	Created by: Tacy@20230922
	Task: Create Member Dummy ParlayBoostAdj for ATHENA000
	DB: DBCust/CustDB
	
	Revisions:
		- 20230922@Tacy: Integration - Parlay Boost Bonus [RedmineID: #194542]
*/  
USE CustDB
GO

CREATE TABLE #supers (srecommend	INT PRIMARY KEY,
					  mrecommend	INT,
					  recommend		INT,
					  creator		INT,		--agent's creator
					  ExchangeId	INT, 
					  currency		NVARCHAR(50), 
					  SiteName		NVARCHAR(50),
					  UplineClosed	BIT,
					  DisableOutright	BIT,
					  matchlimit		SMALLMONEY,
					  VirtualMultiplier SMALLMONEY
					  )

CREATE TABLE #supers_batch
					 (srecommend	INT PRIMARY KEY,
					  mrecommend	INT,
					  recommend		INT,
					  creator		INT,
					  ExchangeId	INT, 
					  currency		NVARCHAR(50), 
					  SiteName		NVARCHAR(50),
					  UplineClosed	BIT,
					  DisableOutright	BIT,
					  matchlimit		SMALLMONEY,
					  VirtualMultiplier SMALLMONEY
					  )

DECLARE @tbError TABLE (srecommend	INT PRIMARY KEY,
						ErrCode		INT,
						ErrMsg		NVARCHAR(4000)
						)

INSERT INTO #supers(srecommend,ExchangeId,currency,SiteName)
SELECT ci.custid, e.ExchangeId, e.currency, c.site 
FROM Customer c WITH(NOLOCK)
INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
INNER JOIN exchange e WITH (NOLOCK) ON e.ExchangeId=c.currency
WHERE ci.roleid = 4 	
AND ci.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)) 
AND ci.Enabled=1	
AND c.site NOT IN ('Saba789')
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
SET s.mrecommend=c.mrecommend, s.recommend=c.custid, s.creator=c.creator
FROM #supers s
CROSS APPLY (SELECT TOP 1 c.custid, c.mrecommend, c.creator
			 FROM Customer c WITH (NOLOCK)
			 WHERE roleid=2 AND c.srecommend=s.srecommend
			 AND (username LIKE '%Acc%01')
			 ORDER BY c.custid ASC) c

UPDATE s
SET s.UplineClosed=c.closed, 
	s.matchlimit=c.MatchLimit,
	s.DisableOutright=c.DisableOutright,
	s.VirtualMultiplier=c.VirtualMultiplier
FROM #supers s
INNER JOIN custInfo c WITH (NOLOCK) ON s.recommend=c.custid

--Create dummy account
DECLARE @custid		INT
	,	@srecommend INT
	,	@mrecommend INT
	,	@recommend	INT
	,	@currency	INT
	,	@pwdexpiry	DATETIME
	,	@Userpwd	VARCHAR(40)
	,	@UsernameParlayBoostAdj VARCHAR(30)
	,	@UplineClosed BIT
	,	@DisableOutright BIT
	,	@matchlimit SMALLMONEY
	,	@VirtualMultiplier SMALLMONEY
	,	@creator	INT
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
	OUTPUT deleted.srecommend,deleted.mrecommend,deleted.recommend,deleted.creator,deleted.ExchangeId,
			deleted.currency,deleted.SiteName,deleted.UplineClosed,deleted.DisableOutright,deleted.matchlimit,deleted.VirtualMultiplier
	INTO #supers_batch (srecommend,mrecommend,recommend,creator,ExchangeId,currency,SiteName,UplineClosed,DisableOutright,matchlimit,VirtualMultiplier)
	FROM #supers S

	WHILE EXISTS (SELECT TOP 1 1 FROM #supers_batch)
	BEGIN
		SELECT TOP 1 @srecommend=srecommend
			, @mrecommend=mrecommend
			, @recommend=recommend
			, @creator=creator
			, @currency=ExchangeId
			, @UsernameParlayBoostAdj= SiteName + currency + 'ParlayBoostAdj'
			, @UplineClosed=UplineClosed
			, @DisableOutright=DisableOutright
			, @matchlimit=matchlimit
			, @VirtualMultiplier=VirtualMultiplier
		FROM #supers_batch
	
		IF ISNULL(@srecommend,0)=0 BREAK

		SELECT @pwdexpiry = dateadd(dd, 30, getdate())

		--Insert general data 
		EXEC dbo.Acc_Dep_CustomerInsUserInfo
			@custid = @custid OUTPUT,
			@creator = @creator,
			@username = @UsernameParlayBoostAdj,
			@userpwd = @userpwd,
			@pwdexpiry = @pwdexpiry,
			@currency = @currency,
			@site = NULL,
			@srecommend = @srecommend,
			@mrecommend = @mrecommend,
			@recommend = @recommend,
			@roleid = 1,
			@TransferOption = NULL,
			@suspended = 0,
			@closed=@UplineClosed,
			@DisableOutright = @DisableOutright,		
			@matchlimit = @matchlimit,
			@virtualmultiplier = @VirtualMultiplier,
			@IsInternal = 0,	
			@credit = 0,
			@maxcredit = 0,
			@IP = DEFAULT,
			@TransferOption_dec = 0,
			@Language = DEFAULT,
			@ErrCode = @ErrCode OUTPUT,
			@ErrMsg = @ErrMsg OUTPUT

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