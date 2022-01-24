/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20220124
	Task: Update test data of  VRCustAutoAdjustment table [RM#166626]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE v
SET v.FirstBetDate = '2022-01-17'
FROM VRCustAutoAdjustment v WITH (ROWLOCK,UPDLOCK)
WHERE v.custid in (44672286,45269459)

/*
SELECT v.*, 
       c.site, 
       c.currency
FROM VRCustAutoAdjustment v WITH(NOLOCK)
     INNER JOIN customer c WITH(NOLOCK)
       ON v.custid = c.custid
WHERE v.custid IN(44672286, 45269459)
*/
