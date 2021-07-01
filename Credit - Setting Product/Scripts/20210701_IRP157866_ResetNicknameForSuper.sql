/*
	Created: 20210701@Johnson
	Task: reset nickname for super  KW19
	DB: DBCUST/CustDB
*/

UPDATE Customer WITH (ROWLOCK)
SET username2=NULL
WHERE custid=34176539


UPDATE CustSuper WITH (ROWLOCK)
SET NicknameLoginOnly=0
WHERE custid=34176539