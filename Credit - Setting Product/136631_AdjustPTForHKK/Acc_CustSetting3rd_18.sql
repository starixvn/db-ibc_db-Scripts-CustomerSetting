ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_18] 
    @srecommend INT= 0,
    @mrecommend iNT = 0,
    @recommend INT = 0,
    @roleid INT,
    @mode  VARCHAR(50) = '',
    @updautomaster bit = 1,
    @updautosuper bit = 1,
    @sporttype INT = 0,
    @bettype INT = 0,
	@Target VARCHAR(20) = ''	
AS
/*
   clone from sp Acc_CustSetting3rd_07
*/ 
BEGIN
    SET NOCOUNT ON
    
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	if NOT(dbo.f_CheckRepTable('custinfo') = 1 
	     AND dbo.f_CheckRepTable('CustOverrideGame') = 1 
	     AND dbo.f_CheckRepTable('CustSettingGame') = 1 
	     AND dbo.f_CheckRepTable('CustSetting3rd') = 1 
	     AND dbo.f_CheckRepTable('CustOverride3rd') = 1 
     )
	   	RETURN   
		
    CREATE TABLE #tblCust(custid INT, recommend INT, mrecommend INT)
	
	DECLARE @tmpAg TABLE (
						sporttype INT, 
						bettype INT, 
						autompositiontaking SMALLMONEY,
						autolivempositiontaking SMALLMONEY,
						isautompositiontaking BIT,
						isautolivempositiontaking BIT,
						minpositiontaking SMALLMONEY, 
						minlivepositiontaking SMALLMONEY,
						maxpositiontaking SMALLMONEY,
						maxlivepositiontaking SMALLMONEY)
		
	DECLARE @tmpMAg TABLE(
						sporttype INT, 
						bettype INT, 
						mpositiontaking SMALLMONEY,
						mlivepositiontaking SMALLMONEY,
						autopositiontaking SMALLMONEY,
						autolivepositiontaking SMALLMONEY,
						isautopositiontaking BIT,
						isautolivepositiontaking BIT,
						minpositiontaking SMALLMONEY,
						minlivepositiontaking SMALLMONEY,
						maxpositiontaking SMALLMONEY,
						maxlivepositiontaking SMALLMONEY
						)
	
	DECLARE @tmpSAg TABLE(
						sporttype INT, 
						bettype INT, 
						spositiontaking SMALLMONEY,
						slivepositiontaking SMALLMONEY,
						minpositiontaking SMALLMONEY,
						minlivepositiontaking SMALLMONEY,
						maxpositiontaking SMALLMONEY,
						maxlivepositiontaking SMALLMONEY
						)
						
    IF @roleid = 4
    BEGIN            
        IF @mode = 'number'
        BEGIN
			INSERT INTO #tblCust(custid,mrecommend)
			SELECT custid,mrecommend
			FROM custinfo c WITH(NOLOCK) 
			WHERE c.srecommend = @srecommend
			   AND c.roleid = 1
			   AND c.Enabled = 1
		   
		   	INSERT INTO @tmpSAg(sporttype,bettype,spositiontaking,slivepositiontaking,minpositiontaking,minlivepositiontaking)  
			SELECT scs.sporttype, scs.bettype,spositiontaking,slivepositiontaking,minpositiontaking,minlivepositiontaking
			FROM custsetting3rd scs WITH(NOLOCK)
				INNER JOIN CustOverride3rd sco WITH(NOLOCK) ON scs.custid = sco.custid
														AND scs.sporttype = sco.sporttype
														AND scs.bettype = sco.bettype
			WHERE scs.custid = @srecommend
				AND scs.sporttype = 161
				
            --u = (i3 or i1)?(u3 or u1)
            --s1 = min(s4-m1-a1, u)        
            --v161
			UPDATE cs3 
                SET spositiontaking = case when scs3.spositiontaking-cs3.mpositiontaking-cs3.apositiontaking >
                                        (case when cs3.isautopositiontaking=1 then cs3.autopositiontaking else mcs3.autopositiontaking end) then (case when cs3.isautopositiontaking=1 then cs3.autopositiontaking else mcs3.autopositiontaking end) else scs3.spositiontaking-cs3.mpositiontaking-cs3.apositiontaking end 
            FROM (SELECT c.custid, c.mrecommend, scs3.*
				FROM #tblCust c
					CROSS JOIN @tmpSAg scs3 
				)scs3
			CROSS APPLY (SELECT TOP 1 isautopositiontaking,autopositiontaking
						FROM custsetting3rd mcs3 WITH(NOLOCK)
						WHERE  mcs3.custid = scs3.mrecommend
						   AND mcs3.sporttype = scs3.sporttype
						   AND mcs3.bettype = scs3.bettype
						)mcs3
			CROSS APPLY (SELECT TOP 1 spositiontaking, mpositiontaking, apositiontaking, isautopositiontaking,autopositiontaking
						FROM custsetting3rd cs3 WITH(UPDLOCK,ROWLOCK)
						WHERE  cs3.custid = scs3.custid
						   AND cs3.sporttype = scs3.sporttype
						   AND cs3.bettype = scs3.bettype
						   AND (cs3.isautopositiontaking = 1
								OR mcs3.isautopositiontaking = 1)
						)cs3
			
			--check super min
            --s1=max(n4-m1-a1,s1)
			UPDATE cs
			   SET spositiontaking = sco.minpositiontaking - cs.mpositiontaking - cs.apositiontaking
			FROM (SELECT c.custid, sco.*
				FROM #tblCust c
					CROSS JOIN @tmpSAg sco 
			)sco		
			CROSS APPLY (SELECT TOP 1 spositiontaking, mpositiontaking, apositiontaking
						FROM custsetting3rd cs WITH(UPDLOCK,ROWLOCK)
						WHERE  cs.custid = sco.custid
						   AND cs.sporttype = sco.sporttype
						   AND cs.bettype = sco.bettype
						   AND cs.apositiontaking + cs.mpositiontaking + cs.spositiontaking < sco.minpositiontaking
						)cs
			
            --v161 
			UPDATE cs3 
                SET slivepositiontaking = case when scs3.slivepositiontaking-cs3.mlivepositiontaking-cs3.alivepositiontaking >
                                        (case when cs3.isautolivepositiontaking=1 then cs3.autolivepositiontaking else mcs3.autolivepositiontaking end) then (case when cs3.isautolivepositiontaking=1 then cs3.autolivepositiontaking else mcs3.autolivepositiontaking end) else scs3.slivepositiontaking-cs3.mlivepositiontaking-cs3.alivepositiontaking end 
            FROM (SELECT c.custid, c.mrecommend, scs3.*
				FROM #tblCust c
					CROSS JOIN @tmpSAg scs3 
				)scs3
			CROSS APPLY (SELECT TOP 1 autolivepositiontaking,isautolivepositiontaking
						FROM custsetting3rd mcs3 WITH(NOLOCK)
						WHERE  mcs3.custid = scs3.mrecommend
						   AND mcs3.sporttype = scs3.sporttype
						   AND mcs3.bettype = scs3.bettype
						)mcs3
			CROSS APPLY (SELECT TOP 1 slivepositiontaking, mlivepositiontaking, alivepositiontaking, autolivepositiontaking, isautolivepositiontaking
						FROM custsetting3rd cs3 WITH(UPDLOCK,ROWLOCK)
						WHERE  cs3.custid = scs3.custid
						   AND cs3.sporttype = scs3.sporttype
						   AND cs3.bettype = scs3.bettype
						   AND (cs3.isautolivepositiontaking = 1
								OR mcs3.isautolivepositiontaking = 1)
						)cs3
			
			UPDATE cs3
			   SET slivepositiontaking = sco.minlivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking
			FROM (SELECT c.custid, c.mrecommend, sco.*
				FROM #tblCust c
					CROSS JOIN @tmpSAg sco 
				)sco			
			CROSS APPLY (SELECT TOP 1 slivepositiontaking, mlivepositiontaking, alivepositiontaking
						FROM custsetting3rd cs3 WITH(UPDLOCK,ROWLOCK)
						WHERE  cs3.custid = sco.custid
						   AND cs3.sporttype = sco.sporttype
						   AND cs3.bettype = sco.bettype
						   AND cs3.alivepositiontaking + cs3.mlivepositiontaking + cs3.slivepositiontaking < sco.minlivepositiontaking
						)cs3    
        END       
        ELSE IF @mode = 'Keno' OR @mode = 'GoldDeluxe'
        BEGIN       
			INSERT INTO #tblCust(custid,mrecommend)
			SELECT custid,mrecommend
			FROM custinfo c WITH(NOLOCK) 
			WHERE c.srecommend = @srecommend
			   AND c.roleid = 1
			   AND c.Enabled = 1
		   
		   	INSERT INTO @tmpSAg(sporttype,bettype,spositiontaking,minpositiontaking)  
			SELECT scs.sporttype, scs.bettype,spositiontaking,minpositiontaking
			FROM CustSettingGame scs WITH(NOLOCK)
				INNER JOIN CustOverrideGame sco WITH(NOLOCK) ON scs.custid = sco.custid
														AND scs.sporttype = sco.sporttype
														AND scs.bettype = sco.bettype
			WHERE scs.custid = @srecommend
				AND scs.sporttype=@sporttype 
				AND 1 = CASE WHEN @mode = 'GoldDeluxe' AND scs.bettype = @bettype THEN 1 
							WHEN @mode = 'Keno' AND scs.bettype IN (1501,1503,1504,1505,1508,1511,1513,1514) THEN 1 
							ELSE 0 END
				
            --u = (i3 or i1)?(u3 or u1)
            --s1 = min(s4-m1-a1, u)
			UPDATE cs 
            SET spositiontaking = CASE WHEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking >
                                         CASE WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking ELSE mcs.autopositiontaking END THEN
                                        (CASE WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking ELSE mcs.autopositiontaking END) 
                                    ELSE scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking 
                                END  
			FROM (SELECT c.custid, c.mrecommend, scs.*
				FROM #tblCust c
					CROSS JOIN @tmpSAg scs 
				)scs
			CROSS APPLY (SELECT TOP 1 autopositiontaking,isautopositiontaking
						FROM CustSettingGame mcs WITH(NOLOCK)
						WHERE  mcs.custid = scs.mrecommend
						   AND mcs.sporttype = scs.sporttype
						   AND mcs.bettype = scs.bettype
						)mcs
			CROSS APPLY (SELECT TOP 1 spositiontaking, mpositiontaking, apositiontaking, isautopositiontaking,autopositiontaking
						FROM CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
						WHERE  cs.custid = scs.custid
						   AND cs.sporttype = scs.sporttype
						   AND 1 = CASE WHEN @mode = 'GoldDeluxe' AND cs.bettype = @bettype THEN 1 
									WHEN @mode = 'Keno' AND cs.bettype IN (1501,1503,1504,1505,1508,1511,1513,1514) THEN 1 
									ELSE 0 END
						   AND (cs.isautopositiontaking = 1
								OR mcs.isautopositiontaking = 1)
						)cs
			
			--check super min
            --s1=max(n4-m1-a1,s1)
			UPDATE cs
               SET spositiontaking = sco.minpositiontaking - cs.mpositiontaking - cs.apositiontaking
            FROM (SELECT c.custid, c.mrecommend, sco.*
				FROM #tblCust c
					CROSS JOIN @tmpSAg sco 
			)sco		
			CROSS APPLY (SELECT TOP 1 spositiontaking, mpositiontaking, apositiontaking
						FROM CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
						WHERE  cs.custid = sco.custid
						   AND cs.sporttype = sco.sporttype
						   AND cs.bettype = sco.bettype
						   AND cs.apositiontaking + cs.mpositiontaking + cs.spositiontaking < sco.minpositiontaking
						)cs
        END        
    END
    
	DROP TABLE #tblCust
END
GO



