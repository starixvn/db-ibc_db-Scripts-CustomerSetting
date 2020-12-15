/*
	Created: 20201215@Johnson
	Task: update PT SB = 0.9065 for HOT99  
	DB: DBCUST/CustDB
*/
--update SB

--HOT99SuperUUS
DECLARE @p1 INT
SET @p1 = 0
DECLARE @p2 NVARCHAR(4000)
SET @p2 = N''

EXEC NAP_LM_LicenseePositionTakingUpd @ErrCode = @p1 OUTPUT
	,@ErrMsg = @p2 OUTPUT
	,@CustID = 46203580--HOT99SuperUUS
	,@Sporttype = 1
	,@ptVALUE = 0.898
	
SELECT @p1
	,@p2
	
GO	

--HOT99SuperRMB
DECLARE @p1 INT
SET @p1 = 0
DECLARE @p2 NVARCHAR(4000)
SET @p2 = N''

EXEC NAP_LM_LicenseePositionTakingUpd @ErrCode = @p1 OUTPUT
	,@ErrMsg = @p2 OUTPUT
	,@CustID = 46203543--HOT99SuperRMB
	,@Sporttype = 1
	,@ptVALUE = 0.898
	
SELECT @p1
	,@p2
GO	

--update SB2
DECLARE @tmpAgent TABLE (custid INT, superID INT, ErrCode INT, ErrMsg NVARCHAR(200), isFinished BIT DEFAULT 0)

INSERT INTO @tmpAgent(custid,superID)
SELECT custid,srecommend
FROM custinfo (NOLOCK) 
WHERE srecommend IN (
	SELECT custid 
	FROM Dep_CustSuper WITH(NOLOCK) 
	WHERE site in ('HOT99')  		
	) 
AND roleid = 2
AND username NOT LIKE '%acc%'

DECLARE @custid INT,
	@superID INT

DECLARE @p8 INT
SET @p8 = 0

DECLARE @p9 NVARCHAR(200)
SET @p9 = ''

WHILE(1=1)
BEGIN
	UPDATE TOP(1) t
	SET @custid = custid,
		@superID = superID,
		isFinished = 1
	FROM @tmpAgent t 
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0 
		BREAK;
		
	EXEC Acc_Dep_CustSetting_PositionTakingSettingUpd 
		@SuperID = @superID
		,@AgentID = @custid
		,@IsAgentOnly = 0
		,@PT = '<ROOT><PT SportType = "43" BetType = "1" PT = "89.8" IsLive = "0" /></ROOT>'
		,@ProductID = 16
		,@UserID = 10278938--starixIT 
		,@IP = '10.3.11.200'
		,@ErrCode = @p8 OUTPUT
		,@ErrMsg = @p9 OUTPUT
	
	IF @p8 > 0
	BEGIN
		UPDATE @tmpAgent 
		SET ErrCode = @p8,
			ErrMsg = @P9
		WHERE custid = @custid	
	END 
	
	WAITFOR DELAY '0:0:0.5'
END		

SELECT * FROM @tmpAgent WHERE ErrCode > 0