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

INSERT INTO #tblCustPT(custid,sporttype,bettype,MaxPT, MaxLivePT)	
SELECT DISTINCT m.custid , cs.sporttype, cs.bettype, scs.spositiontaking as MaxPT, scs.slivepositiontaking as MaxLivePT
FROM CustSetting3rd  cs WITH(NOLOCK)													
	INNER JOIN #Masters m ON m.custid = cs.custid													
	INNER JOIN #supers su ON su.custid = m.srecommend													
	INNER JOIN CustSetting3rd scs WITH(NOLOCK) ON scs.custid = su.custid 
												AND scs.SportType = cs.SportType 
												AND scs.BetType = cs.BetType														
WHERE ((1 = CASE WHEN cs.bettype IN ( 81, 83 ,86 , 88) AND cs.isautopositiontaking = 0
				WHEN cs.bettype IN ( 85, 86 ,87 , 89, 90 ) AND cs.isautolivepositiontaking = 0 THEN 1 ELSE 0 END
			)													
	OR ( 1 = CASE WHEN (cs.bettype IN (81 , 83, 86 ,88 ) AND cs.isautopositiontaking = 1 AND cs.autopositiontaking < cs.spositiontaking)
					OR (cs.bettype IN ( 85, 86 ,87 , 89, 90 ) AND cs.isautolivepositiontaking = 1 AND cs.autolivepositiontaking < cs.slivepositiontaking) THEN 1 ELSE 0 END
		)	
	)		
	AND cs.sporttype = 161
	
--get relevant info to call execrep

EXEC dbo.Acc_CustSetting3rd_05
    @srecommend = @srecommend,
    @mrecommend = @mrecommend,    
    @roleid = 3,
    @mode = 'number',
    
    @isauto_v161spositiontaking_81 = @isauto_v161spositiontaking_81,
    @isauto_v161spositiontaking_83 = @isauto_v161spositiontaking_83,    
    @isauto_v161spositiontaking_86 = @isauto_v161spositiontaking_86,
    @isauto_v161spositiontaking_88 = @isauto_v161spositiontaking_88,
    
    @isauto_v161slivepositiontaking_85 = @isauto_v161slivepositiontaking_85,
    @isauto_v161slivepositiontaking_86 = @isauto_v161slivepositiontaking_86,
    @isauto_v161slivepositiontaking_87 = @isauto_v161slivepositiontaking_87,
    @isauto_v161slivepositiontaking_89 = @isauto_v161slivepositiontaking_89,
    @isauto_v161slivepositiontaking_90 = @isauto_v161slivepositiontaking_90,
    
    @old_isauto_v161spositiontaking_81 = @old_isauto_v161spositiontaking_81,
    @old_isauto_v161spositiontaking_83 = @old_isauto_v161spositiontaking_83,    
    @old_isauto_v161spositiontaking_86 = @old_isauto_v161spositiontaking_86,
    @old_isauto_v161spositiontaking_88 = @old_isauto_v161spositiontaking_88,
    
    @old_isauto_v161slivepositiontaking_85 = @old_isauto_v161slivepositiontaking_85,
    @old_isauto_v161slivepositiontaking_86 = @old_isauto_v161slivepositiontaking_86,
    @old_isauto_v161slivepositiontaking_87 = @old_isauto_v161slivepositiontaking_87,
    @old_isauto_v161slivepositiontaking_89 = @old_isauto_v161slivepositiontaking_89,
    @old_isauto_v161slivepositiontaking_90 = @old_isauto_v161slivepositiontaking_90,
    
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
    
    @updatepositiontakingv161 = @updatepositiontakingv161,
    @updateallmembers = @updateallmembers,
    @updatemultiple = @updatemultiple,
    @newspositiontaking = @newspositiontaking
    
	
	