/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20230717
	Task: Create Dummy exchange Account for INR - 65 licensees [Redmine:#191317]
		Dummy Exchange => format : {site} + Exchange + {currency} 
		--> Under line Dummy Agent => format : {site} + ACC + {currency} + 01
	DB: DBCUST/CustDB
*/

CREATE TABLE #supers (custid INT, currency NVARCHAR(50), Site VARCHAR(20) ,DummyAgentID INT, DummyAgent varchar(30), DummyExchange varchar(30), DummyExchangeID INT, ErrMsg VARCHAR(200), isfinished bit default(0))
INSERT INTO #supers(custid,currency,Site,DummyAgent)
SELECT ci.custid,ex.currency
, CASE WHEN cs.site = 'Mansion88' THEN 'MS88' ELSE cs.Site END
, CASE WHEN cs.site = 'Mansion88' THEN 'MS88' ELSE cs.Site END + 'ACC' + ex.currency + '01'
FROM customer ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN exchange ex WITH(NOLOCK) On ex.ExchangeId = ci.currency
WHERE ci.username NOT LIKE '3rdSuper%'
		AND cs.site IN(
						'OCMS'
						,'zt828'
						,'DFBET'
						,'W88'
						,'Opal88'
						,'TSEnter'
						,'SGM88'
						,'ZhiFeng176'
						,'365online'
						,'PKbet'
						,'ZF055PMW'
						,'MTech'
						,'Royal'
						,'88Macao'
						,'AEUG'
						,'OBGM'
						,'DTGJZ'
						,'IBO'
						,'BigGaming'
						,'DFGame'
						,'Xtu168'
						,'GamingSoft'
						,'IONclub'
						,'Diamond'
						,'DingTai'
						,'ZhiFeng012'
						,'Dawooxin'
						,'ZhiFeng009'
						,'Mayibet'
						,'ZhiFeng021'
						,'ig128'
						,'ZhiFeng183'
						,'M8Credit'
						,'wmcasino'
						,'Dawoo'
						,'win365'
						,'Heaven'
						,'ZFRT090'
						,'Kzing2'
						,'Monaco'
						,'XTSB'
						,'A1game'
						,'ZF301B'
						,'YongBao'
						,'GoldenF'
						,'Mansion88'
						,'AE88'
						,'Gaobet'
						,'Yunji'
						,'TCGMASTER'
						,'9Club'
						,'ZhiFeng051'
						,'MYGAME'
						,'Alphalota'
						,'Mancity2'
						,'ZF026'
						,'Jiuyou'
						,'bmwbet'
						,'khmer'
						,'ab6688'
						,'Bobo88'
						,'ZhiFeng036'
						,'24AVIA'
						,'BBIN3'
						,'TCGINR'
						)
		AND Ci.currency IN (61,121)
		AND ci.roleid = 4

UPDATE t 
SET t.DummyAgent = ag.username,
t.DummyAgentID = ag.custid,
t.DummyExchange =  t.Site + 'Exchange' + t.currency
FROM #supers t 
	INNER JOIN custinfo ag WITH(NOLOCK) 
		ON t.custid = ag.srecommend
WHERE ag.username = t.DummyAgent

UPDATE t 
SET t.isfinished = 1,
	t.DummyExchangeID = m.custid
FROM #supers t 
	INNER JOIN custinfo m WITH(NOLOCK) 
		ON t.custid = m.srecommend
WHERE m.username = t.DummyExchange
	AND m.recommend = t.DummyAgentID

----------Create Dummy Exchange------------------
DECLARE @DummyExchange VARCHAR(30)
	, @DummyAgentID INT
	, @DummyExchangeID INT
	, @ErrCode INT
	, @ErrMsg NVARCHAR(4000)

WHILE 1 = 1
BEGIN
	UPDATE TOP(1) t
	SET isfinished = 1,
		@DummyAgentID = t.DummyAgentID,
		@DummyExchange = t.DummyExchange
	FROM #supers t
	WHERE isfinished = 0

	IF @@ROWCOUNT = 0
		BREAK

	EXEC Acc_Dep_CustomerInsMember_Ag 
		 @custid=@DummyExchangeID output
		,@creator=10278938 --starixIT 
		,@username=@DummyExchange
		,@userpwd=default
		,@recommend=@DummyAgentID
		,@IP='10.3.11.200'
		,@Language=default
		,@SubAccID=0
		,@ErrCode=@ErrCode output
		,@ErrMsg=@ErrMsg output

		UPDATE  t
		SET t.ErrMsg = @ErrMsg,
			t.DummyExchangeID = @DummyExchangeID
		FROM #supers t
		WHERE DummyExchange = @DummyExchange
END

SELECT * FROM #supers t ORDER BY ErrMsg
SELECT * FROM #supers t WHERE ISNULL(ErrMsg,'') <> ''

DROP TABLE #supers