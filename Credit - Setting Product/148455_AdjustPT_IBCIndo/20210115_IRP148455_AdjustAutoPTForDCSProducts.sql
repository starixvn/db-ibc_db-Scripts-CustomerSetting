/*
	Created: 20210114@Johnson
	Task: update AutoPT for masters under IBCIndo for GoldDeluxe
	DB: DBCUST/CustDB	
*/
CREATE TABLE #Supers (custid INT PRIMARY KEY)
CREATE TABLE #Masters (custid INT PRIMARY KEY, srecommend INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblCustPT (custid INT, sporttype INT, bettype INT, isLive BIT, MaxPT SMALLMONEY, PRIMARY KEY (custid,sporttype,bettype,isLive))

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

INSERT INTO #tblCustPT(custid,sporttype,bettype,isLive,MaxPT)	
SELECT DISTINCT m.custid , cs.sporttype, cs.bettype, cs.isLive, scs.SuperPT as MaxPT
FROM CustPTSetting3rd_Agent cs WITH(NOLOCK)											
	INNER JOIN #Masters m on m.custid = cs.custid											
	INNER JOIN #Supers su on su.custid = m.srecommend											
	INNER JOIN CustPTSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = su.custid 
														AND scs.SportType = cs.SportType 
														AND scs.BetType = cs.BetType 
														AND scs.IsLive = cs.IsLive												
WHERE (cs.IsAutoSuperPT = 0 
	OR (cs.IsAutoSuperPT =1 AND cs.AutoSuperPT < scs.SuperPT )
	)											
	AND cs.sporttype NOT IN ( 43 ,44 ) --SB2											


DELETE #Masters
WHERE custid NOT IN (SELECT DISTINCT custid FROM #tblCustPT)

DECLARE @AutoPT		VARCHAR(MAX),
		@PT			VARCHAR(MAX),
		@srecommend INT,
		@custid 	INT

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
	
	SET @PT = (
			SELECT cs.sporttype AS '@SportType'
				,cs.bettype AS '@BetType'
				,cs.isLive AS '@IsLive'							
			FROM #tblCustPT	cs			
			WHERE custid = @custid 				
			FOR XML PATH('PT'), ROOT('ROOT')
		 )	
	
	SET @AutoPT =(
			SELECT cs.sporttype AS '@SportType'
				,cs.bettype AS '@BetType'
				,cs.isLive AS '@IsLive'			
				,1 AS '@IsAuto_New'
				,1 AS '@IsAuto_Old'--dont apply UpdAllMems_Value	
				,0 AS '@IsUpdAllMems'
				,0 AS '@UpdAllMems_Value'
			FROM #tblCustPT	cs			
			WHERE custid = @custid 				
			FOR XML PATH('PT'), ROOT('ROOT')
		 )	
	
	UPDATE cs
	SET SuperPT = 0,
		isAutoSuperPT = 1,
		AutoSuperPT = t.MaxPT
	FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCustPT t ON cs.custid = t.custid
								AND cs.sporttype = t.sporttype
								AND cs.bettype = t.bettype
	WHERE cs.custid = @custid
				
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

