/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Winfred
	Date: 20230327
	Task: CWL - Check CWL for account - twpgmthomas.chou - Redmine: 185891
	DB: DBCUST-CustDB
*/

UPDATE WinLimit_CustGameStatus WITH(ROWLOCK,UPDLOCK)
SET IsBlockedPlaceBet = 0
WHERE CustID = 19345187 AND ProductID = 8  AND IsBlockedPlaceBet = 1 AND BettypeID  Between 1501 AND 1599

SELECT TOP 100 * 
FROM WinLimit_CustGameStatus WITH(NOLOCK)
WHERE CustID = 19345187 AND ProductID = 8  AND IsBlockedPlaceBet = 1 AND BettypeID  Between 1501 AND 1599