/*
	Created: 20190712@Johnson
	Task: change headline for supers set wrong headline
	DB: DBCUST/CustDB
*/

--Step 1: Deploy sp at DBCUST/CustDB
CREATE PROCEDURE DBA_CS_SuperUpdHeadlineInfo
	@SuperID INT,
	@HeadlineID INT
AS
/*
	Created: 20190712@Johnson
	Task :Change headline for super cn88
	DB: DBCUST/CustDB
	
	Revisions:
		- 20190712@Johnson: initial sp [redmine: #116748]

	Parameter's explantions:
*/	
BEGIN
	SET NOCOUNT ON
	
	DECLARE @GroupID INT
	
	SELECT @GroupID = GroupID
	FROM CustAccount WITH(NOLOCK)
	WHERE custid = @HeadlineID
	
	UPDATE CustAccount WITH(UPDLOCK,ROWLOCK)
	SET GroupID = @GroupID
	WHERE custid = @SuperID
	
	UPDATE CustSuper WITH(UPDLOCK,ROWLOCK)
	SET UplineID = @HeadlineID
	WHERE custid = @SuperID
	
END
GO


--STEP 2: run this script @DBCUST/CustDB to update super info

DECLARE @tblSuper TABLE (SuperID INT, HeadlineID INT, isFinished BIT DEFAULT (0))

INSERT INTO @tblSuper(SuperID, HeadlineID)
SELECT 37435509, 37431307 -- TP002
UNION SELECT 37435511, 37431308 --TP003
UNION SELECT 37435517, 37431309 --TP005
UNION SELECT 37435519, 37431310 --TP006
UNION SELECT 37435523, 37431311 --TP007
UNION SELECT 37435530, 37431312 --TP008
UNION SELECT 37435532, 37431313 --TP009
UNION SELECT 37435535, 37431314 --TP010
UNION SELECT 37435540, 37431315 --TP011

DECLARE @SuperID INT, @HeadlineID INT

WHILE (1=1)
BEGIN
	UPDATE TOP (1) t
	SET isFinished = 1,
		@SuperID = SuperID,
		@HeadlineID = HeadlineID
	FROM @tblSuper t	
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0 
		BREAK;
		
	EXEC DBA_CS_SuperUpdHeadlineInfo @SuperID = @SuperID, @HeadlineID = @HeadlineID
END
GO

--Step 3: delete super cn88 un-used
Declare @ErrCode int	
Declare @ErrMsg varchar(200)	

---------------------------------
--delete super TP004 has un-used
	
EXEC dbo.DBA_CustomerDel 	
@username = 'TP004',	
@ErrCode = @ErrCode OUTPUT,
@ErrMsg = @ErrMsg OUTPUT	
---------------------------------	
select 
@ErrCode as ErrCode,	
@ErrMsg as ErrMsg	



