/*<info serverAlias="DBTP-bodb02"></info>*/

/*
	Created: 20221102@Tacy
	Task: Update Keno's Bettype on table [CustMaxBetSetting_History]
		 https://nexdev.net/issues/1780040 RedmineID: #180040
	Database: DBTP-bodb02
*/


DECLARE @tmp_GameType TABLE (GameTypeID INT, IBCBettypeID INT)

BEGIN TRY		
	INSERT INTO @tmp_GameType (GameTypeID, IBCBettypeID)
	SELECT GameTypeID, IBCBettypeID 
	FROM DBAGE.bodb02.dbo.GameType WITH (NOLOCK)
	WHERE IBCBetTypeID BETWEEN 1501 AND 1599	--Keno
END TRY
BEGIN CATCH		
	INSERT INTO @tmp_GameType (GameTypeID, IBCBettypeID)
	SELECT GameTypeID, IBCBettypeID 
	FROM DBTXN.bodb02.dbo.GameType WITH (NOLOCK)
	WHERE IBCBetTypeID BETWEEN 1501 AND 1599	--Keno
END CATCH

UPDATE his
SET his.BetType=t.IBCBettypeID
FROM CustMaxBetSetting_History his WITH (ROWLOCK, UPDLOCK)
INNER JOIN @tmp_GameType t ON t.GameTypeID=his.BetType
WHERE his.SportType=202