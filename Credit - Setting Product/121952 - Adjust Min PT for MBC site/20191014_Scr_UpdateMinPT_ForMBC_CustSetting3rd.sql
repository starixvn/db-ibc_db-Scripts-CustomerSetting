 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for CustSetting3rd
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */


---STEP 1: deploy this sp on DBCUST
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_18] 
    @srecommend INT = 0,
    @mrecommend INT =0,
    @recommend INT = 0,
    @mode varchar(50)='',
    @sporttype INT = 0,
    @bettype INT = 0,
    @custid INT = 0,
    @roleid INT,
	@Target VARCHAR(20) = ''
 AS
    /*
       Clone from Acc_CustSetting3rd_04   
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
               AND cs.bettype = @bettype
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
               AND cs.bettype = @bettype
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
               AND cs.bettype = @bettype
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
               AND cs.bettype = @bettype 


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
               AND cs.bettype = @bettype 
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
               AND cs.bettype = @bettype 
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
               AND cs.bettype = @bettype
               AND cs.apositiontaking + cs.mpositiontaking + cs.spositiontaking > scs.spositiontaking


            RETURN

        END--end mode = 'Keno'
    END

    
    --UPDATE min/max pt ON master
    ELSE IF @roleid = 3
    BEGIN    
        IF @mode = 'number'
        BEGIN
            --check agent min/max
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
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.apositiontaking < aco.minpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET alivepositiontaking = aco.minlivepositiontaking
                 , cs3.mlivepositiontaking =
                     CASE
                       WHEN cs3.mlivepositiontaking + aco.minlivepositiontaking > mcs.mlivepositiontaking THEN mcs.mlivepositiontaking - aco.minlivepositiontaking
                       ELSE cs3.mlivepositiontaking
                     END
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.alivepositiontaking < aco.minlivepositiontaking


            --a1=min(a1,l2)             
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET apositiontaking = aco.maxpositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.apositiontaking > aco.maxpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET alivepositiontaking = aco.maxlivepositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.alivepositiontaking > aco.maxlivepositiontaking


            -- UPDATE m2,a2 WHEN m2+a2>l3
            -- m2=max(min(m3,l3)-a2,0)
            -- a2=min(min(m3,l3)-m2,a2,n2)
            --v161
            UPDATE c3d WITH(ROWLOCK, UPDLOCK)
               SET @maxmapos =
                     CASE
                       WHEN mcs.mpositiontaking > mco.maxpositiontaking THEN mco.maxpositiontaking
                       ELSE mcs.mpositiontaking
                     END
                 , @mpos =
                     CASE
                       WHEN @maxmapos - c3d.apositiontaking < 0 THEN 0
                       ELSE @maxmapos - c3d.apositiontaking
                     END
                 , mpositiontaking = @mpos
                 , @apos =
                     CASE
                       WHEN c3d.apositiontaking + @mpos > @maxmapos THEN @maxmapos - @mpos
                       ELSE c3d.apositiontaking
                     END
                 , apositiontaking =
                     CASE
                       WHEN @apos < aco.minpositiontaking THEN aco.minpositiontaking
                       ELSE @apos
                     END
              FROM custsetting3rd c3d
        INNER JOIN custinfo mb WITH(NOLOCK) ON c3d.custid    = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid     = 2
                                           AND mb.Enabled    = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid    = @mrecommend
                                                  AND mcs.sporttype = c3d.sporttype
                                                  AND mcs.bettype   = c3d.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid    = @mrecommend
                                                   AND mco.sporttype = c3d.sporttype
                                                   AND mco.bettype   = c3d.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid    = mb.recommend
                                                   AND aco.sporttype = c3d.sporttype
                                                   AND aco.bettype   = c3d.bettype
             WHERE c3d.sporttype = 161
               AND c3d.apositiontaking + c3d.mpositiontaking > mco.maxpositiontaking


            UPDATE c3d WITH(ROWLOCK, UPDLOCK)
               SET @maxmapos =
                     CASE
                       WHEN mcs.mlivepositiontaking > mco.maxlivepositiontaking THEN mco.maxlivepositiontaking
                       ELSE mcs.mlivepositiontaking
                     END
                 , @mpos =
                     CASE
                       WHEN @maxmapos - c3d.alivepositiontaking < 0 THEN 0
                       ELSE @maxmapos - c3d.alivepositiontaking
                     END
                 , mlivepositiontaking = @mpos
                 , @apos =
                     CASE
                       WHEN c3d.alivepositiontaking + @mpos > @maxmapos THEN @maxmapos - @mpos
                       ELSE c3d.alivepositiontaking
                     END
                 , alivepositiontaking =
                     CASE
                       WHEN @apos < aco.minlivepositiontaking THEN aco.minlivepositiontaking
                       ELSE @apos
                     END
              FROM custsetting3rd c3d
        INNER JOIN custinfo mb WITH(NOLOCK) ON c3d.custid    = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid     = 2
                                           AND mb.Enabled    = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid    = @mrecommend
                                                  AND mcs.sporttype = c3d.sporttype
                                                  AND mcs.bettype   = c3d.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid    = @mrecommend
                                                   AND mco.sporttype = c3d.sporttype
                                                   AND mco.bettype   = c3d.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid    = mb.recommend
                                                   AND aco.sporttype = c3d.sporttype
                                                   AND aco.bettype   = c3d.bettype
             WHERE c3d.sporttype = 161
               AND c3d.bettype IN (85, 86, 87, 89, 90)
               AND c3d.alivepositiontaking + c3d.mlivepositiontaking > mco.maxlivepositiontaking


            --um2=min(m3,l3) if um2>l3
            --v161
            UPDATE c3d WITH(ROWLOCK, UPDLOCK)
               SET @maxmapos =
                     CASE
                       WHEN mcs.mpositiontaking > mco.maxpositiontaking THEN mco.maxpositiontaking
                       ELSE mcs.mpositiontaking
                     END
                 , autompositiontaking = @maxmapos
              FROM custsetting3rd c3d
        INNER JOIN custinfo mb WITH(NOLOCK) ON c3d.custid    = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid     = 2
                                           AND mb.Enabled    = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid    = @mrecommend
                                                  AND mcs.sporttype = c3d.sporttype
                                                  AND mcs.bettype   = c3d.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid    = @mrecommend
                                                   AND mco.sporttype = c3d.sporttype
                                                   AND mco.bettype   = c3d.bettype
             WHERE c3d.sporttype = 161
               AND c3d.isautompositiontaking = 1
               AND c3d.autompositiontaking > mco.maxpositiontaking


            UPDATE c3d WITH(ROWLOCK, UPDLOCK)
               SET @maxmapos =
                     CASE
                       WHEN mcs.mlivepositiontaking > mco.maxlivepositiontaking THEN mco.maxlivepositiontaking
                       ELSE mcs.mlivepositiontaking
                     END
                 , autolivempositiontaking = @maxmapos
              FROM custsetting3rd c3d
        INNER JOIN custinfo mb WITH(NOLOCK) ON c3d.custid    = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid     = 2
                                           AND mb.Enabled    = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid    = @mrecommend
                                                  AND mcs.sporttype = c3d.sporttype
                                                  AND mcs.bettype   = c3d.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid    = @mrecommend
                                                   AND mco.sporttype = c3d.sporttype
                                                   AND mco.bettype   = c3d.bettype
             WHERE c3d.sporttype = 161
               AND c3d.bettype IN (85, 86, 87, 89, 90)
               AND c3d.isautolivempositiontaking = 1
               AND c3d.autolivempositiontaking > mco.maxlivepositiontaking


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
             WHERE c.mrecommend = @mrecommend
               AND c.roleid = 1
               AND c.Enabled = 1
               AND cs3.sporttype = 161
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
             WHERE c.mrecommend = @mrecommend
               AND c.roleid = 1
               AND c.Enabled = 1
               AND cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND (acs.isautolivempositiontaking = 1
                    OR cs3.isautolivempositiontaking = 1
                   )


            --check master min/max
            --m1=n3-a1
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET mpositiontaking = mco.minpositiontaking - cs3.apositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.apositiontaking + cs3.mpositiontaking < mco.minpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET mlivepositiontaking = mco.minlivepositiontaking - cs3.alivepositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.alivepositiontaking + cs3.mlivepositiontaking < mco.minlivepositiontaking


            -- UPDATE m1,a1 WHEN m1+a1>l3
            -- m1=min(m3,l3)-a1
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
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
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
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.alivepositiontaking + cs3.mlivepositiontaking > mco.maxlivepositiontaking


            --recal autopos
            -- s1=min(s4-m1-a1,u)
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
        INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @srecommend
                                                  AND scs.sporttype = cs3.sporttype
                                                  AND scs.bettype = cs3.bettype
             WHERE c.mrecommend = @mrecommend
               AND c.roleid = 1
               AND c.Enabled = 1
               AND cs3.sporttype = 161
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
        INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @srecommend
                                                  AND scs.sporttype = cs3.sporttype
                                                  AND scs.bettype = cs3.bettype
             WHERE c.mrecommend = @mrecommend
               AND c.roleid = 1
               AND c.Enabled = 1
               AND cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND (cs3.isautolivepositiontaking = 1
                    OR mcs.isautolivepositiontaking = 1
                   )    


            --check super min/max WHEN a1+m1+s1<n4
            -- s1=n4-m1-a1
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET spositiontaking = sco.minpositiontaking - cs3.mpositiontaking - cs3.apositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd sco WITH(NOLOCK) ON sco.custid = @srecommend
                                                   AND sco.sporttype = cs3.sporttype
                                                   AND sco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.apositiontaking + cs3.mpositiontaking + cs3.spositiontaking < sco.minpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET slivepositiontaking = sco.minlivepositiontaking - cs3.mlivepositiontaking-cs3.alivepositiontaking
              FROM custsetting3rd cs3
        INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custoverride3rd sco WITH(NOLOCK) ON sco.custid = @srecommend
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
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @srecommend
                                                  AND scs.sporttype = cs3.sporttype
                                                  AND scs.bettype = cs3.bettype
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
            WHERE cs3.spositiontaking + cs3.apositiontaking + cs3.mpositiontaking > scs.spositiontaking


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
                                           AND mb.mrecommend = @mrecommend
                                           AND mb.roleid = 1
                                           AND mb.Enabled = 1
        INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @srecommend
                                                  AND scs.sporttype = cs3.sporttype
                                                  AND scs.bettype = cs3.bettype
        INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend
                                                  AND mcs.sporttype = cs3.sporttype
                                                  AND mcs.bettype = cs3.bettype
                --INNER JOIN custoverride3rd sco WITH(NOLOCK) ON sco.custid = @srecommend  AND sco.sporttype = cs3.sporttype AND sco.bettype = cs3.bettype
        INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend
                                                   AND mco.sporttype = cs3.sporttype
                                                   AND mco.bettype = cs3.bettype
        INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
                                                   AND aco.sporttype = cs3.sporttype
                                                   AND aco.bettype = cs3.bettype
             WHERE cs3.sporttype = 161
               AND cs3.bettype IN (85, 86, 87, 89, 90)
               AND cs3.slivepositiontaking + cs3.alivepositiontaking + cs3.mlivepositiontaking > scs.slivepositiontaking

        END  
        
        IF @mode = 'Keno' OR @mode = 'GoldDeluxe'
        BEGIN                        
            --check agent min/max
            --a1=max(a1,n2)
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
                                                AND cs.sporttype = aco.sporttype
                                                AND cs.bettype = aco.bettype
        INNER JOIN CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = @custid
                                                   AND mcs.sporttype = cs.sporttype
                                                   AND mcs.bettype = cs.bettype 
             WHERE ci.mrecommend = @custid
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype
               AND cs.bettype = @bettype
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
              FROM CustSettingGame cs
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid 
        INNER JOIN CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = @custid
                                                   AND mcs.sporttype = cs.sporttype
                                                   AND mcs.bettype = cs.bettype 
        INNER JOIN CustSettingGame acs WITH(NOLOCK) ON acs.custid = ci.recommend
                                                   AND acs.sporttype = cs.sporttype
                                                   AND acs.bettype = cs.bettype 
             WHERE ci.mrecommend = @custid
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype
               AND cs.bettype = @bettype 
               AND (acs.isautompositiontaking = 1
                    OR cs.isautompositiontaking = 1
                   )


            --check master min/max
            --m1=n3-a1
            UPDATE cs
               SET cs.mpositiontaking = mco.minpositiontaking - cs.apositiontaking
              FROM CustSettingGame cs
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
        INNER JOIN CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = @custid
                                                   AND mcs.sporttype = cs.sporttype
                                                   AND mcs.bettype = cs.bettype 
        INNER JOIN CustOverrideGame mco WITH(NOLOCK) ON mco.custid = @custid
                                                    AND mco.sporttype = cs.sporttype
                                                    AND mco.bettype = cs.bettype
             WHERE ci.mrecommend = @custid
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype
               AND cs.bettype = @bettype 
               AND cs.mpositiontaking + cs.apositiontaking < mco.minpositiontaking 


            --recal autopos
            -- s1=min(s4-m1-a1,u)
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
        INNER JOIN CustSettingGame scs WITH(NOLOCK) ON scs.custid = @srecommend
                                                   AND scs.sporttype = cs.sporttype
                                                   AND scs.bettype = cs.bettype 
        INNER JOIN CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = @custid
                                                   AND mcs.sporttype = cs.sporttype
                                                   AND mcs.bettype = cs.bettype 
             WHERE ci.mrecommend = @custid
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype
               AND cs.bettype = @bettype
               AND (cs.isautopositiontaking = 1
                    OR mcs.isautopositiontaking = 1
                   )


            --check super min/max WHEN a1+m1+s1<n4
            -- s1=n4-m1-a1
            UPDATE cs
               SET cs.spositiontaking = sco.minpositiontaking - cs.mpositiontaking - cs.apositiontaking
              FROM CustSettingGame cs
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid 
        INNER JOIN CustOverrideGame sco WITH(NOLOCK) ON sco.custid = @srecommend
                                                    AND sco.sporttype = cs.sporttype
                                                    AND sco.bettype = cs.bettype 
             WHERE ci.mrecommend = @custid
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype
               AND cs.bettype = @bettype 
               AND cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking < sco.minpositiontaking    


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
                       WHEN @spos + cs.mpositiontaking + cs.apositiontaking > scs.spositiontaking THEN scs.spositiontaking - @spos
                       ELSE cs.mpositiontaking + cs.apositiontaking
                     END
                 , @mapos2 =
                     CASE
                       WHEN @mapos1 < mcs.mpositiontaking THEN @mapos1
                       ELSE mcs.mpositiontaking
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
                       WHEN cs.apositiontaking + @mpos > @mapos THEN @mapos - @mpos
                       ELSE cs.apositiontaking
                     END
                 , cs.apositiontaking =
                     CASE
                       WHEN @apos < aco.minpositiontaking THEN aco.minpositiontaking
                       ELSE @apos
                     END
              FROM CustSettingGame cs
        INNER JOIN CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid 
        INNER JOIN CustSettingGame scs WITH(NOLOCK) ON scs.custid = @srecommend
                                                   AND scs.sporttype = cs.sporttype
                                                   AND scs.bettype = cs.bettype
        INNER JOIN CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = ci.mrecommend
                                                   AND mcs.sporttype = cs.sporttype
                                                   AND mcs.bettype = cs.bettype
        INNER JOIN CustOverrideGame mco WITH(NOLOCK) ON mco.custid = ci.mrecommend
                                                    AND mco.sporttype = cs.sporttype
                                                    AND mco.bettype = cs.bettype
        INNER JOIN CustOverrideGame aco WITH(NOLOCK) ON aco.custid = ci.recommend
                                                    AND aco.sporttype = cs.sporttype
                                                    AND aco.bettype = cs.bettype
             WHERE ci.mrecommend = @custid
               AND ci.roleid = 1
               AND ci.Enabled = 1
               AND cs.sporttype = @sporttype
               AND cs.bettype = @bettype 
               AND cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking > scs.spositiontaking

        END--end Keno
    END
    ELSE IF @roleid = 2
    BEGIN
        IF @mode = 'number'
        BEGIN            
            --check agent min/max
            -- UPDATE a1 WHEN a1<n2
            -- a1=n2
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                apositiontaking = aco.minpositiontaking,
                cs3.mpositiontaking = CASE WHEN cs3.mpositiontaking + aco.minpositiontaking > mcs.mpositiontaking THEN mcs.mpositiontaking-aco.minpositiontaking ELSE cs3.mpositiontaking END
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend  AND mcs.sporttype=cs3.sporttype AND mcs.bettype=cs3.bettype
                INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = @recommend  AND aco.sporttype=cs3.sporttype AND aco.bettype=cs3.bettype
            WHERE cs3.sporttype = 161 AND cs3.bettype IN (81,83,86,88) AND cs3.apositiontaking<aco.minpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                alivepositiontaking = aco.minlivepositiontaking,
                cs3.mlivepositiontaking = CASE WHEN cs3.mlivepositiontaking + aco.minlivepositiontaking > mcs.mlivepositiontaking THEN mcs.mlivepositiontaking-aco.minlivepositiontaking ELSE cs3.mlivepositiontaking END
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend  AND mcs.sporttype=cs3.sporttype AND mcs.bettype=cs3.bettype
                INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = @recommend  AND aco.sporttype=cs3.sporttype AND aco.bettype=cs3.bettype
            WHERE cs3.sporttype=161 AND cs3.bettype IN (85,86,87,89,90) AND cs3.alivepositiontaking<aco.minlivepositiontaking

            -- UPDATE a1 WHEN a1>l2
            -- a1=l2
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                apositiontaking = aco.maxpositiontaking
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = @recommend  AND aco.sporttype=cs3.sporttype AND aco.bettype=cs3.bettype
            WHERE cs3.sporttype = 161 AND cs3.bettype IN (81,83,86,88) AND cs3.apositiontaking>aco.maxpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                alivepositiontaking = aco.maxlivepositiontaking
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = @recommend  AND aco.sporttype=cs3.sporttype AND aco.bettype=cs3.bettype
            WHERE cs3.sporttype=161 AND cs3.bettype IN (85,86,87,89,90) AND cs3.alivepositiontaking>aco.maxlivepositiontaking

            --Recal AUTO MPT 
            --UPDATE m1=min(m3-a1,u2)
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK) 
            SET mpositiontaking = 
                    CASE WHEN mcs.mpositiontaking-cs3.apositiontaking > CASE WHEN cs3.isautompositiontaking = 1 THEN cs3.autompositiontaking ELSE acs.autompositiontaking END
                        then CASE WHEN cs3.isautompositiontaking = 1 THEN cs3.autompositiontaking ELSE acs.autompositiontaking END
                    else  mcs.mpositiontaking-cs3.apositiontaking END
            from
                custsetting3rd cs3
                INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
                INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend AND mcs.sporttype=cs3.sporttype AND mcs.bettype=cs3.bettype
                INNER JOIN custsetting3rd acs WITH(NOLOCK) ON acs.custid = c.recommend AND acs.sporttype=cs3.sporttype AND acs.bettype=cs3.bettype
            where
                c.recommend = @recommend
                and c.roleid = 1
                and cs3.sporttype = 161
                and cs3.bettype IN (81,83,86,88)
            and (acs.isautompositiontaking = 1 OR cs3.isautompositiontaking = 1)
                
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK) 
            SET mlivepositiontaking =
                    CASE WHEN mcs.mlivepositiontaking-cs3.alivepositiontaking > CASE WHEN cs3.isautolivempositiontaking = 1 THEN cs3.autolivempositiontaking ELSE acs.autolivempositiontaking END
                        then CASE WHEN cs3.isautolivempositiontaking = 1 THEN cs3.autolivempositiontaking ELSE acs.autolivempositiontaking END
                    else  mcs.mlivepositiontaking-cs3.alivepositiontaking END
            from
                custsetting3rd cs3
                INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
                INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend AND mcs.sporttype=cs3.sporttype AND mcs.bettype=cs3.bettype
                INNER JOIN custsetting3rd acs WITH(NOLOCK) ON acs.custid = c.recommend AND acs.sporttype=cs3.sporttype AND acs.bettype=cs3.bettype
            where
                c.recommend = @recommend
                and c.roleid = 1
                and cs3.sporttype = 161
                and cs3.bettype IN (85,86,87,89,90)
                and (acs.isautolivempositiontaking = 1 OR cs3.isautolivempositiontaking = 1)

            --check master min/max
            -- UPDATE m1 WHEN m1+a1<n3
            -- m1=n3-a1
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                mpositiontaking = mco.minpositiontaking-cs3.apositiontaking
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend  AND mco.sporttype=cs3.sporttype AND mco.bettype=cs3.bettype
            WHERE cs3.sporttype = 161 AND cs3.bettype IN (81,83,86,88) AND cs3.apositiontaking+cs3.mpositiontaking<mco.minpositiontaking


            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                mlivepositiontaking = mco.minlivepositiontaking-cs3.alivepositiontaking
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend  AND mco.sporttype=cs3.sporttype AND mco.bettype=cs3.bettype
            WHERE cs3.sporttype=161 AND cs3.bettype IN (85,86,87,89,90) AND cs3.alivepositiontaking+cs3.mlivepositiontaking<mco.minlivepositiontaking

            -- UPDATE m1,a1 WHEN m1+a1>l3
            -- m1=min(m3,l3)-a1
            -- a1=max(iif(m1+a1>min(m3,l3),min(m3,l3)-m1,a1),n2)
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                @maxmapos = CASE WHEN mcs.mpositiontaking>mco.maxpositiontaking THEN mco.maxpositiontaking ELSE mcs.mpositiontaking END,
                @mpos = CASE WHEN @maxmapos-cs3.apositiontaking<0 THEN 0 ELSE @maxmapos-cs3.apositiontaking END,
                mpositiontaking = @mpos,
                @apos = CASE WHEN cs3.apositiontaking + @mpos>@maxmapos THEN @maxmapos-@mpos ELSE cs3.apositiontaking END,
                apositiontaking = CASE WHEN @apos<aco.minpositiontaking THEN aco.minpositiontaking ELSE @apos END
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend  AND mcs.sporttype=cs3.sporttype AND mcs.bettype=cs3.bettype
                INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend  AND mco.sporttype=cs3.sporttype AND mco.bettype=cs3.bettype
                INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = @recommend  AND aco.sporttype=cs3.sporttype AND aco.bettype=cs3.bettype
            WHERE cs3.sporttype = 161  AND cs3.bettype IN (81,83,86,88) AND  cs3.apositiontaking+cs3.mpositiontaking>mco.maxpositiontaking

            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                @maxmapos = CASE WHEN mcs.mlivepositiontaking>mco.maxlivepositiontaking THEN mco.maxlivepositiontaking ELSE mcs.mlivepositiontaking END,
                @mpos = CASE WHEN @maxmapos-cs3.alivepositiontaking<0 THEN 0 ELSE @maxmapos-cs3.alivepositiontaking END,
                mlivepositiontaking = @mpos,
                @apos = CASE WHEN cs3.alivepositiontaking + @mpos>@maxmapos THEN @maxmapos-@mpos ELSE cs3.alivepositiontaking END,
                alivepositiontaking = CASE WHEN @apos<aco.minlivepositiontaking THEN aco.minlivepositiontaking ELSE @apos END
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend  AND mcs.sporttype=cs3.sporttype AND mcs.bettype=cs3.bettype
                INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend  AND mco.sporttype=cs3.sporttype AND mco.bettype=cs3.bettype
                INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = @recommend  AND aco.sporttype=cs3.sporttype AND aco.bettype=cs3.bettype
            WHERE cs3.sporttype=161 AND cs3.bettype IN (85,86,87,89,90) AND cs3.alivepositiontaking+cs3.mlivepositiontaking>mco.maxlivepositiontaking

            --s1=min(s4-m1-a1,u)
            --recal autopos
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK) 
                SET spositiontaking = CASE WHEN scs.spositiontaking-cs3.mpositiontaking-cs3.apositiontaking >
                                        (CASE WHEN cs3.isautopositiontaking=1 THEN cs3.autopositiontaking ELSE mcs.autopositiontaking END) THEN (CASE WHEN cs3.isautopositiontaking=1 THEN cs3.autopositiontaking ELSE mcs.autopositiontaking END) ELSE scs.spositiontaking-cs3.mpositiontaking-cs3.apositiontaking END 
            from
                custsetting3rd cs3
                INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
                INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend AND mcs.sporttype=cs3.sporttype AND mcs.bettype=cs3.bettype
                INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @srecommend AND scs.sporttype=cs3.sporttype AND scs.bettype=cs3.bettype
            where
                c.recommend = @recommend
                and c.roleid = 1
                and cs3.sporttype = 161
                and cs3.bettype IN (81,83,86,88)
                and (cs3.isautopositiontaking=1 OR mcs.isautopositiontaking=1)

            UPDATE cs3 WITH(ROWLOCK, UPDLOCK) 
                SET slivepositiontaking = CASE WHEN scs.slivepositiontaking-cs3.mlivepositiontaking-cs3.alivepositiontaking >
                                        (CASE WHEN cs3.isautolivepositiontaking=1 THEN cs3.autolivepositiontaking ELSE mcs.autolivepositiontaking END) THEN (CASE WHEN cs3.isautolivepositiontaking=1 THEN cs3.autolivepositiontaking ELSE mcs.autolivepositiontaking END) ELSE scs.slivepositiontaking-cs3.mlivepositiontaking-cs3.alivepositiontaking END 
            from
                custsetting3rd cs3
                INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
                INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend AND mcs.sporttype=cs3.sporttype AND mcs.bettype=cs3.bettype
                INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @srecommend AND scs.sporttype=cs3.sporttype AND scs.bettype=cs3.bettype
            where
                c.recommend = @recommend
                and c.roleid = 1
                and cs3.sporttype = 161
                and cs3.bettype IN (85,86,87,89,90)
                and (cs3.isautolivepositiontaking=1 OR mcs.isautolivepositiontaking=1)    
                
            --check super min/max
            --UPDATE s1 WHEN s1+m1+a1<n4
            --s1=n4-m1-a1 
            --v161
            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                spositiontaking = sco.minpositiontaking-cs3.mpositiontaking-cs3.apositiontaking
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custoverride3rd sco WITH(NOLOCK) ON sco.custid = @srecommend  AND sco.sporttype=cs3.sporttype AND sco.bettype=cs3.bettype
            WHERE cs3.sporttype = 161 AND cs3.bettype IN (81,83,86,88) AND cs3.apositiontaking+cs3.mpositiontaking+cs3.spositiontaking<sco.minpositiontaking

            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                slivepositiontaking = sco.minlivepositiontaking-cs3.mlivepositiontaking-cs3.alivepositiontaking
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custoverride3rd sco WITH(NOLOCK) ON sco.custid = @srecommend  AND sco.sporttype=cs3.sporttype AND sco.bettype=cs3.bettype
            WHERE cs3.sporttype=161 AND cs3.bettype IN (85,86,87,89,90) AND cs3.alivepositiontaking+cs3.mlivepositiontaking+cs3.slivepositiontaking<sco.minlivepositiontaking

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
               SET 
                @spos = CASE WHEN scs.spositiontaking-cs3.mpositiontaking-cs3.apositiontaking<0 THEN 0 ELSE scs.spositiontaking-cs3.mpositiontaking-cs3.apositiontaking END,
                spositiontaking = @spos,
                @mapos1 = CASE WHEN @spos+cs3.mpositiontaking+cs3.apositiontaking>scs.spositiontaking THEN scs.spositiontaking-@spos ELSE cs3.mpositiontaking+cs3.apositiontaking END,
                @maxmapos = CASE WHEN mcs.mpositiontaking>mco.maxpositiontaking THEN mco.maxpositiontaking ELSE mcs.mpositiontaking END,
                @mapos2 = CASE WHEN @mapos1>@maxmapos THEN @maxmapos ELSE @mapos1 END,
                @mapos = CASE WHEN @mapos2<mco.minpositiontaking THEN mco.minpositiontaking ELSE @mapos2 END,
                @mpos = CASE WHEN @mapos-cs3.apositiontaking<0 THEN 0 ELSE @mapos-cs3.apositiontaking END,
                mpositiontaking = @mpos,
                @apos = CASE WHEN cs3.apositiontaking + @mpos>@mapos THEN @mapos-@mpos ELSE cs3.apositiontaking END,
                apositiontaking = CASE WHEN @apos<aco.minpositiontaking THEN aco.minpositiontaking ELSE @apos END
            FROM 
                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @srecommend  AND scs.sporttype=cs3.sporttype AND scs.bettype=cs3.bettype
                INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend  AND mcs.sporttype=cs3.sporttype AND mcs.bettype=cs3.bettype
                INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend  AND mco.sporttype=cs3.sporttype AND mco.bettype=cs3.bettype
                INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = @recommend  AND aco.sporttype=cs3.sporttype AND aco.bettype=cs3.bettype
            WHERE cs3.sporttype = 161 AND cs3.bettype IN  (81,83,86,88) AND  cs3.spositiontaking+cs3.apositiontaking+cs3.mpositiontaking>scs.spositiontaking

            UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
               SET 
                @spos = CASE WHEN scs.slivepositiontaking-cs3.mlivepositiontaking-cs3.alivepositiontaking<0 THEN 0 ELSE scs.slivepositiontaking-cs3.mlivepositiontaking-cs3.alivepositiontaking END,
                slivepositiontaking = @spos,
                @mapos1 = CASE WHEN @spos+cs3.mlivepositiontaking+cs3.alivepositiontaking>scs.slivepositiontaking THEN scs.slivepositiontaking-@spos ELSE cs3.mlivepositiontaking+cs3.alivepositiontaking END,
                @maxmapos = CASE WHEN mcs.mlivepositiontaking>mco.maxlivepositiontaking THEN mco.maxlivepositiontaking ELSE mcs.mlivepositiontaking END,
                @mapos2 = CASE WHEN @mapos1>@maxmapos THEN @maxmapos ELSE @mapos1 END,
                @mapos = CASE WHEN @mapos2<mco.minlivepositiontaking THEN mco.minlivepositiontaking ELSE @mapos2 END,
                @mpos = CASE WHEN @mapos-cs3.alivepositiontaking<0 THEN 0 ELSE @mapos-cs3.alivepositiontaking END,
                mlivepositiontaking = @mpos,
                @apos = CASE WHEN cs3.alivepositiontaking + @mpos>@mapos THEN @mapos-@mpos ELSE cs3.alivepositiontaking END,
                alivepositiontaking = CASE WHEN @apos<aco.minlivepositiontaking THEN aco.minlivepositiontaking ELSE @apos END
            FROM 

                custsetting3rd cs3 INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @srecommend  AND scs.sporttype=cs3.sporttype AND scs.bettype=cs3.bettype
                INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = @mrecommend  AND mcs.sporttype=cs3.sporttype AND mcs.bettype=cs3.bettype
                INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = @mrecommend  AND mco.sporttype=cs3.sporttype AND mco.bettype=cs3.bettype
                INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = @recommend  AND aco.sporttype=cs3.sporttype AND aco.bettype=cs3.bettype
            WHERE cs3.sporttype=161 AND cs3.bettype IN (85,86,87,89,90) AND cs3.slivepositiontaking+cs3.alivepositiontaking+cs3.mlivepositiontaking>scs.slivepositiontaking
        END
        
        IF @mode = 'Keno' OR @mode = 'GoldDeluxe'
        BEGIN    
            SELECT    @recommend = custid,
                    @srecommend = srecommend
            FROM custinfo WITH(NOLOCK)
            WHERE custid = @custid

            --check agent min/max
            -- UPDATE a1 WHEN a1<n2
            -- a1=n2
            UPDATE csg WITH(ROWLOCK, UPDLOCK) 
            SET 
                apositiontaking = aco.minpositiontaking,
                mpositiontaking = CASE WHEN csg.mpositiontaking + aco.minpositiontaking > mcs.mpositiontaking THEN mcs.mpositiontaking-aco.minpositiontaking ELSE csg.mpositiontaking END
            FROM custsettingGame csg 
                INNER JOIN custinfo mb WITH(NOLOCK) ON csg.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custsettingGame mcs WITH(NOLOCK) ON mcs.custid = @mrecommend  AND mcs.sporttype=csg.sporttype AND mcs.bettype=csg.bettype
                INNER JOIN custoverridegame aco WITH(NOLOCK) ON aco.custid = @recommend  AND aco.sporttype=csg.sporttype AND aco.bettype=csg.bettype
            WHERE csg.apositiontaking < aco.minpositiontaking
                AND csg.sporttype = @sporttype AND csg.bettype = @bettype

            --Recal AUTO MPT 
            --UPDATE m1=min(m3-a1,u2)
            UPDATE custsettingGame WITH(ROWLOCK, UPDLOCK) 
            SET mpositiontaking = 
                    CASE WHEN mcs.mpositiontaking-custsettingGame.apositiontaking > CASE WHEN custsettingGame.isautompositiontaking = 1 THEN custsettingGame.autompositiontaking ELSE acs.autompositiontaking END
                        then CASE WHEN custsettingGame.isautompositiontaking = 1 THEN custsettingGame.autompositiontaking ELSE acs.autompositiontaking END
                    else  mcs.mpositiontaking-custsettingGame.apositiontaking END
            from
                custsettingGame
                INNER JOIN custinfo c WITH(NOLOCK) ON custsettingGame.custid = c.custid
                INNER JOIN custsettingGame mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend AND mcs.sporttype=custsettingGame.sporttype AND mcs.bettype=custsettingGame.bettype
                INNER JOIN custsettingGame acs WITH(NOLOCK) ON acs.custid = c.recommend AND acs.sporttype=custsettingGame.sporttype AND acs.bettype=custsettingGame.bettype
            where
                c.recommend = @recommend
                and c.roleid = 1 
                and custsettingGame.sporttype = @sporttype AND custsettingGame.bettype = @bettype
            and (acs.isautompositiontaking = 1 OR custsettingGame.isautompositiontaking = 1)

            --check master min/max
            -- UPDATE m1 WHEN m1+a1<n3
            -- m1=n3-a1
            UPDATE custsettingGame WITH(ROWLOCK, UPDLOCK)
               SET 
                mpositiontaking = mco.minpositiontaking-custsettingGame.apositiontaking
            FROM 
                custsettingGame 
                INNER JOIN custinfo mb WITH(NOLOCK) ON custsettingGame.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1 
                INNER JOIN custoverrideGame mco WITH(NOLOCK) ON mco.custid = @mrecommend  AND mco.sporttype=custsettingGame.sporttype AND mco.bettype=custsettingGame.bettype
            WHERE custsettingGame.apositiontaking+custsettingGame.mpositiontaking<mco.minpositiontaking
                and custsettingGame.sporttype = @sporttype AND custsettingGame.bettype = @bettype

            --s1=min(s4-m1-a1,u)
            --recal autopos
            UPDATE custsettingGame WITH(ROWLOCK, UPDLOCK) 
                SET spositiontaking = CASE WHEN scs.spositiontaking-custsettingGame.mpositiontaking-custsettingGame.apositiontaking >
                                        (CASE WHEN custsettingGame.isautopositiontaking=1 THEN custsettingGame.autopositiontaking ELSE mcs.autopositiontaking END) THEN (CASE WHEN custsettingGame.isautopositiontaking=1 THEN custsettingGame.autopositiontaking ELSE mcs.autopositiontaking END) ELSE scs.spositiontaking-custsettingGame.mpositiontaking-custsettingGame.apositiontaking END 
            from
                custsettingGame
                INNER JOIN custinfo c WITH(NOLOCK) ON custsettingGame.custid = c.custid
                INNER JOIN custsettingGame mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend AND mcs.sporttype=custsettingGame.sporttype AND mcs.bettype=custsettingGame.bettype
                INNER JOIN custsettingGame scs WITH(NOLOCK) ON scs.custid = @srecommend AND scs.sporttype=custsettingGame.sporttype AND scs.bettype=custsettingGame.bettype
            where
                c.recommend = @recommend
                and c.roleid = 1 
                and custsettingGame.sporttype = @sporttype AND custsettingGame.bettype = @bettype
                and (custsettingGame.isautopositiontaking=1 OR mcs.isautopositiontaking=1)

            --check super min/max
            --UPDATE s1 WHEN s1+m1+a1<n4
            --s1=n4-m1-a1 
            UPDATE custsettingGame WITH(ROWLOCK, UPDLOCK)
               SET 
                spositiontaking = sco.minpositiontaking-custsettingGame.mpositiontaking-custsettingGame.apositiontaking
            FROM 
                custsettingGame INNER JOIN custinfo mb WITH(NOLOCK) ON custsettingGame.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1
                INNER JOIN custoverrideGame sco WITH(NOLOCK) ON sco.custid = @srecommend  AND sco.sporttype=custsettingGame.sporttype AND sco.bettype=custsettingGame.bettype
            WHERE custsettingGame.apositiontaking+custsettingGame.mpositiontaking+custsettingGame.spositiontaking<sco.minpositiontaking
                and custsettingGame.sporttype = @sporttype AND custsettingGame.bettype = @bettype

            --UPDATE s1,m1,a1 IN CASE s1+m1+a1>s4
            --s1=max(0,s4-m1-a1)
            --@mapos1=iif(s1_new+m1+a1>s4,s4-s1_new,m1+a1)
            --@maxmapos=min(m3,l3)
            --@mapos2=min(@mapos1,@maxmapos)
            --@mapos=max(@mapos2,n3)
            --m1=max(0,@mapos-a1)
            --a1=iif(m1_new+a1>@mapos,@mapos-m1_new,a1)
            UPDATE custsettingGame WITH(ROWLOCK, UPDLOCK)
               SET 
                @spos = CASE WHEN scs.spositiontaking-custsettingGame.mpositiontaking-custsettingGame.apositiontaking<0 THEN 0 ELSE scs.spositiontaking-custsettingGame.mpositiontaking-custsettingGame.apositiontaking END,
                spositiontaking = @spos,
                @mapos1 = CASE WHEN @spos+custsettingGame.mpositiontaking+custsettingGame.apositiontaking>scs.spositiontaking THEN scs.spositiontaking-@spos ELSE custsettingGame.mpositiontaking+custsettingGame.apositiontaking END,
                --@maxmapos = CASE WHEN mcs.mpositiontaking>mco.maxpositiontaking THEN mco.maxpositiontaking ELSE mcs.mpositiontaking END,
                @mapos2 = CASE WHEN @mapos1>@maxmapos THEN @maxmapos ELSE @mapos1 END,
                @mapos = CASE WHEN @mapos2<mco.minpositiontaking THEN mco.minpositiontaking ELSE @mapos2 END,
                @mpos = CASE WHEN @mapos-custsettingGame.apositiontaking<0 THEN 0 ELSE @mapos-custsettingGame.apositiontaking END,
                mpositiontaking = @mpos,
                @apos = CASE WHEN custsettingGame.apositiontaking + @mpos>@mapos THEN @mapos-@mpos ELSE custsettingGame.apositiontaking END,
                apositiontaking = CASE WHEN @apos<aco.minpositiontaking THEN aco.minpositiontaking ELSE @apos END
            FROM 
                custsettingGame INNER JOIN custinfo mb WITH(NOLOCK) ON custsettingGame.custid = mb.custid AND mb.recommend=@recommend AND mb.roleid=1 
                INNER JOIN custsettingGame scs WITH(NOLOCK) ON scs.custid = @srecommend  AND scs.sporttype=custsettingGame.sporttype AND scs.bettype=custsettingGame.bettype
                INNER JOIN custsettingGame mcs WITH(NOLOCK) ON mcs.custid = @mrecommend  AND mcs.sporttype=custsettingGame.sporttype AND mcs.bettype=custsettingGame.bettype
                INNER JOIN custoverrideGame mco WITH(NOLOCK) ON mco.custid = @mrecommend  AND mco.sporttype=custsettingGame.sporttype AND mco.bettype=custsettingGame.bettype
                INNER JOIN custoverrideGame aco WITH(NOLOCK) ON aco.custid = @recommend  AND aco.sporttype=custsettingGame.sporttype AND aco.bettype=custsettingGame.bettype
            WHERE custsettingGame.spositiontaking+custsettingGame.apositiontaking+custsettingGame.mpositiontaking>scs.spositiontaking
                and custsettingGame.sporttype = @sporttype AND custsettingGame.bettype = @bettype

        END
    END    
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------

------------------------------------------------------	
 ---STEP 2: deploy this sp on DBCUST
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
    @custid int,
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('custOverride3rd') = 0 RETURN	
		
	DECLARE @roleid int, @srecommend int, @mrecommend int, @recommend int
	SELECT @roleid = roleid, @srecommend=srecommend, @mrecommend=mrecommend, @recommend=recommend FROM customer WITH (NOLOCK) WHERE custid = @custid

	UPDATE custOverride3rd WITH(ROWLOCK, UPDLOCK)
	SET minpositiontaking = maxpositiontaking, 
		minlivepositiontaking = maxlivepositiontaking
	WHERE custOverride3rd.custid = @custid
	
	IF @roleid = 2
	BEGIN
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @recommend = @recommend, @mode = 'number', @roleid = @roleid, @Target = @Target
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1501, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1503, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1504, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1505, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1507, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1508, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1509, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1511, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1513, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1514, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'GoldDeluxe', @sporttype=255, @bettype = 1701, @roleid = @roleid, @Target = @Target		
	END
	ELSE IF @roleid = 3
	BEGIN
		EXEC Acc_CustSetting3rd_18 @mrecommend = @mrecommend, @srecommend = @srecommend, @mode = 'number', @roleid = @roleid, @Target = @Target
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1501, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1503, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1504, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1505, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1507, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1508, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1509, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1511, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1513, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1514, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'GoldDeluxe', @sporttype=255, @bettype = 1701, @roleid = @roleid, @Target = @Target				
	END
	ELSE IF @roleid= 4 
	BEGIN
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mode = 'number', @roleid = @roleid, @Target = @Target
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1501, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1503, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1504, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1505, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1507, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1508, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1509, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1511, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1513, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1514, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'GoldDeluxe', @sporttype=255, @bettype = 1701, @roleid = @roleid, @Target = @Target						
	END		
	              
END    
GO
-- END STEP 2: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
 
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #tmpCust (custid int, isfinished bit default(0))
    
DECLARE @custid INT

----CustomerList
INSERT INTO #tmpCust(custid)					
	  SELECT '5603319'				--BHK
UNION ALL SELECT '1146496'				--BNE
UNION ALL SELECT '26337653'				--BS-JPY
UNION ALL SELECT '36077034'				--CLE
UNION ALL SELECT '20605416'				--CSDTEST1
UNION ALL SELECT '1382642'				--CTESTR
UNION ALL SELECT '13063323'				--DB
UNION ALL SELECT '16136074'				--ETB
UNION ALL SELECT '1091262'				--HIR
UNION ALL SELECT '570306'				--IMBJPY
UNION ALL SELECT '570302'				--IMBUSD
UNION ALL SELECT '608348'				--ITSA5
UNION ALL SELECT '9573322'				--JIP
UNION ALL SELECT '6173539'				--LC-RM
UNION ALL SELECT '7352491'				--LC-SD
UNION ALL SELECT '12319010'				--LR
UNION ALL SELECT '1688074'				--MTEST
UNION ALL SELECT '1807421'				--MTESTEU
UNION ALL SELECT '25196224'				--OPS-GBP
UNION ALL SELECT '25197688'				--OPS-HKK
UNION ALL SELECT '25197748'				--OPS-IDD
UNION ALL SELECT '25197264'				--OPS-RM
UNION ALL SELECT '25197518'				--OPS-RMB
UNION ALL SELECT '25197906'				--OPS-THB
UNION ALL SELECT '25196109'				--OPS-US$
UNION ALL SELECT '11211742'				--S11RUP
UNION ALL SELECT '3451158'				--S11Y
UNION ALL SELECT '8021101'				--S5D
UNION ALL SELECT '1090001'				--sa-pppp
UNION ALL SELECT '5254477'				--SBKKwrong
UNION ALL SELECT '7119552'				--skwrongxxx
UNION ALL SELECT '8156203'				--SLAM
UNION ALL SELECT '27429881'				--StarixY9TH
UNION ALL SELECT '8159964'				--TD88
UNION ALL SELECT '25722901'				--TestRM
UNION ALL SELECT '23137843'				--Test-RM
UNION ALL SELECT '19272511'				--YSM
UNION ALL SELECT '16773713'				--MLAMRM
UNION ALL SELECT '1091678'				--S5P
UNION ALL SELECT '2051039'				--S5RR
UNION ALL SELECT '1022678'				--S5TT
UNION ALL SELECT '1867721'				--S09H
UNION ALL SELECT '5005322'				--S09M
UNION ALL SELECT '461780'				--S58R
UNION ALL SELECT '405422'				--S58RM
UNION ALL SELECT '33267199'				--BMX
UNION ALL SELECT '2601912'				--S39RR
UNION ALL SELECT '4940784'				--DKD
UNION ALL SELECT '987495'				--S32AH
UNION ALL SELECT '1456420'				--S32AM
UNION ALL SELECT '987497'				--S32BH
UNION ALL SELECT '3654316'				--S32BM
UNION ALL SELECT '987499'				--S32CH
UNION ALL SELECT '17931860'				--S32CM
UNION ALL SELECT '987501'				--S32DH
UNION ALL SELECT '24619005'				--S32DM
UNION ALL SELECT '1366843'				--S32FH
UNION ALL SELECT '857802'				--S32H
UNION ALL SELECT '2284508'				--S32HH
UNION ALL SELECT '15657898'				--S32HKD
UNION ALL SELECT '2838764'				--S32IH
UNION ALL SELECT '3195166'				--S32JH
UNION ALL SELECT '15548698'				--S32K
UNION ALL SELECT '19075657'				--S32KK
UNION ALL SELECT '15657985'				--S32RM
UNION ALL SELECT '324558'				--S32RMB
UNION ALL SELECT '404941'				--S305RM
UNION ALL SELECT '972747'				--S3H
UNION ALL SELECT '3560324'				--S3HH
UNION ALL SELECT '7763508'				--S3HK
UNION ALL SELECT '4362130'				--SSF5H
UNION ALL SELECT '6032879'				--PPB
UNION ALL SELECT '6032912'				--PPR
UNION ALL SELECT '301152'				--SPH
UNION ALL SELECT '261425'				--SPR
UNION ALL SELECT '970269'				--SALH
UNION ALL SELECT '447479'				--SALR
UNION ALL SELECT '726582'				--KAM
UNION ALL SELECT '726562'				--KAR
UNION ALL SELECT '726571'				--KBR
UNION ALL SELECT '726579'				--KCR
UNION ALL SELECT '1164457'				--KDR
UNION ALL SELECT '1238537'				--KER
UNION ALL SELECT '194355'				--KH
UNION ALL SELECT '896708'				--KHAH
UNION ALL SELECT '913628'				--KHBH
UNION ALL SELECT '30475562'				--KHC
UNION ALL SELECT '1069029'				--KHCH
UNION ALL SELECT '2400612'				--KHDH
UNION ALL SELECT '674248'				--KHH
UNION ALL SELECT '712272'				--KHK
UNION ALL SELECT '1537683'				--KHT
UNION ALL SELECT '194354'				--KM
UNION ALL SELECT '476776'				--KMA
UNION ALL SELECT '727340'				--KMAM
UNION ALL SELECT '877777'				--KMBM
UNION ALL SELECT '395075'				--KMM
UNION ALL SELECT '194356'				--KR
UNION ALL SELECT '461767'				--KRR
UNION ALL SELECT '394310'				--KSD
UNION ALL SELECT '4204225'				--79AH
UNION ALL SELECT '4204369'				--79AR
UNION ALL SELECT '29009895'				--801CM
UNION ALL SELECT '30765689'				--801EM
UNION ALL SELECT '6249438'				--87R
UNION ALL SELECT '840993'				--SG1H
UNION ALL SELECT '4181669'				--SG21H
UNION ALL SELECT '4780138'				--SG25H
UNION ALL SELECT '840999'				--SG2H
UNION ALL SELECT '4487258'				--SG2M
UNION ALL SELECT '10719518'				--SG33H
UNION ALL SELECT '1923414'				--SG4H
UNION ALL SELECT '1927603'				--SG6H
UNION ALL SELECT '7680993'				--SG7M
UNION ALL SELECT '8119630'				--SG8M
UNION ALL SELECT '7939911'				--SGGT
UNION ALL SELECT '832992'				--SGH
UNION ALL SELECT '398437'				--SGM
UNION ALL SELECT '399130'				--SGR
UNION ALL SELECT '11314815'				--SGRD
UNION ALL SELECT '324561'				--SGURMB
UNION ALL SELECT '36454579'				--S999M
UNION ALL SELECT '20141184'				--S999RM
UNION ALL SELECT '10440396'				--S999S
UNION ALL SELECT '33881912'				--2699M
UNION ALL SELECT '35213224'				--3135RM
UNION ALL SELECT '33852218'				--9542M
UNION ALL SELECT '24404342'				--S68AH
UNION ALL SELECT '29401764'				--AAH
UNION ALL SELECT '9905998'				--AC1
UNION ALL SELECT '21584528'				--AC18
UNION ALL SELECT '29003710'				--AC20
UNION ALL SELECT '13290701'				--ACH
UNION ALL SELECT '13562677'				--ACH1
UNION ALL SELECT '13863347'				--ACH3
UNION ALL SELECT '18515475'				--ACH6
UNION ALL SELECT '19310674'				--ACH7
UNION ALL SELECT '12168675'				--ACK
UNION ALL SELECT '33419048'				--ACK1
UNION ALL SELECT '19996696'				--ACK2
UNION ALL SELECT '25266465'				--AGC
UNION ALL SELECT '16204333'				--AGD
UNION ALL SELECT '26261138'				--AGE
UNION ALL SELECT '25274162'				--AGN
UNION ALL SELECT '4115476'				--AHA
UNION ALL SELECT '3780034'				--AHL
UNION ALL SELECT '1628179'				--AHM
UNION ALL SELECT '1628290'				--AHN
UNION ALL SELECT '2197674'				--AHO
UNION ALL SELECT '3872491'				--AHT
UNION ALL SELECT '5336854'				--AHV
UNION ALL SELECT '13058363'				--AHZ
UNION ALL SELECT '2221671'				--BHO
UNION ALL SELECT '5780740'				--BHS
UNION ALL SELECT '11028100'				--AHMA
UNION ALL SELECT '13744152'				--AG
UNION ALL SELECT '1812820'				--AW
UNION ALL SELECT '8066804'				--AZ
UNION ALL SELECT '18364243'				--WJ
UNION ALL SELECT '5712158'				--AX
UNION ALL SELECT '12550356'				--AXA
UNION ALL SELECT '7292508'				--AXH
UNION ALL SELECT '12644625'				--AXHK
UNION ALL SELECT '9932698'				--AXT
UNION ALL SELECT '865485'				--SKHK
UNION ALL SELECT '1995341'				--SKM
UNION ALL SELECT '884262'				--SKR
UNION ALL SELECT '28968342'				--BAH
UNION ALL SELECT '24992578'				--BAK
UNION ALL SELECT '31949474'				--BAL
UNION ALL SELECT '36902576'				--BAO
UNION ALL SELECT '36584443'				--BAP
UNION ALL SELECT '15825686'				--RB168
UNION ALL SELECT '1795270'				--SBBR
UNION ALL SELECT '1558372'				--SBBT
UNION ALL SELECT '29899882'				--BBT
UNION ALL SELECT '642291'				--BI
UNION ALL SELECT '13934944'				--BJ
UNION ALL SELECT '21299450'				--BPM
UNION ALL SELECT '36670491'				--BPN
UNION ALL SELECT '17066207'				--BYU
UNION ALL SELECT '10369357'				--C1
UNION ALL SELECT '12070389'				--C12
UNION ALL SELECT '12276215'				--C15
UNION ALL SELECT '31948257'				--C16
UNION ALL SELECT '10560596'				--C2
UNION ALL SELECT '10775412'				--C3
UNION ALL SELECT '11639821'				--C8
UNION ALL SELECT '9579024'				--cks
UNION ALL SELECT '13068960'				--CV
UNION ALL SELECT '13856586'				--KP
UNION ALL SELECT '21423676'				--P9
UNION ALL SELECT '5394462'				--CCM
UNION ALL SELECT '3810473'				--CCT
UNION ALL SELECT '14624531'				--CEH
UNION ALL SELECT '14622428'				--CER
UNION ALL SELECT '33470941'				--CHA
UNION ALL SELECT '1528421'				--B10T
UNION ALL SELECT '1528422'				--B11T
UNION ALL SELECT '1536432'				--B12T
UNION ALL SELECT '1538057'				--B13T
UNION ALL SELECT '1538175'				--B14T
UNION ALL SELECT '1538183'				--B15T
UNION ALL SELECT '1538997'				--B16T
UNION ALL SELECT '1539009'				--B17T
UNION ALL SELECT '1539693'				--B18T
UNION ALL SELECT '1539698'				--B19T
UNION ALL SELECT '1523261'				--B1T
UNION ALL SELECT '1539699'				--B20T
UNION ALL SELECT '1539700'				--B21T
UNION ALL SELECT '1540216'				--B22T
UNION ALL SELECT '1540217'				--B23T
UNION ALL SELECT '1588140'				--B24T
UNION ALL SELECT '1588145'				--B25T
UNION ALL SELECT '2508822'				--B26T
UNION ALL SELECT '2541779'				--B27T
UNION ALL SELECT '7815141'				--B29T
UNION ALL SELECT '1528410'				--B2T
UNION ALL SELECT '9664861'				--B31T
UNION ALL SELECT '9669693'				--B32T
UNION ALL SELECT '9933863'				--B33T
UNION ALL SELECT '9934001'				--B34T
UNION ALL SELECT '9933940'				--B35T
UNION ALL SELECT '9934027'				--B36T
UNION ALL SELECT '17305892'				--B46T
UNION ALL SELECT '17305980'				--B47T
UNION ALL SELECT '1528413'				--B4T
UNION ALL SELECT '18452186'				--B50T
UNION ALL SELECT '18452187'				--B51T
UNION ALL SELECT '21639245'				--B53T
UNION ALL SELECT '21639246'				--B54T
UNION ALL SELECT '1517951'				--B5T
UNION ALL SELECT '26979533'				--B60T
UNION ALL SELECT '1528414'				--B6T
UNION ALL SELECT '1528418'				--B7T
UNION ALL SELECT '1528419'				--B8T
UNION ALL SELECT '1528420'				--B9T
UNION ALL SELECT '1517030'				--BT
UNION ALL SELECT '2421122'				--SABT
UNION ALL SELECT '641144'				--ST2T
UNION ALL SELECT '2388779'				--STEB
UNION ALL SELECT '1563928'				--CI
UNION ALL SELECT '22918619'				--CLM
UNION ALL SELECT '2083036'				--CO
UNION ALL SELECT '2131553'				--CS
UNION ALL SELECT '14759423'				--CTH
UNION ALL SELECT '18889582'				--CTM
UNION ALL SELECT '16007620'				--CTV
UNION ALL SELECT '2103376'				--CU
UNION ALL SELECT '23280386'				--DMB
UNION ALL SELECT '18777368'				--DRM
UNION ALL SELECT '21229669'				--DRN
UNION ALL SELECT '21746732'				--DRP
UNION ALL SELECT '29895950'				--HD6
UNION ALL SELECT '32019482'				--DE
UNION ALL SELECT '897588'				--DI
UNION ALL SELECT '17041176'				--DM
UNION ALL SELECT '18579339'				--DS1
UNION ALL SELECT '1652112'				--S42CH
UNION ALL SELECT '1640992'				--DAT
UNION ALL SELECT '1372998'				--DW
UNION ALL SELECT '30480498'				--EEB
UNION ALL SELECT '21227644'				--EED
UNION ALL SELECT '14393371'				--EEH
UNION ALL SELECT '14392343'				--EEM
UNION ALL SELECT '4604381'				--FBH
UNION ALL SELECT '2327638'				--SFB
UNION ALL SELECT '1373748'				--FF
UNION ALL SELECT '11566943'				--FJM
UNION ALL SELECT '22534793'				--FNG
UNION ALL SELECT '22534951'				--FNH
UNION ALL SELECT '22621772'				--FNM
UNION ALL SELECT '22535166'				--FNN
UNION ALL SELECT '22535487'				--FNU
UNION ALL SELECT '9428916'				--FYK
UNION ALL SELECT '8050233'				--FYS
UNION ALL SELECT '9934245'				--FYT
UNION ALL SELECT '4012673'				--FYY
UNION ALL SELECT '747037'				--GI
UNION ALL SELECT '8551070'				--gtwrong
UNION ALL SELECT '3100395'				--HHB
UNION ALL SELECT '3390598'				--HHBS
UNION ALL SELECT '2014372'				--HHG
UNION ALL SELECT '641918'				--HI
UNION ALL SELECT '1069683'				--HAH
UNION ALL SELECT '17905676'				--HIF
UNION ALL SELECT '889147'				--HIH
UNION ALL SELECT '1816739'				--HIK
UNION ALL SELECT '400973'				--HIS
UNION ALL SELECT '10392284'				--HIT
UNION ALL SELECT '2511910'				--HIW
UNION ALL SELECT '1029732'				--HJ
UNION ALL SELECT '2882278'				--HM
UNION ALL SELECT '712439'				--HP
UNION ALL SELECT '15615851'				--HP2
UNION ALL SELECT '11173365'				--HPD
UNION ALL SELECT '7723444'				--HPH
UNION ALL SELECT '5215598'				--HPI
UNION ALL SELECT '7656188'				--HPJ
UNION ALL SELECT '2251491'				--HPM
UNION ALL SELECT '5044097'				--HPMM
UNION ALL SELECT '2138601'				--HPO
UNION ALL SELECT '29609449'				--HTT
UNION ALL SELECT '11674017'				--MO
UNION ALL SELECT '11674030'				--MP
UNION ALL SELECT '20441569'				--MV
UNION ALL SELECT '23608613'				--MX
UNION ALL SELECT '22224357'				--HSM
UNION ALL SELECT '30376920'				--HSM1
UNION ALL SELECT '9931047'				--HT1
UNION ALL SELECT '9933782'				--HT2
UNION ALL SELECT '11306634'				--HT3
UNION ALL SELECT '19378350'				--HT4
UNION ALL SELECT '19380292'				--HT5
UNION ALL SELECT '3526034'				--ID
UNION ALL SELECT '14011590'				--IA
UNION ALL SELECT '14308443'				--IE
UNION ALL SELECT '5880048'				--IF
UNION ALL SELECT '18546512'				--IG
UNION ALL SELECT '27927536'				--IH
UNION ALL SELECT '689767'				--II
UNION ALL SELECT '4802250'				--IK
UNION ALL SELECT '4378806'				--IM
UNION ALL SELECT '4404078'				--IN
UNION ALL SELECT '31870999'				--IQ
UNION ALL SELECT '21549631'				--IU
UNION ALL SELECT '27231792'				--IY
UNION ALL SELECT '1564982'				--IP
UNION ALL SELECT '2831595'				--IR
UNION ALL SELECT '1220882'				--JAH
UNION ALL SELECT '1603986'				--JAM
UNION ALL SELECT '13469206'				--JARWRONG
UNION ALL SELECT '1248383'				--JAS
UNION ALL SELECT '1220879'				--JAT
UNION ALL SELECT '22765105'				--MBO
UNION ALL SELECT '21388074'				--JBM
UNION ALL SELECT '29802667'				--82M
UNION ALL SELECT '2302419'				--JJ
UNION ALL SELECT '5484091'				--JJB
UNION ALL SELECT '26858222'				--JJC
UNION ALL SELECT '11760592'				--JJM
UNION ALL SELECT '987804'				--S35H
UNION ALL SELECT '2258222'				--S35M
UNION ALL SELECT '1797678'				--JM
UNION ALL SELECT '19589733'				--JQ
UNION ALL SELECT '8657557'				--JR
UNION ALL SELECT '2199854'				--JS2
UNION ALL SELECT '19590429'				--JZ
UNION ALL SELECT '2829199'				--SJS
UNION ALL SELECT '24642387'				--JYD
UNION ALL SELECT '25185439'				--JYE
UNION ALL SELECT '26751787'				--JYF
UNION ALL SELECT '20461064'				--JYG
UNION ALL SELECT '31548037'				--JYH
UNION ALL SELECT '23625521'				--JYY
UNION ALL SELECT '1865464'				--KJM
UNION ALL SELECT '6525867'				--KJMD
UNION ALL SELECT '15583251'				--KJMF
UNION ALL SELECT '14014232'				--KAA
UNION ALL SELECT '16000766'				--KAC
UNION ALL SELECT '18201422'				--KAG
UNION ALL SELECT '26372036'				--KAP
UNION ALL SELECT '29184371'				--KBP
UNION ALL SELECT '23343127'				--KFU
UNION ALL SELECT '16594953'				--KGA
UNION ALL SELECT '16595046'				--KGB
UNION ALL SELECT '15927973'				--KGP
UNION ALL SELECT '12334400'				--KKF
UNION ALL SELECT '27748138'				--VVB
UNION ALL SELECT '4037357'				--KPM
UNION ALL SELECT '506057'				--SKPRMB
UNION ALL SELECT '12048828'				--KPW
UNION ALL SELECT '1088459'				--KYH
UNION ALL SELECT '2026798'				--KYM
UNION ALL SELECT '25216716'				--LHB
UNION ALL SELECT '25221008'				--LHC
UNION ALL SELECT '4374817'				--LHH
UNION ALL SELECT '7754066'				--LHH2
UNION ALL SELECT '7754182'				--LHH3
UNION ALL SELECT '11449326'				--LHH8
UNION ALL SELECT '8418095'				--LHHRMB
UNION ALL SELECT '25307522'				--LHJ
UNION ALL SELECT '4445198'				--LHM
UNION ALL SELECT '7753114'				--LHM1
UNION ALL SELECT '17107778'				--LHM5
UNION ALL SELECT '22031727'				--LHM7
UNION ALL SELECT '23033435'				--LHM8
UNION ALL SELECT '10044015'				--LHR
UNION ALL SELECT '8103018'				--LHS
UNION ALL SELECT '643456'				--LI
UNION ALL SELECT '14635815'				--BGR
UNION ALL SELECT '24839750'				--BJQ
UNION ALL SELECT '19040588'				--CHU
UNION ALL SELECT '19884111'				--FFF
UNION ALL SELECT '4792246'				--KD
UNION ALL SELECT '5771986'				--LA
UNION ALL SELECT '3770553'				--LB
UNION ALL SELECT '3810488'				--LC
UNION ALL SELECT '3954915'				--LD
UNION ALL SELECT '3973944'				--LE
UNION ALL SELECT '4189499'				--LF
UNION ALL SELECT '7680679'				--LG
UNION ALL SELECT '2749224'				--LH
UNION ALL SELECT '2075688'				--LJ
UNION ALL SELECT '7680792'				--LM
UNION ALL SELECT '5473265'				--LS
UNION ALL SELECT '4367748'				--LT
UNION ALL SELECT '4006796'				--LV
UNION ALL SELECT '3539862'				--LY
UNION ALL SELECT '21258222'				--USD
UNION ALL SELECT '533951'				--S12HK
UNION ALL SELECT '1549924'				--S12M
UNION ALL SELECT '14176207'				--S12MM
UNION ALL SELECT '8236892'				--L25RM
UNION ALL SELECT '1071794'				--S25R
UNION ALL SELECT '8148919'				--S25RM
UNION ALL SELECT '1011974'				--S26H
UNION ALL SELECT '7772139'				--S359CM
UNION ALL SELECT '838074'				--S37RMB
UNION ALL SELECT '528691'				--S50RMB
UNION ALL SELECT '12591491'				--S53HHK
UNION ALL SELECT '17902498'				--S53M
UNION ALL SELECT '12142609'				--S53S
UNION ALL SELECT '28229771'				--S668H
UNION ALL SELECT '2937749'				--S55CRMB
UNION ALL SELECT '29920422'				--S57BH
UNION ALL SELECT '4138910'				--S863R
UNION ALL SELECT '1107530'				--M8HHHH
UNION ALL SELECT '1266057'				--S96h
UNION ALL SELECT '1427766'				--SZ
UNION ALL SELECT '1456925'				--SAMR
UNION ALL SELECT '1265902'				--SMAMRMB
UNION ALL SELECT '38730876'				--DC1
UNION ALL SELECT '38731024'				--DC2
UNION ALL SELECT '1773803'				--MC
UNION ALL SELECT '2308589'				--MC2
UNION ALL SELECT '10506715'				--MC3
UNION ALL SELECT '15805514'				--MC5
UNION ALL SELECT '19287562'				--MEA
UNION ALL SELECT '19287667'				--MEB
UNION ALL SELECT '13330822'				--SGKB
UNION ALL SELECT '4508624'				--SGMM
UNION ALL SELECT '2116268'				--SGSM
UNION ALL SELECT '642386'				--SGTB
UNION ALL SELECT '4792310'				--TED
UNION ALL SELECT '2000098'				--TEH
UNION ALL SELECT '2504299'				--TEK
UNION ALL SELECT '29504201'				--THG
UNION ALL SELECT '2061201'				--THR
UNION ALL SELECT '8216498'				--THS
UNION ALL SELECT '17797101'				--THT
UNION ALL SELECT '13653794'				--JCH
UNION ALL SELECT '997137'				--MK1
UNION ALL SELECT '1074882'				--MK10
UNION ALL SELECT '1074884'				--MK11C
UNION ALL SELECT '4127035'				--MK27
UNION ALL SELECT '998346'				--MK4C
UNION ALL SELECT '997155'				--MK6
UNION ALL SELECT '24739806'				--MKD
UNION ALL SELECT '28360678'				--MKE
UNION ALL SELECT '15477714'				--MKH
UNION ALL SELECT '17299936'				--MKHA
UNION ALL SELECT '3715080'				--MKI
UNION ALL SELECT '1606473'				--MKM1
UNION ALL SELECT '1437908'				--MKS
UNION ALL SELECT '12294019'				--MKS1
UNION ALL SELECT '1539908'				--MKTB
UNION ALL SELECT '4253518'				--TH28
UNION ALL SELECT '23242311'				--TH3
UNION ALL SELECT '5402188'				--THM
UNION ALL SELECT '595962'				--SBKH
UNION ALL SELECT '324336'				--SBKHK
UNION ALL SELECT '2278343'				--SMBH
UNION ALL SELECT '13294314'				--SMCH
UNION ALL SELECT '984745'				--SMH
UNION ALL SELECT '398467'				--SMM
UNION ALL SELECT '984746'				--SMMH
UNION ALL SELECT '1211027'				--SMMS
UNION ALL SELECT '3150153'				--PTM
UNION ALL SELECT '14210898'				--SQHH
UNION ALL SELECT '33882079'				--ANTE
UNION ALL SELECT '16787471'				--SVA
UNION ALL SELECT '16645316'				--SVE
UNION ALL SELECT '490037'				--SVM
UNION ALL SELECT '7758309'				--SVP
UNION ALL SELECT '490215'				--SVR
UNION ALL SELECT '754114'				--SYM
UNION ALL SELECT '6092482'				--YHK
UNION ALL SELECT '10406641'				--NBV
UNION ALL SELECT '792439'				--SMOH1R
UNION ALL SELECT '15745716'				--SPEH
UNION ALL SELECT '3623378'				--SPSD
UNION ALL SELECT '19240638'				--SHJ
UNION ALL SELECT '463265'				--SHK
UNION ALL SELECT '796555'				--SPHM
UNION ALL SELECT '994735'				--SPK
UNION ALL SELECT '3988315'				--PKA
UNION ALL SELECT '3988331'				--PKB
UNION ALL SELECT '4553978'				--PKC
UNION ALL SELECT '4638100'				--PKD
UNION ALL SELECT '4957465'				--PKE
UNION ALL SELECT '5205926'				--PKF
UNION ALL SELECT '6520522'				--PKG
UNION ALL SELECT '7694826'				--PKH
UNION ALL SELECT '21142690'				--PKI
UNION ALL SELECT '4546391'				--PKID
UNION ALL SELECT '8363406'				--PKJ
UNION ALL SELECT '3934718'				--PKK
UNION ALL SELECT '8591808'				--PKL
UNION ALL SELECT '9368991'				--PKM
UNION ALL SELECT '21170614'				--PKN
UNION ALL SELECT '11548361'				--PKO
UNION ALL SELECT '12033438'				--PKP
UNION ALL SELECT '15469734'				--PKQ
UNION ALL SELECT '21824947'				--PKR
UNION ALL SELECT '21142801'				--PKRA
UNION ALL SELECT '4037362'				--PKRM
UNION ALL SELECT '16403843'				--PKS
UNION ALL SELECT '15852092'				--PKT
UNION ALL SELECT '21964064'				--PKU
UNION ALL SELECT '22893016'				--PKV
UNION ALL SELECT '23757509'				--PKW
UNION ALL SELECT '29886115'				--PKX
UNION ALL SELECT '37279635'				--PKZ
UNION ALL SELECT '9513012'				--POE
UNION ALL SELECT '7765833'				--POS
UNION ALL SELECT '23416974'				--POA
UNION ALL SELECT '9934460'				--POB
UNION ALL SELECT '17436696'				--POJ
UNION ALL SELECT '8488565'				--POK
UNION ALL SELECT '27474847'				--POQ
UNION ALL SELECT '5340162'				--POR
UNION ALL SELECT '5340166'				--POT
UNION ALL SELECT '12300617'				--POW
UNION ALL SELECT '8621974'				--POY
UNION ALL SELECT '19646705'				--POZ
UNION ALL SELECT '27349067'				--PVV
UNION ALL SELECT '2394977'				--PPH
UNION ALL SELECT '3574705'				--PPM
UNION ALL SELECT '23494009'				--PPA
UNION ALL SELECT '34383807'				--PPC
UNION ALL SELECT '30039712'				--PPE
UNION ALL SELECT '35506199'				--PPG
UNION ALL SELECT '17550987'				--PPS
UNION ALL SELECT '24648313'				--PPT
UNION ALL SELECT '25630543'				--PPU
UNION ALL SELECT '31845614'				--PPX
UNION ALL SELECT '18023072'				--PYA
UNION ALL SELECT '20055370'				--PYB
UNION ALL SELECT '20124800'				--PYC
UNION ALL SELECT '16154752'				--PYG
UNION ALL SELECT '9525991'				--PYH
UNION ALL SELECT '17724317'				--PYR
UNION ALL SELECT '13338762'				--PYT
UNION ALL SELECT '8095139'				--Pyy
UNION ALL SELECT '1349398'				--QQ
UNION ALL SELECT '27085403'				--QA13
UNION ALL SELECT '22636899'				--QAMM
UNION ALL SELECT '12957917'				--QQBS
UNION ALL SELECT '7763719'				--QQK3
UNION ALL SELECT '7756579'				--QQKA
UNION ALL SELECT '12573245'				--QQKY
UNION ALL SELECT '7756637'				--QQMA
UNION ALL SELECT '7756603'				--QQMW
UNION ALL SELECT '7756631'				--QQMY
UNION ALL SELECT '7756563'				--QQMZ
UNION ALL SELECT '9934169'				--QQTB
UNION ALL SELECT '24222512'				--QWA
UNION ALL SELECT '27743238'				--MG1
UNION ALL SELECT '27743327'				--MG2
UNION ALL SELECT '31694381'				--MG5
UNION ALL SELECT '23896205'				--RG2DO
UNION ALL SELECT '23746463'				--RGIDO
UNION ALL SELECT '26758668'				--RGU
UNION ALL SELECT '23715144'				--RGWON
UNION ALL SELECT '1586764'				--RR
UNION ALL SELECT '1435492'				--S120R
UNION ALL SELECT '15682765'				--S120S
UNION ALL SELECT '3391041'				--S121R
UNION ALL SELECT '8145099'				--S122R
UNION ALL SELECT '12545786'				--S123R
UNION ALL SELECT '13885989'				--S124R
UNION ALL SELECT '20250284'				--S125R
UNION ALL SELECT '33507367'				--S126R
UNION ALL SELECT '984326'				--S188AH
UNION ALL SELECT '462612'				--S188R
UNION ALL SELECT '507226'				--S188RM
UNION ALL SELECT '15848874'				--2CK
UNION ALL SELECT '13083302'				--2CR
UNION ALL SELECT '13344620'				--2CT
UNION ALL SELECT '25685400'				--2CU
UNION ALL SELECT '28372948'				--2CV
UNION ALL SELECT '3800272'				--2DH
UNION ALL SELECT '7772435'				--2EU
UNION ALL SELECT '8281764'				--2MN
UNION ALL SELECT '17045552'				--2MP
UNION ALL SELECT '17333226'				--2MY
UNION ALL SELECT '11733282'				--2NN
UNION ALL SELECT '21823600'				--2RB
UNION ALL SELECT '9670471'				--2RM
UNION ALL SELECT '15583137'				--S222N
UNION ALL SELECT '560429'				--S222R
UNION ALL SELECT '979900'				--S23H
UNION ALL SELECT '17074641'				--S23M
UNION ALL SELECT '2193103'				--S23S
UNION ALL SELECT '3752852'				--S27A
UNION ALL SELECT '1001999'				--S27HK
UNION ALL SELECT '7945539'				--S27TK
UNION ALL SELECT '4744473'				--SADA
UNION ALL SELECT '23145834'				--JMC
UNION ALL SELECT '1020356'				--S2H
UNION ALL SELECT '1211024'				--S2M
UNION ALL SELECT '12341915'				--S2MM
UNION ALL SELECT '14385514'				--S2MN
UNION ALL SELECT '882346'				--S2R
UNION ALL SELECT '2398557'				--M312T
UNION ALL SELECT '8243036'				--R312R
UNION ALL SELECT '19466231'				--R313Y
UNION ALL SELECT '19608676'				--S312A
UNION ALL SELECT '9672019'				--S312C
UNION ALL SELECT '21009614'				--S312D
UNION ALL SELECT '27730904'				--S312E
UNION ALL SELECT '17520621'				--S312G
UNION ALL SELECT '17469607'				--S312H
UNION ALL SELECT '27653910'				--S312K
UNION ALL SELECT '20116744'				--S312RMA
UNION ALL SELECT '12589170'				--S312RMB
UNION ALL SELECT '27868961'				--S312RMC
UNION ALL SELECT '7754654'				--S31BRM
UNION ALL SELECT '2823274'				--SSFK
UNION ALL SELECT '2554844'				--K311
UNION ALL SELECT '2554864'				--R311
UNION ALL SELECT '1246023'				--S31H
UNION ALL SELECT '18393844'				--S33A
UNION ALL SELECT '335748'				--S33AR
UNION ALL SELECT '463659'				--S33BR
UNION ALL SELECT '484809'				--S33CR
UNION ALL SELECT '211567'				--S33E
UNION ALL SELECT '211566'				--S33M
UNION ALL SELECT '211568'				--S33R
UNION ALL SELECT '431696'				--S33S
UNION ALL SELECT '390567'				--S33SM
UNION ALL SELECT '9934485'				--S33T
UNION ALL SELECT '19872670'				--ALL
UNION ALL SELECT '22076483'				--ALO
UNION ALL SELECT '15200915'				--ALR
UNION ALL SELECT '21826151'				--ALTH
UNION ALL SELECT '24568090'				--ALY
UNION ALL SELECT '18803268'				--RMB
UNION ALL SELECT '7753071'				--S359am
UNION ALL SELECT '6385611'				--S359M
UNION ALL SELECT '7186058'				--S359S
UNION ALL SELECT '7757274'				--SLG
UNION ALL SELECT '7768121'				--SLL
UNION ALL SELECT '405391'				--S36RM
UNION ALL SELECT '324559'				--S36RMB
UNION ALL SELECT '941038'				--S3AAH
UNION ALL SELECT '576984'				--S3AAR
UNION ALL SELECT '941026'				--S3AH
UNION ALL SELECT '572607'				--S3AR
UNION ALL SELECT '443008'				--S3ARM
UNION ALL SELECT '9732491'				--S3BH
UNION ALL SELECT '7657763'				--S3EH
UNION ALL SELECT '2926808'				--S41H
UNION ALL SELECT '1690565'				--S41M
UNION ALL SELECT '1690560'				--S41S
UNION ALL SELECT '8270016'				--S43H
UNION ALL SELECT '3019886'				--S43S
UNION ALL SELECT '1036451'				--S42AH
UNION ALL SELECT '28409795'				--S42AM
UNION ALL SELECT '2428032'				--S42ARM
UNION ALL SELECT '1290422'				--S42BH
UNION ALL SELECT '23119152'				--S42CN
UNION ALL SELECT '4672707'				--S42D
UNION ALL SELECT '1022404'				--S42H
UNION ALL SELECT '3513305'				--S42M
UNION ALL SELECT '817188'				--S42RM
UNION ALL SELECT '1207541'				--S42S
UNION ALL SELECT '14405674'				--TWS
UNION ALL SELECT '10529214'				--YHA
UNION ALL SELECT '1506023'				--S45AH
UNION ALL SELECT '18327825'				--S45BM
UNION ALL SELECT '1362437'				--S45H
UNION ALL SELECT '1492016'				--s45m
UNION ALL SELECT '8553985'				--S47DR
UNION ALL SELECT '3047517'				--S47IR
UNION ALL SELECT '27201499'				--S47K
UNION ALL SELECT '17721092'				--S47M
UNION ALL SELECT '838051'				--S47R
UNION ALL SELECT '480725'				--S47RM
UNION ALL SELECT '406935'				--S47SD
UNION ALL SELECT '5831527'				--S49H
UNION ALL SELECT '877004'				--S49R
UNION ALL SELECT '426131'				--S49RM
UNION ALL SELECT '1349148'				--S51H
UNION ALL SELECT '7301563'				--S51HA
UNION ALL SELECT '695131'				--S51SM
UNION ALL SELECT '9933834'				--S51TB
UNION ALL SELECT '406808'				--TAS51S
UNION ALL SELECT '4910597'				--S555
UNION ALL SELECT '4910667'				--S666
UNION ALL SELECT '16189265'				--S777
UNION ALL SELECT '15968342'				--HK09
UNION ALL SELECT '23900450'				--HK56
UNION ALL SELECT '12785073'				--S56A
UNION ALL SELECT '15689281'				--S56AE
UNION ALL SELECT '838203'				--S56AH
UNION ALL SELECT '8062488'				--S56AI
UNION ALL SELECT '826317'				--S56CRM
UNION ALL SELECT '3681857'				--S56D
UNION ALL SELECT '877768'				--S56EH
UNION ALL SELECT '1031455'				--S56GH
UNION ALL SELECT '838201'				--S56H
UNION ALL SELECT '1194960'				--S56KH
UNION ALL SELECT '3775566'				--S56NH
UNION ALL SELECT '3775579'				--S56PH
UNION ALL SELECT '4356717'				--S56QH
UNION ALL SELECT '461775'				--S56R
UNION ALL SELECT '405017'				--S56RM
UNION ALL SELECT '1537688'				--S56TH
UNION ALL SELECT '800262'				--S57AR
UNION ALL SELECT '2869345'				--S989R
UNION ALL SELECT '2904839'				--330GBP
UNION ALL SELECT '365484'				--S5M
UNION ALL SELECT '365486'				--S5R
UNION ALL SELECT '365483'				--S5S
UNION ALL SELECT '3611231'				--W79
UNION ALL SELECT '11748799'				--E60
UNION ALL SELECT '1576179'				--S60AR
UNION ALL SELECT '510159'				--S60RUP
UNION ALL SELECT '3589741'				--KH6
UNION ALL SELECT '3589738'				--KM6
UNION ALL SELECT '3589744'				--KS6
UNION ALL SELECT '1720567'				--S62H
UNION ALL SELECT '3149272'				--S62M
UNION ALL SELECT '3127387'				--S63H
UNION ALL SELECT '21336723'				--S63K
UNION ALL SELECT '22009953'				--S63M
UNION ALL SELECT '7672409'				--S66D
UNION ALL SELECT '1111902'				--s66s
UNION ALL SELECT '3634248'				--S77X
UNION ALL SELECT '901840'				--S688H
UNION ALL SELECT '2509713'				--S688M
UNION ALL SELECT '959157'				--S688T
UNION ALL SELECT '914839'				--S788H
UNION ALL SELECT '15252449'				--S69BP
UNION ALL SELECT '9342128'				--S69E
UNION ALL SELECT '4439144'				--S69H
UNION ALL SELECT '19909578'				--S69M
UNION ALL SELECT '21424221'				--S69NT
UNION ALL SELECT '836949'				--S69R
UNION ALL SELECT '6153706'				--S69RD
UNION ALL SELECT '478394'				--S69RM
UNION ALL SELECT '15530542'				--S69RP
UNION ALL SELECT '404986'				--S69SD
UNION ALL SELECT '9918280'				--S69TB
UNION ALL SELECT '604044'				--S7RM
UNION ALL SELECT '1575555'				--AA
UNION ALL SELECT '13893053'				--AKO2
UNION ALL SELECT '17120967'				--AKO3
UNION ALL SELECT '1584509'				--BA
UNION ALL SELECT '19665350'				--BR1
UNION ALL SELECT '2078394'				--DA
UNION ALL SELECT '4505274'				--FA
UNION ALL SELECT '11665608'				--FM
UNION ALL SELECT '5969746'				--GA
UNION ALL SELECT '8429220'				--GG
UNION ALL SELECT '15140611'				--KRW
UNION ALL SELECT '26575473'				--M6M
UNION ALL SELECT '16737515'				--MD
UNION ALL SELECT '28318108'				--N8E
UNION ALL SELECT '35915586'				--NA
UNION ALL SELECT '37318337'				--ND
UNION ALL SELECT '37321086'				--NE
UNION ALL SELECT '35915766'				--RA
UNION ALL SELECT '17961935'				--S6AHK
UNION ALL SELECT '835418'				--S6ARUP
UNION ALL SELECT '5711971'				--S6BP
UNION ALL SELECT '8539195'				--s6cn
UNION ALL SELECT '527906'				--S6EU
UNION ALL SELECT '3676675'				--S6H
UNION ALL SELECT '11660210'				--S6HK
UNION ALL SELECT '9735627'				--S6KW
UNION ALL SELECT '12665939'				--S6P
UNION ALL SELECT '11660213'				--S6RMB
UNION ALL SELECT '549191'				--S6RUP
UNION ALL SELECT '18949397'				--S6S
UNION ALL SELECT '17537176'				--S6T
UNION ALL SELECT '706886'				--S6US
UNION ALL SELECT '17200168'				--S9EU
UNION ALL SELECT '17583600'				--S9KS
UNION ALL SELECT '15530229'				--S9KW
UNION ALL SELECT '35915769'				--SA
UNION ALL SELECT '15424123'				--VA
UNION ALL SELECT '4548911'				--VC
UNION ALL SELECT '14773243'				--VE
UNION ALL SELECT '5957920'				--VF
UNION ALL SELECT '15485426'				--VG
UNION ALL SELECT '28164639'				--VH
UNION ALL SELECT '17916695'				--VJ
UNION ALL SELECT '32108400'				--VL
UNION ALL SELECT '5938255'				--VM
UNION ALL SELECT '8284552'				--VO
UNION ALL SELECT '9514014'				--VP
UNION ALL SELECT '10927694'				--VQ
UNION ALL SELECT '26296151'				--VS
UNION ALL SELECT '29096051'				--VT
UNION ALL SELECT '29544049'				--VU
UNION ALL SELECT '37127380'				--YA
UNION ALL SELECT '23869272'				--ZA
UNION ALL SELECT '24669486'				--ZB
UNION ALL SELECT '26631784'				--ZC
UNION ALL SELECT '8100556'				--S70M
UNION ALL SELECT '726483'				--S70RMB
UNION ALL SELECT '2924293'				--S71BH
UNION ALL SELECT '12573367'				--S71DH
UNION ALL SELECT '993226'				--S71H
UNION ALL SELECT '2797447'				--S71M
UNION ALL SELECT '2957601'				--S71MA
UNION ALL SELECT '421328'				--S71RM
UNION ALL SELECT '987102'				--S799H
UNION ALL SELECT '900371'				--S79AHH
UNION ALL SELECT '836410'				--S79H
UNION ALL SELECT '2775382'				--S79HS
UNION ALL SELECT '405975'				--S79RM
UNION ALL SELECT '8452452'				--WD
UNION ALL SELECT '4649955'				--HK8
UNION ALL SELECT '7374379'				--S7D
UNION ALL SELECT '26269491'				--S7G
UNION ALL SELECT '18579015'				--S7RR
UNION ALL SELECT '23998205'				--S7T
UNION ALL SELECT '29671917'				--S7U
UNION ALL SELECT '20717186'				--S7W
UNION ALL SELECT '356942'				--S80R
UNION ALL SELECT '2162072'				--S81R
UNION ALL SELECT '966501'				--GEH
UNION ALL SELECT '1601946'				--GFH
UNION ALL SELECT '37866159'				--S822A
UNION ALL SELECT '2042873'				--S822M
UNION ALL SELECT '1108229'				--S85S
UNION ALL SELECT '1004318'				--S87R
UNION ALL SELECT '7776236'				--S88D
UNION ALL SELECT '1572664'				--S88H
UNION ALL SELECT '20112011'				--S88IE
UNION ALL SELECT '665985'				--S88R
UNION ALL SELECT '2853838'				--S8AH
UNION ALL SELECT '1841983'				--S8AR
UNION ALL SELECT '3494465'				--S8BH
UNION ALL SELECT '3491753'				--S8BR
UNION ALL SELECT '657896'				--S8H
UNION ALL SELECT '220846'				--S8R
UNION ALL SELECT '368537'				--S8U
UNION ALL SELECT '1402421'				--S90AR
UNION ALL SELECT '7923118'				--S90H
UNION ALL SELECT '523974'				--S90R
UNION ALL SELECT '1127269'				--S91R
UNION ALL SELECT '1078111'				--S93H
UNION ALL SELECT '12291627'				--S93P
UNION ALL SELECT '4359847'				--S93RRMB
UNION ALL SELECT '831604'				--S93S
UNION ALL SELECT '1029269'				--S95AH
UNION ALL SELECT '1059173'				--S95BH
UNION ALL SELECT '2300662'				--S95DH
UNION ALL SELECT '967131'				--S95H
UNION ALL SELECT '1317514'				--S95M
UNION ALL SELECT '2291699'				--S95RM
UNION ALL SELECT '356946'				--S95RMB
UNION ALL SELECT '12515436'				--S98E
UNION ALL SELECT '38420990'				--S98F
UNION ALL SELECT '38420813'				--S98G
UNION ALL SELECT '1008234'				--S98H
UNION ALL SELECT '12653798'				--S98K
UNION ALL SELECT '477659'				--S98R
UNION ALL SELECT '15229780'				--S99D
UNION ALL SELECT '18929915'				--S99E
UNION ALL SELECT '859594'				--S99H
UNION ALL SELECT '7604170'				--S99HKD
UNION ALL SELECT '11471646'				--S99K
UNION ALL SELECT '23729783'				--S99KW
UNION ALL SELECT '1448199'				--S99M
UNION ALL SELECT '912272'				--S99TB
UNION ALL SELECT '9925322'				--S99TH
UNION ALL SELECT '16026037'				--S99V
UNION ALL SELECT '14084827'				--S99W
UNION ALL SELECT '4554012'				--S9H
UNION ALL SELECT '691884'				--S9M
UNION ALL SELECT '17058130'				--XKS
UNION ALL SELECT '944306'				--SAKH
UNION ALL SELECT '994666'				--SAKM
UNION ALL SELECT '10321289'				--SAE
UNION ALL SELECT '13752690'				--SAI
UNION ALL SELECT '2383816'				--SAS
UNION ALL SELECT '5283781'				--SATE
UNION ALL SELECT '7781015'				--SATM
UNION ALL SELECT '2229262'				--SATU
UNION ALL SELECT '11584923'				--SAZM
UNION ALL SELECT '35605718'				--W39iD
UNION ALL SELECT '7439977'				--SB22R
UNION ALL SELECT '1571570'				--SB2R
UNION ALL SELECT '2094401'				--SB3R
UNION ALL SELECT '5088978'				--SBOK
UNION ALL SELECT '944721'				--SB6R
UNION ALL SELECT '1194834'				--SB7R
UNION ALL SELECT '955286'				--SB8R
UNION ALL SELECT '1140623'				--SBB
UNION ALL SELECT '4622222'				--SBSD
UNION ALL SELECT '16576689'				--SBV
UNION ALL SELECT '3259517'				--SBCR
UNION ALL SELECT '805450'				--SBHK
UNION ALL SELECT '5266935'				--SBKK
UNION ALL SELECT '913948'				--SBLH
UNION ALL SELECT '17721601'				--SBMW
UNION ALL SELECT '2214708'				--SBRR
UNION ALL SELECT '8017299'				--SBC
UNION ALL SELECT '1604404'				--SBM
UNION ALL SELECT '3230597'				--SBTH
UNION ALL SELECT '3254803'				--SBTK
UNION ALL SELECT '8282635'				--SBTL
UNION ALL SELECT '3131329'				--SBTM
UNION ALL SELECT '3515870'				--SBTN
UNION ALL SELECT '1517662'				--SMT
UNION ALL SELECT '7711724'				--SBZ
UNION ALL SELECT '14644207'				--SBZB
UNION ALL SELECT '1721616'				--SBZR
UNION ALL SELECT '3046451'				--SCLH
UNION ALL SELECT '838215'				--SCH
UNION ALL SELECT '324557'				--SCHK
UNION ALL SELECT '2285864'				--SCI
UNION ALL SELECT '398615'				--SCM
UNION ALL SELECT '32971814'				--SCNM
UNION ALL SELECT '398636'				--SCS
UNION ALL SELECT '984549'				--SDH
UNION ALL SELECT '1008937'				--SDHK
UNION ALL SELECT '776702'				--SDR
UNION ALL SELECT '410722'				--SDRM
UNION ALL SELECT '479690'				--SDRMB
UNION ALL SELECT '4283123'				--SEA
UNION ALL SELECT '7410076'				--SEB
UNION ALL SELECT '3237129'				--SEI
UNION ALL SELECT '4371323'				--SEK
UNION ALL SELECT '5900375'				--SEMA
UNION ALL SELECT '774701'				--SER
UNION ALL SELECT '3139575'				--SF8
UNION ALL SELECT '1175237'				--SHT
UNION ALL SELECT '14761185'				--CFT
UNION ALL SELECT '7958991'				--HHN
UNION ALL SELECT '838053'				--SHRMB
UNION ALL SELECT '430735'				--SHSD
UNION ALL SELECT '17050644'				--AQ
UNION ALL SELECT '5528833'				--AT
UNION ALL SELECT '4663772'				--CL
UNION ALL SELECT '21268909'				--CP
UNION ALL SELECT '7216279'				--CX
UNION ALL SELECT '10792955'				--CY
UNION ALL SELECT '6210213'				--HO
UNION ALL SELECT '6465457'				--HU
UNION ALL SELECT '7176459'				--HW
UNION ALL SELECT '6706058'				--IZ
UNION ALL SELECT '4152553'				--JA
UNION ALL SELECT '4404067'				--JB
UNION ALL SELECT '4437168'				--JC
UNION ALL SELECT '6855660'				--JK
UNION ALL SELECT '9412566'				--JN
UNION ALL SELECT '10064280'				--JT
UNION ALL SELECT '5551373'				--LN
UNION ALL SELECT '11548722'				--MH
UNION ALL SELECT '4320374'				--SB
UNION ALL SELECT '185849'				--SI
UNION ALL SELECT '16694213'				--TA
UNION ALL SELECT '4677011'				--UA
UNION ALL SELECT '4677048'				--UB
UNION ALL SELECT '5773292'				--UE
UNION ALL SELECT '14118357'				--UG
UNION ALL SELECT '11010588'				--UH
UNION ALL SELECT '4048531'				--UK
UNION ALL SELECT '4253707'				--UM
UNION ALL SELECT '4320399'				--UN
UNION ALL SELECT '7277118'				--UV
UNION ALL SELECT '7177766'				--UW
UNION ALL SELECT '14956535'				--UY
UNION ALL SELECT '10797628'				--UZ
UNION ALL SELECT '19738497'				--WA
UNION ALL SELECT '4739346'				--WB
UNION ALL SELECT '18747621'				--WG
UNION ALL SELECT '3919061'				--WH
UNION ALL SELECT '16016306'				--YM
UNION ALL SELECT '4622387'				--YN
UNION ALL SELECT '5532706'				--ZZ
UNION ALL SELECT '19240555'				--SJJM
UNION ALL SELECT '787938'				--SJM
UNION ALL SELECT '23188635'				--SJR
UNION ALL SELECT '12575535'				--SJSD
UNION ALL SELECT '14301612'				--SKKM
UNION ALL SELECT '3345772'				--SKMM
UNION ALL SELECT '2178402'				--SLH
UNION ALL SELECT '3872549'				--SLJ
UNION ALL SELECT '2937091'				--SLK
UNION ALL SELECT '5473299'				--SLM
UNION ALL SELECT '30697649'				--SLZ
UNION ALL SELECT '2222683'				--SLLM
UNION ALL SELECT '23570053'				--MOX
UNION ALL SELECT '7146892'				--SMOC
UNION ALL SELECT '8330307'				--SMOCNY
UNION ALL SELECT '15588279'				--SMOI
UNION ALL SELECT '407649'				--SMORM
UNION ALL SELECT '324564'				--SMORMB
UNION ALL SELECT '3230605'				--SMOS
UNION ALL SELECT '35597100'				--SMQ
UNION ALL SELECT '1374344'				--SMQARMB
UNION ALL SELECT '2504697'				--SOGA
UNION ALL SELECT '753624'				--SOGO
UNION ALL SELECT '13615649'				--SPA3M
UNION ALL SELECT '2341316'				--SRHKA
UNION ALL SELECT '1247148'				--SRMA
UNION ALL SELECT '324563'				--SRRMB
UNION ALL SELECT '356937'				--S305CRMB
UNION ALL SELECT '771942'				--S31ARMB
UNION ALL SELECT '408317'				--S31RM
UNION ALL SELECT '478396'				--S31RMB
UNION ALL SELECT '1013342'				--SSF2H
UNION ALL SELECT '837904'				--SSFH
UNION ALL SELECT '17044959'				--SSMA
UNION ALL SELECT '30597263'				--SSMM
UNION ALL SELECT '2192160'				--SSSD
UNION ALL SELECT '2491953'				--SSTMH
UNION ALL SELECT '3009929'				--SSTMM
UNION ALL SELECT '18974796'				--SSYH
UNION ALL SELECT '3938541'				--SSYR
UNION ALL SELECT '4212621'				--STE1H
UNION ALL SELECT '4589422'				--STE1M
UNION ALL SELECT '3566056'				--STE2
UNION ALL SELECT '3592718'				--STE3
UNION ALL SELECT '4019163'				--STE9
UNION ALL SELECT '3309466'				--STEA
UNION ALL SELECT '3780410'				--STEE
UNION ALL SELECT '3592707'				--STEF
UNION ALL SELECT '2383191'				--STEI
UNION ALL SELECT '3296297'				--STEN
UNION ALL SELECT '2430883'				--STEO
UNION ALL SELECT '1574254'				--STEQ
UNION ALL SELECT '2252615'				--STEU
UNION ALL SELECT '3062829'				--STEZ
UNION ALL SELECT '38068180'				--STM
UNION ALL SELECT '755409'				--STPM
UNION ALL SELECT '23463328'				--SVV
UNION ALL SELECT '867735'				--SW
UNION ALL SELECT '450036'				--SWKR
UNION ALL SELECT '1211231'				--SWK
UNION ALL SELECT '1211237'				--SWM
UNION ALL SELECT '14870436'				--SWO
UNION ALL SELECT '1201561'				--SWU
UNION ALL SELECT '24307432'				--SBI
UNION ALL SELECT '15516774'				--SNI
UNION ALL SELECT '4601030'				--SYI
UNION ALL SELECT '1083052'				--TL6
UNION ALL SELECT '9727510'				--TP
UNION ALL SELECT '19436067'				--TD1
UNION ALL SELECT '19436202'				--TD2
UNION ALL SELECT '19440122'				--TD3
UNION ALL SELECT '19440128'				--TD4
UNION ALL SELECT '19473802'				--TD5
UNION ALL SELECT '19473831'				--TD6
UNION ALL SELECT '19574419'				--TDA
UNION ALL SELECT '19574488'				--TDB
UNION ALL SELECT '19761295'				--TDC
UNION ALL SELECT '17797342'				--TS1
UNION ALL SELECT '33465007'				--TS10
UNION ALL SELECT '17797400'				--TS2
UNION ALL SELECT '17820768'				--TS3
UNION ALL SELECT '29764329'				--TS8
UNION ALL SELECT '33023129'				--TS9
UNION ALL SELECT '656135'				--UI
UNION ALL SELECT '19447731'				--VBR
UNION ALL SELECT '10398791'				--VKH
UNION ALL SELECT '10933415'				--SVVG
UNION ALL SELECT '5778932'				--VVG
UNION ALL SELECT '24104781'				--VVM
UNION ALL SELECT '26767367'				--VVN
UNION ALL SELECT '35816325'				--VVP
UNION ALL SELECT '14732090'				--WCH
UNION ALL SELECT '1124040'				--WI
UNION ALL SELECT '21355056'				--ACE
UNION ALL SELECT '4404031'				--AJ
UNION ALL SELECT '4314665'				--AP
UNION ALL SELECT '4212172'				--AS
UNION ALL SELECT '21524716'				--BAT
UNION ALL SELECT '22310261'				--BTM
UNION ALL SELECT '26263062'				--IX
UNION ALL SELECT '30715660'				--MN
UNION ALL SELECT '26263173'				--RJ
UNION ALL SELECT '21744949'				--TOP
UNION ALL SELECT '19984856'				--WINA
UNION ALL SELECT '19984899'				--WINC
UNION ALL SELECT '19998377'				--WINE
UNION ALL SELECT '20096020'				--WINF
UNION ALL SELECT '20096077'				--WING
UNION ALL SELECT '20398676'				--WINI
UNION ALL SELECT '20393148'				--WINJ
UNION ALL SELECT '20006616'				--WINS
UNION ALL SELECT '37352378'				--WP13
UNION ALL SELECT '11761289'				--WPR
UNION ALL SELECT '3854395'				--S797S
UNION ALL SELECT '1376434'				--wm
UNION ALL SELECT '4045713'				--WMA
UNION ALL SELECT '720475'				--WW
UNION ALL SELECT '2925993'				--WKR
UNION ALL SELECT '1131889'				--WWR
UNION ALL SELECT '14015187'				--XCN
UNION ALL SELECT '10346439'				--XKH
UNION ALL SELECT '10346359'				--XKM
UNION ALL SELECT '2270259'				--YI
UNION ALL SELECT '5973408'				--CYKM
UNION ALL SELECT '1993804'				--YKH
UNION ALL SELECT '5931469'				--YKM
UNION ALL SELECT '13053739'				--YUH
UNION ALL SELECT '11472964'				--YUM

------------- PROCESS --------------------
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tmpCust
	SET isfinished = 1
		,@custid = custid				
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @custid = @custid					
			,@target = 'REPLICATED'

	--WAITFOR DELAY '00:00:0.100'
END			

 DROP TABLE #tmpCust
GO		
-- END STEP 3: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------
-- BEGIN STEP 4: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #tmpCust (custid int, isfinished bit default(0))
    
DECLARE @custid INT

----CustomerList
INSERT INTO #tmpCust(custid)					
	  SELECT '5603319'				--BHK
UNION ALL SELECT '1146496'				--BNE
UNION ALL SELECT '26337653'				--BS-JPY
UNION ALL SELECT '36077034'				--CLE
UNION ALL SELECT '20605416'				--CSDTEST1
UNION ALL SELECT '1382642'				--CTESTR
UNION ALL SELECT '13063323'				--DB
UNION ALL SELECT '16136074'				--ETB
UNION ALL SELECT '1091262'				--HIR
UNION ALL SELECT '570306'				--IMBJPY
UNION ALL SELECT '570302'				--IMBUSD
UNION ALL SELECT '608348'				--ITSA5
UNION ALL SELECT '9573322'				--JIP
UNION ALL SELECT '6173539'				--LC-RM
UNION ALL SELECT '7352491'				--LC-SD
UNION ALL SELECT '12319010'				--LR
UNION ALL SELECT '1688074'				--MTEST
UNION ALL SELECT '1807421'				--MTESTEU
UNION ALL SELECT '25196224'				--OPS-GBP
UNION ALL SELECT '25197688'				--OPS-HKK
UNION ALL SELECT '25197748'				--OPS-IDD
UNION ALL SELECT '25197264'				--OPS-RM
UNION ALL SELECT '25197518'				--OPS-RMB
UNION ALL SELECT '25197906'				--OPS-THB
UNION ALL SELECT '25196109'				--OPS-US$
UNION ALL SELECT '11211742'				--S11RUP
UNION ALL SELECT '3451158'				--S11Y
UNION ALL SELECT '8021101'				--S5D
UNION ALL SELECT '1090001'				--sa-pppp
UNION ALL SELECT '5254477'				--SBKKwrong
UNION ALL SELECT '7119552'				--skwrongxxx
UNION ALL SELECT '8156203'				--SLAM
UNION ALL SELECT '27429881'				--StarixY9TH
UNION ALL SELECT '8159964'				--TD88
UNION ALL SELECT '25722901'				--TestRM
UNION ALL SELECT '23137843'				--Test-RM
UNION ALL SELECT '19272511'				--YSM
UNION ALL SELECT '16773713'				--MLAMRM
UNION ALL SELECT '1091678'				--S5P
UNION ALL SELECT '2051039'				--S5RR
UNION ALL SELECT '1022678'				--S5TT
UNION ALL SELECT '1867721'				--S09H
UNION ALL SELECT '5005322'				--S09M
UNION ALL SELECT '461780'				--S58R
UNION ALL SELECT '405422'				--S58RM
UNION ALL SELECT '33267199'				--BMX
UNION ALL SELECT '2601912'				--S39RR
UNION ALL SELECT '4940784'				--DKD
UNION ALL SELECT '987495'				--S32AH
UNION ALL SELECT '1456420'				--S32AM
UNION ALL SELECT '987497'				--S32BH
UNION ALL SELECT '3654316'				--S32BM
UNION ALL SELECT '987499'				--S32CH
UNION ALL SELECT '17931860'				--S32CM
UNION ALL SELECT '987501'				--S32DH
UNION ALL SELECT '24619005'				--S32DM
UNION ALL SELECT '1366843'				--S32FH
UNION ALL SELECT '857802'				--S32H
UNION ALL SELECT '2284508'				--S32HH
UNION ALL SELECT '15657898'				--S32HKD
UNION ALL SELECT '2838764'				--S32IH
UNION ALL SELECT '3195166'				--S32JH
UNION ALL SELECT '15548698'				--S32K
UNION ALL SELECT '19075657'				--S32KK
UNION ALL SELECT '15657985'				--S32RM
UNION ALL SELECT '324558'				--S32RMB
UNION ALL SELECT '404941'				--S305RM
UNION ALL SELECT '972747'				--S3H
UNION ALL SELECT '3560324'				--S3HH
UNION ALL SELECT '7763508'				--S3HK
UNION ALL SELECT '4362130'				--SSF5H
UNION ALL SELECT '6032879'				--PPB
UNION ALL SELECT '6032912'				--PPR
UNION ALL SELECT '301152'				--SPH
UNION ALL SELECT '261425'				--SPR
UNION ALL SELECT '970269'				--SALH
UNION ALL SELECT '447479'				--SALR
UNION ALL SELECT '726582'				--KAM
UNION ALL SELECT '726562'				--KAR
UNION ALL SELECT '726571'				--KBR
UNION ALL SELECT '726579'				--KCR
UNION ALL SELECT '1164457'				--KDR
UNION ALL SELECT '1238537'				--KER
UNION ALL SELECT '194355'				--KH
UNION ALL SELECT '896708'				--KHAH
UNION ALL SELECT '913628'				--KHBH
UNION ALL SELECT '30475562'				--KHC
UNION ALL SELECT '1069029'				--KHCH
UNION ALL SELECT '2400612'				--KHDH
UNION ALL SELECT '674248'				--KHH
UNION ALL SELECT '712272'				--KHK
UNION ALL SELECT '1537683'				--KHT
UNION ALL SELECT '194354'				--KM
UNION ALL SELECT '476776'				--KMA
UNION ALL SELECT '727340'				--KMAM
UNION ALL SELECT '877777'				--KMBM
UNION ALL SELECT '395075'				--KMM
UNION ALL SELECT '194356'				--KR
UNION ALL SELECT '461767'				--KRR
UNION ALL SELECT '394310'				--KSD
UNION ALL SELECT '4204225'				--79AH
UNION ALL SELECT '4204369'				--79AR
UNION ALL SELECT '29009895'				--801CM
UNION ALL SELECT '30765689'				--801EM
UNION ALL SELECT '6249438'				--87R
UNION ALL SELECT '840993'				--SG1H
UNION ALL SELECT '4181669'				--SG21H
UNION ALL SELECT '4780138'				--SG25H
UNION ALL SELECT '840999'				--SG2H
UNION ALL SELECT '4487258'				--SG2M
UNION ALL SELECT '10719518'				--SG33H
UNION ALL SELECT '1923414'				--SG4H
UNION ALL SELECT '1927603'				--SG6H
UNION ALL SELECT '7680993'				--SG7M
UNION ALL SELECT '8119630'				--SG8M
UNION ALL SELECT '7939911'				--SGGT
UNION ALL SELECT '832992'				--SGH
UNION ALL SELECT '398437'				--SGM
UNION ALL SELECT '399130'				--SGR
UNION ALL SELECT '11314815'				--SGRD
UNION ALL SELECT '324561'				--SGURMB
UNION ALL SELECT '36454579'				--S999M
UNION ALL SELECT '20141184'				--S999RM
UNION ALL SELECT '10440396'				--S999S
UNION ALL SELECT '33881912'				--2699M
UNION ALL SELECT '35213224'				--3135RM
UNION ALL SELECT '33852218'				--9542M
UNION ALL SELECT '24404342'				--S68AH
UNION ALL SELECT '29401764'				--AAH
UNION ALL SELECT '9905998'				--AC1
UNION ALL SELECT '21584528'				--AC18
UNION ALL SELECT '29003710'				--AC20
UNION ALL SELECT '13290701'				--ACH
UNION ALL SELECT '13562677'				--ACH1
UNION ALL SELECT '13863347'				--ACH3
UNION ALL SELECT '18515475'				--ACH6
UNION ALL SELECT '19310674'				--ACH7
UNION ALL SELECT '12168675'				--ACK
UNION ALL SELECT '33419048'				--ACK1
UNION ALL SELECT '19996696'				--ACK2
UNION ALL SELECT '25266465'				--AGC
UNION ALL SELECT '16204333'				--AGD
UNION ALL SELECT '26261138'				--AGE
UNION ALL SELECT '25274162'				--AGN
UNION ALL SELECT '4115476'				--AHA
UNION ALL SELECT '3780034'				--AHL
UNION ALL SELECT '1628179'				--AHM
UNION ALL SELECT '1628290'				--AHN
UNION ALL SELECT '2197674'				--AHO
UNION ALL SELECT '3872491'				--AHT
UNION ALL SELECT '5336854'				--AHV
UNION ALL SELECT '13058363'				--AHZ
UNION ALL SELECT '2221671'				--BHO
UNION ALL SELECT '5780740'				--BHS
UNION ALL SELECT '11028100'				--AHMA
UNION ALL SELECT '13744152'				--AG
UNION ALL SELECT '1812820'				--AW
UNION ALL SELECT '8066804'				--AZ
UNION ALL SELECT '18364243'				--WJ
UNION ALL SELECT '5712158'				--AX
UNION ALL SELECT '12550356'				--AXA
UNION ALL SELECT '7292508'				--AXH
UNION ALL SELECT '12644625'				--AXHK
UNION ALL SELECT '9932698'				--AXT
UNION ALL SELECT '865485'				--SKHK
UNION ALL SELECT '1995341'				--SKM
UNION ALL SELECT '884262'				--SKR
UNION ALL SELECT '28968342'				--BAH
UNION ALL SELECT '24992578'				--BAK
UNION ALL SELECT '31949474'				--BAL
UNION ALL SELECT '36902576'				--BAO
UNION ALL SELECT '36584443'				--BAP
UNION ALL SELECT '15825686'				--RB168
UNION ALL SELECT '1795270'				--SBBR
UNION ALL SELECT '1558372'				--SBBT
UNION ALL SELECT '29899882'				--BBT
UNION ALL SELECT '642291'				--BI
UNION ALL SELECT '13934944'				--BJ
UNION ALL SELECT '21299450'				--BPM
UNION ALL SELECT '36670491'				--BPN
UNION ALL SELECT '17066207'				--BYU
UNION ALL SELECT '10369357'				--C1
UNION ALL SELECT '12070389'				--C12
UNION ALL SELECT '12276215'				--C15
UNION ALL SELECT '31948257'				--C16
UNION ALL SELECT '10560596'				--C2
UNION ALL SELECT '10775412'				--C3
UNION ALL SELECT '11639821'				--C8
UNION ALL SELECT '9579024'				--cks
UNION ALL SELECT '13068960'				--CV
UNION ALL SELECT '13856586'				--KP
UNION ALL SELECT '21423676'				--P9
UNION ALL SELECT '5394462'				--CCM
UNION ALL SELECT '3810473'				--CCT
UNION ALL SELECT '14624531'				--CEH
UNION ALL SELECT '14622428'				--CER
UNION ALL SELECT '33470941'				--CHA
UNION ALL SELECT '1528421'				--B10T
UNION ALL SELECT '1528422'				--B11T
UNION ALL SELECT '1536432'				--B12T
UNION ALL SELECT '1538057'				--B13T
UNION ALL SELECT '1538175'				--B14T
UNION ALL SELECT '1538183'				--B15T
UNION ALL SELECT '1538997'				--B16T
UNION ALL SELECT '1539009'				--B17T
UNION ALL SELECT '1539693'				--B18T
UNION ALL SELECT '1539698'				--B19T
UNION ALL SELECT '1523261'				--B1T
UNION ALL SELECT '1539699'				--B20T
UNION ALL SELECT '1539700'				--B21T
UNION ALL SELECT '1540216'				--B22T
UNION ALL SELECT '1540217'				--B23T
UNION ALL SELECT '1588140'				--B24T
UNION ALL SELECT '1588145'				--B25T
UNION ALL SELECT '2508822'				--B26T
UNION ALL SELECT '2541779'				--B27T
UNION ALL SELECT '7815141'				--B29T
UNION ALL SELECT '1528410'				--B2T
UNION ALL SELECT '9664861'				--B31T
UNION ALL SELECT '9669693'				--B32T
UNION ALL SELECT '9933863'				--B33T
UNION ALL SELECT '9934001'				--B34T
UNION ALL SELECT '9933940'				--B35T
UNION ALL SELECT '9934027'				--B36T
UNION ALL SELECT '17305892'				--B46T
UNION ALL SELECT '17305980'				--B47T
UNION ALL SELECT '1528413'				--B4T
UNION ALL SELECT '18452186'				--B50T
UNION ALL SELECT '18452187'				--B51T
UNION ALL SELECT '21639245'				--B53T
UNION ALL SELECT '21639246'				--B54T
UNION ALL SELECT '1517951'				--B5T
UNION ALL SELECT '26979533'				--B60T
UNION ALL SELECT '1528414'				--B6T
UNION ALL SELECT '1528418'				--B7T
UNION ALL SELECT '1528419'				--B8T
UNION ALL SELECT '1528420'				--B9T
UNION ALL SELECT '1517030'				--BT
UNION ALL SELECT '2421122'				--SABT
UNION ALL SELECT '641144'				--ST2T
UNION ALL SELECT '2388779'				--STEB
UNION ALL SELECT '1563928'				--CI
UNION ALL SELECT '22918619'				--CLM
UNION ALL SELECT '2083036'				--CO
UNION ALL SELECT '2131553'				--CS
UNION ALL SELECT '14759423'				--CTH
UNION ALL SELECT '18889582'				--CTM
UNION ALL SELECT '16007620'				--CTV
UNION ALL SELECT '2103376'				--CU
UNION ALL SELECT '23280386'				--DMB
UNION ALL SELECT '18777368'				--DRM
UNION ALL SELECT '21229669'				--DRN
UNION ALL SELECT '21746732'				--DRP
UNION ALL SELECT '29895950'				--HD6
UNION ALL SELECT '32019482'				--DE
UNION ALL SELECT '897588'				--DI
UNION ALL SELECT '17041176'				--DM
UNION ALL SELECT '18579339'				--DS1
UNION ALL SELECT '1652112'				--S42CH
UNION ALL SELECT '1640992'				--DAT
UNION ALL SELECT '1372998'				--DW
UNION ALL SELECT '30480498'				--EEB
UNION ALL SELECT '21227644'				--EED
UNION ALL SELECT '14393371'				--EEH
UNION ALL SELECT '14392343'				--EEM
UNION ALL SELECT '4604381'				--FBH
UNION ALL SELECT '2327638'				--SFB
UNION ALL SELECT '1373748'				--FF
UNION ALL SELECT '11566943'				--FJM
UNION ALL SELECT '22534793'				--FNG
UNION ALL SELECT '22534951'				--FNH
UNION ALL SELECT '22621772'				--FNM
UNION ALL SELECT '22535166'				--FNN
UNION ALL SELECT '22535487'				--FNU
UNION ALL SELECT '9428916'				--FYK
UNION ALL SELECT '8050233'				--FYS
UNION ALL SELECT '9934245'				--FYT
UNION ALL SELECT '4012673'				--FYY
UNION ALL SELECT '747037'				--GI
UNION ALL SELECT '8551070'				--gtwrong
UNION ALL SELECT '3100395'				--HHB
UNION ALL SELECT '3390598'				--HHBS
UNION ALL SELECT '2014372'				--HHG
UNION ALL SELECT '641918'				--HI
UNION ALL SELECT '1069683'				--HAH
UNION ALL SELECT '17905676'				--HIF
UNION ALL SELECT '889147'				--HIH
UNION ALL SELECT '1816739'				--HIK
UNION ALL SELECT '400973'				--HIS
UNION ALL SELECT '10392284'				--HIT
UNION ALL SELECT '2511910'				--HIW
UNION ALL SELECT '1029732'				--HJ
UNION ALL SELECT '2882278'				--HM
UNION ALL SELECT '712439'				--HP
UNION ALL SELECT '15615851'				--HP2
UNION ALL SELECT '11173365'				--HPD
UNION ALL SELECT '7723444'				--HPH
UNION ALL SELECT '5215598'				--HPI
UNION ALL SELECT '7656188'				--HPJ
UNION ALL SELECT '2251491'				--HPM
UNION ALL SELECT '5044097'				--HPMM
UNION ALL SELECT '2138601'				--HPO
UNION ALL SELECT '29609449'				--HTT
UNION ALL SELECT '11674017'				--MO
UNION ALL SELECT '11674030'				--MP
UNION ALL SELECT '20441569'				--MV
UNION ALL SELECT '23608613'				--MX
UNION ALL SELECT '22224357'				--HSM
UNION ALL SELECT '30376920'				--HSM1
UNION ALL SELECT '9931047'				--HT1
UNION ALL SELECT '9933782'				--HT2
UNION ALL SELECT '11306634'				--HT3
UNION ALL SELECT '19378350'				--HT4
UNION ALL SELECT '19380292'				--HT5
UNION ALL SELECT '3526034'				--ID
UNION ALL SELECT '14011590'				--IA
UNION ALL SELECT '14308443'				--IE
UNION ALL SELECT '5880048'				--IF
UNION ALL SELECT '18546512'				--IG
UNION ALL SELECT '27927536'				--IH
UNION ALL SELECT '689767'				--II
UNION ALL SELECT '4802250'				--IK
UNION ALL SELECT '4378806'				--IM
UNION ALL SELECT '4404078'				--IN
UNION ALL SELECT '31870999'				--IQ
UNION ALL SELECT '21549631'				--IU
UNION ALL SELECT '27231792'				--IY
UNION ALL SELECT '1564982'				--IP
UNION ALL SELECT '2831595'				--IR
UNION ALL SELECT '1220882'				--JAH
UNION ALL SELECT '1603986'				--JAM
UNION ALL SELECT '13469206'				--JARWRONG
UNION ALL SELECT '1248383'				--JAS
UNION ALL SELECT '1220879'				--JAT
UNION ALL SELECT '22765105'				--MBO
UNION ALL SELECT '21388074'				--JBM
UNION ALL SELECT '29802667'				--82M
UNION ALL SELECT '2302419'				--JJ
UNION ALL SELECT '5484091'				--JJB
UNION ALL SELECT '26858222'				--JJC
UNION ALL SELECT '11760592'				--JJM
UNION ALL SELECT '987804'				--S35H
UNION ALL SELECT '2258222'				--S35M
UNION ALL SELECT '1797678'				--JM
UNION ALL SELECT '19589733'				--JQ
UNION ALL SELECT '8657557'				--JR
UNION ALL SELECT '2199854'				--JS2
UNION ALL SELECT '19590429'				--JZ
UNION ALL SELECT '2829199'				--SJS
UNION ALL SELECT '24642387'				--JYD
UNION ALL SELECT '25185439'				--JYE
UNION ALL SELECT '26751787'				--JYF
UNION ALL SELECT '20461064'				--JYG
UNION ALL SELECT '31548037'				--JYH
UNION ALL SELECT '23625521'				--JYY
UNION ALL SELECT '1865464'				--KJM
UNION ALL SELECT '6525867'				--KJMD
UNION ALL SELECT '15583251'				--KJMF
UNION ALL SELECT '14014232'				--KAA
UNION ALL SELECT '16000766'				--KAC
UNION ALL SELECT '18201422'				--KAG
UNION ALL SELECT '26372036'				--KAP
UNION ALL SELECT '29184371'				--KBP
UNION ALL SELECT '23343127'				--KFU
UNION ALL SELECT '16594953'				--KGA
UNION ALL SELECT '16595046'				--KGB
UNION ALL SELECT '15927973'				--KGP
UNION ALL SELECT '12334400'				--KKF
UNION ALL SELECT '27748138'				--VVB
UNION ALL SELECT '4037357'				--KPM
UNION ALL SELECT '506057'				--SKPRMB
UNION ALL SELECT '12048828'				--KPW
UNION ALL SELECT '1088459'				--KYH
UNION ALL SELECT '2026798'				--KYM
UNION ALL SELECT '25216716'				--LHB
UNION ALL SELECT '25221008'				--LHC
UNION ALL SELECT '4374817'				--LHH
UNION ALL SELECT '7754066'				--LHH2
UNION ALL SELECT '7754182'				--LHH3
UNION ALL SELECT '11449326'				--LHH8
UNION ALL SELECT '8418095'				--LHHRMB
UNION ALL SELECT '25307522'				--LHJ
UNION ALL SELECT '4445198'				--LHM
UNION ALL SELECT '7753114'				--LHM1
UNION ALL SELECT '17107778'				--LHM5
UNION ALL SELECT '22031727'				--LHM7
UNION ALL SELECT '23033435'				--LHM8
UNION ALL SELECT '10044015'				--LHR
UNION ALL SELECT '8103018'				--LHS
UNION ALL SELECT '643456'				--LI
UNION ALL SELECT '14635815'				--BGR
UNION ALL SELECT '24839750'				--BJQ
UNION ALL SELECT '19040588'				--CHU
UNION ALL SELECT '19884111'				--FFF
UNION ALL SELECT '4792246'				--KD
UNION ALL SELECT '5771986'				--LA
UNION ALL SELECT '3770553'				--LB
UNION ALL SELECT '3810488'				--LC
UNION ALL SELECT '3954915'				--LD
UNION ALL SELECT '3973944'				--LE
UNION ALL SELECT '4189499'				--LF
UNION ALL SELECT '7680679'				--LG
UNION ALL SELECT '2749224'				--LH
UNION ALL SELECT '2075688'				--LJ
UNION ALL SELECT '7680792'				--LM
UNION ALL SELECT '5473265'				--LS
UNION ALL SELECT '4367748'				--LT
UNION ALL SELECT '4006796'				--LV
UNION ALL SELECT '3539862'				--LY
UNION ALL SELECT '21258222'				--USD
UNION ALL SELECT '533951'				--S12HK
UNION ALL SELECT '1549924'				--S12M
UNION ALL SELECT '14176207'				--S12MM
UNION ALL SELECT '8236892'				--L25RM
UNION ALL SELECT '1071794'				--S25R
UNION ALL SELECT '8148919'				--S25RM
UNION ALL SELECT '1011974'				--S26H
UNION ALL SELECT '7772139'				--S359CM
UNION ALL SELECT '838074'				--S37RMB
UNION ALL SELECT '528691'				--S50RMB
UNION ALL SELECT '12591491'				--S53HHK
UNION ALL SELECT '17902498'				--S53M
UNION ALL SELECT '12142609'				--S53S
UNION ALL SELECT '28229771'				--S668H
UNION ALL SELECT '2937749'				--S55CRMB
UNION ALL SELECT '29920422'				--S57BH
UNION ALL SELECT '4138910'				--S863R
UNION ALL SELECT '1107530'				--M8HHHH
UNION ALL SELECT '1266057'				--S96h
UNION ALL SELECT '1427766'				--SZ
UNION ALL SELECT '1456925'				--SAMR
UNION ALL SELECT '1265902'				--SMAMRMB
UNION ALL SELECT '38730876'				--DC1
UNION ALL SELECT '38731024'				--DC2
UNION ALL SELECT '1773803'				--MC
UNION ALL SELECT '2308589'				--MC2
UNION ALL SELECT '10506715'				--MC3
UNION ALL SELECT '15805514'				--MC5
UNION ALL SELECT '19287562'				--MEA
UNION ALL SELECT '19287667'				--MEB
UNION ALL SELECT '13330822'				--SGKB
UNION ALL SELECT '4508624'				--SGMM
UNION ALL SELECT '2116268'				--SGSM
UNION ALL SELECT '642386'				--SGTB
UNION ALL SELECT '4792310'				--TED
UNION ALL SELECT '2000098'				--TEH
UNION ALL SELECT '2504299'				--TEK
UNION ALL SELECT '29504201'				--THG
UNION ALL SELECT '2061201'				--THR
UNION ALL SELECT '8216498'				--THS
UNION ALL SELECT '17797101'				--THT
UNION ALL SELECT '13653794'				--JCH
UNION ALL SELECT '997137'				--MK1
UNION ALL SELECT '1074882'				--MK10
UNION ALL SELECT '1074884'				--MK11C
UNION ALL SELECT '4127035'				--MK27
UNION ALL SELECT '998346'				--MK4C
UNION ALL SELECT '997155'				--MK6
UNION ALL SELECT '24739806'				--MKD
UNION ALL SELECT '28360678'				--MKE
UNION ALL SELECT '15477714'				--MKH
UNION ALL SELECT '17299936'				--MKHA
UNION ALL SELECT '3715080'				--MKI
UNION ALL SELECT '1606473'				--MKM1
UNION ALL SELECT '1437908'				--MKS
UNION ALL SELECT '12294019'				--MKS1
UNION ALL SELECT '1539908'				--MKTB
UNION ALL SELECT '4253518'				--TH28
UNION ALL SELECT '23242311'				--TH3
UNION ALL SELECT '5402188'				--THM
UNION ALL SELECT '595962'				--SBKH
UNION ALL SELECT '324336'				--SBKHK
UNION ALL SELECT '2278343'				--SMBH
UNION ALL SELECT '13294314'				--SMCH
UNION ALL SELECT '984745'				--SMH
UNION ALL SELECT '398467'				--SMM
UNION ALL SELECT '984746'				--SMMH
UNION ALL SELECT '1211027'				--SMMS
UNION ALL SELECT '3150153'				--PTM
UNION ALL SELECT '14210898'				--SQHH
UNION ALL SELECT '33882079'				--ANTE
UNION ALL SELECT '16787471'				--SVA
UNION ALL SELECT '16645316'				--SVE
UNION ALL SELECT '490037'				--SVM
UNION ALL SELECT '7758309'				--SVP
UNION ALL SELECT '490215'				--SVR
UNION ALL SELECT '754114'				--SYM
UNION ALL SELECT '6092482'				--YHK
UNION ALL SELECT '10406641'				--NBV
UNION ALL SELECT '792439'				--SMOH1R
UNION ALL SELECT '15745716'				--SPEH
UNION ALL SELECT '3623378'				--SPSD
UNION ALL SELECT '19240638'				--SHJ
UNION ALL SELECT '463265'				--SHK
UNION ALL SELECT '796555'				--SPHM
UNION ALL SELECT '994735'				--SPK
UNION ALL SELECT '3988315'				--PKA
UNION ALL SELECT '3988331'				--PKB
UNION ALL SELECT '4553978'				--PKC
UNION ALL SELECT '4638100'				--PKD
UNION ALL SELECT '4957465'				--PKE
UNION ALL SELECT '5205926'				--PKF
UNION ALL SELECT '6520522'				--PKG
UNION ALL SELECT '7694826'				--PKH
UNION ALL SELECT '21142690'				--PKI
UNION ALL SELECT '4546391'				--PKID
UNION ALL SELECT '8363406'				--PKJ
UNION ALL SELECT '3934718'				--PKK
UNION ALL SELECT '8591808'				--PKL
UNION ALL SELECT '9368991'				--PKM
UNION ALL SELECT '21170614'				--PKN
UNION ALL SELECT '11548361'				--PKO
UNION ALL SELECT '12033438'				--PKP
UNION ALL SELECT '15469734'				--PKQ
UNION ALL SELECT '21824947'				--PKR
UNION ALL SELECT '21142801'				--PKRA
UNION ALL SELECT '4037362'				--PKRM
UNION ALL SELECT '16403843'				--PKS
UNION ALL SELECT '15852092'				--PKT
UNION ALL SELECT '21964064'				--PKU
UNION ALL SELECT '22893016'				--PKV
UNION ALL SELECT '23757509'				--PKW
UNION ALL SELECT '29886115'				--PKX
UNION ALL SELECT '37279635'				--PKZ
UNION ALL SELECT '9513012'				--POE
UNION ALL SELECT '7765833'				--POS
UNION ALL SELECT '23416974'				--POA
UNION ALL SELECT '9934460'				--POB
UNION ALL SELECT '17436696'				--POJ
UNION ALL SELECT '8488565'				--POK
UNION ALL SELECT '27474847'				--POQ
UNION ALL SELECT '5340162'				--POR
UNION ALL SELECT '5340166'				--POT
UNION ALL SELECT '12300617'				--POW
UNION ALL SELECT '8621974'				--POY
UNION ALL SELECT '19646705'				--POZ
UNION ALL SELECT '27349067'				--PVV
UNION ALL SELECT '2394977'				--PPH
UNION ALL SELECT '3574705'				--PPM
UNION ALL SELECT '23494009'				--PPA
UNION ALL SELECT '34383807'				--PPC
UNION ALL SELECT '30039712'				--PPE
UNION ALL SELECT '35506199'				--PPG
UNION ALL SELECT '17550987'				--PPS
UNION ALL SELECT '24648313'				--PPT
UNION ALL SELECT '25630543'				--PPU
UNION ALL SELECT '31845614'				--PPX
UNION ALL SELECT '18023072'				--PYA
UNION ALL SELECT '20055370'				--PYB
UNION ALL SELECT '20124800'				--PYC
UNION ALL SELECT '16154752'				--PYG
UNION ALL SELECT '9525991'				--PYH
UNION ALL SELECT '17724317'				--PYR
UNION ALL SELECT '13338762'				--PYT
UNION ALL SELECT '8095139'				--Pyy
UNION ALL SELECT '1349398'				--QQ
UNION ALL SELECT '27085403'				--QA13
UNION ALL SELECT '22636899'				--QAMM
UNION ALL SELECT '12957917'				--QQBS
UNION ALL SELECT '7763719'				--QQK3
UNION ALL SELECT '7756579'				--QQKA
UNION ALL SELECT '12573245'				--QQKY
UNION ALL SELECT '7756637'				--QQMA
UNION ALL SELECT '7756603'				--QQMW
UNION ALL SELECT '7756631'				--QQMY
UNION ALL SELECT '7756563'				--QQMZ
UNION ALL SELECT '9934169'				--QQTB
UNION ALL SELECT '24222512'				--QWA
UNION ALL SELECT '27743238'				--MG1
UNION ALL SELECT '27743327'				--MG2
UNION ALL SELECT '31694381'				--MG5
UNION ALL SELECT '23896205'				--RG2DO
UNION ALL SELECT '23746463'				--RGIDO
UNION ALL SELECT '26758668'				--RGU
UNION ALL SELECT '23715144'				--RGWON
UNION ALL SELECT '1586764'				--RR
UNION ALL SELECT '1435492'				--S120R
UNION ALL SELECT '15682765'				--S120S
UNION ALL SELECT '3391041'				--S121R
UNION ALL SELECT '8145099'				--S122R
UNION ALL SELECT '12545786'				--S123R
UNION ALL SELECT '13885989'				--S124R
UNION ALL SELECT '20250284'				--S125R
UNION ALL SELECT '33507367'				--S126R
UNION ALL SELECT '984326'				--S188AH
UNION ALL SELECT '462612'				--S188R
UNION ALL SELECT '507226'				--S188RM
UNION ALL SELECT '15848874'				--2CK
UNION ALL SELECT '13083302'				--2CR
UNION ALL SELECT '13344620'				--2CT
UNION ALL SELECT '25685400'				--2CU
UNION ALL SELECT '28372948'				--2CV
UNION ALL SELECT '3800272'				--2DH
UNION ALL SELECT '7772435'				--2EU
UNION ALL SELECT '8281764'				--2MN
UNION ALL SELECT '17045552'				--2MP
UNION ALL SELECT '17333226'				--2MY
UNION ALL SELECT '11733282'				--2NN
UNION ALL SELECT '21823600'				--2RB
UNION ALL SELECT '9670471'				--2RM
UNION ALL SELECT '15583137'				--S222N
UNION ALL SELECT '560429'				--S222R
UNION ALL SELECT '979900'				--S23H
UNION ALL SELECT '17074641'				--S23M
UNION ALL SELECT '2193103'				--S23S
UNION ALL SELECT '3752852'				--S27A
UNION ALL SELECT '1001999'				--S27HK
UNION ALL SELECT '7945539'				--S27TK
UNION ALL SELECT '4744473'				--SADA
UNION ALL SELECT '23145834'				--JMC
UNION ALL SELECT '1020356'				--S2H
UNION ALL SELECT '1211024'				--S2M
UNION ALL SELECT '12341915'				--S2MM
UNION ALL SELECT '14385514'				--S2MN
UNION ALL SELECT '882346'				--S2R
UNION ALL SELECT '2398557'				--M312T
UNION ALL SELECT '8243036'				--R312R
UNION ALL SELECT '19466231'				--R313Y
UNION ALL SELECT '19608676'				--S312A
UNION ALL SELECT '9672019'				--S312C
UNION ALL SELECT '21009614'				--S312D
UNION ALL SELECT '27730904'				--S312E
UNION ALL SELECT '17520621'				--S312G
UNION ALL SELECT '17469607'				--S312H
UNION ALL SELECT '27653910'				--S312K
UNION ALL SELECT '20116744'				--S312RMA
UNION ALL SELECT '12589170'				--S312RMB
UNION ALL SELECT '27868961'				--S312RMC
UNION ALL SELECT '7754654'				--S31BRM
UNION ALL SELECT '2823274'				--SSFK
UNION ALL SELECT '2554844'				--K311
UNION ALL SELECT '2554864'				--R311
UNION ALL SELECT '1246023'				--S31H
UNION ALL SELECT '18393844'				--S33A
UNION ALL SELECT '335748'				--S33AR
UNION ALL SELECT '463659'				--S33BR
UNION ALL SELECT '484809'				--S33CR
UNION ALL SELECT '211567'				--S33E
UNION ALL SELECT '211566'				--S33M
UNION ALL SELECT '211568'				--S33R
UNION ALL SELECT '431696'				--S33S
UNION ALL SELECT '390567'				--S33SM
UNION ALL SELECT '9934485'				--S33T
UNION ALL SELECT '19872670'				--ALL
UNION ALL SELECT '22076483'				--ALO
UNION ALL SELECT '15200915'				--ALR
UNION ALL SELECT '21826151'				--ALTH
UNION ALL SELECT '24568090'				--ALY
UNION ALL SELECT '18803268'				--RMB
UNION ALL SELECT '7753071'				--S359am
UNION ALL SELECT '6385611'				--S359M
UNION ALL SELECT '7186058'				--S359S
UNION ALL SELECT '7757274'				--SLG
UNION ALL SELECT '7768121'				--SLL
UNION ALL SELECT '405391'				--S36RM
UNION ALL SELECT '324559'				--S36RMB
UNION ALL SELECT '941038'				--S3AAH
UNION ALL SELECT '576984'				--S3AAR
UNION ALL SELECT '941026'				--S3AH
UNION ALL SELECT '572607'				--S3AR
UNION ALL SELECT '443008'				--S3ARM
UNION ALL SELECT '9732491'				--S3BH
UNION ALL SELECT '7657763'				--S3EH
UNION ALL SELECT '2926808'				--S41H
UNION ALL SELECT '1690565'				--S41M
UNION ALL SELECT '1690560'				--S41S
UNION ALL SELECT '8270016'				--S43H
UNION ALL SELECT '3019886'				--S43S
UNION ALL SELECT '1036451'				--S42AH
UNION ALL SELECT '28409795'				--S42AM
UNION ALL SELECT '2428032'				--S42ARM
UNION ALL SELECT '1290422'				--S42BH
UNION ALL SELECT '23119152'				--S42CN
UNION ALL SELECT '4672707'				--S42D
UNION ALL SELECT '1022404'				--S42H
UNION ALL SELECT '3513305'				--S42M
UNION ALL SELECT '817188'				--S42RM
UNION ALL SELECT '1207541'				--S42S
UNION ALL SELECT '14405674'				--TWS
UNION ALL SELECT '10529214'				--YHA
UNION ALL SELECT '1506023'				--S45AH
UNION ALL SELECT '18327825'				--S45BM
UNION ALL SELECT '1362437'				--S45H
UNION ALL SELECT '1492016'				--s45m
UNION ALL SELECT '8553985'				--S47DR
UNION ALL SELECT '3047517'				--S47IR
UNION ALL SELECT '27201499'				--S47K
UNION ALL SELECT '17721092'				--S47M
UNION ALL SELECT '838051'				--S47R
UNION ALL SELECT '480725'				--S47RM
UNION ALL SELECT '406935'				--S47SD
UNION ALL SELECT '5831527'				--S49H
UNION ALL SELECT '877004'				--S49R
UNION ALL SELECT '426131'				--S49RM
UNION ALL SELECT '1349148'				--S51H
UNION ALL SELECT '7301563'				--S51HA
UNION ALL SELECT '695131'				--S51SM
UNION ALL SELECT '9933834'				--S51TB
UNION ALL SELECT '406808'				--TAS51S
UNION ALL SELECT '4910597'				--S555
UNION ALL SELECT '4910667'				--S666
UNION ALL SELECT '16189265'				--S777
UNION ALL SELECT '15968342'				--HK09
UNION ALL SELECT '23900450'				--HK56
UNION ALL SELECT '12785073'				--S56A
UNION ALL SELECT '15689281'				--S56AE
UNION ALL SELECT '838203'				--S56AH
UNION ALL SELECT '8062488'				--S56AI
UNION ALL SELECT '826317'				--S56CRM
UNION ALL SELECT '3681857'				--S56D
UNION ALL SELECT '877768'				--S56EH
UNION ALL SELECT '1031455'				--S56GH
UNION ALL SELECT '838201'				--S56H
UNION ALL SELECT '1194960'				--S56KH
UNION ALL SELECT '3775566'				--S56NH
UNION ALL SELECT '3775579'				--S56PH
UNION ALL SELECT '4356717'				--S56QH
UNION ALL SELECT '461775'				--S56R
UNION ALL SELECT '405017'				--S56RM
UNION ALL SELECT '1537688'				--S56TH
UNION ALL SELECT '800262'				--S57AR
UNION ALL SELECT '2869345'				--S989R
UNION ALL SELECT '2904839'				--330GBP
UNION ALL SELECT '365484'				--S5M
UNION ALL SELECT '365486'				--S5R
UNION ALL SELECT '365483'				--S5S
UNION ALL SELECT '3611231'				--W79
UNION ALL SELECT '11748799'				--E60
UNION ALL SELECT '1576179'				--S60AR
UNION ALL SELECT '510159'				--S60RUP
UNION ALL SELECT '3589741'				--KH6
UNION ALL SELECT '3589738'				--KM6
UNION ALL SELECT '3589744'				--KS6
UNION ALL SELECT '1720567'				--S62H
UNION ALL SELECT '3149272'				--S62M
UNION ALL SELECT '3127387'				--S63H
UNION ALL SELECT '21336723'				--S63K
UNION ALL SELECT '22009953'				--S63M
UNION ALL SELECT '7672409'				--S66D
UNION ALL SELECT '1111902'				--s66s
UNION ALL SELECT '3634248'				--S77X
UNION ALL SELECT '901840'				--S688H
UNION ALL SELECT '2509713'				--S688M
UNION ALL SELECT '959157'				--S688T
UNION ALL SELECT '914839'				--S788H
UNION ALL SELECT '15252449'				--S69BP
UNION ALL SELECT '9342128'				--S69E
UNION ALL SELECT '4439144'				--S69H
UNION ALL SELECT '19909578'				--S69M
UNION ALL SELECT '21424221'				--S69NT
UNION ALL SELECT '836949'				--S69R
UNION ALL SELECT '6153706'				--S69RD
UNION ALL SELECT '478394'				--S69RM
UNION ALL SELECT '15530542'				--S69RP
UNION ALL SELECT '404986'				--S69SD
UNION ALL SELECT '9918280'				--S69TB
UNION ALL SELECT '604044'				--S7RM
UNION ALL SELECT '1575555'				--AA
UNION ALL SELECT '13893053'				--AKO2
UNION ALL SELECT '17120967'				--AKO3
UNION ALL SELECT '1584509'				--BA
UNION ALL SELECT '19665350'				--BR1
UNION ALL SELECT '2078394'				--DA
UNION ALL SELECT '4505274'				--FA
UNION ALL SELECT '11665608'				--FM
UNION ALL SELECT '5969746'				--GA
UNION ALL SELECT '8429220'				--GG
UNION ALL SELECT '15140611'				--KRW
UNION ALL SELECT '26575473'				--M6M
UNION ALL SELECT '16737515'				--MD
UNION ALL SELECT '28318108'				--N8E
UNION ALL SELECT '35915586'				--NA
UNION ALL SELECT '37318337'				--ND
UNION ALL SELECT '37321086'				--NE
UNION ALL SELECT '35915766'				--RA
UNION ALL SELECT '17961935'				--S6AHK
UNION ALL SELECT '835418'				--S6ARUP
UNION ALL SELECT '5711971'				--S6BP
UNION ALL SELECT '8539195'				--s6cn
UNION ALL SELECT '527906'				--S6EU
UNION ALL SELECT '3676675'				--S6H
UNION ALL SELECT '11660210'				--S6HK
UNION ALL SELECT '9735627'				--S6KW
UNION ALL SELECT '12665939'				--S6P
UNION ALL SELECT '11660213'				--S6RMB
UNION ALL SELECT '549191'				--S6RUP
UNION ALL SELECT '18949397'				--S6S
UNION ALL SELECT '17537176'				--S6T
UNION ALL SELECT '706886'				--S6US
UNION ALL SELECT '17200168'				--S9EU
UNION ALL SELECT '17583600'				--S9KS
UNION ALL SELECT '15530229'				--S9KW
UNION ALL SELECT '35915769'				--SA
UNION ALL SELECT '15424123'				--VA
UNION ALL SELECT '4548911'				--VC
UNION ALL SELECT '14773243'				--VE
UNION ALL SELECT '5957920'				--VF
UNION ALL SELECT '15485426'				--VG
UNION ALL SELECT '28164639'				--VH
UNION ALL SELECT '17916695'				--VJ
UNION ALL SELECT '32108400'				--VL
UNION ALL SELECT '5938255'				--VM
UNION ALL SELECT '8284552'				--VO
UNION ALL SELECT '9514014'				--VP
UNION ALL SELECT '10927694'				--VQ
UNION ALL SELECT '26296151'				--VS
UNION ALL SELECT '29096051'				--VT
UNION ALL SELECT '29544049'				--VU
UNION ALL SELECT '37127380'				--YA
UNION ALL SELECT '23869272'				--ZA
UNION ALL SELECT '24669486'				--ZB
UNION ALL SELECT '26631784'				--ZC
UNION ALL SELECT '8100556'				--S70M
UNION ALL SELECT '726483'				--S70RMB
UNION ALL SELECT '2924293'				--S71BH
UNION ALL SELECT '12573367'				--S71DH
UNION ALL SELECT '993226'				--S71H
UNION ALL SELECT '2797447'				--S71M
UNION ALL SELECT '2957601'				--S71MA
UNION ALL SELECT '421328'				--S71RM
UNION ALL SELECT '987102'				--S799H
UNION ALL SELECT '900371'				--S79AHH
UNION ALL SELECT '836410'				--S79H
UNION ALL SELECT '2775382'				--S79HS
UNION ALL SELECT '405975'				--S79RM
UNION ALL SELECT '8452452'				--WD
UNION ALL SELECT '4649955'				--HK8
UNION ALL SELECT '7374379'				--S7D
UNION ALL SELECT '26269491'				--S7G
UNION ALL SELECT '18579015'				--S7RR
UNION ALL SELECT '23998205'				--S7T
UNION ALL SELECT '29671917'				--S7U
UNION ALL SELECT '20717186'				--S7W
UNION ALL SELECT '356942'				--S80R
UNION ALL SELECT '2162072'				--S81R
UNION ALL SELECT '966501'				--GEH
UNION ALL SELECT '1601946'				--GFH
UNION ALL SELECT '37866159'				--S822A
UNION ALL SELECT '2042873'				--S822M
UNION ALL SELECT '1108229'				--S85S
UNION ALL SELECT '1004318'				--S87R
UNION ALL SELECT '7776236'				--S88D
UNION ALL SELECT '1572664'				--S88H
UNION ALL SELECT '20112011'				--S88IE
UNION ALL SELECT '665985'				--S88R
UNION ALL SELECT '2853838'				--S8AH
UNION ALL SELECT '1841983'				--S8AR
UNION ALL SELECT '3494465'				--S8BH
UNION ALL SELECT '3491753'				--S8BR
UNION ALL SELECT '657896'				--S8H
UNION ALL SELECT '220846'				--S8R
UNION ALL SELECT '368537'				--S8U
UNION ALL SELECT '1402421'				--S90AR
UNION ALL SELECT '7923118'				--S90H
UNION ALL SELECT '523974'				--S90R
UNION ALL SELECT '1127269'				--S91R
UNION ALL SELECT '1078111'				--S93H
UNION ALL SELECT '12291627'				--S93P
UNION ALL SELECT '4359847'				--S93RRMB
UNION ALL SELECT '831604'				--S93S
UNION ALL SELECT '1029269'				--S95AH
UNION ALL SELECT '1059173'				--S95BH
UNION ALL SELECT '2300662'				--S95DH
UNION ALL SELECT '967131'				--S95H
UNION ALL SELECT '1317514'				--S95M
UNION ALL SELECT '2291699'				--S95RM
UNION ALL SELECT '356946'				--S95RMB
UNION ALL SELECT '12515436'				--S98E
UNION ALL SELECT '38420990'				--S98F
UNION ALL SELECT '38420813'				--S98G
UNION ALL SELECT '1008234'				--S98H
UNION ALL SELECT '12653798'				--S98K
UNION ALL SELECT '477659'				--S98R
UNION ALL SELECT '15229780'				--S99D
UNION ALL SELECT '18929915'				--S99E
UNION ALL SELECT '859594'				--S99H
UNION ALL SELECT '7604170'				--S99HKD
UNION ALL SELECT '11471646'				--S99K
UNION ALL SELECT '23729783'				--S99KW
UNION ALL SELECT '1448199'				--S99M
UNION ALL SELECT '912272'				--S99TB
UNION ALL SELECT '9925322'				--S99TH
UNION ALL SELECT '16026037'				--S99V
UNION ALL SELECT '14084827'				--S99W
UNION ALL SELECT '4554012'				--S9H
UNION ALL SELECT '691884'				--S9M
UNION ALL SELECT '17058130'				--XKS
UNION ALL SELECT '944306'				--SAKH
UNION ALL SELECT '994666'				--SAKM
UNION ALL SELECT '10321289'				--SAE
UNION ALL SELECT '13752690'				--SAI
UNION ALL SELECT '2383816'				--SAS
UNION ALL SELECT '5283781'				--SATE
UNION ALL SELECT '7781015'				--SATM
UNION ALL SELECT '2229262'				--SATU
UNION ALL SELECT '11584923'				--SAZM
UNION ALL SELECT '35605718'				--W39iD
UNION ALL SELECT '7439977'				--SB22R
UNION ALL SELECT '1571570'				--SB2R
UNION ALL SELECT '2094401'				--SB3R
UNION ALL SELECT '5088978'				--SBOK
UNION ALL SELECT '944721'				--SB6R
UNION ALL SELECT '1194834'				--SB7R
UNION ALL SELECT '955286'				--SB8R
UNION ALL SELECT '1140623'				--SBB
UNION ALL SELECT '4622222'				--SBSD
UNION ALL SELECT '16576689'				--SBV
UNION ALL SELECT '3259517'				--SBCR
UNION ALL SELECT '805450'				--SBHK
UNION ALL SELECT '5266935'				--SBKK
UNION ALL SELECT '913948'				--SBLH
UNION ALL SELECT '17721601'				--SBMW
UNION ALL SELECT '2214708'				--SBRR
UNION ALL SELECT '8017299'				--SBC
UNION ALL SELECT '1604404'				--SBM
UNION ALL SELECT '3230597'				--SBTH
UNION ALL SELECT '3254803'				--SBTK
UNION ALL SELECT '8282635'				--SBTL
UNION ALL SELECT '3131329'				--SBTM
UNION ALL SELECT '3515870'				--SBTN
UNION ALL SELECT '1517662'				--SMT
UNION ALL SELECT '7711724'				--SBZ
UNION ALL SELECT '14644207'				--SBZB
UNION ALL SELECT '1721616'				--SBZR
UNION ALL SELECT '3046451'				--SCLH
UNION ALL SELECT '838215'				--SCH
UNION ALL SELECT '324557'				--SCHK
UNION ALL SELECT '2285864'				--SCI
UNION ALL SELECT '398615'				--SCM
UNION ALL SELECT '32971814'				--SCNM
UNION ALL SELECT '398636'				--SCS
UNION ALL SELECT '984549'				--SDH
UNION ALL SELECT '1008937'				--SDHK
UNION ALL SELECT '776702'				--SDR
UNION ALL SELECT '410722'				--SDRM
UNION ALL SELECT '479690'				--SDRMB
UNION ALL SELECT '4283123'				--SEA
UNION ALL SELECT '7410076'				--SEB
UNION ALL SELECT '3237129'				--SEI
UNION ALL SELECT '4371323'				--SEK
UNION ALL SELECT '5900375'				--SEMA
UNION ALL SELECT '774701'				--SER
UNION ALL SELECT '3139575'				--SF8
UNION ALL SELECT '1175237'				--SHT
UNION ALL SELECT '14761185'				--CFT
UNION ALL SELECT '7958991'				--HHN
UNION ALL SELECT '838053'				--SHRMB
UNION ALL SELECT '430735'				--SHSD
UNION ALL SELECT '17050644'				--AQ
UNION ALL SELECT '5528833'				--AT
UNION ALL SELECT '4663772'				--CL
UNION ALL SELECT '21268909'				--CP
UNION ALL SELECT '7216279'				--CX
UNION ALL SELECT '10792955'				--CY
UNION ALL SELECT '6210213'				--HO
UNION ALL SELECT '6465457'				--HU
UNION ALL SELECT '7176459'				--HW
UNION ALL SELECT '6706058'				--IZ
UNION ALL SELECT '4152553'				--JA
UNION ALL SELECT '4404067'				--JB
UNION ALL SELECT '4437168'				--JC
UNION ALL SELECT '6855660'				--JK
UNION ALL SELECT '9412566'				--JN
UNION ALL SELECT '10064280'				--JT
UNION ALL SELECT '5551373'				--LN
UNION ALL SELECT '11548722'				--MH
UNION ALL SELECT '4320374'				--SB
UNION ALL SELECT '185849'				--SI
UNION ALL SELECT '16694213'				--TA
UNION ALL SELECT '4677011'				--UA
UNION ALL SELECT '4677048'				--UB
UNION ALL SELECT '5773292'				--UE
UNION ALL SELECT '14118357'				--UG
UNION ALL SELECT '11010588'				--UH
UNION ALL SELECT '4048531'				--UK
UNION ALL SELECT '4253707'				--UM
UNION ALL SELECT '4320399'				--UN
UNION ALL SELECT '7277118'				--UV
UNION ALL SELECT '7177766'				--UW
UNION ALL SELECT '14956535'				--UY
UNION ALL SELECT '10797628'				--UZ
UNION ALL SELECT '19738497'				--WA
UNION ALL SELECT '4739346'				--WB
UNION ALL SELECT '18747621'				--WG
UNION ALL SELECT '3919061'				--WH
UNION ALL SELECT '16016306'				--YM
UNION ALL SELECT '4622387'				--YN
UNION ALL SELECT '5532706'				--ZZ
UNION ALL SELECT '19240555'				--SJJM
UNION ALL SELECT '787938'				--SJM
UNION ALL SELECT '23188635'				--SJR
UNION ALL SELECT '12575535'				--SJSD
UNION ALL SELECT '14301612'				--SKKM
UNION ALL SELECT '3345772'				--SKMM
UNION ALL SELECT '2178402'				--SLH
UNION ALL SELECT '3872549'				--SLJ
UNION ALL SELECT '2937091'				--SLK
UNION ALL SELECT '5473299'				--SLM
UNION ALL SELECT '30697649'				--SLZ
UNION ALL SELECT '2222683'				--SLLM
UNION ALL SELECT '23570053'				--MOX
UNION ALL SELECT '7146892'				--SMOC
UNION ALL SELECT '8330307'				--SMOCNY
UNION ALL SELECT '15588279'				--SMOI
UNION ALL SELECT '407649'				--SMORM
UNION ALL SELECT '324564'				--SMORMB
UNION ALL SELECT '3230605'				--SMOS
UNION ALL SELECT '35597100'				--SMQ
UNION ALL SELECT '1374344'				--SMQARMB
UNION ALL SELECT '2504697'				--SOGA
UNION ALL SELECT '753624'				--SOGO
UNION ALL SELECT '13615649'				--SPA3M
UNION ALL SELECT '2341316'				--SRHKA
UNION ALL SELECT '1247148'				--SRMA
UNION ALL SELECT '324563'				--SRRMB
UNION ALL SELECT '356937'				--S305CRMB
UNION ALL SELECT '771942'				--S31ARMB
UNION ALL SELECT '408317'				--S31RM
UNION ALL SELECT '478396'				--S31RMB
UNION ALL SELECT '1013342'				--SSF2H
UNION ALL SELECT '837904'				--SSFH
UNION ALL SELECT '17044959'				--SSMA
UNION ALL SELECT '30597263'				--SSMM
UNION ALL SELECT '2192160'				--SSSD
UNION ALL SELECT '2491953'				--SSTMH
UNION ALL SELECT '3009929'				--SSTMM
UNION ALL SELECT '18974796'				--SSYH
UNION ALL SELECT '3938541'				--SSYR
UNION ALL SELECT '4212621'				--STE1H
UNION ALL SELECT '4589422'				--STE1M
UNION ALL SELECT '3566056'				--STE2
UNION ALL SELECT '3592718'				--STE3
UNION ALL SELECT '4019163'				--STE9
UNION ALL SELECT '3309466'				--STEA
UNION ALL SELECT '3780410'				--STEE
UNION ALL SELECT '3592707'				--STEF
UNION ALL SELECT '2383191'				--STEI
UNION ALL SELECT '3296297'				--STEN
UNION ALL SELECT '2430883'				--STEO
UNION ALL SELECT '1574254'				--STEQ
UNION ALL SELECT '2252615'				--STEU
UNION ALL SELECT '3062829'				--STEZ
UNION ALL SELECT '38068180'				--STM
UNION ALL SELECT '755409'				--STPM
UNION ALL SELECT '23463328'				--SVV
UNION ALL SELECT '867735'				--SW
UNION ALL SELECT '450036'				--SWKR
UNION ALL SELECT '1211231'				--SWK
UNION ALL SELECT '1211237'				--SWM
UNION ALL SELECT '14870436'				--SWO
UNION ALL SELECT '1201561'				--SWU
UNION ALL SELECT '24307432'				--SBI
UNION ALL SELECT '15516774'				--SNI
UNION ALL SELECT '4601030'				--SYI
UNION ALL SELECT '1083052'				--TL6
UNION ALL SELECT '9727510'				--TP
UNION ALL SELECT '19436067'				--TD1
UNION ALL SELECT '19436202'				--TD2
UNION ALL SELECT '19440122'				--TD3
UNION ALL SELECT '19440128'				--TD4
UNION ALL SELECT '19473802'				--TD5
UNION ALL SELECT '19473831'				--TD6
UNION ALL SELECT '19574419'				--TDA
UNION ALL SELECT '19574488'				--TDB
UNION ALL SELECT '19761295'				--TDC
UNION ALL SELECT '17797342'				--TS1
UNION ALL SELECT '33465007'				--TS10
UNION ALL SELECT '17797400'				--TS2
UNION ALL SELECT '17820768'				--TS3
UNION ALL SELECT '29764329'				--TS8
UNION ALL SELECT '33023129'				--TS9
UNION ALL SELECT '656135'				--UI
UNION ALL SELECT '19447731'				--VBR
UNION ALL SELECT '10398791'				--VKH
UNION ALL SELECT '10933415'				--SVVG
UNION ALL SELECT '5778932'				--VVG
UNION ALL SELECT '24104781'				--VVM
UNION ALL SELECT '26767367'				--VVN
UNION ALL SELECT '35816325'				--VVP
UNION ALL SELECT '14732090'				--WCH
UNION ALL SELECT '1124040'				--WI
UNION ALL SELECT '21355056'				--ACE
UNION ALL SELECT '4404031'				--AJ
UNION ALL SELECT '4314665'				--AP
UNION ALL SELECT '4212172'				--AS
UNION ALL SELECT '21524716'				--BAT
UNION ALL SELECT '22310261'				--BTM
UNION ALL SELECT '26263062'				--IX
UNION ALL SELECT '30715660'				--MN
UNION ALL SELECT '26263173'				--RJ
UNION ALL SELECT '21744949'				--TOP
UNION ALL SELECT '19984856'				--WINA
UNION ALL SELECT '19984899'				--WINC
UNION ALL SELECT '19998377'				--WINE
UNION ALL SELECT '20096020'				--WINF
UNION ALL SELECT '20096077'				--WING
UNION ALL SELECT '20398676'				--WINI
UNION ALL SELECT '20393148'				--WINJ
UNION ALL SELECT '20006616'				--WINS
UNION ALL SELECT '37352378'				--WP13
UNION ALL SELECT '11761289'				--WPR
UNION ALL SELECT '3854395'				--S797S
UNION ALL SELECT '1376434'				--wm
UNION ALL SELECT '4045713'				--WMA
UNION ALL SELECT '720475'				--WW
UNION ALL SELECT '2925993'				--WKR
UNION ALL SELECT '1131889'				--WWR
UNION ALL SELECT '14015187'				--XCN
UNION ALL SELECT '10346439'				--XKH
UNION ALL SELECT '10346359'				--XKM
UNION ALL SELECT '2270259'				--YI
UNION ALL SELECT '5973408'				--CYKM
UNION ALL SELECT '1993804'				--YKH
UNION ALL SELECT '5931469'				--YKM
UNION ALL SELECT '13053739'				--YUH
UNION ALL SELECT '11472964'				--YUM

------------- PROCESS --------------------
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tmpCust
	SET isfinished = 1
		,@custid = custid				
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @custid = @custid					
			,@target = 'DBCUST'

	--WAITFOR DELAY '00:00:0.100'
END			

 DROP TABLE #tmpCust
GO		
-- END STEP 4: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------
