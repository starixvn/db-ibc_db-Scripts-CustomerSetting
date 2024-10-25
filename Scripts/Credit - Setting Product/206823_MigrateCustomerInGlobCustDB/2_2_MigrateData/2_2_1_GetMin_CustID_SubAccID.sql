/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240715@Helios
	Task: Scale out DBCUST - Credit Customer in GlobCustDB - Get CustInfoMini.MinCustID [#206823]  
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/


SELECT
	MIN(cim.CustID) - 1 AS MinCustID
FROM CustInfoMini cim WITH (NOLOCK)

SELECT
	MIN(cim.SubAccID) - 1 AS MinSubAccID
FROM CustSubMini cim WITH (NOLOCK)

-- Get @StartDTS

SELECT SYSDATETIME () AS StartDTS
