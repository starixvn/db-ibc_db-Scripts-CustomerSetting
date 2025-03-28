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
            CustBetSetting3rd_Agent = MAX(CASE WHEN TEXT LIKE ''%CustBetSetting3rd_Agent%'' OR OBJECT_NAME(id) LIKE ''%CustBetSetting3rd_Agent%'' THEN 1 ELSE 0 END),
            CustBetSetting3rd_Member = MAX(CASE WHEN TEXT LIKE ''%CustBetSetting3rd_Member%'' OR OBJECT_NAME(id) LIKE ''%CustBetSetting3rd_Member%'' THEN 1 ELSE 0 END),
            AgentCommRate = MAX(CASE WHEN TEXT LIKE ''%AgentCommRate%'' OR OBJECT_NAME(id) LIKE ''%AgentCommRate%'' THEN 1 ELSE 0 END),
            custOverride = MAX(CASE WHEN TEXT LIKE ''%custOverride%'' OR OBJECT_NAME(id) LIKE ''%custOverride%'' THEN 1 ELSE 0 END),
            CustSetting = MAX(CASE WHEN TEXT LIKE ''%CustSetting%'' OR OBJECT_NAME(id) LIKE ''%CustSetting%'' THEN 1 ELSE 0 END),
            CustCommRate = MAX(CASE WHEN TEXT LIKE ''%CustCommRate%'' OR OBJECT_NAME(id) LIKE ''%CustCommRate%'' THEN 1 ELSE 0 END)
    FROM syscomments (NOLOCK)
    WHERE (
            TEXT LIKE ''%CustBetSetting3rd_Agent%'' OR TEXT LIKE ''%CustBetSetting3rd_Member%'' OR TEXT LIKE ''%AgentCommRate%'' OR 
            TEXT LIKE ''%custOverride%'' OR TEXT LIKE ''%CustSetting%'' OR TEXT LIKE ''%CustCommRate%'' OR 
            OBJECT_NAME(id) LIKE ''%CustBetSetting3rd_Agent%'' OR OBJECT_NAME(id) LIKE ''%CustBetSetting3rd_Member%'' OR 
            OBJECT_NAME(id) LIKE ''%AgentCommRate%'' OR OBJECT_NAME(id) LIKE ''%custOverride%'' OR 
            OBJECT_NAME(id) LIKE ''%CustSetting%'' OR OBJECT_NAME(id) LIKE ''%CustCommRate%''
        )
        AND OBJECT_NAME(id) NOT LIKE ''%_UAT%'' 
        AND OBJECT_NAME(id) NOT LIKE ''%_xpre%'' 
        AND OBJECT_NAME(id) NOT LIKE ''%_xtest%'' 
        AND OBJECT_NAME(id) NOT LIKE ''%_cn88%''
    GROUP BY OBJECT_NAME(id)
)
SELECT *
FROM CTE
WHERE CustBetSetting3rd_Agent=1 OR CustBetSetting3rd_Member=1 OR AgentCommRate=1 OR custOverride=1 OR CustSetting=1 OR CustCommRate=1
ORDER BY SPName';