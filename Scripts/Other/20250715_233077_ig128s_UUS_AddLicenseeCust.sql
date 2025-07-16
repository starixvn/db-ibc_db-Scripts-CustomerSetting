/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: Tacy@20250715
	Task: Add Agent into LicenseeCust [redmine: #xxx]
	DB: DBCUST-bodb_Licensee
*/
USE bodb_Licensee
GO

DECLARE @LicenseeID INT
		
SELECT @LicenseeId = LicenseeID
FROM dbo.Licensees WITH (NOLOCK)
WHERE LicenseeName = 'ig128s'

-- INSERT LICENSEE CUST  
;WITH AgentList AS (
	SELECT a.CustID
		, a.RoleID
		, a.Currency
		, 'UUS' AS currencyName
	FROM CustDB.dbo.customer a WITH (NOLOCK)
	WHERE custid IN (151906754, 151906757, 151906759, 151906762, 151906765
					,151906767, 151906770, 151906772, 151906774, 151906776
					,151906778, 151906781, 151906783, 151906785, 151906787
					,151906790, 151906792, 151906794, 151906796, 151906798
					,151906801, 151906803, 151906805, 151906807, 151906809
					,151906811, 151906814, 151906816, 151906819, 151906821
					,151906824, 151906826, 151906828, 151906830, 151906832
					,151906834, 151906837, 151906839, 151906841, 151906844
					,151906846, 151906850, 151906852, 151906854, 151906857
					,151906861, 151906864, 151906866, 151906868, 151906870)
)
INSERT INTO LicenseeCust (
	LicenseeID
	, CustID
	, RoleID
	, Currency
	, CurrencyName
	, [Description]
)
SELECT @LicenseeId
	, a.CustID
	, a.RoleID
	, a.Currency
	, a.CurrencyName
	, '' [Description]
FROM AgentList a
WHERE NOT EXISTS (
		SELECT 1
		FROM dbo.LicenseeCust b WITH (NOLOCK)
		WHERE b.LicenseeID = @LicenseeId
			AND a.custid = b.custid
			AND a.roleid = b.roleid
			AND a.currency = b.currency
)
GO