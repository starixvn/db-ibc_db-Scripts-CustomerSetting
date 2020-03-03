/*
    Created: Eden
    Date: 20200303
    Task: DELETE VR setting for customers have custid < 100
	Redmine: #129279
    DB: DBCUST/CUSTDB
*/ 
USE CUSTDB
GO
SET NOCOUNT ON
DECLARE @SportType INT = 1

CREATE TABLE #VRUpdated ( CustID INT , IsProcessed BIT default 0)

INSERT INTO #VRUpdated(CustID)
SELECT DISTINCT vr.CustId
FROM VRSettingAutoUpdate vr WITH(NOLOCK)
	INNER JOIN custinfo c WITH(NOLOCK) On vr.CustId = c.custid
WHERE c.roleid IN (2,3,4)

DECLARE @CustID INT
	, @VirtualMultiplier VARCHAR(MAX) = '<Root></Root>'
	, @UserID INT = 8
	, @IP VARCHAR(15) = '0.0.0.0'
	, @ErrCode INT = 0
	, @ErrMsg NVARCHAR(200) = ''

WHILE 1 = 1
BEGIN
	UPDATE TOP (1) #VRUpdated 
	SET @CustID = custID,
		IsProcessed = 1
	WHERE IsProcessed = 0

	IF @@ROWCOUNT = 0
		BREAK;

	EXEC [Acc_CustVirtualMultiplier_Upd]
		  @CustID = @CustID
		, @SportType = @SportType
		, @VirtualMultiplier = @VirtualMultiplier
		, @UserID  = @UserID
		, @IP  = @IP
		, @ErrCode = @ErrCode OUT
		, @ErrMsg = @ErrMsg OUT

	IF @ErrCode <> 0
		--print error
		PRINT 'CustID = ' + CONVERT (VARCHAR(10),@CustID) + ' - ' + @ErrMsg 
	ELSE 
		PRINT 'CustID = ' + CONVERT (VARCHAR(10),@CustID) + ' - SUCCEED'
END
DROP TABLE #VRUpdated