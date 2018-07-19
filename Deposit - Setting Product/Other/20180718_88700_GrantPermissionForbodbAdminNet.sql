/*
	Created by: Winnie
	Created Date: 20180718
	Description: Licensee DCS setting - Support insert/edit setting for sub_licensee, https://nexdev.net/issues/88700
	Database: DBCUST/CustDB
		
*/

USE [SiteConfig]
GO

CREATE USER [bodbAdminNet] FOR LOGIN [bodbAdminNet] WITH DEFAULT_SCHEMA=[dbo]
GO

EXEC sp_addrolemember N'db_datareader', N'bodbAdminNet'
