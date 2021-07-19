/*
	Created: 20190606@Elodie
	DB: DBCUST/CustDB
	Task: Update nickname
*/
USE CustDB
GO

UPDATE c
SET username2 = 'CN88$han244811'
FROM Customer c WITH (ROWLOCK)
WHERE custid = 35970810

UPDATE c
SET username2 = 'CN88$han2448old'
FROM Customer c WITH (ROWLOCK)
WHERE custid = 35972831

UPDATE c
SET username2 = 'CN88$peggypeggyold'
FROM Customer c WITH (ROWLOCK)
WHERE custid = 36176114




