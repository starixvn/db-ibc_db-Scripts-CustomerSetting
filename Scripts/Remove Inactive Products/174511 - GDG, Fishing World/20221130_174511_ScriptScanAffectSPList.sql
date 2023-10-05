;WITH CTE AS (
	SELECT  ServerName		= @@SERVERNAME,
			DBName			= DB_NAME(),
			SPName			= OBJECT_NAME(id),
			GDG				= MAX(case when text like '%GDG%'  then 1 else 0 end),
			FishingWorld	= MAX(case when text like '%FishingWorld%' Or text like '%FW%' then 1 else 0 end)
	FROM syscomments (NOLOCK)
	WHERE (
			--Product
			text like '%GDG%' 
			Or text like '%FishingWorld%' 
			Or text like '%FW%' 
			---
			--column
			OR text like '%DisableGDG%'
			OR text like '%SyncedGDG%'
			OR text like '%HideGDG%'
			OR text like '%DisableFishingWorld%'
			OR text like '%SyncedFishingWorld%'
			OR text like '%HideFishingWorld%'
			)
			AND OBJECT_NAME(id)  not like '%_UAT%'
			AND OBJECT_NAME(id)  not like '%_xpre%'
			AND OBJECT_NAME(id)  not like '%_xtest%'
			AND OBJECT_NAME(id)  not like '%_winfred%'
			AND OBJECT_NAME(id)  not like '%Elodie%'
			AND OBJECT_NAME(id)  not like '%Helen%'
			AND OBJECT_NAME(id)  not like '%Eden%'
			AND OBJECT_NAME(id)  not like '%testing%'
			AND OBJECT_NAME(id)  not like '%Johnson%'
			AND OBJECT_NAME(id)  not like '%test%'
			AND OBJECT_NAME(id)  not like '%_Daniel%'
			AND OBJECT_NAME(id)  not like '%_ORG%'
			AND OBJECT_NAME(id)  not like '%_old%'
			AND OBJECT_NAME(id)  not like '%_arround%'

	GROUP BY  OBJECT_NAME(id)
)
SELECT *
FROM CTE
WHERE GDG=1 OR FishingWorld=1
ORDER BY SPName
