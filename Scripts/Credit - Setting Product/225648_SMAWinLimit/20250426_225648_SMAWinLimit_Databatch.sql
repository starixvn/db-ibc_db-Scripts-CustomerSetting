/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20250426@Elodie
	Task: SMA WinLimit - Databatch [#225648] 
		https://nexdev.net/issues/225648
	DB: SiteDB03/bodb02
*/

USE bodb02
GO 
DECLARE @custid INT = 229235151

SELECT winlostdate, SUM(winlost-actual_stake) balance INTO #DebitGame
FROM bettranslc 
WHERE custid =  @custid
	AND status = 'WON' 
GROUP BY winlostdate

SELECT winlostdate, SUM(winlost-actual_stake) balance INTO #CreditGame
FROM bettranslc 
WHERE custid = @custid 
	AND status = 'LOSE' 
GROUP BY winlostdate

UPDATE b
SET b.Balance = t.balance
FROM BalanceDebitGame b
	INNER JOIN #DebitGame t ON b.winlostdate = t.winlostdate
WHERE b.custid = @custid

UPDATE b
SET b.Balance = t.balance
FROM BalanceCreditGame b
	INNER JOIN #CreditGame t ON b.winlostdate = t.winlostdate
WHERE b.custid = @custid

