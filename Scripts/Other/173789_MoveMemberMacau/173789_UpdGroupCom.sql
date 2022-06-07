/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220607
	Task: Macaubet - Splitting group commission MACAU - Deposit RedmineID:#173789
	DB: DBCUST/bodb_Licensee

	Notes: Move 70k members from MACAU to MACAU2
*/
USE bodb_Licensee
GO
DECLARE @GroupCommID INT, @LicenseeID INT, @GroupCommID_New INT
	, @GroupBatch_size INT = 70000
	, @CustBatch_size INT = 2000

SELECT  @GroupCommID = 2132, @LicenseeID = 19 , @GroupCommID_New = 84

CREATE TABLE #custid_tmp (CustID INT, Isfinished BIT)
CREATE TABLE #custid_batch_tmp (CustID INT, Isfinished BIT)

DECLARE @Custid_cnt INT = 0
	,@ErrMsg NVARCHAR(4000) = ''

SET @Custid_cnt = (SELECT COUNT(1) FROM dbo.LicenseeCustComm WITH (NOLOCK) WHERE LicenseeID = @LicenseeID AND GroupCommID = @GroupCommID)
	
IF @custID_cnt <= 100000
BEGIN
	SELECT @ErrMsg = 'No valid group.'
	RETURN
END

WHILE (1=1)
BEGIN

	INSERT INTO #custid_tmp (CustID)
	SELECT TOP (@GroupBatch_size) custid
	FROM dbo.LicenseeCustComm (NOLOCK)
	WHERE GroupCommID = @GroupCommID
	
	IF @@ROWCOUNT < @GroupBatch_size BREAK

	WHILE (1=1)
	BEGIN
		UPDATE TOP (@CustBatch_size) t
		SET Isfinished = 1
		OUTPUT deleted.custid	INTO #custid_batch_tmp (CustID) 		
		FROM #custid_tmp t
		WHERE Isfinished IS NULL
		
		IF @@ROWCOUNT = 0 BREAK
			
		UPDATE lc
		SET GroupCommID = @GroupCommID_New
		FROM dbo.LicenseeCustComm lc WITH (ROWLOCK)
			INNER JOIN #custid_batch_tmp lc_tmp ON lc.CustID = lc_tmp.CustID
		WHERE lc.GroupCommID = @GroupCommID AND lc.Licenseeid = @LicenseeID
		
		DELETE #custid_batch_tmp
			
	END
	
	DELETE #custid_tmp

END

DROP TABLE #custid_batch_tmp
DROP TABLE #custid_tmp
