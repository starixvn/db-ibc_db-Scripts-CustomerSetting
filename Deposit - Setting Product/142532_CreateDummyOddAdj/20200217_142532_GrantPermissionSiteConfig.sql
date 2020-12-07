/*
	Created by: winfred
	Date: 20201207
	Task: Grant permission
	DB: DBCUST/SiteConfig
*/
USE SiteConfig
GO

GRANT SELECT ON dbo.LicVendorProfile TO bodbAdminNet
GRANT SELECT ON dbo.LicVendorProfile TO Dot_Member
