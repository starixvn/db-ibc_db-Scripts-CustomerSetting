/*<info serverAlias="DBCUST-CustDB_History" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250204@Elodie
	Task: grant permission on CustDB_History for tw accounts
	DB: DBCUST-CustDB_History
	
	Example:			
*/
USE CustDB_History
GO
/* 
CREATE USER [Dot_Admin] FOR LOGIN [Dot_Admin] WITH DEFAULT_SCHEMA=[dbo]
GO
 
GRANT CONNECT,INSERT TO [Dot_Admin]
GO
*/
CREATE USER [svc_tig] FOR LOGIN [svc_tig] WITH DEFAULT_SCHEMA=[dbo]
GO
 
GRANT CONNECT,INSERT TO [svc_tig]
GO

CREATE USER [Dot_BetLab] FOR LOGIN [Dot_BetLab] WITH DEFAULT_SCHEMA=[dbo]
GO
 
GRANT CONNECT,INSERT TO [Dot_BetLab]
GO

CREATE USER [Dot_Casino] FOR LOGIN [Dot_Casino] WITH DEFAULT_SCHEMA=[dbo]
GO
 
GRANT CONNECT,INSERT TO [Dot_Casino]
GO

CREATE USER [Dot_Evolution] FOR LOGIN [Dot_Evolution] WITH DEFAULT_SCHEMA=[dbo]
GO
 
GRANT CONNECT,INSERT TO [Dot_Evolution]
GO

CREATE USER [Dot_Intg] FOR LOGIN [Dot_Intg] WITH DEFAULT_SCHEMA=[dbo]
GO
 
GRANT CONNECT,INSERT TO [Dot_Intg]
GO

