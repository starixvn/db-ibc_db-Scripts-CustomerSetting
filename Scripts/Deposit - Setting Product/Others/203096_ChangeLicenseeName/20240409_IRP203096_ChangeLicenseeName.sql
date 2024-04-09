/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240409@Johnson
	Task: Change Licensee Name [redmine: #203096]
	DB: DBCUST/CUSTDB
*/
DECLARE @srecommend INT 

SELECT @srecommend = custid
FROM customer WITH(NOLOCK)
WHERE username = 'PKKingSuperDIV'

UPDATE customer WITH(UPDLOCK,ROWLOCK)
SET username = REPLACE(username,'DIV','DIA'),
	username2 = REPLACE(username2,'DIV','DIA')
WHERE srecommend = @srecommend

UPDATE customer WITH(UPDLOCK,ROWLOCK)
SET username = REPLACE(username,'DIV','DIA'),
	username2 = REPLACE(username2,'DIV','DIA')
WHERE srecommend = @srecommend

UPDATE custinfo WITH(UPDLOCK,ROWLOCK)
SET username = REPLACE(username,'DIV','DIA')
WHERE srecommend = @srecommend

UPDATE Dep_CustSuper WITH(UPDLOCK,ROWLOCK)
SET username = REPLACE(username,'DIV','DIA')
WHERE custid = @srecommend

