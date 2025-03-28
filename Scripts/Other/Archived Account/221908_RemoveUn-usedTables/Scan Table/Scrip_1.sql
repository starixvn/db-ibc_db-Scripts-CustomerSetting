/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit [#221908] 
	DB: DBCust/CustDB
*/

EXEC sp_MSforeachdb '
USE [?];
;WITH CTE AS (
    SELECT  ServerName = @@SERVERNAME,
            DBName = DB_NAME(),
            SPName = OBJECT_NAME(id),
            CustBetSetting_Agent = MAX(CASE WHEN TEXT LIKE ''%CustBetSetting_Agent%'' OR OBJECT_NAME(id) LIKE ''%CustBetSetting_Agent%'' THEN 1 ELSE 0 END),
            CustBetSetting_Member = MAX(CASE WHEN TEXT LIKE ''%CustBetSetting_Member%'' OR OBJECT_NAME(id) LIKE ''%CustBetSetting_Member%'' THEN 1 ELSE 0 END),
            custOverride3rd = MAX(CASE WHEN TEXT LIKE ''%custOverride3rd%'' OR OBJECT_NAME(id) LIKE ''%custOverride3rd%'' THEN 1 ELSE 0 END),
            CustOverrideGame = MAX(CASE WHEN TEXT LIKE ''%CustOverrideGame%'' OR OBJECT_NAME(id) LIKE ''%CustOverrideGame%'' THEN 1 ELSE 0 END),
            CustSetting3rd = MAX(CASE WHEN TEXT LIKE ''%CustSetting3rd%'' OR OBJECT_NAME(id) LIKE ''%CustSetting3rd%'' THEN 1 ELSE 0 END),
            CustSettingGame = MAX(CASE WHEN TEXT LIKE ''%CustSettingGame%'' OR OBJECT_NAME(id) LIKE ''%CustSettingGame%'' THEN 1 ELSE 0 END)
    FROM syscomments (NOLOCK)
    WHERE (
            TEXT LIKE ''%CustBetSetting_Agent%'' OR TEXT LIKE ''%CustBetSetting_Member%'' OR TEXT LIKE ''%custOverride3rd%'' OR 
            TEXT LIKE ''%CustOverrideGame%'' OR TEXT LIKE ''%CustSetting3rd%'' OR TEXT LIKE ''%CustSettingGame%'' OR 
            OBJECT_NAME(id) LIKE ''%CustBetSetting_Agent%'' OR OBJECT_NAME(id) LIKE ''%CustBetSetting_Member%'' OR 
            OBJECT_NAME(id) LIKE ''%custOverride3rd%'' OR OBJECT_NAME(id) LIKE ''%CustOverrideGame%'' OR 
            OBJECT_NAME(id) LIKE ''%CustSetting3rd%'' OR OBJECT_NAME(id) LIKE ''%CustSettingGame%''
        )
        AND OBJECT_NAME(id) NOT LIKE ''%_UAT%'' 
        AND OBJECT_NAME(id) NOT LIKE ''%_xpre%'' 
        AND OBJECT_NAME(id) NOT LIKE ''%_xtest%'' 
        AND OBJECT_NAME(id) NOT LIKE ''%_cn88%''
    GROUP BY OBJECT_NAME(id)
)
SELECT *
FROM CTE
WHERE CustBetSetting_Agent=1 OR CustBetSetting_Member=1 OR custOverride3rd=1 OR CustOverrideGame=1 OR CustSetting3rd=1 OR CustSettingGame=1
ORDER BY SPName'; 