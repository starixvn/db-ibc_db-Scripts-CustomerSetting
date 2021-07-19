/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	CreatedDate: 20200511@Elodie
	Task: Change username2 of some unused accounts
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE c  
SET c.username2 = REPLACE(c.username2, 'Delete_', '')
FROM dbo.Customer c WITH (ROWLOCK)
WHERE custid IN (28482835, 28833703, 15912315)

UPDATE c  
SET c.username2 = 'Delete_' + c.username2
FROM dbo.Customer c WITH (ROWLOCK)
WHERE custid IN (22407024, 21237549, 14690277, 4710633, 3778704)

SELECT c.username, c.custid, c.username2, *
FROM vw_Customer c WITH (NOLOCK) 
WHERE c.custid IN (28482835
,28482836
,28833703
,28833704
,22407024
,22407025
,15923608
,15912315
,21237548
,21237549
,14690277
,15585882
,4710633
,20406808
,3778704
,3927230)