/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 07/06/2024
	Task: Migrate RNG Keno For Headline Is Hidden - Get MaxCustID [#204358]				
	DB: DBCust/CustDB
*/
--Get Super Account Affect
CREATE TABLE #SuperID (SuperID INT , PRIMARY KEY CLUSTERED (SuperID))

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid 
FROM custInfo c WITH (NOLOCK) 
WHERE c.username IN ('SA-US$','SA-TB','SA-HK$','SA-EURO','SA-AUD','SA-GBP','SA-RMB','SA-IN','SH-HK$','SH-RMB','SS-RMB') 
AND c.Enabled = 1


SELECT MAX(c.custid) AS MaxCustID
FROM Customer c WITH (NOLOCK)
INNER JOIN #SuperID si ON c.srecommend = si.SuperID


DROP TABLE #SuperID