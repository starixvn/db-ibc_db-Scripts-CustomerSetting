/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240516@Eden
	Task: init missing data for 12BETINH01S100145 [Redmine: #205227]
		CustID = 122228278
	DB: DBCUST/CustDB 
*/ 
DECLARE @CustID INT = 122228278
DECLARE @recommend INT,    
		@mrecommend INT,    
		@srecommend INT,  
		@DCSErrCode INT

SELECT  @srecommend = ci.srecommend,    
		@mrecommend = ci.mrecommend,     
		@recommend = ci.custID   
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

SELECT @DCSErrCode