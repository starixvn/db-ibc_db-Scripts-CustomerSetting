/*
	Created: 20200702@Johnson
	Task: update min/max pt for HKK's supers
	DB: DBCUST/CUSTDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
    @custid INT,	
	@UpdateMinPTNonSport BIT,
	@IsSpecial BIT,
	@maxcustid INT,
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF NOT(dbo.f_CheckRepTable('custinfo') = 1 
		AND dbo.f_CheckRepTable('CustSetting') = 1 
	    AND dbo.f_CheckRepTable('CustOverride') = 1 
	    AND dbo.f_CheckRepTable('CustSettingGame') = 1 
	    AND dbo.f_CheckRepTable('CustOverrideGame') = 1 
	    AND dbo.f_CheckRepTable('CustSetting3rd') = 1 
	    AND dbo.f_CheckRepTable('CustOverride3rd') = 1 
		AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1 	    		
		AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
		AND dbo.f_CheckRepTable('CustSettingGame') = 1
		AND dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 1
		AND dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 1	
		AND dbo.f_CheckRepTable('CustGameType') = 1
		AND dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 1		
		AND dbo.f_CheckRepTable('CustWinLossLimit_Member') = 1
	    )
	   RETURN
	   
	DECLARE @PT SMALLMONEY = 0.88
	
	--update preset s4,m4,a4
	UPDATE cs 
	SET cs.spositiontaking = @PT ,
		cs.mpositiontaking = cs.mpositiontaking + @PT - cs.spositiontaking ,
		cs.apositiontaking = cs.apositiontaking + @PT - cs.spositiontaking,
		
		cs.slivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE cs.slivepositiontaking END,
		cs.mlivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN cs.mlivepositiontaking + @PT - cs.slivepositiontaking ELSE cs.mlivepositiontaking END,
		cs.alivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN cs.alivepositiontaking + @PT - cs.slivepositiontaking ELSE cs.alivepositiontaking END
	FROM CustSetting cs WITH (UPDLOCK,ROWLOCK)
	WHERE custid = @custid
	
	UPDATE cs 
	SET maxpositiontaking = CASE WHEN @PT > maxpositiontaking THEN @PT ELSE maxpositiontaking END,			
		minpositiontaking = CASE WHEN @PT > minpositiontaking THEN @PT ELSE minpositiontaking END,			
		
		maxlivepositiontaking = CASE WHEN @PT > maxlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE maxlivepositiontaking END,
		minlivepositiontaking = CASE WHEN @PT > minlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE minlivepositiontaking END
	FROM custoverride cs WITH(ROWLOCK, UPDLOCK)				
	WHERE custid = @custid
	
	EXEC dbo.Acc_CustSetting_18 @srecommend = @custid, @roleid = 4, @Target = @Target						
	
	
	--Number Game
	SELECT @PT = 0.85
	
	UPDATE custsetting3rd with (ROWLOCK, UPDLOCK)
    SET
        spositiontaking = CASE WHEN bettype IN (81,83,86,88) THEN @PT ELSE spositiontaking END,
        mpositiontaking = CASE WHEN bettype IN (81,83,86,88) THEN mpositiontaking + @PT - spositiontaking ELSE mpositiontaking END,
		apositiontaking = CASE WHEN bettype IN (81,83,86,88) THEN apositiontaking + @PT - spositiontaking ELSE apositiontaking END,
		
        slivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) THEN @PT ELSE slivepositiontaking END ,
        mlivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) THEN mlivepositiontaking + @PT - slivepositiontaking ELSE mlivepositiontaking END ,
        alivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) THEN alivepositiontaking + @PT - slivepositiontaking ELSE mlivepositiontaking END 
    WHERE custid=@custid and sporttype = 161
	
	UPDATE cs 
	SET maxpositiontaking = CASE WHEN bettype IN (81,83,86,88) AND @PT > maxpositiontaking THEN @PT ELSE maxpositiontaking END,							
		maxlivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) AND @PT > maxlivepositiontaking THEN @PT ELSE maxlivepositiontaking END,

		minpositiontaking = CASE WHEN @UpdateMinPTNonSport = 1 AND bettype IN (81,83,86,88) 
										AND (@isSpecial = 0 
											OR (@isSpecial = 1 AND minpositiontaking > 0 )
											) 
										AND @PT > minpositiontaking THEN @PT ELSE minpositiontaking END,							
		minlivepositiontaking = CASE WHEN @UpdateMinPTNonSport = 1 AND bettype IN (85,86,87,89,90) 
										AND (@isSpecial = 0 
											OR (@isSpecial = 1 AND minlivepositiontaking > 0 )
											) 
										AND @PT > minlivepositiontaking THEN @PT ELSE minlivepositiontaking END		
	FROM custoverride3rd cs WITH(ROWLOCK, UPDLOCK)				
	WHERE custid = @custid
		AND sporttype = 161
	
	EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @custid, 
									@roleid = 4, 
									@mode = 'number',
									@Target = @Target	
	
	--RnG Keno
	SELECT @PT = 0.85
	
	UPDATE CustSettingGame WITH(UPDLOCK,ROWLOCK)
    SET spositiontaking = @PT
    WHERE custid = @custid 
		AND sporttype = 202
		AND bettype IN (1501,1503,1504,1505,1508,1511,1513,1514)
	
	IF @UpdateMinPTNonSport = 1
	BEGIN
		UPDATE CustOverrideGame WITH(UPDLOCK,ROWLOCK)
		SET minpositiontaking = CASE WHEN @isSpecial = 0 OR (@isSpecial = 1 AND minpositiontaking > 0) 
										THEN @PT ELSE minpositiontaking END
		WHERE custid = @custid 
			AND sporttype = 202
	END
	
	EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @custid, 
									@roleid = 4, 
									@sporttype = 202,
									@mode = 'Keno',
									@Target = @Target
	
	--GoldDeluxe
	SELECT @PT = 0.93
	
	UPDATE CustSettingGame WITH(UPDLOCK,ROWLOCK)
    SET spositiontaking = @PT
    WHERE custid = @custid 
		AND sporttype = 255
		AND bettype = 1701
	
	IF @UpdateMinPTNonSport = 1
	BEGIN
		UPDATE CustOverrideGame WITH(UPDLOCK,ROWLOCK)
		SET minpositiontaking = CASE WHEN @isSpecial = 0 OR (@isSpecial = 1 AND minpositiontaking > 0) 
										THEN @PT ELSE minpositiontaking END
		WHERE custid = @custid 
			AND sporttype = 255
	END
	
	EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @custid, 
									@roleid = 4, 
									@sporttype = 255,									
									@mode = 'GoldDeluxe',
									@Target = @Target
									
	--> FOR DCS products
	DECLARE @tmpSettings TABLE (sporttype INT, PT SMALLINT)
	
	INSERT INTO @tmpSettings(sporttype,PT)
	SELECT 43, 88 --E-Sports
	UNION SELECT 44, 88	--Muay Thai
	UNION SELECT 180, 85 --	Virtual Soccer
	UNION SELECT 181, 85 --	Virtual Horse Racing
	UNION SELECT 182, 85 --	Virtual Greyhounds
	UNION SELECT 183, 85 --	Virtual Speedway
	UNION SELECT 184, 85 --	Virtual Motorsports
	UNION SELECT 185, 85 --	Virtual Cycling
	UNION SELECT 186, 85 --	Virtual Tennis
	UNION SELECT 190, 85 --	Virtual Soccer League
	UNION SELECT 191, 85 --	Virtual Soccer Nation
	UNION SELECT 192, 85 --	Virtual Soccer World Cup
	UNION SELECT 193, 85 --	Virtual Basketball
	UNION SELECT 211, 93 --Allbet
	UNION SELECT 212, 85 --	Macau Games
	UNION SELECT 219, 90 --	Fishing World
	UNION SELECT 220, 85 --	Lottery
	UNION SELECT 222, 85 --	Table Game
	UNION SELECT 224, 85 --	RNG War
	UNION SELECT 225, 85 --	ION
	UNION SELECT 241, 85 --	BBIN
	UNION SELECT 243, 85 --	Sexy Gaming
	UNION SELECT 244, 93 --	SA Gaming
	UNION SELECT 245, 90 --	Virtual Games
	
	DECLARE @xml XML;
	SET @xml = (
				SELECT (
						SELECT SportType AS '@SportType'
							, BetType AS '@BetType'
							, IsLive AS '@IsLive'
						FROM dbo.ProductSettingDetail WITH(NOLOCK)
						WHERE settingtype = 1 
							  AND SportType IN (SELECT sporttype FROM @tmpSettings)
						FOR XML PATH('PT')
							, TYPE
						)
				FOR XML PATH('ROOT')
					, TYPE
				);
	DECLARE @SportBettypeXML NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX),@xml);
	
	UPDATE cs 
	SET cs.MaxPT = CASE WHEN cs.MaxPT < t.PT THEN t.PT ELSE cs.MaxPT END,
		cs.MinPT = CASE WHEN  cs.sporttype IN (43,44) 
							OR (@UpdateMinPTNonSport = 1
								AND (@isSpecial = 0
									OR (@isSpecial = 1 AND cs.MinPT > 0)
									)
								)	
						THEN CASE WHEN cs.MinPT < t.PT THEN t.PT ELSE cs.MinPT END 
						ELSE cs.MinPT END,
		cs.SuperPT  =  t.PT ,
		cs.MasterPT =  cs.MasterPT + t.PT - cs.SuperPT ,
		cs.AgentPT  =  cs.AgentPT + t.PT - cs.SuperPT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)	
		INNER JOIN @tmpSettings t ON cs.sporttype = t.sporttype
	WHERE custid = @custid
		
	EXEC dbo.Acc_DynamicCustSetting3rd_08 				
				@SuperID = @custid	
				,@Roleid = 4		
				,@SportBettypeXML = @SportBettypeXML
				,@Target = @Target	
	
	--update LossLimit & bet setting
	CREATE TABLE #Downlines (custid INT PRIMARY KEY, roleid TINYINT, isfinished BIT DEFAULT 0)
	
	INSERT INTO #Downlines (custid,roleid)
	SELECT custid, roleid
	FROM custinfo WITH(NOLOCK)
	WHERE srecommend = @custid
		AND Enabled = 1
		AND custid <= @maxcustid
		
	DECLARE @BatchMember TABLE(custid INT PRIMARY KEY, roleid TINYINT)
	
	DECLARE @BetSetting TABLE(sporttype INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)
	DECLARE @LossLimitSetting TABLE(sporttype INT, LossLimit MONEY)
	
	INSERT INTO @BetSetting(sporttype,MinBet,MaxBet,MaxPerMatch)
	SELECT 	180	, 5, 2200, 50000--	Virtual Soccer
	UNION ALL SELECT 	181	, 5, 2200, 50000--	Virtual Horse Racing
	UNION ALL SELECT 	182	, 5, 2200, 50000--	Virtual Greyhounds
	UNION ALL SELECT 	183	, 5, 2200, 50000--	Virtual Speedway
	UNION ALL SELECT 	184	, 5, 2200, 50000--	Virtual Motorsports
	UNION ALL SELECT 	185	, 5, 2200, 50000--	Virtual Cycling
	UNION ALL SELECT 	186	, 5, 2200, 50000--	Virtual Tennis
	UNION ALL SELECT 	190	, 5, 2200, 50000--	Virtual Soccer League
	UNION ALL SELECT 	191	, 5, 2200, 50000--	Virtual Soccer Nation
	UNION ALL SELECT 	192	, 5, 2200, 50000--	Virtual Soccer World Cup
	UNION ALL SELECT 	193	, 5, 2200, 50000--	Virtual Basketball
	UNION ALL SELECT 	199	, 5, 2200, 50000--	Virtual Sports Parlay
	UNION ALL SELECT 	161	, 10, 6000, 180000--	Number game
	UNION ALL SELECT 	164	, 10, 12000, 120000--	Happy 5
	UNION ALL SELECT 	202	, 5, 4200, 65000--	RnG Keno
	UNION ALL SELECT 	220	, 5, 4200, 65000--	Lottery
	UNION ALL SELECT 	224	, 5, 4200, 65000--	RnG War	
	UNION ALL SELECT 	222	, 5, 4200, 65000--	Table Game
	
	INSERT INTO @LossLimitSetting (sporttype, LossLimit)
	SELECT 180	, 500000 --	Virtual sports							
	UNION SELECT 	211	, 500000--	Allbet	
	UNION SELECT 	220	, 100000--	Lottery
	UNION SELECT 	222	, 100000--	Table Game
	UNION SELECT 	224	, 100000--	RNG War
	UNION SELECT 	225	, 500000--	ION								
	UNION SELECT 	243	, 500000--	Sexy Gaming
	UNION SELECT 	244	, 500000--	SA Gaming	
	UNION SELECT 	219	, 100000--	Fishing World
	UNION SELECT 	241	, 500000--	BBIN

	WHILE(1=1)
	BEGIN
		DELETE @BatchMember
		
		UPDATE TOP (500) t
		SET isfinished = 1
		OUTPUT DELETED.custid, DELETED.roleid INTO @BatchMember(custid,roleid)
		FROM #Downlines t
		WHERE isfinished = 0		
				
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		IF EXISTS(SELECT 1 FROM @BatchMember WHERE roleid > 1)
		BEGIN
			UPDATE cs 
			SET cs.MaxLossLimit = l.LossLimit
			FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
				INNER JOIN @LossLimitSetting l ON cs.sporttype = l.sporttype
			WHERE cs.custid IN (SELECT custid FROM @BatchMember WHERE roleid > 1)				
				AND MaxLossLimit > l.LossLimit
			
			UPDATE cs
			SET cs.MinBet = CASE WHEN cs.MinBet > b.MinBet THEN b.MinBet ELSE cs.MinBet END, 
				cs.MaxBet = CASE WHEN cs.MaxBet > b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END,
				cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > b.MaxPerMatch THEN b.MaxPerMatch ELSE cs.MaxPerMatch END		
			FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
				INNER JOIN @BetSetting b ON cs.sporttype = b.sporttype
			WHERE custid IN (SELECT custid FROM @BatchMember WHERE roleid > 1)
				AND b.sporttype IN (180,--Virtual soccer
									181	,--	Virtual Horse Racing
				                    182	,--	Virtual Greyhounds
				                    183	,--	Virtual Speedway
				                    184	,--	Virtual Motorsports
				                    185	,--	Virtual Cycling
				                    186	,--	Virtual Tennis
				                    190	,--	Virtual Soccer League
				                    191	,--	Virtual Soccer Nation
				                    192	,--	Virtual Soccer World Cup
				                    193	,--	Virtual Basketball
				                    199	,--	Virtual Sports Parlay									
									220	,--	Lottery
									222	,--	Table Game
									224	--	RNG War	
								)
				AND (cs.MinBet > b.MinBet 
					OR cs.MaxBet > b.MaxBet				
					OR cs.MaxPerMatch > b.MaxPerMatch
					)
		END

		IF EXISTS(SELECT 1 FROM @BatchMember WHERE roleid = 1)	
		BEGIN
			--Loss Limit
			UPDATE cs 
			SET cs.MaxLossLimit = l.LossLimit
			FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
				INNER JOIN @LossLimitSetting l ON cs.sporttype = l.sporttype
			WHERE cs.custid IN (SELECT custid FROM @BatchMember WHERE roleid = 1)				
				AND cs.MaxLossLimit > l.LossLimit
			
			--Bet setting
			UPDATE cs
			SET cs.MinBet = CASE WHEN cs.MinBet > b.MinBet THEN b.MinBet ELSE cs.MinBet END, 
				cs.MaxBet = CASE WHEN cs.MaxBet > b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END,
				cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > b.MaxPerMatch THEN b.MaxPerMatch ELSE cs.MaxPerMatch END		
			FROM CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
				INNER JOIN @BetSetting b ON cs.sporttype = b.sporttype
			WHERE custid IN (SELECT custid FROM @BatchMember WHERE roleid = 1)
				AND b.sporttype IN (180,--Virtual soccer
									181	,--	Virtual Horse Racing
				                    182	,--	Virtual Greyhounds
				                    183	,--	Virtual Speedway
				                    184	,--	Virtual Motorsports
				                    185	,--	Virtual Cycling
				                    186	,--	Virtual Tennis
				                    190	,--	Virtual Soccer League
				                    191	,--	Virtual Soccer Nation
				                    192	,--	Virtual Soccer World Cup
				                    193	,--	Virtual Basketball
				                    199	,--	Virtual Sports Parlay									
									220	,--	Lottery
									222	,--	Table Game
									224	--	RNG War	
								)
				AND (cs.MinBet > b.MinBet 
					OR cs.MaxBet > b.MaxBet				
					OR cs.MaxPerMatch > b.MaxPerMatch
					)
		END
		
		--RnG Keno
		UPDATE cs
		SET cs.MinBet = CASE WHEN cs.MinBet > b.MinBet THEN b.MinBet ELSE cs.MinBet END, 
			cs.MaxBet = CASE WHEN cs.MaxBet > b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerGameType = CASE WHEN cs.MaxPerGameType > b.MaxPerMatch THEN b.MaxPerMatch ELSE cs.MaxPerGameType END
		FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)
			CROSS APPLY (SELECT * FROM @BetSetting WHERE sporttype = 202 )b 
		WHERE custid IN (SELECT custid FROM @BatchMember)
			AND cs.GameTypeID BETWEEN 1 AND 26			
			AND (cs.MinBet > b.MinBet 
				OR cs.MaxBet > b.MaxBet
				OR cs.MaxPerGameType > b.MaxPerMatch
				)
		
		--NG, Happy 5
		UPDATE cs
		SET cs.MinBet = CASE WHEN cs.MinBet > b.MinBet THEN b.MinBet ELSE cs.MinBet END, 
			cs.MaxBet = CASE WHEN cs.MaxBet > b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END			
		FROM CustSetting3rd cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @BetSetting b ON cs.sporttype = b.sporttype
		WHERE custid IN (SELECT custid FROM @BatchMember)
			AND b.sporttype IN (161,164)
			AND (cs.MinBet > b.MinBet 
				OR cs.MaxBet > b.MaxBet				
				)
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @custid INT,
		@UpdateMinPTNonSport BIT,
		@isSpecial BIT,
		@maxcustid INT = xxx

CREATE TABLE #Supers(CustID INT, UpdateMinPTNonSport BIT DEFAULT 0, isSpecial BIT DEFAULT 0, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid)
SELECT custid
FROM vw_customer WITH(NOLOCK)
WHERE currency = 67
	AND roleid = 4
	AND site IN ('733333','222223','722222')

--update MinPT for all NonSports normal list	
UPDATE s
SET UpdateMinPTNonSport = 1 
FROM #supers s 
	INNER JOIN vw_customer c WITH(NOLOCK) ON s.custid = c.custid
WHERE username IN (
'S3H','S3HH','SSF5H','S3HK','S3HJ','S3HM','S3HA','S32RMB','S32H','S32BH','S32CH','S32DH','S32EH','S32HH','S32HKD','S32KH','S32LH','S32MH','S32NH','S32PH','S32QH','S32E','SBKHK','SBKH','SMBH','SMORMB','SMOL','SMON','SMOP','SMOQ','SMOT','SMOR','SMOS','SMOA','SMOB','SMOC','SMOE','SMOU','SMOF','SMORA','MOA','MOB','SMOKH','SMOV','SMOI','SMOX','SMODH','SMOEH','SMOFH','SMOGH','SMOJH','MOY','MOE','S188HL','SV','S188HJ','S553H','S668H','SBHK','S305CRMB','S31RMB','S31ARMB','SSFH','SSF2H','S3HP','SSF6H','SSF7H','S2R','S222H','S222HK','S222AH','S222BH','S222CH','S222DH','2EH','S222FH','S222GH','2KH','S222MH','S222NH','2AH','2BH','2CH','2DH','2LH','2MH','2NH','2PH','2YH','2FH','2GH','2WH','S222JH','2HH','S222X','2HK','2XX','2WW','2RH','2IH','2QH','2OH','2SH','2AA','2UH','2HB','2VH','YSL','ADD','1JS','1JZ','NSN','YS8','SAKH','MK1','MK2','MK3','MK5','MK6','MK4C','TH7','MK8','MK9','MK10','MK11C','MK12','MK17','MK19','MK21','MK16','TH25','TH26','MK23','JC1','JC7','JC2','JC6','JC9','MK27','TH28','TH29','JC10','TH89','MK31','JC82','GAX','MK32','JC83','AK1','MK33','MK35','MK36','TH3','82H','SRHKA','SRJ','SRKH','SRHH','SRHD','SRQ','SRHC','SMQARMB','S99H','S99ah','S99HK','S99HKK','S99HKD','S99MHK','S99HA','S99HD','SAK','S99HHK','SWH','SWAH','SWHH','SWSH','WN','WT','SWB','SWC','SWD','SWE','SWF','SWG','SWI','SWJ','SWN','SWP','SWQ','SWR','SWX','WTT','WTB','WTC','WTD','WTE','WTF','WTG','RRA','WTK','KJH','KJD','KJE','KJC','GEH','GFH','DJA','DJB','DJC','DJ27','D27','DJF','SNG','DAP','PPH','SYLHK','SYLH','SYLHZ','SYLG','SYCN','SSK','SSKA','SSKB','SSKC','SSKK','SBTM','SBTH','SBTK','LHH','LHH2','LHH3','LHH7','LHH8','LHH9','LHH10','LHH12','LHA','LHB','LHJ','LHH15','S359BH','S359CH','S359HH','SLO','SLL','SLE','SLV','ALH','ALB','ALC','ALD','ALK','ALF','ALG','ALL','ALJ','ALE','ALN','ALP','ALQ','ALT','ALS','ALU','ALV','ALW','ALX','AL4','ALZ','AL1','AL3','AL2','AL5','AL6','AL7','LGH1','AL9','ALH1','ALH2','ALH3','ALH4','ALH5','ALH6','ALH7','ALH8','ALH9','ALHA','ALHB','ALHC','ALHD','ALHE','ALHF','ALHG','AG1','AG9','L1','L2','L3','L4','L5','L6','L9','L10','L11','AL10','JS','JS1','JS3','JS5','JS6','JS7','JSA','JSC','JSD','SYSHK','JSF','JSK','JSL','JSM','JSZ','SHG','JSU','JSV','JSW','JSX','JSY','JSO','JSI','JHA','JHB','JHC','JHD','SOP','TH','TF','TC','TZ','TL','TLM','TLN','D71','C1','C5','C7','TLH','C8','C9','C10','C11','C13','C15','H9','H1','JK6','C6','H2','H3','HZ','H5','CV','9H','1C','EPL','MMS','H8','S1','S2','S3','S6','S7','S9','S11','SR','CM','ZS','A6','R8','A2','A3','A5','US','J1','ZJ','CQ','A7','A9','C17','WK','WQ','Y1','DS','SX','CZ','C18','VKH','VKB','KKH','KKY','KKG','KKK','KKR','KAB','KGK','KGL','KGM','KGN','SRS','KAD','KBA','KBB','KBC','KBD','KBE','KAG','KAH','KAJ','KAK','KBG','KBH','KBJ','KBK','KBU','KBV','KBW','KAI','KAL','KAN','KAQ','KAS','KAU','KGQ','KGR','KBX','KBY','KK1','S56','KGF','KBZ','KCC','BPH','EEH','EEK','EEB','EEC','EEE','HG9','HG8','HG7','HG6','HG88','HG101','HG102','HG71','HG81','HG29','HA8','H39','H7','HG3','HG5','YK','HJUN','P2','L7','J3','P3','L8','Y2','K3','K33','HGC','D77','D78','D79','D80','D81','D82','D83','D85','D99','D66','BB1','D96','BB9','BB19','BB3','BB2','BB5','D91','D19','BB82','BB8','D18','BB63','BB6','D55','D56','D98','AK9','KW19','DB1','D97','VVY','VCY','VBY','VDY','VEY','VFY','VGY','VHY','VHJ','VHK','VJY','NBY','VKY','VAA','VMY','RG1','RG2','RG3','RG5','RG7','RG9','RG11','RG12','RG13','RGG','RG17','RG18','RG19','RG20','RGC','RG21','RG22','RG23','RG25','RG26','RG27','RG30','RG31','RG32','MG5','MG6','RG33','RG36','RG37','RG38','RG39','RG50','RG51','RG52','RG55','RG56','RG57','RG58','RG59','RG60','RG61','RG62','RG63','RG65','RG66','RG67','RG68','RG69','RG70','RG71','RG72','RG75','RG76','RG77','RG78','RG79','RG81','RM2','RG82','RM11','RG83','RG85','RG88','RG89','RG90','RG91','RM12','TS2','TS6','TS12','Y77','T88','HANN','M996','BCH','S42CH','DS2','DS3','DS5','DS6','DS7','DS8','DS9','DS10','DS11','DS12','DS13','DS15','DS16','DS17','DS18','DS19','DS20','DS27','DS21','DS22','DS23','DS25','DS26','DS30','DS31','DS32','DS33','DS35','DS28','DS36','DS38','DS37','DS39','CS01','DS50','DS51','DS53','CS06','S89','DS55','MEB','JBK','JBN','JBA','LWW','AIK','QWB','BAG','BAJ','BAP','801H','802H','802AH','801AH','801BH','801CH','801DH','801HK','801Z','803H','805H','806H','807H','808H','801SH','801W','SG33Z','801Q','SG33M','801F','801G','801J','801N','EE89','801TH','801L','GG69','802CH','WP11','WP12','WP15','WRX','TTH','PDK',
,'S56EH','S56GH','S56NH','S56PH','S56QH','S56SH','S56AA','S56UH','HKD','HK01','HK03','HK07','HK10','HK11','HK12','HK13','HK15','HK16','HK17','HK18','HK19','HK21','HK22','HK25','HK26','HK27','HK31','HK33','HK34','HK36','HK50','HK51','HK52','JYT','JYG','JYU','JYK','YYL',
,'HPP','HPO','HPU','HPV','HPQ','HPY','HPR','SX3','SZZ','SX5','SX6','SX8','HP3','SX9','HSS','SX10','SX11','DJA','DJB','DJC','DJ27','D27','DJF','SNG','DAP'
,'SGH','SG2H','SG8H','SG10H','SG16H','SG17H','SG25H','SG27H','sg29h','SG37H','SG38H','SG39H','SG41H','SG47H','SG48H','SG50H ','SG51H ','SG4H','SG7H','SG15H','SG21H','SG9H','SG31H','SG32H','SG33H','SG36H','SG40H','SG43H','SG45H','SG46H','SG6H','SG49H','SG1H','AHO','BHO','AHP','AHR','AHE','AHF','AHC','BHS','AHX','AKK','DDD','DDA','GM1','DDB','GM2','GMG','BKK','GMM','GAA','GBB','GCC'
)

--special list
UPDATE s
SET UpdateMinPTNonSport = 1,
	isSpecial = 1
FROM #supers s 
	INNER JOIN vw_customer c WITH(NOLOCK) ON s.custid = c.custid
WHERE username IN (
'S359HK','HG','HDQ','DAB','DAC','DAF','S359HL','DAH','DAQ','S42H','S42AH','YH','S42EH','PAA','SBH','MYM','SSF','SBHF','SBHG','SSG','S2H','S2HH','S2HY','JMC','S555','S666','S777','QQKR','QQKA','QQKU','QQBS','QQKT','QQKS','QQKV','QQQ1','QQQ3','QQMM','QQQ2','QQKL','QQQ5','Q622','QQ92','PPS','PPJ','PPN','PPQ','PPZ','PPP','PPA','PPT','PPU','PPV','PPD','PPE','PPX','PPK','PPC','PPF'
)
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #Supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@custid = custid	
		,@UpdateMinPTNonSport = UpdateMinPTNonSport
		,@isSpecial = isSpecial
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting_19] 
			@custid = @custid, 
			@UpdateMinPTNonSport = @UpdateMinPTNonSport,
			@isSpecial = @isSpecial,
			@maxcustid = @maxcustid,			
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------	
	

---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
DECLARE @custid INT,
		@UpdateMinPTNonSport BIT,
		@isSpecial BIT,
		@maxcustid INT = xxx

CREATE TABLE #Supers(CustID INT, UpdateMinPTNonSport BIT DEFAULT 0, isSpecial BIT DEFAULT 0, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid)
SELECT custid
FROM vw_customer WITH(NOLOCK)
WHERE currency = 67
	AND roleid = 4
	AND site IN ('733333','222223','722222')

--update MinPT for all NonSports normal list	
UPDATE s
SET UpdateMinPTNonSport = 1 
FROM #supers s 
	INNER JOIN vw_customer c WITH(NOLOCK) ON s.custid = c.custid
WHERE username IN (
'S3H','S3HH','SSF5H','S3HK','S3HJ','S3HM','S3HA','S32RMB','S32H','S32BH','S32CH','S32DH','S32EH','S32HH','S32HKD','S32KH','S32LH','S32MH','S32NH','S32PH','S32QH','S32E','SBKHK','SBKH','SMBH','SMORMB','SMOL','SMON','SMOP','SMOQ','SMOT','SMOR','SMOS','SMOA','SMOB','SMOC','SMOE','SMOU','SMOF','SMORA','MOA','MOB','SMOKH','SMOV','SMOI','SMOX','SMODH','SMOEH','SMOFH','SMOGH','SMOJH','MOY','MOE','S188HL','SV','S188HJ','S553H','S668H','SBHK','S305CRMB','S31RMB','S31ARMB','SSFH','SSF2H','S3HP','SSF6H','SSF7H','S2R','S222H','S222HK','S222AH','S222BH','S222CH','S222DH','2EH','S222FH','S222GH','2KH','S222MH','S222NH','2AH','2BH','2CH','2DH','2LH','2MH','2NH','2PH','2YH','2FH','2GH','2WH','S222JH','2HH','S222X','2HK','2XX','2WW','2RH','2IH','2QH','2OH','2SH','2AA','2UH','2HB','2VH','YSL','ADD','1JS','1JZ','NSN','YS8','SAKH','MK1','MK2','MK3','MK5','MK6','MK4C','TH7','MK8','MK9','MK10','MK11C','MK12','MK17','MK19','MK21','MK16','TH25','TH26','MK23','JC1','JC7','JC2','JC6','JC9','MK27','TH28','TH29','JC10','TH89','MK31','JC82','GAX','MK32','JC83','AK1','MK33','MK35','MK36','TH3','82H','SRHKA','SRJ','SRKH','SRHH','SRHD','SRQ','SRHC','SMQARMB','S99H','S99ah','S99HK','S99HKK','S99HKD','S99MHK','S99HA','S99HD','SAK','S99HHK','SWH','SWAH','SWHH','SWSH','WN','WT','SWB','SWC','SWD','SWE','SWF','SWG','SWI','SWJ','SWN','SWP','SWQ','SWR','SWX','WTT','WTB','WTC','WTD','WTE','WTF','WTG','RRA','WTK','KJH','KJD','KJE','KJC','GEH','GFH','DJA','DJB','DJC','DJ27','D27','DJF','SNG','DAP','PPH','SYLHK','SYLH','SYLHZ','SYLG','SYCN','SSK','SSKA','SSKB','SSKC','SSKK','SBTM','SBTH','SBTK','LHH','LHH2','LHH3','LHH7','LHH8','LHH9','LHH10','LHH12','LHA','LHB','LHJ','LHH15','S359BH','S359CH','S359HH','SLO','SLL','SLE','SLV','ALH','ALB','ALC','ALD','ALK','ALF','ALG','ALL','ALJ','ALE','ALN','ALP','ALQ','ALT','ALS','ALU','ALV','ALW','ALX','AL4','ALZ','AL1','AL3','AL2','AL5','AL6','AL7','LGH1','AL9','ALH1','ALH2','ALH3','ALH4','ALH5','ALH6','ALH7','ALH8','ALH9','ALHA','ALHB','ALHC','ALHD','ALHE','ALHF','ALHG','AG1','AG9','L1','L2','L3','L4','L5','L6','L9','L10','L11','AL10','JS','JS1','JS3','JS5','JS6','JS7','JSA','JSC','JSD','SYSHK','JSF','JSK','JSL','JSM','JSZ','SHG','JSU','JSV','JSW','JSX','JSY','JSO','JSI','JHA','JHB','JHC','JHD','SOP','TH','TF','TC','TZ','TL','TLM','TLN','D71','C1','C5','C7','TLH','C8','C9','C10','C11','C13','C15','H9','H1','JK6','C6','H2','H3','HZ','H5','CV','9H','1C','EPL','MMS','H8','S1','S2','S3','S6','S7','S9','S11','SR','CM','ZS','A6','R8','A2','A3','A5','US','J1','ZJ','CQ','A7','A9','C17','WK','WQ','Y1','DS','SX','CZ','C18','VKH','VKB','KKH','KKY','KKG','KKK','KKR','KAB','KGK','KGL','KGM','KGN','SRS','KAD','KBA','KBB','KBC','KBD','KBE','KAG','KAH','KAJ','KAK','KBG','KBH','KBJ','KBK','KBU','KBV','KBW','KAI','KAL','KAN','KAQ','KAS','KAU','KGQ','KGR','KBX','KBY','KK1','S56','KGF','KBZ','KCC','BPH','EEH','EEK','EEB','EEC','EEE','HG9','HG8','HG7','HG6','HG88','HG101','HG102','HG71','HG81','HG29','HA8','H39','H7','HG3','HG5','YK','HJUN','P2','L7','J3','P3','L8','Y2','K3','K33','HGC','D77','D78','D79','D80','D81','D82','D83','D85','D99','D66','BB1','D96','BB9','BB19','BB3','BB2','BB5','D91','D19','BB82','BB8','D18','BB63','BB6','D55','D56','D98','AK9','KW19','DB1','D97','VVY','VCY','VBY','VDY','VEY','VFY','VGY','VHY','VHJ','VHK','VJY','NBY','VKY','VAA','VMY','RG1','RG2','RG3','RG5','RG7','RG9','RG11','RG12','RG13','RGG','RG17','RG18','RG19','RG20','RGC','RG21','RG22','RG23','RG25','RG26','RG27','RG30','RG31','RG32','MG5','MG6','RG33','RG36','RG37','RG38','RG39','RG50','RG51','RG52','RG55','RG56','RG57','RG58','RG59','RG60','RG61','RG62','RG63','RG65','RG66','RG67','RG68','RG69','RG70','RG71','RG72','RG75','RG76','RG77','RG78','RG79','RG81','RM2','RG82','RM11','RG83','RG85','RG88','RG89','RG90','RG91','RM12','TS2','TS6','TS12','Y77','T88','HANN','M996','BCH','S42CH','DS2','DS3','DS5','DS6','DS7','DS8','DS9','DS10','DS11','DS12','DS13','DS15','DS16','DS17','DS18','DS19','DS20','DS27','DS21','DS22','DS23','DS25','DS26','DS30','DS31','DS32','DS33','DS35','DS28','DS36','DS38','DS37','DS39','CS01','DS50','DS51','DS53','CS06','S89','DS55','MEB','JBK','JBN','JBA','LWW','AIK','QWB','BAG','BAJ','BAP','801H','802H','802AH','801AH','801BH','801CH','801DH','801HK','801Z','803H','805H','806H','807H','808H','801SH','801W','SG33Z','801Q','SG33M','801F','801G','801J','801N','EE89','801TH','801L','GG69','802CH','WP11','WP12','WP15','WRX','TTH','PDK',
,'S56EH','S56GH','S56NH','S56PH','S56QH','S56SH','S56AA','S56UH','HKD','HK01','HK03','HK07','HK10','HK11','HK12','HK13','HK15','HK16','HK17','HK18','HK19','HK21','HK22','HK25','HK26','HK27','HK31','HK33','HK34','HK36','HK50','HK51','HK52','JYT','JYG','JYU','JYK','YYL',
,'HPP','HPO','HPU','HPV','HPQ','HPY','HPR','SX3','SZZ','SX5','SX6','SX8','HP3','SX9','HSS','SX10','SX11','DJA','DJB','DJC','DJ27','D27','DJF','SNG','DAP'
,'SGH','SG2H','SG8H','SG10H','SG16H','SG17H','SG25H','SG27H','sg29h','SG37H','SG38H','SG39H','SG41H','SG47H','SG48H','SG50H ','SG51H ','SG4H','SG7H','SG15H','SG21H','SG9H','SG31H','SG32H','SG33H','SG36H','SG40H','SG43H','SG45H','SG46H','SG6H','SG49H','SG1H','AHO','BHO','AHP','AHR','AHE','AHF','AHC','BHS','AHX','AKK','DDD','DDA','GM1','DDB','GM2','GMG','BKK','GMM','GAA','GBB','GCC'
)

--special list
UPDATE s
SET UpdateMinPTNonSport = 1,
	isSpecial = 1
FROM #supers s 
	INNER JOIN vw_customer c WITH(NOLOCK) ON s.custid = c.custid
WHERE username IN (
'S359HK','HG','HDQ','DAB','DAC','DAF','S359HL','DAH','DAQ','S42H','S42AH','YH','S42EH','PAA','SBH','MYM','SSF','SBHF','SBHG','SSG','S2H','S2HH','S2HY','JMC','S555','S666','S777','QQKR','QQKA','QQKU','QQBS','QQKT','QQKS','QQKV','QQQ1','QQQ3','QQMM','QQQ2','QQKL','QQQ5','Q622','QQ92','PPS','PPJ','PPN','PPQ','PPZ','PPP','PPA','PPT','PPU','PPV','PPD','PPE','PPX','PPK','PPC','PPF'
)
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #Supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@custid = custid	
		,@UpdateMinPTNonSport = UpdateMinPTNonSport
		,@isSpecial = isSpecial
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting_19] 
			@custid = @custid, 
			@UpdateMinPTNonSport = @UpdateMinPTNonSport,
			@isSpecial = @isSpecial,
			@maxcustid = @maxcustid,			
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
-----------------------------------------------------------------------------------	
	


	

