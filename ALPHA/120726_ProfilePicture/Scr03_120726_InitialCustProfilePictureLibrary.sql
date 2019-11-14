/*
	Created: 20191008@Elodie
	Task: Initial data for profile picture
	DB: DBAGE/bodb_Age
*/

USE bodb_Age
GO

INSERT INTO Age_CustProfilePicture (custid,ImageId,modified)
SELECT custid, (custid%200 + 1) + CASE WHEN site = '789y' THEN 20000 ELSE 10000 END, NULL
FROM bodb02.dbo.customer c WITH (NOLOCK)
WHERE roleid BETWEEN 2 AND 4
	AND NOT EXISTS (SELECT 1 FROM bodb02.dbo.Age_CustProfilePicture WHERE custid = c.custid)

