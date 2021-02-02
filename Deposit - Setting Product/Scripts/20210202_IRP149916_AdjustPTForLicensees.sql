/*
	Created: 20210202@Johnson
	Task: adjust PT for licensees
	DB: DBCUST/CustDB
*/

CREATE TABLE #Supers (custid INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblCust (custid INT PRIMARY KEY, isFinished BIT DEFAULT 0)

INSERT INTO #Supers (custid)
SELECT custid 
FROM Dep_CustSuper WITH(NOLOCK)
WHERE site IN ('Lucky88','11bet','Fabet','One88','Five88','zbet','Sunwin','Debet','Red88','Zowin','SV88','Nbet','OXbet','Sky88','Lode88','Sin88')

DECLARE @srecommend INT,
		@ids VARCHAR(MAX),
		@Sporttype INT = 1,
		@ptVALUE MONEY = 0.88,
		@rowcnt INT

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Super: %d.'

SET @Super_cnt = (SELECT COUNT(*) FROM #Supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT


WHILE(1=1)
BEGIN
	UPDATE TOP (1) s	
	SET isFinished = 1,
		@srecommend = custid
	FROM #Supers s	
	WHERE isFinished = 0
	
	IF @@rowcount = 0
	BREAK;
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT
		
	DELETE #tblCust
	
	INSERT INTO #tblCust(custid)
	SELECT custid
	FROM custinfo WITH(NOLOCK)	
	WHERE srecommend = @srecommend 
			AND mrecommend NOT IN (SELECT custid FROM custinfo WITH(NOLOCK)
									WHERE srecommend = @srecommend AND username LIKE '%Acc%' AND roleid=3)
	
	WHILE (1=1)
	BEGIN
		SELECT @ids = ''

		UPDATE TOP (200) t
		SET @ids = @ids + CASE @ids WHEN '' THEN '' ELSE ',' END + CAST(custid AS VARCHAR(12))
			,isfinished = 1
		FROM #tblCust t
		WHERE isfinished = 0

		SELECT @rowcnt = @@rowcount	

		EXEC Acc_CustSetting3rd_12 @ids = @ids, @Sporttype = @Sporttype, @ptVALUE = @ptVALUE

		IF @rowcnt < 200 BREAK

		WAITFOR DELAY '00:00:00.28'
	END
END