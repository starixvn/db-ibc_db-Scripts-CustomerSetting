/*<info serverAlias="DBCUST-CustDB_History"></info>*/
/*
	Created: 20240820@Johnson
	Task: Add permission for web account [redmine:#207025]
	DB: DBCUST/CustDB_History
*/
CREATE USER svc_tig FOR LOGIN svc_tig WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO svc_tig
GO

--grant permission for web account
CREATE USER [wsv_lap] FOR LOGIN [wsv_lap] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO wsv_lap
GO

CREATE USER [ow_12bet] FOR LOGIN [ow_12bet] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO ow_12bet
GO

CREATE USER [ow_lic_12bet] FOR LOGIN [ow_lic_12bet] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO ow_lic_12bet
GO

CREATE USER [vnteam] FOR LOGIN [vnteam] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO vnteam
GO

CREATE USER [wsv_aff] FOR LOGIN [wsv_aff] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO wsv_aff
GO

CREATE USER [wsv_afinet] FOR LOGIN [wsv_afinet] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO wsv_afinet
GO

CREATE USER [wsv_alp] FOR LOGIN [wsv_alp] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO wsv_alp
GO

CREATE USER [wsv_xnap] FOR LOGIN [wsv_xnap] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO wsv_xnap
GO

CREATE USER [Dot_Evolution] FOR LOGIN [Dot_Evolution] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO Dot_Evolution
GO

CREATE USER [sqllink] FOR LOGIN [sqllink] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO sqllink
GO