/*
    Created: Vicky
    Date: 20180704
    Task: initial setting for Manage Account Info permission
    DB: DBPOLICY/BODB02
*/ 

DECLARE @FuncIdDesposit INT
DECLARE @FuncIdCredit INT
DECLARE @p10 INT, @parentID INT
DECLARE @p11 NVARCHAR(200)

SET @parentID = (SELECT FuncID FROM acc_functioninfo WHERE FuncName ='[ViewInfo]' AND System = 'ACCOUNTING')
SET @FuncIdDesposit=0
SET @FuncIdCredit=0

--------------------------------------------------------------------

SET @p10=0
SET @p11=N''
---create new function: credit site and deposit site
EXEC Acc_Con_FuncInfoIns @FuncId=@FuncIdDesposit output,@FuncName=N'[DepositSite]',@FuncNote=N'',@FuncDesc=N'Deposit Site',@DisplayOrder=3,@ParentId=@parentID,@FileNames='',
        @System=N'ACCOUNTING',@Language='E',@ErrCode=@p10 output,@ErrMsg=@p11 output,@UserID=8
SELECT @FuncIdDesposit, @p10, @p11


SET @p10=0
SET @p11=N''

EXEC Acc_Con_FuncInfoIns @FuncId=@FuncIdCredit output,@FuncName=N'[CreditSite]',@FuncNote=N'',@FuncDesc=N'Credit Site',@DisplayOrder=3,@ParentId=@parentID,@FileNames='',
        @System=N'ACCOUNTING',@Language='E',@ErrCode=@p10 output,@ErrMsg=@p11 output,@UserID=8
SELECT @FuncIdCredit, @p10, @p11

       
---update View Account Info -> Manage Account Info      
UPDATE acc_functioninfo
SET FuncDesc = 'Manage Account Info'
WHERE FuncID = @parentID


---update policy for member.
UPDATE m
SET m.Policy = mParent.Policy
FROM acc_memberpolicy_1 m
    INNER JOIN acc_memberpolicy_1 mParent ON m.CustId = mParent.CustID
WHERE m.FuncID IN (@FuncIdDesposit, @FuncIdCredit) AND mParent.FuncID = @parentID



---update policy for group.
UPDATE g
SET g.Policy = gParent.Policy
FROM acc_grouppolicy_1 g
    INNER JOIN acc_grouppolicy_1 gParent ON g.groupid = gParent.groupid
WHERE g.FuncID IN (@FuncIdDesposit, @FuncIdCredit) AND gParent.FuncID = @parentID


