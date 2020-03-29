/*
	created: 20200329@Johnson
	Task: adjust PT Virtual sports for some line [redmine:#131274]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tblCust (custid INT, srecommend INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblCustSport (custid INT, sporttype INT, bettype INT, isLive BIT)

INSERT INTO #tblCust(custid,srecommend)
SELECT custid, srecommend
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (4664545,--	HD
					14592746,--	MOD
					17916695,--	VJ
					26369026--	DH
					)
	AND roleid = 3					

INSERT INTO #tblCustSport(custid,sporttype,bettype,isLive)	
SELECT cs.custid, cs.sporttype, cs.bettype, cs.isLive
FROM #tblCust t
	CROSS JOIN (
				SELECT 180 as sporttype, 1201 as bettype, 0 isLive
				UNION ALL  SELECT 181, 1231, 0
				UNION ALL  SELECT 182, 1231, 0
				UNION ALL  SELECT 183, 1231, 0
				UNION ALL  SELECT 184, 1231, 0
				UNION ALL  SELECT 185, 1231, 0
				UNION ALL  SELECT 186, 1220, 0
				UNION ALL  SELECT 190, 2701, 0
				UNION ALL  SELECT 191, 2701, 0
				UNION ALL  SELECT 192, 2701, 0
				UNION ALL  SELECT 193, 2801, 0) s
		INNER JOIN CustPTSetting3rd_Agent cs (NOLOCK) ON t.custid = cs.custid 
														AND cs.SportType = s.sporttype 
														AND cs.BetType = s.bettype
WHERE cs.AutoSuperPT < 85

DELETE t
FROM #tblCust t	
WHERE custid NOT IN (SELECT DISTINCT custid FROM #tblCustSport)

DECLARE @AutoPT		VARCHAR(MAX),
		@PT			VARCHAR(MAX),
		@srecommend INT,
		@custid 	INT

SELECT @PT='<ROOT>
<PT SportType="180" BetType="1201" IsLive="0"/>
<PT SportType="181" BetType="1231" IsLive="0"/>
<PT SportType="182" BetType="1231" IsLive="0"/>
<PT SportType="183" BetType="1231" IsLive="0"/>
<PT SportType="184" BetType="1231" IsLive="0"/>
<PT SportType="185" BetType="1231" IsLive="0"/>
<PT SportType="186" BetType="1220" IsLive="0"/>
<PT SportType="190" BetType="2701" IsLive="0"/>
<PT SportType="191" BetType="2701" IsLive="0"/>
<PT SportType="192" BetType="2701" IsLive="0"/>
<PT SportType="193" BetType="2801" IsLive="0"/>
</ROOT>'
		
WHILE (1=1)	
BEGIN
	UPDATE TOP (1) t
	SET @custid = custid,
		@srecommend = srecommend,
		isFinished = 1
	FROM #tblCust t 
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	SET @AutoPT =(
			SELECT cs.sporttype AS '@SportType'
				,cs.bettype AS '@BetType'
				,cs.isLive AS '@IsLive'			
				,1 AS '@IsAuto_New'
				,cs.isAutoSuperPT AS '@IsAuto_Old'	
				,0 AS '@IsUpdAllMems'
				,0 AS '@UpdAllMems_Value'
			FROM CustPTSetting3rd_Agent cs WITH(NOLOCK)	
				INNER JOIN #tblCustSport t ON cs.custid = t.custid 
											AND cs.sporttype = t.sporttype
											AND cs.bettype = t.bettype
											AND cs.isLive = t.isLive
			WHERE t.custid = @custid 				
			FOR XML PATH('PT'), ROOT('ROOT')
		 )	
	
	UPDATE cs
	SET cs.SuperPT = 0,
		cs.isAutoSuperPT = 1,
		cs.AutoSuperPT = 85
	FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCustSport t ON cs.custid = t.custid 
									AND cs.sporttype = t.sporttype
									AND cs.bettype = t.bettype
									AND cs.isLive = t.isLive
	WHERE t.custid = @custid
		
		
	EXEC dbo.Acc_DynamicCustSetting3rd_05
            @SuperID = @srecommend,
            @MasterID = @custid,
            @RoleID = 3,          
            @AutoPT = @AutoPT
           
	EXEC dbo.Acc_DynamicCustSetting3rd_07
		@SuperID = @srecommend
		,@MasterID = @custid
		,@RoleID = 3
		,@SportBettypeXML = @PT	
	
	WAITFOR DELAY '0:0:0.28'
END




	