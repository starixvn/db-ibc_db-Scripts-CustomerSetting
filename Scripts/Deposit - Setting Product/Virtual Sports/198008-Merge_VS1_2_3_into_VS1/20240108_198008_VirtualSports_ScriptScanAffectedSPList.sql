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
		SPName			= OBJECT_NAME(id)
FROM syscomments (NOLOCK)
WHERE (
		--Product
		text like ''%VS1%'' 
		Or text like ''%VS2%'' 
		Or text like ''%VS3%'' 

		--VS
		Or text like ''%SportType%=%18[0-6]%'' 
		Or text like ''%BetType%=%1201%'' 
		Or text like ''%typeid%=%1201%'' 

		--VS2
		Or text like ''%SportType%=%19[0-7]%'' 
		Or text like ''%BetType%=%2701%'' 
		Or text like ''%typeid%=%2701%'' 

		--VS3
		Or text like ''%SportType%=%17[8-9]%'' 
		Or text like ''%BetType%=%5302%'' 
		Or text like ''%typeid%=%5302%'' 

		---
		OR text like ''%Virtual%Sport%''
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
		AND (OBJECT_NAME(id)   like ''%dep%''
			OR OBJECT_NAME(id)   like ''%lrf%''
			OR OBJECT_NAME(id)   like ''%Nap_LM%''
			OR OBJECT_NAME(id)   like ''%NAP_Special%''
			OR OBJECT_NAME(id)   like ''%Licensee%''
			OR OBJECT_NAME(id)   like ''%Log%''
			)
GROUP BY OBJECT_NAME(id)
ORDER BY OBJECT_NAME(id)
'
