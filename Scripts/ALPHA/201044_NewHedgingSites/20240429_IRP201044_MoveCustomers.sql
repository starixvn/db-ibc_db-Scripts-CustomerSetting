/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240429@Johnson
	Task: move customers for Hedging & Phone Betting sites [redmine: #201044]
	DB: DBCUST/CustDB
*/

DECLARE @mrecommend_New INT, @srecommend_New INT, @recommend_New INT

--Update member '231USDT'
SELECT @recommend_New = custid,
	@mrecommend_New = mrecommend,
	@srecommend_New = srecommend
FROM custinfo WITH(NOLOCK)
WHERE username = '231'

UPDATE c
SET srecommend = @srecommend_New,
	mrecommend = @mrecommend_New,
	recommend = @recommend_New	
FROM customer c WITH(ROWLOCK)
WHERE username IN ('231USDT')

UPDATE c
SET srecommend = @srecommend_New,
	mrecommend = @mrecommend_New,
	recommend = @recommend_New
FROM custinfo c WITH(ROWLOCK)
WHERE username IN ('231USDT')