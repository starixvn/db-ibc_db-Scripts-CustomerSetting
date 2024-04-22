/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240304@Johnson
	Task: move customers for Hedging & Phone Betting sites [redmine: #201044]
	DB: DBCUST/CustDB
*/

DECLARE @tblCust TABLE(CustID INT, Username VARCHAR(10), site VARCHAR(30), roleid TINYINT, mrecommend_New INT, srecommend_New INT, IsFinished BIT DEFAULT(0))
DECLARE @custid INT, @Username VARCHAR(30), @site VARCHAR(10), @roleid TINYINT, @mrecommend_New INT, @srecommend_New INT, @recommend_New INT

INSERT INTO @tblCust(CustID,Username,site,roleid)
SELECT custid,username,'Hedging',roleid
FROM custinfo (NOLOCK)
WHERE username IN ('MOLLYBET','AH501','MollyBF','XYZHK','billma','FRARM','M008iRM','M9999RM','mbrm','2022WC-RM','CASHTEST','CMD','FRA','IT-test1','MMRODDS','XYZPTRM','XYZRM','ISN','STELIM'
--,'999MYR','USTM'
)
UNION 
SELECT custid,username,'Special',roleid
FROM custinfo (NOLOCK)
WHERE username IN ('wsrmb','8RM','8RM8801','8RM8802','8RM8803','8RM8804','8RM8805','8RM8806','8RM8807','8RM8808','8RM8809','8RM8810','8RMTest01','BARM','BARM002','MMRWC22','PHIRM','WCBill','WINRM','wsrm')

;WITH T AS (
	SELECT 'MOLLYBET' username, 'MH-EURO' Master, 'SH-EURO' Super
	UNION SELECT 'AH501', NULL, 'SH-HK$'
	UNION SELECT 'MollyBF', 'MH-HK$', 'SH-HK$'
	UNION SELECT 'XYZHK', 'MH-HK$', 'SH-HK$'
	UNION SELECT 'billma', NULL, 'SH-RM'
	UNION SELECT 'FRARM', NULL, 'SH-RM'
	UNION SELECT 'M008iRM', NULL, 'SH-RM'
	UNION SELECT 'M9999RM', NULL, 'SH-RM'
	UNION SELECT 'mbrm', NULL, 'SH-RM'
	UNION SELECT '2022WC-RM', 'MH-RM', 'SH-RM'
	UNION SELECT 'CASHTEST', 'MH-RM', 'SH-RM'
	UNION SELECT 'CMD', 'MH-RM', 'SH-RM'
	UNION SELECT 'FRA', 'MH-RM', 'SH-RM'
	UNION SELECT 'IT-test1', 'MH-RM', 'SH-RM'
	UNION SELECT 'MMRODDS', 'MH-RM', 'SH-RM'
	UNION SELECT 'XYZPTRM', 'MH-RM', 'SH-RM'
	UNION SELECT 'XYZRM', 'MH-RM', 'SH-RM'
	UNION SELECT 'ISN', NULL, 'SH-RMB'
	UNION SELECT 'STELIM', NULL, 'SH-RMB'
	
	UNION SELECT 'wsrmb', 'MS-RMB', 'SS-RMB'
	UNION SELECT '8RM', 'MS-RM', 'SS-RM'
	UNION SELECT '8RM8801', 'MS-RM', 'SS-RM'
	UNION SELECT '8RM8802', 'MS-RM', 'SS-RM'
	UNION SELECT '8RM8803', 'MS-RM', 'SS-RM'
	UNION SELECT '8RM8804', 'MS-RM', 'SS-RM'
	UNION SELECT '8RM8805', 'MS-RM', 'SS-RM'
	UNION SELECT '8RM8806', 'MS-RM', 'SS-RM'
	UNION SELECT '8RM8807', 'MS-RM', 'SS-RM'
	UNION SELECT '8RM8808', 'MS-RM', 'SS-RM'
	UNION SELECT '8RM8809', 'MS-RM', 'SS-RM'
	UNION SELECT '8RM8810', 'MS-RM', 'SS-RM'
	UNION SELECT '8RMTest01', 'MS-RM', 'SS-RM'
	UNION SELECT 'BARM', 'MS-RM', 'SS-RM'
	UNION SELECT 'BARM002', 'MS-RM', 'SS-RM'
	UNION SELECT 'MMRWC22', 'MS-RM', 'SS-RM'
	UNION SELECT 'PHIRM', 'MS-RM', 'SS-RM'
	UNION SELECT 'WCBill', 'MS-RM', 'SS-RM'
	UNION SELECT 'WINRM', 'MS-RM', 'SS-RM'
	UNION SELECT 'wsrm', 'MS-RM', 'SS-RM'
)
UPDATE c
SET c.srecommend_New = s.custid,
	c.mrecommend_New = m.custid
FROM @tblCust c
	INNER JOIN T ON c.username = t.username
	INNER JOIN customer s WITH(NOLOCK) ON t.super = s.username
	LEFT JOIN customer m WITH(NOLOCK) ON t.master = m.username
/*
--UPDATE site for 999MYR(4k5 members), USTM (70 members)
WHILE(1=1)
BEGIN
	UPDATE t
	SET  @custid = custid, 
		@Username = username,
		@site = site,
		IsFinished = 1
	FROM @tblCust t
	WHERE username IN ('999MYR', 'USTM')
		AND IsFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	--downlines < 5k
	UPDATE c
	SET site = @site
	FROM Customer c WITH(ROWLOCK)
	WHERE srecommend = @custid

	UPDATE ca
	SET ca.site = @site
	FROM CustAgent ca WITH (ROWLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON ca.custid = ci.custid
	WHERE srecommend = @custid
	
	WAITFOR DELAY '0:0:1'
END
*/

--Move line for customers
WHILE(1=1)
BEGIN
	UPDATE TOP(1) t
	SET  @custid = custid, 
		@Username = username,
		@site = site,
		@roleid = roleid,
		@mrecommend_New = mrecommend_New,
		@srecommend_New = srecommend_New,
		IsFinished = 1
	FROM @tblCust t
	WHERE IsFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	--downlines < 5k
	IF @roleid = 3
	BEGIN
		UPDATE c
		SET 
			--site = @site,
			srecommend = @srecommend_New
		FROM Customer c WITH(ROWLOCK)
		WHERE mrecommend = @custid
		
		UPDATE c
		SET srecommend = @srecommend_New
		FROM Custinfo c WITH(ROWLOCK)
		WHERE mrecommend = @custid
		/*
		UPDATE ca
		SET ca.site = @site
		FROM CustAgent ca WITH (ROWLOCK)
			INNER JOIN custinfo ci WITH(NOLOCK) ON ca.custid = ci.custid
		WHERE mrecommend = @custid
		*/
	END
	ELSE IF @roleid = 2
	BEGIN
		UPDATE c
		SET 
			--site = @site,
			srecommend = @srecommend_New,
			mrecommend = @mrecommend_New
		FROM Customer c WITH(ROWLOCK)
		WHERE recommend = @custid
		
		UPDATE c
		SET srecommend = @srecommend_New,
			mrecommend = @mrecommend_New
		FROM Custinfo c WITH(ROWLOCK)
		WHERE recommend = @custid
		/*
		UPDATE ca
		SET ca.site = @site
		FROM CustAgent ca WITH (ROWLOCK)
			INNER JOIN custinfo ci WITH(NOLOCK) ON ca.custid = ci.custid
		WHERE recommend = @custid
		*/
	END	
	
	WAITFOR DELAY '0:0:1'
END

--Update member fmrup
SELECT @recommend_New = custid,
	@mrecommend_New = mrecommend,
	@srecommend_New = srecommend
FROM custinfo WITH(NOLOCK)
WHERE username = 'AH-RUP'

UPDATE c
SET srecommend = @srecommend_New,
	mrecommend = @mrecommend_New,
	recommend = @recommend_New
	--,site = 'Hedging'
FROM customer c WITH(ROWLOCK)
WHERE username = 'fmrup'

UPDATE c
SET srecommend = @srecommend_New,
	mrecommend = @mrecommend_New,
	recommend = @recommend_New
FROM custinfo c WITH(ROWLOCK)
WHERE username = 'fmrup'