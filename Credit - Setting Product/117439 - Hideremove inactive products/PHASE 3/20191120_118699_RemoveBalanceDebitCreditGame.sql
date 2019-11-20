/*	
	Created: 20191120Eden
	Task: Clean data for LiveCasino on BalanceDebitGame, BalanceCreditGame tables : bettype = 1101
	Redmine: https://nexdev.net/issues/118699
	DB: DBTXN/bodb02
*/
USE bodb02
GO

CREATE TABLE #BalanceDebitGame(custid int, winlostdate smalldatetime ,bettype smallint)
CREATE TABLE #BalanceCreditGame(custid int, winlostdate smalldatetime ,bettype smallint)

DECLARE @Batch int = 5000
DECLARE @Rowcount1 INT = 1
DECLARE @Rowcount2 INT = 1

WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #BalanceDebitGame
	TRUNCATE TABLE #BalanceCreditGame

	IF @Rowcount1 > 0
		INSERT INTO #BalanceDebitGame(custid, winlostdate, bettype)
		SELECT TOP (@Batch) custid, winlostdate, bettype
		FROM BalanceDebitGame WITH(NOLOCK)
		WHERE balance = 0
			  AND bettype = 1101

	SET @Rowcount1 = @@ROWCOUNT
	
	IF @Rowcount2 > 0
		INSERT INTO #BalanceCreditGame(custid, winlostdate, bettype)
		SELECT TOP (@Batch) custid, winlostdate, bettype
		FROM BalanceCreditGame WITH(NOLOCK)
		WHERE balance = 0
			  AND bettype = 1101
	
	SET @Rowcount2 = @@ROWCOUNT

	IF @Rowcount1 = 0 and @Rowcount2 = 0
		BREAK;
	
	IF @Rowcount1 > 0
		DELETE a
		FROM BalanceDebitGame a WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #BalanceDebitGame tmp 
			ON a.custid = tmp.custid
			AND a.winlostdate = tmp.winlostdate
			AND a.bettype = tmp.bettype

	IF @Rowcount2 > 0
		DELETE a
		FROM BalanceCreditGame a WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #BalanceCreditGame tmp 
			ON a.custid = tmp.custid
			AND a.winlostdate = tmp.winlostdate
			AND a.bettype = tmp.bettype

	WAITFOR DELAY '00:00:0.100'
END
DROP TABLE #BalanceCreditGame
DROP TABLE #BalanceDebitGame
