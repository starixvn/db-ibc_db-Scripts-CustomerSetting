/*
	Created: 20181122@Elodie
	Task: Initial data for bodb_Age Migration
	DB: DBCUST/CustDB
*/
USE CustDB
GO
DECLARE @Threshold INT = 5000,@fromID INT , @toID INT, @maxID INT	
----------------------------------------------------------------------------------
CREATE TABLE #Acc_CustGroup (CustId INT, RoleID TINYINT, GroupName VARCHAR(50), IsPayOut BIT, ID INT IDENTITY(1,1))
INSERT INTO #Acc_CustGroup (CustID, RoleID, GroupName, IsPayout)
SELECT CustID, RoleID, GroupName, IsPayout
FROM DBAGE.bodb_Age.dbo.Acc_CustGroup WITH (NOLOCK)

WHILE(1=1)
BEGIN
	DELETE TOP (@Threshold) FROM Acc_CustGroup WITH (ROWLOCK)

	IF @@ROWCOUNT < @Threshold
		BREAK;			
			
	WAITFOR DELAY '00:00:00.200'
END

SELECT @maxID = max(ID) FROM #Acc_CustGroup
SELECT @fromID = 1, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
WHILE(1=1)
BEGIN
	INSERT INTO Acc_CustGroup (CustID, RoleID, GroupName, IsPayout)
	SELECT CustID, RoleID, GroupName, IsPayout
	FROM #Acc_CustGroup
	WHERE ID BETWEEN @fromID AND @toID

	SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold

	IF @fromID > @maxID
		BREAK;			
			
	WAITFOR DELAY '00:00:00.200'
END

-----------------------------------------------------
CREATE TABLE #Age_CustDateLimit (CustId INT, MinDate SMALLDATETIME, LimitDays SMALLINT, ID INT IDENTITY(1,1))
INSERT INTO #Age_CustDateLimit (CustID, MinDate, LimitDays)
SELECT CustID, MinDate, LimitDays
FROM DBAGE.bodb_Age.dbo.Age_CustDateLimit WITH (NOLOCK)

WHILE(1=1)
BEGIN
	DELETE TOP (@Threshold) FROM Age_CustDateLimit WITH (ROWLOCK)

	IF @@ROWCOUNT < @Threshold
		BREAK;			
			
	WAITFOR DELAY '00:00:00.200'
END

SELECT @maxID = max(ID) FROM #Age_CustDateLimit
SELECT @fromID = 1, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
WHILE(1=1)
BEGIN
	INSERT INTO Age_CustDateLimit (CustID, MinDate, LimitDays)
	SELECT CustId, MinDate, LimitDays
	FROM #Age_CustDateLimit WITH (NOLOCK)
	WHERE ID BETWEEN @fromID AND @toID

	SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold

	IF @fromID > @maxID
		BREAK;			
			
	WAITFOR DELAY '00:00:00.200'
END

-----------------------------------------------------
CREATE TABLE #Age_CustProfilePicture (CustId INT, image VARBINARY(MAX), modified DATETIME, ID INT IDENTITY(1,1))
INSERT INTO #Age_CustProfilePicture (CustID, image, modified)
SELECT CustID, image, modified
FROM DBAGE.bodb_Age.dbo.Age_CustProfilePicture WITH (NOLOCK)

WHILE(1=1)
BEGIN
	DELETE TOP (@Threshold) FROM Age_CustProfilePicture WITH (ROWLOCK)

	IF @@ROWCOUNT < @Threshold
		BREAK;			
			
	WAITFOR DELAY '00:00:00.200'
END

SELECT @maxID = max(ID) FROM #Age_CustProfilePicture
SELECT @fromID = 1, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
WHILE(1=1)
BEGIN
	INSERT INTO Age_CustProfilePicture (CustID, image, modified)
	SELECT CustID, image, modified
	FROM #Age_CustProfilePicture WITH (NOLOCK)
	WHERE ID BETWEEN @fromID AND @toID

	SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold

	IF @fromID > @maxID
		BREAK;			
			
	WAITFOR DELAY '00:00:00.200'
END

-----------------------------------------------------
CREATE TABLE #Age_CustSeq (SeqName VARCHAR(3), Type TINYINT, ID INT IDENTITY(1,1))
INSERT INTO #Age_CustSeq (SeqName, Type)
SELECT SeqName, Type
FROM DBAGE.bodb_Age.dbo.Age_CustSeq WITH (NOLOCK)

WHILE(1=1)
BEGIN
	DELETE TOP (@Threshold) FROM Age_CustSeq WITH (ROWLOCK)

	IF @@ROWCOUNT < @Threshold
		BREAK;			
			
	WAITFOR DELAY '00:00:00.200'
END

SELECT @maxID = max(ID) FROM #Age_CustSeq
SELECT @fromID = 1, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
WHILE(1=1)
BEGIN
	INSERT INTO Age_CustSeq (SeqName, Type)
	SELECT SeqName, Type
	FROM #Age_CustSeq WITH (NOLOCK)
	WHERE ID BETWEEN @fromID AND @toID

	SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold

	IF @fromID > @maxID
		BREAK;			
			
	WAITFOR DELAY '00:00:00.200'
END





