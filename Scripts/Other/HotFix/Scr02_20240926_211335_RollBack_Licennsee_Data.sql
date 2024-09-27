/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created by: Tacy@20240926
	Task: rollback licensee data - 'veligames'  [Redmine:#211335] 
	DB:	DBCUST-bodb_Licensee
*/
/*
	Licensees
	LicenseeCust
	CurrencyUser
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
USE bodb_Licensee
GO

DECLARE @LicenseeID INT

SELECT @LicenseeID=LicenseeID
FROM dbo.Licensees with (nolock)
WHERE LicenseeName='veligames'

/*
SELECT * FROM CurrencyUser WITH (NOLOCK)
WHERE LicenseeID=@LicenseeID

SELECT * FROM LicenseeCust WITH (NOLOCK)
WHERE LicenseeID=@LicenseeID

SELECT * FROM Licensees WITH (NOLOCK)
WHERE LicenseeID=@LicenseeID
*/


DELETE FROM CurrencyUser WITH (ROWLOCK)
WHERE LicenseeID=@LicenseeID

DELETE FROM LicenseeCust WITH (ROWLOCK)
WHERE LicenseeID=@LicenseeID

DELETE FROM Licensees WITH (ROWLOCK)
WHERE LicenseeID=@LicenseeID
GO