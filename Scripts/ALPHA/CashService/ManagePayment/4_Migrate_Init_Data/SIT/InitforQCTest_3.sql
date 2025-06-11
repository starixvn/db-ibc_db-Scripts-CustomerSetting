/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Change Data Rule SubDomainPrefix [223896]   
	DB: DBCUST/AgencyCashService
*/

SET NOCOUNT ON;

SELECT * , 'simplec-' + LEFT(CAST(a.AgentId AS VARCHAR), 3) + 
					 CAST(DomainID AS VARCHAR) + 
					 SUBSTRING(CAST(a.AgentId AS VARCHAR), 4, LEN(CAST(a.AgentId AS VARCHAR)) - 3) AS SubDomainPrefix_new
INTO #A
FROM CashDomainManagement a WITH (NOLOCK)

--SELECT  c.SubDomainPrefix , tmp.SubDomainPrefix_new , c.DomainId
UPDATE c SET c.SubDomainPrefix = tmp.SubDomainPrefix_new , RepUpdateTime = SYSDATETIME ()
FROM #A tmp
INNER JOIN CashDomainManagement c WITH (ROWLOCK,UPDLOCK) ON tmp.AgentId = c.AgentId AND tmp.DomainId = c.DomainId

DROP TABLE #A