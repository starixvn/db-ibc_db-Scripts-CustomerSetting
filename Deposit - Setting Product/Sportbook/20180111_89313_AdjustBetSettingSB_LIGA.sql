/*
	Created: 20180111@Elodie
	Task: Adjust bet setting Sportbook for LIGA Licensees
	Redmine: https://nexdev.net/issues/89313
	DB: DBCUST/CUSTDB
*/ 

DECLARE @CustID				INT,
		@SportType			INT, 
		@BetType			INT, 
		@MinBet				MONEY = 20,
		@MaxBet				MONEY = 100000,
		@MaxPerMatch		MONEY = 500000,
		@ExistedMember		BIT = 1,
		@UserID				INT = 22040268, -- starix59
		@IP					VARCHAR(40) = '', 
		@ErrCode			INT, 
		@ErrMsg				NVARCHAR(200) = ''	

DECLARE @super_cnt INT, @index INT 
DECLARE @msg NVARCHAR(200) 
DECLARE @msg_total NVARCHAR(200) 

CREATE TABLE #supers (custid INT, Sporttype INT, Bettype INT, isfinished BIT DEFAULT(0))

SET @index = 0

SET @msg = 'Currently at order %d, SuperID: %d.'
SET @msg_total = 'Total of supers: %d.'

SELECT site
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 1
	AND s.site IN ('LIGA')

INSERT INTO #supers(custid, Sporttype, Bettype)
SELECT CS.custid, Sporttype, Bettype
FROM  dbo.Dep_CustSuper cs WITH(NOLOCK) 
	INNER JOIN #OfferedSites s ON cs.site = s.site
	CROSS JOIN (				  SELECT 1		AS sporttype, 1		AS bettype						
						UNION ALL SELECT 2		AS sporttype, 1		AS bettype						
						UNION ALL SELECT 3		AS sporttype, 1		AS bettype						
						UNION ALL SELECT 5		AS sporttype, 1		AS bettype						
						UNION ALL SELECT 8		AS sporttype, 1		AS bettype						
						UNION ALL SELECT 10		AS sporttype, 1		AS bettype						
						UNION ALL SELECT 11		AS sporttype, 1		AS bettype						
						UNION ALL SELECT 99		AS sporttype, 1		AS bettype
						UNION ALL SELECT 99		AS sporttype, 9		AS bettype
						UNION ALL SELECT 154	AS sporttype, 20	AS bettype
						UNION ALL SELECT 44		AS sporttype, 3		AS bettype
						) sb
WHERE cs.currency = 15

-- For deployer info
SET @super_cnt = (SELECT COUNT(*) FROM #supers WITH (NOLOCK))

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1,
		@CustID = custid,		
		@Sporttype = Sporttype,
		@BetType = Bettype
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @CustID) WITH NOWAIT
	
	EXEC dbo.NAP_LM_LicenseeBetSettingUpd_Manual 
			@CustID = @CustID,
			@SportType = @SportType,
			@BetType = @BetType,
			@UserID = @UserID,
			@IP = @IP,
			@MinBet = @MinBet,			 
			@MaxBet = @MaxBet,			 
			@MaxPerMatch = @MaxPerMatch,	
			@ExistedMember = @ExistedMember,
			@ErrCode = @ErrCode,
			@ErrMsg = @ErrMsg
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers	
DROP TABLE #OfferedSites	
GO		

