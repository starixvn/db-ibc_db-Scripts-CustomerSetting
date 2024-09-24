/*
	Created: Tacy@20240417 
	Task: NAP - Permission controls on UUS currency [redmine: #202523]
		- Scan affected SPs
	DB: all servers/db
*/

EXEC sp_MSforeachdb'
USE [?];
SELECT  ServerName		= @@SERVERNAME,
		DBName			= DB_NAME(),
		SPName			= OBJECT_NAME(id)
FROM syscomments (NOLOCK)
WHERE (
		--Product
		text like ''%f_GetDeniedSiteByUser%'' 
		)
		AND OBJECT_NAME(id)  not like ''%_UAT%''
		AND OBJECT_NAME(id)  not like ''%_xpre%''
		AND OBJECT_NAME(id)  not like ''%_xtest%''
		AND OBJECT_NAME(id)  not like ''%_winfred%''
		AND OBJECT_NAME(id)  not like ''%Helen%''
		AND OBJECT_NAME(id)  not like ''%Eden%''
		AND OBJECT_NAME(id)  not like ''%Tina%''
		AND OBJECT_NAME(id)  not like ''%Elodie%''
		AND OBJECT_NAME(id)  not like ''%testing%''
		AND OBJECT_NAME(id)  not like ''%test%''
		AND OBJECT_NAME(id)  not like ''%_cn88%''
		AND OBJECT_NAME(id)  not like ''%_ORG''
		AND OBJECT_NAME(id)  not like ''%_old''
		AND OBJECT_NAME(id)  not like ''%_arround%''
		AND OBJECT_NAME(id)  not like ''%_production''
		AND OBJECT_NAME(id)  not like ''%_tacy''
		AND OBJECT_NAME(id)  not like ''%_luke''
'