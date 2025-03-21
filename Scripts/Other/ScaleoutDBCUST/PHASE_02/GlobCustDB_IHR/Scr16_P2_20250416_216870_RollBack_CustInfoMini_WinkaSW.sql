/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250319@Tacy	
	Task: Rollback data CustInfoMini - 'WinkaSW' [RedmineID: #216870]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DELETE TOP (93) ci
	OUTPUT deleted.CustID, dbo.f_GetDateTime2()
	INTO CustInfoMini_Del_Inhouse (CustID, RepUpdateTime)
FROM CustInfoMini ci WITH (ROWLOCK)
LEFT JOIN CustDB.dbo.Customer c WITH (NOLOCK) ON c.custid=ci.CustID
WHERE ci.Site='WinkaSW' AND c.custid IS NULL
GO

-- Rename and deactive Site
UPDATE Site WITH (ROWLOCK, UPDLOCK)
SET site='Del_WinkaSW'
	,isActive=0
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE Site='WinkaSW'
GO