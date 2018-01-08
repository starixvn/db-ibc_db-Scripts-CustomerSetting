/*
	Created: 20180108@Elodie
	Task: Turn off VS2 for 396Club Licensees
	Redmine: https://nexdev.net/issues/89150
	DB: DBCUST/CUSTDB
*/ 

DECLARE @ProductID			INT = 27,
		@CustID				INT,
		@IsDisabled			BIT = 1, 
		@IsDisabledDownLine	BIT = 1, 
		@SportType			INT = 190, 
		@BetType			INT = 2701, 
		@bitmapOrder		TINYINT = 5, 
		@UserID				INT = 22040268, -- starix59
		@IP					VARCHAR(40) = '', 
		@ErrCode			INT, 
		@ErrMsg				NVARCHAR(200) = ''	

DECLARE @super_cnt INT, @index INT 
DECLARE @msg NVARCHAR(200) 
DECLARE @msg_total NVARCHAR(200) 

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

SET @index = 0

SET @msg = 'Currently at order %d, SuperID: %d.'
SET @msg_total = 'Total of supers: %d.'

SELECT site
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 1
	AND s.site IN ('368Cash')

INSERT INTO #supers(custid)
SELECT CS.custid
FROM  dbo.Dep_CustSuper CS WITH(NOLOCK) 
	INNER JOIN #OfferedSites s ON cs.site = s.site

-- For deployer info
SET @super_cnt = (SELECT COUNT(*) FROM #supers WITH (NOLOCK))

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1,
		@CustID = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @CustID) WITH NOWAIT
	
	EXEC dbo.Acc_Dep_CustSetting_StatusUpd_Manual 
		@ProductID = @ProductID
		, @CustID = @CustID
		, @IsDisabled = @IsDisabled
		, @IsDisabledDownLine = @IsDisabledDownLine
		, @SportType = @SportType
		, @BetType = @BetType
		, @bitmapOrder = @bitmapOrder 
		, @UserID = @UserID
		, @IP = @IP
		, @ErrCode = @ErrCode
		, @ErrMsg = @ErrMsg
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers	
DROP TABLE #OfferedSites	
GO		

