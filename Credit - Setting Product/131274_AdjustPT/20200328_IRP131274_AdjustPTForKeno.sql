/*
	created: 20200328@Johnson
	Task: adjust PT RnG Keno for some line [redmine:#131274]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tblMaster (custid INT, srecommend INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblMasterSport (custid INT, sporttype INT, bettype INT, isFinished BIT DEFAULT 0)

INSERT INTO #tblMaster(custid,srecommend)
SELECT custid, srecommend
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (4664545,--	HD
					14592746,--	MOD
					17916695,--	VJ
					26369026--	DH
					)
	AND roleid = 3					

INSERT INTO #tblMasterSport(custid,sporttype,bettype)	
SELECT cs.custid, cs.sporttype, cs.bettype
FROM #tblMaster t
	CROSS JOIN (
				SELECT 202 as sporttype, 1501 as bettype, 0 isLive
				UNION ALL  SELECT 202, 1503, 0
				UNION ALL  SELECT 202, 1504, 0
				UNION ALL  SELECT 202, 1505, 0				
				UNION ALL  SELECT 202, 1508, 0				
				UNION ALL  SELECT 202, 1511, 0
				UNION ALL  SELECT 202, 1513, 0
				UNION ALL  SELECT 202, 1514, 0				
				) s
		INNER JOIN CustSettingGame cs (NOLOCK) ON t.custid = cs.custid 
												AND cs.SportType = s.sporttype 
												AND cs.BetType = s.bettype
WHERE cs.autopositiontaking = 0.8 AND cs.isautopositiontaking = 1

DELETE t
FROM #tblMaster t	
WHERE custid NOT IN (SELECT DISTINCT custid FROM #tblMasterSport)

DECLARE @srecommend INT,
		@custid 	INT,
		@sporttype 	INT,
		@bettype 	INT,
		@Old_IsAuto_SPositionTaking BIT
		
WHILE (1=1)	
BEGIN
	UPDATE TOP (1) t
	SET @custid = custid,
		@srecommend = srecommend,
		isFinished = 1
	FROM #tblMaster t 
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	WHILE(1=1)
	BEGIN
		UPDATE TOP (1) t
		SET @sporttype = sporttype,
			@bettype = bettype,
			isFinished = 1
		FROM #tblMasterSport t
		WHERE custid = @custid 
			AND isFinished = 0
		
		IF @@ROWCOUNT = 0
			BREAK;
				
		UPDATE cs
		SET cs.spositiontaking = 0,
			cs.isautopositiontaking = 1,
			cs.autopositiontaking = 0.85
		FROM CustSettingGame cs WITH(UPDLOCK,ROWLOCK)			
		WHERE custid = @custid	
			AND sporttype = @sporttype
			AND bettype = @bettype			
			
		EXEC dbo.Acc_CustSetting3rd_05
            @srecommend = @srecommend
            , @mrecommend = @custid
            , @roleid = 3
            , @mode = 'Keno'

            , @IsAuto_KenoSPositionTaking = 1
            , @Old_IsAuto_KenoSPositionTaking = 1--current auto status
            , @Auto_KenoSPositionTaking = 0.85
        
            , @Updateallmembers = 0
            , @newspositiontaking = 0
            , @KenoBetType = @BetType
			
		EXEC dbo.Acc_CustSetting3rd_07
            @srecommend = @srecommend,
            @mrecommend = @custid,
            @roleid = 3,
            @mode = 'Keno',
            @Sporttype = @SportType,
            @Bettype = @Bettype	
		
	END	
	
	WAITFOR DELAY '0:0:0.28'
END




	