/*
	Created: 20210114@Johnson
	Task: update AutoPT for masters under IBCIndo for GoldDeluxe
	DB: DBCUST/CustDB	
*/


CREATE TABLE #Supers (custid INT PRIMARY KEY)
CREATE TABLE #Masters (custid INT PRIMARY KEY, srecommend INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblCustPT (custid INT, sporttype INT, bettype INT, MaxPT SMALLMONEY, MaxLivePT SMALLMONEY DEFAULT 0 PRIMARY KEY (custid,sporttype,bettype))

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

INSERT INTO #tblCustPT(custid,sporttype,bettype,MaxPT, MaxLivePT)	
SELECT DISTINCT m.custid , cs.sporttype, cs.bettype, scs.spositiontaking as MaxPT, scs.slivepositiontaking as MaxLivePT
FROM CustSetting3rd  cs WITH(NOLOCK)													
	INNER JOIN #Masters m ON m.custid = cs.custid													
	INNER JOIN #supers su ON su.custid = m.srecommend													
	INNER JOIN CustSetting3rd scs WITH(NOLOCK) ON scs.custid = su.custid 
												AND scs.SportType = cs.SportType 
												AND scs.BetType = cs.BetType														
WHERE ((1 = CASE WHEN cs.bettype IN ( 81, 83 ,86 , 88) AND cs.isautopositiontaking = 0 THEN 1
				WHEN cs.bettype IN ( 85, 86 ,87 , 89, 90 ) AND cs.isautolivepositiontaking = 0 THEN 1 ELSE 0 END
			)													
	OR ( 1 = CASE WHEN (cs.bettype IN (81 , 83, 86 ,88 ) AND cs.isautopositiontaking = 1 AND cs.autopositiontaking < scs.spositiontaking)
					OR (cs.bettype IN ( 85, 86 ,87 , 89, 90 ) AND cs.isautolivepositiontaking = 1 AND cs.autolivepositiontaking < scs.slivepositiontaking) THEN 1 ELSE 0 END
		)	
	)		
	AND cs.sporttype = 161


DELETE #Masters
WHERE custid NOT IN (SELECT DISTINCT custid FROM #tblCustPT)

DECLARE @custid INT,
		@srecommend INT
		
-- For deployer info
DECLARE @master_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, MasterID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Masters: %d.'

DECLARE @auto_v161spositiontaking_81 SMALLMONEY,
		@auto_v161spositiontaking_83 SMALLMONEY, 
		@auto_v161spositiontaking_86 SMALLMONEY,
		@auto_v161spositiontaking_88 SMALLMONEY,
		
		@auto_v161slivepositiontaking_85 SMALLMONEY,
		@auto_v161slivepositiontaking_86 SMALLMONEY,
		@auto_v161slivepositiontaking_87 SMALLMONEY,
		@auto_v161slivepositiontaking_89 SMALLMONEY,
		@auto_v161slivepositiontaking_90 SMALLMONEY,
		
		@old_auto_v161spositiontaking_81 SMALLMONEY,
		@old_auto_v161spositiontaking_83 SMALLMONEY, 
		@old_auto_v161spositiontaking_86 SMALLMONEY,
		@old_auto_v161spositiontaking_88 SMALLMONEY,
		
		@old_auto_v161slivepositiontaking_85 SMALLMONEY,
		@old_auto_v161slivepositiontaking_86 SMALLMONEY,
		@old_auto_v161slivepositiontaking_87 SMALLMONEY,
		@old_auto_v161slivepositiontaking_89 SMALLMONEY,
		@old_auto_v161slivepositiontaking_90 SMALLMONEY
		

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
	
	select     @old_auto_v161spositiontaking_81    =    autopositiontaking, @auto_v161spositiontaking_81    =    autopositiontaking from custsetting3rd with (nolock) where custid = @custid and sporttype=161    and bettype=    81
	select     @old_auto_v161spositiontaking_83    =    autopositiontaking, @auto_v161spositiontaking_83    =    autopositiontaking from custsetting3rd with (nolock) where custid = @custid and sporttype=161    and bettype=    83
	select     @old_auto_v161spositiontaking_86    =    autopositiontaking, @auto_v161spositiontaking_86    =    autopositiontaking from custsetting3rd with (nolock) where custid = @custid and sporttype=161    and bettype=    86
	select     @old_auto_v161spositiontaking_88    =    autopositiontaking, @auto_v161spositiontaking_88    =    autopositiontaking from custsetting3rd with (nolock) where custid = @custid and sporttype=161    and bettype=    88
	select     @old_auto_v161slivepositiontaking_85    =    autolivepositiontaking, @auto_v161slivepositiontaking_85    =    autolivepositiontaking from custsetting3rd with (nolock) where custid = @custid and sporttype =    161    and bettype=    85
	select     @old_auto_v161slivepositiontaking_86    =    autolivepositiontaking, @auto_v161slivepositiontaking_86    =    autolivepositiontaking from custsetting3rd with (nolock) where custid = @custid and sporttype =    161    and bettype=    86
	select     @old_auto_v161slivepositiontaking_87    =    autolivepositiontaking, @auto_v161slivepositiontaking_87    =    autolivepositiontaking from custsetting3rd with (nolock) where custid = @custid and sporttype =    161    and bettype=    87
	select     @old_auto_v161slivepositiontaking_89    =    autolivepositiontaking, @auto_v161slivepositiontaking_89    =    autolivepositiontaking from custsetting3rd with (nolock) where custid = @custid and sporttype =    161    and bettype=    89
	select     @old_auto_v161slivepositiontaking_90    =    autolivepositiontaking, @auto_v161slivepositiontaking_90    =    autolivepositiontaking from custsetting3rd with (nolock) where custid = @custid and sporttype =    161    and bettype=    90

	--get new autopt value 
	select     @auto_v161spositiontaking_81    =    MaxPT from #tblCustPT where custid = @custid and sporttype=161    and bettype=    81
	select     @auto_v161spositiontaking_83    =    MaxPT from #tblCustPT where custid = @custid and sporttype=161    and bettype=    83
	select     @auto_v161spositiontaking_86    =    MaxPT from #tblCustPT where custid = @custid and sporttype=161    and bettype=    86
	select     @auto_v161spositiontaking_88    =    MaxPT from #tblCustPT where custid = @custid and sporttype=161    and bettype=    88
	select     @auto_v161slivepositiontaking_85    =    MaxLivePT from #tblCustPT where custid = @custid and sporttype =    161    and bettype=    85
	select     @auto_v161slivepositiontaking_86    =    MaxLivePT from #tblCustPT where custid = @custid and sporttype =    161    and bettype=    86
	select     @auto_v161slivepositiontaking_87    =    MaxLivePT from #tblCustPT where custid = @custid and sporttype =    161    and bettype=    87
	select     @auto_v161slivepositiontaking_89    =    MaxLivePT from #tblCustPT where custid = @custid and sporttype =    161    and bettype=    89
	select     @auto_v161slivepositiontaking_90    =    MaxLivePT from #tblCustPT where custid = @custid and sporttype =    161    and bettype=    90
	
	UPDATE cs
	SET spositiontaking = CASE WHEN cs.bettype IN ( 81, 83 ,86 , 88) THEN 0 ELSE spositiontaking END,
		isautopositiontaking = CASE WHEN cs.bettype IN ( 81, 83 ,86 , 88) THEN 1 ELSE 0 END,
		autopositiontaking = CASE WHEN cs.bettype IN ( 81, 83 ,86 , 88) THEN MaxPT ELSE autopositiontaking END,
		
		slivepositiontaking = CASE WHEN cs.bettype IN ( 85, 86 ,87 , 89, 90 ) THEN 0 ELSE slivepositiontaking END,
		isautolivepositiontaking = CASE WHEN cs.bettype IN ( 85, 86 ,87 , 89, 90 ) THEN 1 ELSE 0 END,
		autolivepositiontaking = CASE WHEN cs.bettype IN ( 85, 86 ,87 , 89, 90 ) THEN MaxLivePT ELSE autolivepositiontaking END		
	FROM custsetting3rd cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCustPT t ON cs.custid = t.custid
								AND cs.sporttype = t.sporttype
								AND cs.bettype = t.bettype
	WHERE cs.custid =	@custid
		AND cs.sporttype = 161
	
	EXEC dbo.Acc_CustSetting3rd_05
		@srecommend = @srecommend,
		@mrecommend = @custid,    
		@roleid = 3,
		@mode = 'number',
		
		@isauto_v161spositiontaking_81 = 1,
		@isauto_v161spositiontaking_83 = 1,    
		@isauto_v161spositiontaking_86 = 1,
		@isauto_v161spositiontaking_88 = 1,
		
		@isauto_v161slivepositiontaking_85 = 1,
		@isauto_v161slivepositiontaking_86 = 1,
		@isauto_v161slivepositiontaking_87 = 1,
		@isauto_v161slivepositiontaking_89 = 1,
		@isauto_v161slivepositiontaking_90 = 1,
		
		@old_isauto_v161spositiontaking_81 = 1,--dont apply @updateallmembers
		@old_isauto_v161spositiontaking_83 = 1,    
		@old_isauto_v161spositiontaking_86 = 1,
		@old_isauto_v161spositiontaking_88 = 1,
		
		@old_isauto_v161slivepositiontaking_85 = 1,
		@old_isauto_v161slivepositiontaking_86 = 1,
		@old_isauto_v161slivepositiontaking_87 = 1,
		@old_isauto_v161slivepositiontaking_89 = 1,
		@old_isauto_v161slivepositiontaking_90 = 1,
		
		@auto_v161spositiontaking_81 = @auto_v161spositiontaking_81,
		@auto_v161spositiontaking_83 = @auto_v161spositiontaking_83,    
		@auto_v161spositiontaking_86 = @auto_v161spositiontaking_86,
		@auto_v161spositiontaking_88 = @auto_v161spositiontaking_88,
		
		@auto_v161slivepositiontaking_85 = @auto_v161slivepositiontaking_85,
		@auto_v161slivepositiontaking_86 = @auto_v161slivepositiontaking_86,
		@auto_v161slivepositiontaking_87 = @auto_v161slivepositiontaking_87,
		@auto_v161slivepositiontaking_89 = @auto_v161slivepositiontaking_89,
		@auto_v161slivepositiontaking_90 = @auto_v161slivepositiontaking_90,
		
		@old_auto_v161spositiontaking_81 = @old_auto_v161spositiontaking_81,
		@old_auto_v161spositiontaking_83 = @old_auto_v161spositiontaking_83,    
		@old_auto_v161spositiontaking_86 = @old_auto_v161spositiontaking_86,
		@old_auto_v161spositiontaking_88 = @old_auto_v161spositiontaking_88,
		
		@old_auto_v161slivepositiontaking_85 = @old_auto_v161slivepositiontaking_85,
		@old_auto_v161slivepositiontaking_86 = @old_auto_v161slivepositiontaking_86,
		@old_auto_v161slivepositiontaking_87 = @old_auto_v161slivepositiontaking_87,
		@old_auto_v161slivepositiontaking_89 = @old_auto_v161slivepositiontaking_89,
		@old_auto_v161slivepositiontaking_90 = @old_auto_v161slivepositiontaking_90,
		
		@updatepositiontakingv161 = 1,
		@updateallmembers = 0,
		@updatemultiple = 0,
		@newspositiontaking = 0
		
	EXEC dbo.Acc_CustSetting3rd_07 
		@srecommend = @srecommend, 
		@mrecommend = @custid, 
		@roleid = 3, 
		@mode = 'number'
	
	WAITFOR DELAY '00:00:0.28'	
END
	
	