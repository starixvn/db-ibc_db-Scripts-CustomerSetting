/*
	CreatedDate: 20181120@Elodie
	Task: Initial data for eaGroupConfiguration table
	DB: DBEAS/bodb_EAS
*/
USE bodb_EAS
GO

DELETE FROM eaGroupConfiguration
GO

--6464 affected rows
INSERT INTO CustSuperProfile (custid, firstname, lastname, phone, mobilephone, fax, email, remark)
SELECT DISTINCT c.custid, firstname, lastname, phone, mobilephone, fax, email, remark
FROM DBAGE.bodb_Age.dbo.Acc_CustGroup ac WITH (NOLOCK)
	INNER JOIN dbo.Customer c WITH (NOLOCK) ON c.custid = ac.CustID
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON c.custid = ci.CustID
WHERE ci.Enabled = 1



