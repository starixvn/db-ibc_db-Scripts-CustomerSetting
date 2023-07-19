--12betExchangeINR => format : {site} + Exchange + {currency}
--DUmmy Agent => format : {site} + ACC + {currency} + 01
CREATE TABLE #supers (custid INT, currency NVARCHAR(50), Site VARCHAR(20) ,DummyAgentID INT, DummyAgent varchar(30), DummyExchange varchar(30), ErrMsg VARCHAR(200), isfinished bit default(0))
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
		AND Ci.currency IN (61,121,97)
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
SET t.isfinished = 1
FROM #supers t 
	INNER JOIN custinfo ag WITH(NOLOCK) 
		ON t.custid = ag.srecommend
WHERE ag.username = t.DummyAgent

SELECT * FROM #supers t
----------Create Dummy Exchange------------------
DECLARE @DummyExchange varchar(30), @DummyAgentID INT
WHILE 1 = 1
BEGIN
	UPDATE TOP(1) t
	SET isfinished = 1
	FROM #supers t
	WHERE isfinished = 0
	
END
DROP TABLE #supers

--declare @p3 int
--exec Acc_Dep_CheckExistedAccount @username='12BETACCJPY01',@RoleID=2,@CustID=@p3 output
--select @p3
--go
--declare @p1 int
--declare @p9 int
--declare @p10 nvarchar(4000)
--exec Acc_Dep_CustomerInsMember_Ag @custid=@p1 output,@creator=8,@username='12BETACCJPY01EdenTest',@userpwd=default,@recommend=6006576,@IP='10.18.200.204',@Language=default,@SubAccID=0,@ErrCode=@p9 output,@ErrMsg=@p10 output
--select @p1, @p9, @p10
--go
