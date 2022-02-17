
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220217@Robert
	Task:	Change settings for #168493 - CWL - Change limit setting for some products
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220217@Robert:	correct some product settings.
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/


DECLARE 
	@tblProduct TABLE
				   (
	ProductId INT, 
	GroupId   INT, 
	Level101  MONEY, 
	Level102  MONEY, 
	Level1    MONEY, 
	Level2    MONEY, 
	Level3    MONEY
				   );

DECLARE 
	@tblCust TABLE
				(
	CustId   BIGINT, 
	Username VARCHAR(50)
				);
INSERT INTO @tblCust
   (
	  CustId, 
	  Username
   )
	  SELECT 
		    custid, 
		    username
	  FROM custInfo c(NOLOCK)
	  WHERE username IN('HeavenRMB019262', 'HeavenRMB019257', 'WKCURRMB0138143', 'txwl002RMB0240224', 'HeavenRMB019384', 'FB88INH013915', 'Sin88INH0131657', 'FB88INH0119138');


INSERT INTO @tblProduct
   (
	  ProductId, 
	  GroupId, 
	  Level101, 
	  Level102, 
	  Level1, 
	  Level2, 
	  Level3
   )
	  SELECT 
		    66, 
		    47, 
		    -20000, 
		    -50000, 
		    5000, 
		    30000, 
		    75000 -- Vgaming
	  UNION ALL
	  SELECT 
		    34, 
		    21, 
		    -20000, 
		    -50000, 
		    5000, 
		    30000, 
		    75000 -- Arcadia Gaming
	  UNION ALL
	  SELECT 
		    38, 
		    24, 
		    -20000, 
		    -50000, 
		    5000, 
		    30000, 
		    75000; -- Virtual games



UPDATE wl
  SET 
	 wl.MaxWinLimitSetting = CAST('<MaxWinLimitSetting Level1="' + CAST(p.Level1 AS VARCHAR(20)) + '" Level2="' + CAST(p.Level2 AS VARCHAR(20)) + '" Level3="' + CAST(p.Level3 AS VARCHAR(20)) + '" Level101="' + CAST(p.Level101 AS VARCHAR(20)) + '" Level102="' + CAST(p.Level102 AS VARCHAR(20)) + '" />' AS XML)
FROM WinLimit_CustGameMonitoring wl WITH (ROWLOCK, UPDLOCK)
	INNER JOIN @tblProduct p ON wl.ProductID = p.ProductId
						   AND wl.GroupID = p.GroupId
	INNER JOIN @tblCust c ON wl.CustID = c.CustId
WHERE 
	 wl.ModifiedDate = '2022-02-16 21:55:48.067';


UPDATE wl
  SET 
	 wl.MaxWinLimitSetting = CAST('<MaxWinLimitSetting Level1="' + CAST(p.Level1 AS VARCHAR(20)) + '" Level2="' + CAST(p.Level2 AS VARCHAR(20)) + '" Level3="' + CAST(p.Level3 AS VARCHAR(20)) + '" Level101="' + CAST(p.Level101 AS VARCHAR(20)) + '" Level102="' + CAST(p.Level102 AS VARCHAR(20)) + '" />' AS XML)
FROM WinLimit_CustGameMonitoring_History wl WITH (ROWLOCK, UPDLOCK)
	INNER JOIN @tblProduct p ON wl.ProductID = p.ProductId
						   AND wl.GroupID = p.GroupId
	INNER JOIN @tblCust c ON wl.CustID = c.CustId
WHERE 
	 wl.ModifiedDate = '2022-02-16 21:55:48.067';
