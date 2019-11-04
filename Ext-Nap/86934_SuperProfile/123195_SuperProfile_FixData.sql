/*
	CreatedDate: 20191104@Elodie
	Task: Fix data of super profile on Ext-NAP
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO

--5 affected rows
UPDATE s 
SET s.firstname = '',
	s.mobilephone = '',
	s.email = ''
FROM dbo.CustSuperProfile s WITH (ROWLOCK)
WHERE custid IN (32467245,39358143,38174131,39583632,39583203)


