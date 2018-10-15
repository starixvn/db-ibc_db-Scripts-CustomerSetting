/*
	Created: 20181015@Vicky
	Task: Insert data into custgametype table
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tblCustID TABLE (CustID INT, GameTypeID INT)
DECLARE @tblGameTypeID TABLE (GameTypeID INT)
DECLARE @srecommend INT
---------------------------------------------------------------------------------------------------------------


SELECT @srecommend = srecommend 
FROM CustInfo WITH (NOLOCK)
WHERE custid = 1176086

INSERT INTO @tblGameTypeID(GameTypeID)
VALUES (16), (17), (19), (20), (21), (22), (24)


INSERT INTO @tblCustID(CustID, GameTypeID)
SELECT ci.custid, tbl.GameTypeID
FROM CustInfo ci WITH (NOLOCK)
	CROSS APPLY(
		SELECT g.GameTypeID
		FROM @tblGameTypeID g
			LEFT JOIN CustGameType cg WITH (NOLOCK) ON cg.GameTypeID = g.GameTypeID AND cg.CustID = ci.CustID
		WHERE cg.GameTypeID IS NULL
	) AS tbl
WHERE ci.srecommend = @srecommend
	
-------------------check data--------------------------------------------------------------
/*
SELECT *  
FROM @tblCustID c
	INNER JOIN CustGameType cg ON cg.CustID = c.CustID AND c.GameTypeID = cg.GameTypeID
*/

INSERT INTO CustGameType (CustID,GameTypeID,StakeLevelList,MaxPerGameType,MinBet,MaxBet,IsDisabled)
SELECT c.CustID,c.GameTypeID,cg.StakeLevelList,cg.MaxPerGameType,cg.MinBet,cg.MaxBet,cg.IsDisabled
FROM @tblCustID c
	INNER JOIN CustGameType cg ON cg.CustID = c.CustID
WHERE cg.GameTypeID = 1
