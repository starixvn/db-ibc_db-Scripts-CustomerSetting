/*
	Created: 20210114@Johnson
	Task: update AutoPT for masters under IBCIndo for GoldDeluxe
	DB: DBCUST/CustDB	
*/
CREATE TABLE #Supers (custid INT PRIMARY KEY)
CREATE TABLE #Masters (custid INT PRIMARY KEY, srecommend INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblCustPT (custid INT, sporttype INT, bettype INT, MaxPT SMALLMONEY, isFinished BIT DEFAULT 0 PRIMARY KEY (custid,sporttype,bettype))

INSERT INTO #Supers(custid)		
SELECT c.custid
FROM vw_customer c WITH (NOLOCK)			
	INNER JOIN CustSuper cs WITH (NOLOCK) ON cs.custid = c.custid			
WHERE roleid = 4			
	AND c.site= 'IBCINDO'			
	AND currency <> 20			
	AND IsInternal = 0			
			
INSERT INTO #Masters(custid,srecommend)
SELECT c.custid, c.srecommend 			
FROM vw_customer c WITH (NOLOCK)			
	INNER JOIN custInfo cu WITH (NOLOCK) ON cu.custid = c.custid			
	INNER JOIN #Supers s on s.custid = c.srecommend			
WHERE c.roleid= 3			
	AND cu.Enabled= 1			

INSERT INTO #tblCustPT(custid,sporttype,bettype,MaxPT)	
SELECT DISTINCT m.custid , cs.sporttype, cs.bettype, scs.spositiontaking as MaxPT
FROM CustSettingGame cs WITH (NOLOCK)											
	INNER JOIN #Masters m on m.custid = cs.custid											
	INNER JOIN #Supers su on su.custid = m.srecommend											
	INNER JOIN CustSettingGame scs WITH (NOLOCK) ON scs.custid = su.custid 
													AND scs.SportType = cs.SportType 
													AND scs.BetType = cs.BetType												
WHERE (cs.isautopositiontaking= 0 
	OR (cs.isautopositiontaking =1 
		AND cs.autopositiontaking < scs.spositiontaking 
		)
	)	
	AND cs.sporttype IN (255,202)

DELETE #Masters
WHERE custid NOT IN (SELECT DISTINCT custid FROM #tblCustPT)

DECLARE @custid INT,
		@srecommend INT,
		@sporttype INT,
		@bettype INT,
		@MaxPT SMALLMONEY


-- For deployer info
DECLARE @master_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, MasterID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Masters: %d.'

SET @master_cnt = (SELECT COUNT(*) FROM #Masters )
RAISERROR (@msg_total, 0, 1, @master_cnt) WITH NOWAIT
		
WHILE(1=1)
BEGIN
	UPDATE TOP (1) t
	SET isFinished = 1,
		@custid = custid,
		@srecommend = srecommend
	FROM #Masters t
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @custid) WITH NOWAIT
	
	WHILE(1=1)
	BEGIN
		UPDATE TOP(1) t
		SET @sporttype = sporttype,
			@bettype = bettype,
			@MaxPT = MaxPT,
			isFinished = 1
		FROM #tblCustPT t
		WHERE isFinished = 0
			AND custid = @custid
			
		IF @@ROWCOUNT = 0 
			BREAK;
		
		IF @sporttype = 255
		BEGIN
			UPDATE cs
			SET spositiontaking = 0,
				isautopositiontaking = 1,
				autopositiontaking = @MaxPT
			FROM CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
			WHERE custid = @custid
				AND sporttype = 255
				
			EXEC dbo.Acc_CustSetting3rd_05
					@srecommend = @srecommend,
					@mrecommend = @custid,
					@roleid = 3,
					@mode = 'GoldDeluxe',
					
					@isauto_v255spositiontaking_1701 = 1,
					@old_isauto_v255spositiontaking_1701 = 1,
					
					@auto_v255spositiontaking_1701 = @MaxPT, 
					
					@Updateallmembers = 0,
					@newspositiontaking = 0
					
			EXEC dbo.Acc_CustSetting3rd_07
					@srecommend = @srecommend,
					@mrecommend = @custid,
					@roleid = 3,
					@mode = 'GoldDeluxe',
					@sporttype = 255,
					@bettype = 1701
		END
		ELSE IF @SportType = 202
		BEGIN
			UPDATE cs
			SET cs.spositiontaking = 0,
				cs.isautopositiontaking = 1,
				cs.autopositiontaking = @MaxPT
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
				, @Old_IsAuto_KenoSPositionTaking = 1--dont apply @newspositiontaking
				, @Auto_KenoSPositionTaking = @MaxPT
			
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
		
		WAITFOR DELAY '00:00:0.28'	
	END		
END	

