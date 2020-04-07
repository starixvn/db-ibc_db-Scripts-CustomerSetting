/*
	Created: 20200407@Elodie
	Task: adjust PT RnG Keno for some line [redmine:#131903]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tblMaster (custid INT, srecommend INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblMasterSport (custid INT, sporttype INT, bettype INT, isFinished BIT DEFAULT 0)

INSERT INTO #tblMaster(custid,srecommend)
SELECT custid, srecommend
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (21355056	--ACE
					,13744152	--AG
					,5086616	--AN
					,4314665	--AP
					,4212172	--AS
					,39061067	--AV
					,1812820	--AW
					,26369026	--DH
					,21498400	--FAT
					,27783723	--KC
					,39645666	--NO
					,18747621	--WG
					,19984898	--WINB
					,19984899	--WINC
					,20096077	--WING
					,19998069	--WINZ
					,18364243	--WJ
					,40332643	--WO
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
WHERE cs.autopositiontaking < 0.85

DELETE t
FROM #tblMaster t	
WHERE custid NOT IN (SELECT DISTINCT custid FROM #tblMasterSport)

DECLARE @srecommend INT,
		@custid 	INT,
		@sporttype 	INT,
		@bettype 	INT,
		@Old_IsAuto BIT
		
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
		
		SELECT @Old_IsAuto = isautopositiontaking
		FROM CustSettingGame cs WITH(NOLOCK)			
		WHERE custid = @custid	
			AND sporttype = @sporttype
			AND bettype = @bettype
		
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
            , @Old_IsAuto_KenoSPositionTaking = @Old_IsAuto
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




	