/*
    Created: Vicky
    Date: 20180704
    Task: Roll back for Manage Account Info permission
    DB: DBPOLICY/BODB02
*/ 

DECLARE @FuncNameD NVARCHAR(100)
DECLARE @FuncNameC NVARCHAR(100)
DECLARE @FuncNameP NVARCHAR(100)
DECLARE @System NVARCHAR(100)
DECLARE @FuncIdD INT
DECLARE @FuncIdC INT
DECLARE @parentID INT


SET @FuncNameD = N'[DepositSite]'
SET @FuncNameC = N'[CreditSite]'
SET @FuncNameP = N'[ViewInfo]'
SET @System = 'ACCOUNTING'

-----------------------------------------------------------------------------------------------

--select id
SELECT @FuncIdD = FuncID
FROM acc_functioninfo
WHERE FuncName = @FuncNameD

SELECT @FuncIdC = FuncID
FROM acc_functioninfo
WHERE FuncName = @FuncNameC

SELECT @parentID = FuncID
FROM acc_functioninfo
WHERE FuncName = @FuncNameP AND System = @System

SELECT @FuncIdC AS FuncIDCredit, @FuncIdD AS FuncIDDeposit, @parentID AS ParentID
-------------------

UPDATE acc_functioninfo
SET FuncDesc = 'View Account Info'
WHERE FuncID = @parentID


DELETE acc_memberpolicy_1
WHERE FuncID IN (@FuncIdC, @FuncIdD)


DELETE acc_grouppolicy_1
WHERE FuncID IN (@FuncIdC, @FuncIdD)


DELETE acc_functioninfo
WHERE FuncID IN (@FuncIdC, @FuncIdD)
