/*
	Created by: Elodie
	Date: 20200216
	Task: Update suspend info
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @CustID INT, @roleid TINYINT, @Suspended BIT = 1

SELECT @CustID = custid, @roleid = ci.roleid
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.username IN ('D771201')

UPDATE	cs 
SET	SuspendInfo = (SELECT suspendinfo FROM dbo.f_GenerateSuspendInfo(@roleid,@Suspended,ISNULL(SuspendInfo,0)))	
FROM CustProductStatus cs WITH (ROWLOCK, UPDLOCK) 		
WHERE custid = @CustID
	
IF @RoleID BETWEEN 2 AND 4 
BEGIN
	EXEC Acc_DynamicCustomerInfo_04
		@CustID		= @CustID
		,@RoleID	= @RoleID
		,@Action	= 'SuspendInfo'
		,@Suspended	= @Suspended					
END