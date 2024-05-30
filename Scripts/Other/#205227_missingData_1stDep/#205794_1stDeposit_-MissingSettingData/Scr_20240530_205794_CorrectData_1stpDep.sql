/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240530@Eden
	Task: init missing data [Redmine: #205227]
		CustID IN (124779065,124779066,124662242,124662243)
	DB: DBCUST/CustDB 
*/ 
DECLARE @CustID INT 

DECLARE @recommend INT,    
		@mrecommend INT,    
		@srecommend INT,  
		@DCSErrCode INT

DECLARE @TempCustList TABLE (
	custid int
	,recommend INT   
	,mrecommend INT   
	,srecommend INT  
)
INSERT INTO @TempCustList(custid,recommend,mrecommend,srecommend)
SELECT	ci.custid	
	,ci.srecommend,    
	ci.mrecommend,     
	ci.recommend   
FROM custinfo ci WITH(NOLOCK)     
WHERE ci.CustID IN (124779065,124779066,124662242,124662243)

WHILE 1 = 1
BEGIN
	SELECT TOP 1 @srecommend = ci.srecommend,    
			@mrecommend = ci.mrecommend,     
			@recommend = ci.recommend,
			@CustID = ci.custid
	FROM @TempCustList ci    

	IF @@ROWCOUNT = 0
		BREAK

	EXEC dbo.Acc_Dep_DynamicCustSetting_00
				  @CustID			= @CustID
				, @SuperID			= @srecommend
				, @MasterID			= @mrecommend
				, @AgentID			= @recommend
				, @RoleID			= 1
				, @ProductID		= NULL
				, @ErrCode			= @DCSErrCode OUTPUT

	SELECT @CustID AS CustID, @DCSErrCode AS DCSErrCode

	DELETE FROM @TempCustList WHERE custid = @CustID
END
GO