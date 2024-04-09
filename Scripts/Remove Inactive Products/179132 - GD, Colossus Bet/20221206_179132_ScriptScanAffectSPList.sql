EXEC sp_MSforeachdb'
USE [?];
;WITH CTE AS (
	SELECT  ServerName		= @@SERVERNAME,
			DBName			= DB_NAME(),
			SPName			= OBJECT_NAME(id),
			GD				= MAX(CASE WHEN TEXT LIKE ''%GD%'' OR OBJECT_NAME(id) LIKE ''%GoldDeluxe%'' THEN 1 ELSE 0 END),
			ColossusBet		= MAX(CASE WHEN TEXT LIKE ''%ColossusBet%'' OR OBJECT_NAME(id) LIKE ''%ColossusBet%'' THEN 1 ELSE 0 END)
	FROM syscomments (NOLOCK)
	WHERE (
			--Product
			text like ''%GoldDeluxe%'' 
			Or text like ''%Deluxe%'' 
			Or text like ''%ColossusBet%'' 
			---
			--column
			OR text like ''%DisableGD%''
			OR text like ''%SyncedGD%''
			OR text like ''%HideGD%''
			OR text like ''%DisableColossusBet%''
			OR text like ''%SyncedColossusBet%''
			OR text like ''%HideColossusBet%''
			---
			--SP
			OR OBJECT_NAME(id) like ''%GoldDeluxe%''
			OR OBJECT_NAME(id) like ''%ColossusBet%''
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
)
SELECT *
FROM CTE
WHERE GD=1 OR ColossusBet=1
ORDER BY SPName
'