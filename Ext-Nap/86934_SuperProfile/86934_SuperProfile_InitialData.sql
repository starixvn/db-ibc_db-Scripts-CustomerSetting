/*
	CreatedDate: 20180730@Elodie
	Task: Initial data to support super profile on Ext-NAP
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO

--105 affected rows
INSERT INTO CustSuperProfile (custid, firstname, lastname, phone, mobilephone, fax, email, remark)
SELECT c.custid, firstname, lastname, phone, mobilephone, fax, email, remark
FROM DBPOLICY.bodb02.dbo.Acc_CustGroup ac WITH (NOLOCK)
	INNER JOIN dbo.Customer c WITH (NOLOCK) ON c.custid = ac.CustID
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON c.custid = ci.CustID
WHERE ci.Enabled = 1



