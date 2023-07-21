/*	
	Created: 20230620@Tacy
	Task: NG2 - Remove Setting
		https://nexdev.net/issues/189762
	DB: All DB Server
*/

EXEC sp_MSforeachdb'
USE [?];
SELECT  ServerName		= @@SERVERNAME,
		DBName			= DB_NAME(),
		SPName			= OBJECT_NAME(id)
FROM syscomments (NOLOCK)
WHERE (
		--Product
		text like ''%NG2%'' 
		--SP
		OR OBJECT_NAME(id) like ''%NG2%''
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
		AND OBJECT_NAME(id)  not like ''%_ORG%''
		AND OBJECT_NAME(id)  not like ''%_old%''
		AND OBJECT_NAME(id)  not like ''%_arround%''
		AND OBJECT_NAME(id)  not like ''%_MO%''
		AND OBJECT_NAME(id)  not like ''%_pro''
		AND OBJECT_NAME(id)  not like ''%_production''
		AND OBJECT_NAME(id)  not like ''%_tacy''
GROUP BY  OBJECT_NAME(id)
'
