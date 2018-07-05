/*
    Created: Vicky
    Date: 20180704
    Task: initial setting for Manage Account Info permission
    DB: DBPOLICY/BODB02
*/ 
DECLARE @FuncIdDeposit INT
DECLARE @FuncIdCreadit INT
DECLARE @ParentId INT,
        @CREATOR  INT
DECLARE @P11 NVARCHAR(200) 
DECLARE @DisplayOrder INT

SET @FuncIdDeposit=0
SET @FuncIdCreadit=0 


SELECT @parentid = funcid,
       @creator =  creator,
       @DisplayOrder = MAX(DisplayOrder) + 1
FROM   acc_functioninfo
WHERE  funcname ='[ViewInfo]' AND    SYSTEM = 'ACCOUNTING'
GROUP BY funcid,creator

--------------------------------------------------------------------

INSERT INTO ACC_FUNCTIONINFO
            (funcname,       funcnote,funcdesc,         funcrender, createdate, modifydate, displayorder,   creator,    parentid,   filenames,  system)
VALUES      ('[DepositSite]',N'',     N'Deposit Site',  3,          Getdate( ), Getdate( ), @DisplayOrder,  @creator,   @ParentId,  '',         N'ACCOUNTING')
SELECT @FuncIdDeposit = @@IDENTITY



INSERT INTO ACC_FUNCTIONINFO
            (funcname,      funcnote,   funcdesc,       funcrender, createdate, modifydate, displayorder,       creator,    parentid,   filenames,  system)
VALUES      ('[CreditSite]',N'',        N'Credit Site', 3,          Getdate( ), Getdate( ), @DisplayOrder + 1,  @creator,   @ParentId,  '',         N'ACCOUNTING')
SELECT @FuncIdCreadit = @@IDENTITY

SELECT @FuncIdDeposit AS FuncIdDeposit, @FuncIdCreadit AS FuncIdCredit, @ParentId AS ParentId


---create new function: credit site and deposit site
INSERT INTO ACC_GROUPPOLICY_1
            (funcid,            groupid,    policy, createdate, modifydate, creator)
SELECT       @FuncIdDeposit,    groupid,    policy, Getdate( ), Getdate( ), creator
FROM   ACC_GROUPPOLICY_1 WITH (nolock)
WHERE  funcid = @ParentId

INSERT INTO ACC_GROUPPOLICY_1
            (funcid,            groupid,    policy, createdate, modifydate,creator)
SELECT       @FuncIdCreadit,    groupid,    policy, Getdate( ), Getdate( ),creator
FROM   ACC_GROUPPOLICY_1 WITH (nolock)
WHERE  funcid = @ParentId


--add list custid is used on parentid
INSERT INTO ACC_MEMBERPOLICY_1
            (custid,    funcid,             policy,     createdate,     modifydate, creator)
SELECT       custid,    @FuncIdDeposit,     policy,     Getdate( ),     Getdate( ), Creator
FROM   ACC_MEMBERPOLICY_1 WITH (nolock)
WHERE  funcid = @ParentId 



INSERT INTO ACC_MEMBERPOLICY_1
            (custid,    funcid,         policy, createdate, modifydate, creator)
SELECT       custid,    @FuncIdCreadit, policy, Getdate( ), Getdate( ), Creator
FROM   ACC_MEMBERPOLICY_1 WITH (nolock)
WHERE  funcid = @ParentId 



---update View Account Info -> Manage Account Info      
UPDATE ACC_FUNCTIONINFO
SET    funcdesc = 'Manage Account Info'
WHERE  funcid = @parentID 


