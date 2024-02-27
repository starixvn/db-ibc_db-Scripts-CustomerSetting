/*
	Created: Tacy@20240108 
	Task: Deposit - Merge VS1, VS2, VS3 into Virtual Sports [redmine: #198008]
		- Scan affected SPs
	DB: all servers/db
*/
EXEC sp_MSforeachdb'
USE [?];
SELECT  ServerName		= @@SERVERNAME,
		DBName			= DB_NAME(),
		SPName			= OBJECT_NAME(id),
		[Function]		= MAX(CASE WHEN TEXT LIKE ''%f_Dep_CustSetting_SportBetTypeSettingSelect%'' THEN 1 ELSE 0 END),
		[Table]			= MAX(CASE WHEN TEXT LIKE ''%Dep_ProductSettingDetail%'' THEN 1 ELSE 0 END)
FROM syscomments (NOLOCK)
WHERE (
		--Product
		text like ''%f_Dep_CustSetting_SportBetTypeSettingSelect%'' 
		Or text like ''%Dep_ProductSetting%'' 

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
		AND OBJECT_NAME(id)  not like ''%_production''
		AND OBJECT_NAME(id)  not like ''%_tacy''
		-------------------------------------------
		
GROUP BY OBJECT_NAME(id)
ORDER BY OBJECT_NAME(id)
'
