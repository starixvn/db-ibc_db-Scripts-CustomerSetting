/*<info serverAlias="DBCUST-CustDB" executers="" viewers="" isFunction="0"></info>*/
USE [CustDB]
GO

GRANT SELECT ON Site TO wsv_nap
GO
GRANT SELECT ON Site TO wsv_alp
GO
GRANT SELECT ON Site TO wsv_alpv
GO
GRANT SELECT ON Site TO wsv_xnap
GO
GRANT SELECT ON Site TO wsv_lap

GRANT SELECT ON SiteDBConfig TO wsv_nap
GO
GRANT SELECT ON SiteDBConfig TO wsv_alp
GO
GRANT SELECT ON SiteDBConfig TO wsv_alpv
GO
GRANT SELECT ON SiteDBConfig TO wsv_xnap
GO
GRANT SELECT ON SiteDBConfig TO wsv_lap

GRANT SELECT ON CustInfoMini TO wsv_nap
GO
GRANT SELECT ON CustInfoMini TO wsv_alp
GO
GRANT SELECT ON CustInfoMini TO wsv_alpv
GO
GRANT SELECT ON CustInfoMini TO wsv_xnap
GO
GRANT SELECT ON CustInfoMini TO wsv_lap