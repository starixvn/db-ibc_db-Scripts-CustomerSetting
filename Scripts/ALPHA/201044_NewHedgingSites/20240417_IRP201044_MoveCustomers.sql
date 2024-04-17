/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240417@Johnson
	Task: move customers for Hedging & Phone Betting sites [redmine: #201044]
	DB: DBCUST/CustDB
*/

DECLARE @mrecommend_New INT, @srecommend_New INT, @recommend_New INT

--Update agent '6666AHK'
SELECT @mrecommend_New = mrecommend,
	@srecommend_New = srecommend
FROM custinfo WITH(NOLOCK)
WHERE username = 'MH-HK$'

UPDATE c
SET srecommend = @srecommend_New,
	mrecommend = @mrecommend_New
FROM customer c WITH(ROWLOCK)
WHERE username IN ('6666AHK')

UPDATE c
SET srecommend = @srecommend_New,
	mrecommend = @mrecommend_New
FROM custinfo c WITH(ROWLOCK)
WHERE username IN ('6666AHK')

--Update member '230RMB','231RMB'
SELECT @recommend_New = custid,
	@mrecommend_New = mrecommend,
	@srecommend_New = srecommend
FROM custinfo WITH(NOLOCK)
WHERE username = 'AH-RMB'

UPDATE c
SET srecommend = @srecommend_New,
	mrecommend = @mrecommend_New,
	recommend = @recommend_New	
FROM customer c WITH(ROWLOCK)
WHERE username IN ('230RMB','231RMB')

UPDATE c
SET srecommend = @srecommend_New,
	mrecommend = @mrecommend_New,
	recommend = @recommend_New
FROM custinfo c WITH(ROWLOCK)
WHERE username IN ('230RMB','231RMB')

--Correct direct accounts
INSERT INTO Acc_CustDirect(custid,roleid)
SELECT custid,roleid
FROM custinfo WITH(NOLOCK)
WHERE username IN ('SH-HK$','MH-HK$','SH-RM','MH-RM','SS-RMB','MS-RMB','SH-EURO',
'AH-RMB','MH-RMB','SH-RMB','AH-RUP','MH-RUP','SH-RUP','MS-RMB','SS-RMB','MS-RM','SS-RM')

DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (
		SELECT custid
		FROM custinfo WITH(NOLOCK)
		WHERE username IN ('SH-HK$','MH-HK$','SH-RM','MH-RM','SH-RMB','SS-RMB','MS-RMB','AH-RMB','MH-RMB',
		'AH-RUP','MH-RUP','SH-RUP','MS-RMB','SS-RMB','MS-RM','SS-RM','SH-EURO', 'MH-EURO')
	)