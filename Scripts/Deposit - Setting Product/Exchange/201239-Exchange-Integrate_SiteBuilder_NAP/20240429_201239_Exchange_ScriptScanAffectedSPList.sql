/*
	Created: Tacy@20240429 
	Task: Sitebuilder/NAP - Integrate Exchange [RedmineID: #201239]
		- Scan affected SPs that call [f_Dep_CustSetting_SportBetTypeSettingSelect]
	DB: all servers/db
*/

EXEC sp_MSforeachdb'
USE [?];
SELECT DISTINCT
		ServerName		= @@SERVERNAME,
		DBName			= DB_NAME(),
		SPName			= OBJECT_NAME(id)
FROM syscomments (NOLOCK)
WHERE (
		--Product
		text like ''%f_Dep_CustSetting_SportBetTypeSettingSelect%'' 
		)
		AND OBJECT_NAME(id)  not like ''%_UAT%''
		AND OBJECT_NAME(id)  not like ''%_xpre%''
		AND OBJECT_NAME(id)  not like ''%_xtest%''
		AND OBJECT_NAME(id)  not like ''%_winfred%''
		AND OBJECT_NAME(id)  not like ''%_win%''
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
