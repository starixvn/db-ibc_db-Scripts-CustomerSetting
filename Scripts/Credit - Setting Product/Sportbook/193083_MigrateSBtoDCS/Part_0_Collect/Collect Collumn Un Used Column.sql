EXEC sp_MSforeachdb' 
USE [?];
;WITH CTE AS (
	SELECT  ServerName		= @@SERVERNAME,
			DBName			= DB_NAME(),
			SPName			= OBJECT_NAME(id),
			DisableEsports			= MAX(CASE WHEN TEXT LIKE ''%DisableEsports%'' OR OBJECT_NAME(id) LIKE ''%DisableEsports%'' THEN 1 ELSE 0 END),
			AutoIBCPositionTaking_Fixed			= MAX(CASE WHEN TEXT LIKE ''%AutoIBCPositionTaking_Fixed%'' OR OBJECT_NAME(id) LIKE ''%AutoIBCPositionTaking_Fixed%'' THEN 1 ELSE 0 END),
			AutoIBCPositionTaking_Tote			= MAX(CASE WHEN TEXT LIKE ''%AutoIBCPositionTaking_Tote%'' OR OBJECT_NAME(id) LIKE ''%AutoIBCPositionTaking_Tote%'' THEN 1 ELSE 0 END)
	FROM syscomments (NOLOCK)
	WHERE (
			
			--column
			text like ''%DisableEsports%''
			OR text like ''%AutoIBCPositionTaking_Fixed%''
			OR text like ''%AutoIBCPositionTaking_Tote%''
			--SP
			OR OBJECT_NAME(id) like ''%DisableEsports%''
			OR OBJECT_NAME(id) like ''%AutoIBCPositionTaking_Fixed%''
			OR OBJECT_NAME(id) like ''%AutoIBCPositionTaking_Tote%''
			)
			AND OBJECT_NAME(id)  not like ''%_UAT%''
			AND OBJECT_NAME(id)  not like ''%_xpre%''
			AND OBJECT_NAME(id)  not like ''%_xtest%''
			AND OBJECT_NAME(id)  not like ''%_winfred%''
			AND OBJECT_NAME(id)  not like ''%Helen%''
			AND OBJECT_NAME(id)  not like ''%Eden%''
			AND OBJECT_NAME(id)  not like ''%Tina%''
			AND OBJECT_NAME(id)  not like ''%Elodie%''
			AND OBJECT_NAME(id)  not like ''%_cn88%''
			AND OBJECT_NAME(id)  not like ''%_tacy''
	GROUP BY  OBJECT_NAME(id)
)
SELECT *
FROM CTE
WHERE DisableEsports=1
OR AutoIBCPositionTaking_Fixed=1
OR AutoIBCPositionTaking_Tote=1
ORDER BY SPName
'
