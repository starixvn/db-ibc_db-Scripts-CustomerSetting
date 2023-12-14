/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created by: Tacy@20231213
	Task: grant permission ON dbo.Products
		https://nexdev.net/issues/198317
	DB: DBTXN-bodb02
*/

USE bodb02
GO

GRANT SELECT ON dbo.Products TO bodbAdminNet
GO