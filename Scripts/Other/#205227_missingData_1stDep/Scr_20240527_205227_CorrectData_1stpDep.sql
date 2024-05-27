/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240527@Tacy
	Task: init missing data [Redmine: #205227]
		CustID IN (124052611,124052612)
	DB: DBCUST/CustDB 
*/ 
DECLARE @CustID INT 

DECLARE @recommend INT,    
		@mrecommend INT,    
		@srecommend INT,  
		@DCSErrCode INT

------
SET @CustID = 124052611

SELECT  @srecommend = ci.srecommend,    
		@mrecommend = ci.mrecommend,     
		@recommend = ci.recommend   
FROM custinfo ci WITH(NOLOCK)     
WHERE ci.CustID = @CustID  

EXEC dbo.Acc_Dep_DynamicCustSetting_00
			  @CustID			= @CustID
			, @SuperID			= @srecommend
			, @MasterID			= @mrecommend
			, @AgentID			= @recommend
			, @RoleID			= 1
			, @ProductID		= NULL
			, @ErrCode			= @DCSErrCode OUTPUT

SELECT @CustID AS CustID, @DCSErrCode AS DCSErrCode

------
SELECT @CustID = 124052612
	, @DCSErrCode = 0

SELECT  @srecommend = ci.srecommend,    
		@mrecommend = ci.mrecommend,     
		@recommend = ci.recommend   
FROM custinfo ci WITH(NOLOCK)     
WHERE ci.CustID = @CustID  

EXEC dbo.Acc_Dep_DynamicCustSetting_00
			  @CustID			= @CustID
			, @SuperID			= @srecommend
			, @MasterID			= @mrecommend
			, @AgentID			= @recommend
			, @RoleID			= 1
			, @ProductID		= NULL
			, @ErrCode			= @DCSErrCode OUTPUT

SELECT @CustID AS CustID, @DCSErrCode AS DCSErrCode
GO