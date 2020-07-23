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
   clone from sp Acc_CustSetting3rd_04
*/ 
BEGIN
    SET NOCOUNT ON
    
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	if NOT(dbo.f_CheckRepTable('custinfo') = 1 
	    AND dbo.f_CheckRepTable('CustSettingGame') = 1 
	    AND dbo.f_CheckRepTable('CustOverrideGame') = 1 
	    AND dbo.f_CheckRepTable('CustSetting3rd') = 1 
	    AND dbo.f_CheckRepTable('CustOverride3rd') = 1 
	    )
	   RETURN
    
     
    declare @mpos smallmoney, @apos smallmoney, @spos smallmoney, @mapos1 smallmoney, @mapos2 smallmoney, @mapos smallmoney, @maxmapos smallmoney
    
    --UPDATE min pt ON super
    IF @roleid = 4
    BEGIN   
        IF @mode = 'number'
        BEGIN
            DECLARE @_srecommend INT
            SELECT @_srecommend = @srecommend

            --s1=min(s1,s4-m3) if i=0
            
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET cs3.spositiontaking = scs.spositiontaking - mcs.mpositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
                                                  AND scs.sporttype = cs3.sporttype
                                                  AND scs.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (81, 83, 86, 88)
               AND cs3.isautopositiontaking = 0
               AND mcs.isautopositiontaking = 0
               AND scs.spositiontaking - mcs.mpositiontaking < cs3.spositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET cs3.slivepositiontaking = scs.slivepositiontaking - mcs.mlivepositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
                                                  AND scs.sporttype = cs3.sporttype
                                                  AND scs.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.isautolivepositiontaking = 0
               AND mcs.isautolivepositiontaking = 0
               AND scs.slivepositiontaking - mcs.mlivepositiontaking < cs3.slivepositiontaking


            --check agent min
            --a1=max(a1,n2)    
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET apositiontaking = aco.minpositiontaking
                 , cs3.mpositiontaking =
                     CASE
                       WHEN cs3.mpositiontaking + aco.minpositiontaking > mcs.mpositiontaking THEN mcs.mpositiontaking - aco.minpositiontaking
                       ELSE cs3.mpositiontaking
                     END
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (81, 83, 86, 88)
               AND cs3.apositiontaking < aco.minpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET cs3.alivepositiontaking = aco.minlivepositiontaking
                 , cs3.mlivepositiontaking =
                     CASE
                       WHEN cs3.mlivepositiontaking + aco.minlivepositiontaking > mcs.mlivepositiontaking THEN mcs.mlivepositiontaking - aco.minlivepositiontaking
                       ELSE cs3.mlivepositiontaking
                     END
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.alivepositiontaking < aco.minlivepositiontaking


            --check agent max
            --a1=min(a1,l2)    
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET apositiontaking = aco.maxpositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (81, 83, 86, 88)
               AND cs3.apositiontaking > aco.maxpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET alivepositiontaking = aco.maxlivepositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.alivepositiontaking > aco.maxlivepositiontaking


            --Recal AUTO MPT m1=min(m3-a1,u2)
            
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK) 
               SET mpositiontaking =
                     CASE
                       WHEN mcs.mpositiontaking - cs3.apositiontaking >
                              CASE
                                WHEN cs3.isautompositiontaking = 1 THEN cs3.autompositiontaking
                                ELSE acs.autompositiontaking
                              END
                         THEN CASE
                                WHEN cs3.isautompositiontaking = 1 THEN cs3.autompositiontaking
                                ELSE acs.autompositiontaking
                              END
                       ELSE mcs.mpositiontaking - cs3.apositiontaking
                     END
              FROM custsetting3rd cs3
        INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custsetting3rd acs WITH(NOLOCK) ON acs.custid = c.recommend
                                                  AND acs.sporttype = cs3.sporttype
                                                  AND acs.bettype = cs3.bettype
             WHERE c.srecommend = @_srecommend
               AND c.roleid = 1
               AND c.Enabled = 1
               AND cs3.sporttype = 161
               AND cs3.bettype IN (81, 83, 86, 88)
               AND (acs.isautompositiontaking = 1
                    OR cs3.isautompositiontaking = 1
                   )

    
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK) 
               SET mlivepositiontaking =
                     CASE
                       WHEN mcs.mlivepositiontaking - cs3.alivepositiontaking >
                              CASE
                                WHEN cs3.isautolivempositiontaking = 1 THEN cs3.autolivempositiontaking
                                ELSE acs.autolivempositiontaking
                              END
                         THEN CASE
                                WHEN cs3.isautolivempositiontaking = 1 THEN cs3.autolivempositiontaking
                                ELSE acs.autolivempositiontaking
                              END
                       ELSE mcs.mlivepositiontaking - cs3.alivepositiontaking
                     END
              FROM custsetting3rd cs3
        INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custsetting3rd acs WITH(NOLOCK) ON acs.custid = c.recommend
                                                   AND acs.sporttype = cs3.sporttype
                                                   AND acs.bettype = cs3.bettype
             WHERE c.srecommend = @_srecommend
               AND c.roleid = 1
               AND c.Enabled = 1
               AND cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND (acs.isautolivempositiontaking = 1
                    OR cs3.isautolivempositiontaking = 1
                   )    


            --check master min
            --m1=max(m1,n3-a1)
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET mpositiontaking = mco.minpositiontaking - cs3.apositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
                                                    AND mco.sporttype = cs3.sporttype
                                                    AND mco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (81, 83, 86, 88)
               AND cs3.apositiontaking + cs3.mpositiontaking < mco.minpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET mlivepositiontaking = mco.minlivepositiontaking-cs3.alivepositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.alivepositiontaking + cs3.mlivepositiontaking < mco.minlivepositiontaking


            --check master max   
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET @maxmapos =
                     CASE
                       WHEN mcs.mpositiontaking > mco.maxpositiontaking THEN mco.maxpositiontaking
                       ELSE mcs.mpositiontaking
                     END
                 , @mpos =
                     CASE
                       WHEN @maxmapos - cs3.apositiontaking < 0 THEN 0
                       ELSE @maxmapos - cs3.apositiontaking
                     END
                 , mpositiontaking = @mpos
                 , @apos =
                     CASE
                       WHEN cs3.apositiontaking + @mpos > @maxmapos THEN @maxmapos - @mpos
                       ELSE cs3.apositiontaking
                     END
                 , apositiontaking =
                     CASE
                       WHEN @apos < aco.minpositiontaking THEN aco.minpositiontaking
                       ELSE @apos
                     END
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (81, 83, 86, 88)
               AND cs3.apositiontaking + cs3.mpositiontaking > mco.maxpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET @maxmapos =
                     CASE
                       WHEN mcs.mlivepositiontaking > mco.maxlivepositiontaking THEN mco.maxlivepositiontaking
                       ELSE mcs.mlivepositiontaking
                     END
                 , @mpos =
                     CASE
                       WHEN @maxmapos - cs3.alivepositiontaking < 0 THEN 0
                       ELSE @maxmapos - cs3.alivepositiontaking
                     END
                 , mlivepositiontaking = @mpos
                 , @apos =
                     CASE
                       WHEN cs3.alivepositiontaking + @mpos > @maxmapos THEN @maxmapos - @mpos
                       ELSE cs3.alivepositiontaking
                     END
                 , alivepositiontaking =
                     CASE
                       WHEN @apos < aco.minlivepositiontaking THEN aco.minlivepositiontaking
                       ELSE @apos
                     END
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.alivepositiontaking + cs3.mlivepositiontaking > mco.maxlivepositiontaking


            --recal autopos   
                
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET spositiontaking =
                     CASE
                       WHEN scs.spositiontaking - cs3.mpositiontaking - cs3.apositiontaking >
                              CASE
                                WHEN cs3.isautopositiontaking = 1 THEN cs3.autopositiontaking
                                ELSE mcs.autopositiontaking
                              END
                         THEN CASE
                                WHEN cs3.isautopositiontaking = 1 THEN cs3.autopositiontaking
                                ELSE mcs.autopositiontaking
                              END
                       ELSE scs.spositiontaking - cs3.mpositiontaking - cs3.apositiontaking
                     END
              FROM custsetting3rd cs3
        INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
                                                  AND scs.sporttype = cs3.sporttype
                                                  AND scs.bettype=cs3.bettype
             WHERE c.srecommend = @_srecommend
               AND c.roleid = 1
               AND c.Enabled = 1
               AND cs3.sporttype = 161
               AND cs3.bettype IN (81, 83, 89, 88)
               AND (cs3.isautopositiontaking = 1
                    OR mcs.isautopositiontaking = 1
                   )


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET slivepositiontaking =
                     CASE
                       WHEN scs.slivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking >
                              CASE
                                WHEN cs3.isautolivepositiontaking = 1 THEN cs3.autolivepositiontaking
                                ELSE mcs.autolivepositiontaking
                              END
                         THEN CASE
                                WHEN cs3.isautolivepositiontaking = 1 THEN cs3.autolivepositiontaking
                                ELSE mcs.autolivepositiontaking
                              END
                       ELSE scs.slivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking
                     END 
              FROM custsetting3rd cs3
        INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
                                                  AND scs.sporttype = cs3.sporttype
                                                  AND scs.bettype = cs3.bettype
             WHERE c.srecommend = @_srecommend
               AND c.roleid = 1
               AND c.Enabled = 1
               AND cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND (cs3.isautolivepositiontaking = 1
                    OR mcs.isautolivepositiontaking = 1
                   )    


            --check super min
            --s1=max(n4-m1-a1,s1)    
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET spositiontaking = sco.minpositiontaking - cs3.mpositiontaking - cs3.apositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd sco WITH(NOLOCK) ON sco.custid = @_srecommend
                                                   AND sco.sporttype = cs3.sporttype
                                                   AND sco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (81, 83, 86, 88)
               AND cs3.apositiontaking + cs3.mpositiontaking + cs3.spositiontaking < sco.minpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET slivepositiontaking = sco.minlivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd sco WITH(NOLOCK) ON sco.custid = @_srecommend
                                                   AND sco.sporttype = cs3.sporttype
                                                   AND sco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.alivepositiontaking + cs3.mlivepositiontaking + cs3.slivepositiontaking < sco.minlivepositiontaking

            

            --UPDATE s1,m1,a1 IN CASE s1+m1+a1>s4
            --s1=max(0,s4-m1-a1)
            --@mapos1=iif(s1_new+m1+a1>s4,s4-s1_new,m1+a1)
            --@maxmapos=min(m3,l3)
            --@mapos2=min(@mapos1,@maxmapos)
            --@mapos=max(@mapos2,n3)
            --m1=max(0,@mapos-a1)
            --a1=iif(m1_new+a1>@mapos,@mapos-m1_new,a1)
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET @spos =
                     CASE
                       WHEN scs.spositiontaking - cs3.mpositiontaking - cs3.apositiontaking < 0 THEN 0
                       ELSE scs.spositiontaking - cs3.mpositiontaking - cs3.apositiontaking
                     END
                 , spositiontaking = @spos
                 , @mapos1 =
                     CASE
                       WHEN @spos + cs3.mpositiontaking + cs3.apositiontaking > scs.spositiontaking THEN scs.spositiontaking - @spos
                       ELSE cs3.mpositiontaking + cs3.apositiontaking
                     END
                 , @maxmapos =
                     CASE
                       WHEN mcs.mpositiontaking > mco.maxpositiontaking THEN mco.maxpositiontaking
                       ELSE mcs.mpositiontaking
                     END
                 , @mapos2 =
                     CASE
                       WHEN @mapos1 > @maxmapos THEN @maxmapos
                       ELSE @mapos1
                     END
                 , @mapos =
                     CASE
                       WHEN @mapos2 < mco.minpositiontaking THEN mco.minpositiontaking
                       ELSE @mapos2
                     END
                 , @mpos =
                     CASE
                       WHEN @mapos - cs3.apositiontaking < 0 THEN 0
                       ELSE @mapos - cs3.apositiontaking
                     END
                 , mpositiontaking = @mpos
                 , @apos =
                     CASE
                       WHEN cs3.apositiontaking + @mpos > @mapos THEN @mapos - @mpos
                       ELSE cs3.apositiontaking
                     END
                 , apositiontaking =
                     CASE
                       WHEN @apos < aco.minpositiontaking THEN aco.minpositiontaking
                       ELSE @apos
                     END
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
                                                  AND scs.sporttype = cs3.sporttype
                                                  AND scs.bettype = cs3.bettype
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (81, 83, 86, 88)
               AND cs3.spositiontaking + cs3.apositiontaking + cs3.mpositiontaking > scs.spositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET @spos =
                     CASE
                       WHEN scs.slivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking < 0 THEN 0
                       ELSE scs.slivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking
                     END
                 , slivepositiontaking = @spos
                 , @mapos1 =
                     CASE
                       WHEN @spos + cs3.mlivepositiontaking + cs3.alivepositiontaking > scs.slivepositiontaking THEN scs.slivepositiontaking - @spos
                       ELSE cs3.mlivepositiontaking + cs3.alivepositiontaking
                     END
                 , @maxmapos =
                     CASE
                       WHEN mcs.mlivepositiontaking > mco.maxlivepositiontaking THEN mco.maxlivepositiontaking
                       ELSE mcs.mlivepositiontaking
                     END
                 , @mapos2 =
                     CASE
                       WHEN @mapos1 > @maxmapos THEN @maxmapos
                       ELSE @mapos1
                     END
                 , @mapos =
                     CASE
                       WHEN @mapos2 < mco.minlivepositiontaking THEN mco.minlivepositiontaking
                       ELSE @mapos2
                     END
                 , @mpos =
                     CASE
                       WHEN @mapos - cs3.alivepositiontaking < 0 THEN 0
                       ELSE @mapos - cs3.alivepositiontaking
                     END
                 , mlivepositiontaking = @mpos
                 , @apos =
                     CASE
                       WHEN cs3.alivepositiontaking + @mpos > @mapos THEN @mapos - @mpos
                       ELSE cs3.alivepositiontaking
                     END
                 , alivepositiontaking =
                     CASE
                       WHEN @apos < aco.minlivepositiontaking THEN aco.minlivepositiontaking
                       ELSE @apos
                     END
               FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.srecommend = @_srecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
                                                  AND scs.sporttype = cs3.sporttype
                                                  AND scs.bettype = cs3.bettype
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.slivepositiontaking + cs3.alivepositiontaking + cs3.mlivepositiontaking > scs.slivepositiontaking

            RETURN
        END--end mode = 'number'        
        
        IF @mode = 'Keno' OR @mode = 'GoldDeluxe'
        BEGIN        
            --s1=min(s1,s4-m3) if i=0
            UPDATE cs
               SET cs.spositiontaking = scs.spositiontaking - mcs.mpositiontaking
              FROM CustSettingGame cs 
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
        INNER JOIN CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = ci.mrecommend
                                                   AND mcs.sporttype = cs.sporttype
                                                   AND mcs.bettype = cs.bettype
        INNER JOIN CustSettingGame scs WITH(NOLOCK) ON scs.custid = @srecommend
                                                   AND scs.sporttype = cs.sporttype
                                                   AND scs.bettype = cs.bettype
             WHERE ci.srecommend = @srecommend
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype              
               AND (mcs.isautopositiontaking = 0
                    OR cs.isautopositiontaking = 0
                   )
               AND scs.spositiontaking - mcs.mpositiontaking < cs.spositiontaking


            --check agent min
            --a1=max(a1,n2)
            --m1=min(m3-n2,m1)
            UPDATE cs
               SET cs.apositiontaking = aco.minpositiontaking
                 , cs.mpositiontaking =
                     CASE
                       WHEN cs.mpositiontaking + aco.minpositiontaking > mcs.mpositiontaking THEN mcs.mpositiontaking - aco.minpositiontaking
                       ELSE cs.mpositiontaking
                     END
              FROM CustSettingGame cs
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
        INNER JOIN CustOverrideGame aco WITH(NOLOCK) ON aco.custid = ci.recommend
                                                    AND aco.sporttype = cs.sporttype
                                                    AND aco.bettype = cs.bettype
        INNER JOIN CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = ci.mrecommend
                                                   AND mcs.sporttype = cs.sporttype
                                                   AND mcs.bettype = cs.bettype
             WHERE ci.srecommend = @srecommend
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype               
               AND cs.apositiontaking < aco.minpositiontaking


            --Recal AUTO MPT m1=min(m3-a1,u2)
            UPDATE cs
               SET cs.mpositiontaking =
                     CASE
                       WHEN mcs.mpositiontaking - cs.apositiontaking >
                              CASE
                                WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking
                                ELSE acs.autompositiontaking
                              END
                         THEN CASE
                                WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking
                                ELSE acs.autompositiontaking
                              END
                       ELSE mcs.mpositiontaking - cs.apositiontaking
                     END
              FROM CustSettingGame cs WITH(NOLOCK)
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
        INNER JOIN CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = ci.mrecommend
                                                   AND mcs.sporttype = cs.sporttype
                                                   AND mcs.bettype = cs.bettype
        INNER JOIN CustSettingGame acs WITH(NOLOCK) ON acs.custid = ci.recommend
                                                   AND acs.sporttype = cs.sporttype
                                                   AND acs.bettype = cs.bettype
             WHERE ci.srecommend = @srecommend
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype               
               AND (cs.isautompositiontaking = 1
                    OR acs.isautompositiontaking = 1
                   )


            --check master min
            --m1=max(m1,n3-a1)
            UPDATE cs
               SET cs.mpositiontaking =
                     CASE
                       WHEN cs.mpositiontaking + cs.apositiontaking < mco.minpositiontaking THEN mco.minpositiontaking - cs.apositiontaking
                       ELSE cs.mpositiontaking
                     END
              FROM CustSettingGame cs
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid 
        INNER JOIN CustOverrideGame mco WITH(NOLOCK) ON mco.custid = ci.mrecommend
                                                    AND mco.sporttype = cs.sporttype
                                                    AND mco.bettype = cs.bettype
             WHERE ci.srecommend = @srecommend
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype               


            --recal autopos
            UPDATE cs
               SET cs.spositiontaking =
                     CASE
                       WHEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking >
                              CASE
                                WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking
                                ELSE mcs.autopositiontaking
                              END
                         THEN CASE
                                WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking
                                ELSE mcs.autopositiontaking
                              END 
                       ELSE scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking
                     END
              FROM CustSettingGame cs
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid 
        INNER JOIN CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = ci.mrecommend
                                                   AND mcs.sporttype = cs.sporttype
                                                   AND mcs.bettype = cs.bettype 
        INNER JOIN CustSettingGame scs WITH(NOLOCK) ON scs.custid = @srecommend
                                                   AND scs.sporttype = cs.sporttype
                                                   AND scs.bettype = cs.bettype 
              WHERE ci.srecommend = @srecommend
                AND ci.roleid = 1
                AND ci.Enabled = 1
               AND cs.sporttype = @sporttype               
               AND (cs.isautopositiontaking = 1
                    OR mcs.isautopositiontaking = 1
                   )


            --check super min
            --s1=max(n4-m1-a1,s1)
            UPDATE cs
               SET spositiontaking = sco.minpositiontaking - cs.mpositiontaking - cs.apositiontaking
              FROM CustSettingGame cs
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
        INNER JOIN CustOverrideGame sco WITH(NOLOCK) ON sco.custid = @srecommend
                                                    AND sco.sporttype = cs.sporttype
                                                    AND sco.bettype = cs.bettype
             WHERE ci.srecommend = @srecommend
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype               
               AND cs.apositiontaking + cs.mpositiontaking + cs.spositiontaking < sco.minpositiontaking


            --UPDATE s1,m1,a1 IN CASE s1+m1+a1>s4
            --s1=max(0,s4-m1-a1)
            --@mapos1=iif(s1_new+m1+a1>s4,s4-s1_new,m1+a1)
            --@maxmapos=min(m3,l3)
            --@mapos2=min(@mapos1,@maxmapos)
            --@mapos=max(@mapos2,n3)
            --m1=max(0,@mapos-a1)
            --a1=iif(m1_new+a1>@mapos,@mapos-m1_new,a1)
            UPDATE cs
               SET @spos =
                     CASE
                       WHEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking < 0 THEN 0
                       ELSE scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking
                     END
                 , cs.spositiontaking = @spos
                 , @mapos1 =
                     CASE
                       WHEN @spos + cs.mpositiontaking + cs.apositiontaking > scs.spositiontaking THEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking
                       ELSE cs.mpositiontaking + cs.apositiontaking
                     END
                 , @mapos2 =
                     CASE
                       WHEN @mapos1 > mcs.mpositiontaking THEN mcs.mpositiontaking
                       ELSE @mapos1
                     END
                 , @mapos =
                     CASE
                       WHEN @mapos2 < mco.minpositiontaking THEN mco.minpositiontaking
                       ELSE @mapos2
                     END
                 , @mpos =
                     CASE
                       WHEN @mapos - cs.apositiontaking < 0 THEN 0
                       ELSE @mapos - cs.apositiontaking
                     END
                 , cs.mpositiontaking = @mpos
                 , @apos =
                     CASE
                       WHEN @mpos + cs.apositiontaking > @mapos THEN @mapos - @mpos
                       ELSE cs.apositiontaking
                     END
                 , cs.apositiontaking =
                     CASE
                       WHEN @apos < aco.minpositiontaking THEN aco.minpositiontaking
                       ELSE @apos
                     END
              FROM CustSettingGame cs
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid 
        INNER JOIN CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = ci.mrecommend
                                                   AND mcs.sporttype = cs.sporttype
                                                   AND mcs.bettype = cs.bettype 
        INNER JOIN CustOverrideGame mco WITH(NOLOCK) ON mco.custid = ci.mrecommend
                                                    AND mco.sporttype = cs.sporttype
                                                    AND mco.bettype = cs.bettype
        INNER JOIN CustOverrideGame aco WITH(NOLOCK) ON aco.custid = ci.recommend
                                                    AND aco.sporttype = cs.sporttype
                                                    AND aco.bettype = cs.bettype 
        INNER JOIN CustSettingGame scs WITH(NOLOCK) ON scs.custid = @srecommend
                                                   AND scs.sporttype = cs.sporttype
                                                   AND scs.bettype = cs.bettype 
             WHERE ci.srecommend = @srecommend
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype               
               AND cs.apositiontaking + cs.mpositiontaking + cs.spositiontaking > scs.spositiontaking


            RETURN

        END--end mode = 'Keno'
    END
END
GO



