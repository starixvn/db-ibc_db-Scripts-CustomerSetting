/*<info serverAlias="DBCUST-GlobCustDB"></info>*/
/*
	Created: Eden@20240628
	Task: View  [#204358]
		CREATE VIEW [CustInfoMini]
		CREATE VIEW [CustSubMini]
		CREATE VIEW [CustInfoMini_Del_Inhouse]
		CREATE VIEW [CustSubMini_Del_Inhouse]
	DB: DBCUST-CustDB
*/
USE GlobCustDB
GO
/*
DROP VIEW [CustInfoMini]
DROP VIEW [CustSubMini]
DROP VIEW [CustInfoMini_Del_Inhouse]
DROP VIEW [CustSubMini_Del_Inhouse]
*/

CREATE VIEW [dbo].CustInfoMini 
/*
    Created by: 20240628@Eden
    Task: 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240628@Eden: Newly Created Customer in GlobCustDB [redmine: #206823]
    
*/
AS
SELECT CustID
	,username
	,username2
	,recommend
	,mrecommend
	,srecommend
	,roleid
	,SiteDBGroupID
	,RepUpdateTime
FROM CustDB.dbo.CustInfoMini WITH (NOLOCK) 

GO

CREATE VIEW [dbo].CustSubMini 
/*
    Created by: 20240628@Eden
    Task: 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240628@Eden: Newly Created Customer in GlobCustDB [redmine: #206823]
    
*/
AS
SELECT subaccid
	,CustID
	,username
	,username2
	,SiteDBGroupID
	,RepUpdateTime
FROM CustDB.dbo.CustSubMini WITH (NOLOCK) 

GO

CREATE VIEW [dbo].CustInfoMini_Del_Inhouse 
/*
    Created by: 20240628@Eden
    Task: 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240628@Eden: Newly Created Customer in GlobCustDB [redmine: #206823]
    
*/
AS
SELECT CustID
	,RepUpdateTime
FROM CustDB.dbo.CustInfoMini_Del_Inhouse WITH (NOLOCK) 

GO


CREATE VIEW [dbo].CustSubMini_Del_Inhouse 
/*
    Created by: 20240628@Eden
    Task: 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240628@Eden: Newly Created Customer in GlobCustDB [redmine: #206823]
    
*/
AS
SELECT subaccid
	,RepUpdateTime
FROM CustDB.dbo.CustSubMini_Del_Inhouse WITH (NOLOCK) 

GO


GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.CustInfoMini TO wsv_alp;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.CustInfoMini TO wsv_nap;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.CustInfoMini TO wsv_xnap;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.CustInfoMini TO svc_tig;

GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustSubMini] TO wsv_alp;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustSubMini] TO wsv_nap;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustSubMini] TO wsv_xnap;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustSubMini] TO svc_tig;

GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustInfoMini_Del_Inhouse] TO wsv_alp;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustInfoMini_Del_Inhouse] TO wsv_nap;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustInfoMini_Del_Inhouse] TO wsv_xnap;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustInfoMini_Del_Inhouse] TO svc_tig;

GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustSubMini_Del_Inhouse] TO wsv_alp;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustSubMini_Del_Inhouse] TO wsv_nap;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustSubMini_Del_Inhouse] TO wsv_xnap;
GRANT UPDATE,INSERT,DELETE,ALTER ON dbo.[CustSubMini_Del_Inhouse] TO svc_tig;
GO