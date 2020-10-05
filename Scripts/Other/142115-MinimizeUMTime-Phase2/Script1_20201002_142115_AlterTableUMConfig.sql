/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20201002
    Task: ALTER TABLE UMConfig [#142115]
    DB: DBCUST/CustDB
*/ 
USE CustDB
ALTER TABLE UMConfig ADD ShowTime smalldatetime NULL
ALTER TABLE UMConfig ADD LockAddingNew BIT NULL