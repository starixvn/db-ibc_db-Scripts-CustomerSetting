/*
	Created: 20181122@Elodie
	Task: Initial data for bodb_Age Migration
	DB: DBCUST/CustDB and all replicated servers (DB052/bodb02, DB053/bodb02, DB06/bodb02, DBTP/bodb02, .....)
*/
USE CustDB
GO
DECLARE @Threshold INT = 5000,@fromID INT , @toID INT, @maxID INT	
----------------------------------------------------------------------------------
CREATE TABLE #custSearch (userId INT, UserName VARCHAR(30), SearchCount INT, Firstname NVARCHAR(50), LastName NVARCHAR(50), Currency INT, GroupName VARCHAR(50), ID INT IDENTITY(1,1))
INSERT INTO #custSearch (userid, username, searchcount, firstname, lastname, Currency, GroupName)
SELECT userid, username, searchcount, firstname, lastname, Currency, GroupName
FROM DBAGE.bodb02.dbo.custSearch WITH (NOLOCK)

SELECT @maxID = max(ID) FROM #custSearch
SELECT @fromID = 1, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
WHILE(1=1)
BEGIN
	INSERT INTO custSearch (userid, username, searchcount, firstname, lastname, Currency, GroupName)
	SELECT userid, username, searchcount, firstname, lastname, Currency, GroupName
	FROM #custSearch
	WHERE ID BETWEEN @fromID AND @toID

	SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold

	IF @fromID > @maxID
		BREAK;			
			
	WAITFOR DELAY '00:00:00.200'
END