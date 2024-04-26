/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240426@Johnson
	Task: move customers for Hedging & Phone Betting sites [redmine: #201044]
	DB: DBCUST/CustDB
*/

DECLARE @mrecommend_New INT, @srecommend_New INT, @custid INT

--Update agent '6666AHK'
SELECT @mrecommend_New = mrecommend,
	@srecommend_New = srecommend
FROM custinfo WITH(NOLOCK)
WHERE username = 'MH-HK$'

SEleCT @custid = custid
FROM customer c WITH(NOLOCK)
WHERE username = '6666AHK'

UPDATE c
SET srecommend = @srecommend_New,
	mrecommend = @mrecommend_New
FROM customer c WITH(ROWLOCK)
WHERE recommend = @custid
	AND roleid = 1

UPDATE c
SET srecommend = @srecommend_New,
	mrecommend = @mrecommend_New
FROM custinfo c WITH(ROWLOCK)
WHERE recommend = @custid
	AND roleid = 1