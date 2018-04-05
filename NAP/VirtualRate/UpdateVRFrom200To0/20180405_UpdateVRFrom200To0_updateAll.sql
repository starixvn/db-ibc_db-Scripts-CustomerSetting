/*
    Created: Vicky.phan
    Date: 2018-04-05
    Task : Update VR from 200% to 0
    DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tbl_cust_updated TABLE(custid INT, VRValue INT, 
                                sporttype SMALLINT, bettype SMALLINT, islive BIT, 
                                SRecommend INT, MRecommend INT, Recommend INT, 
                                isfinished BIT, enableVirtualrate BIT, siteid INT)
DECLARE @var_str_xml VARCHAR(MAX)
DECLARE @ErrCode INT
DECLARE @ErrMsg VARCHAR(MAX)
DECLARE @vr_old_value VARCHAR(5)
DECLARE @vr_new_value VARCHAR(5)

SELECT @vr_old_value = '3', @vr_new_value = '1'


------------------------get all custid that need to be updated, but not BA Account
INSERT INTO @tbl_cust_updated
        ( custid, VRValue, 
          sporttype, bettype, islive, 
          SRecommend, MRecommend, Recommend, 
          isfinished, enableVirtualrate, siteid)

          
SELECT cvs.custid, tblVRValue.val
        , pvs.sporttype, pvs.bettype, pvs.islive
        , ci.srecommend, ci.mrecommend, ci.recommend
        , 0, ci.VirtualMultiplier,st.siteid
FROM dbo.CustVirtualSetting AS cvs WITH (NOLOCK)  
    INNER JOIN  dbo.ProfileVirtualSetting AS pvs WITH (NOLOCK) ON  cvs.seqNo = pvs.seqNo 
    INNER JOIN CustInfo ci WITH (NOLOCK) ON ci.CustId = cvs.custId
    INNER JOIN Customer ctAgent WITH (NOLOCK) ON ci.recommend = ctAgent.custId
    INNER JOIN [Site] st WITH (NOLOCK) ON st.[site] = ctAgent.[site]
    CROSS APPLY (SELECT val FROM [dbo].[f_GetVirtualRateSetting](cvs.bitmapVirtual, pvs.profileID)) as tblVRValue
    LEFT JOIN DBLIC.bodb_licensee.dbo.[LicenseeBAHistory] BA WITH (NOLOCK) ON BA.CustID = ci.custid AND BA.Status = 'Running'
WHERE tblVRValue.val = 3
    AND pvs.profileID = 2
    AND BA.CustID IS NULL
    AND ci.roleId= 1
    

 ----------------------insert log
 SELECT @var_str_xml = CAST(
    (
    SELECT (
        SELECT (
                SELECT  custid          AS '@CustID', 
                        '2018-04-05'    AS '@ReportDate',
                        pvs1.SiteID     AS '@SiteID', 
                        pvs1.SRecommend AS '@SRecommend', 
                        pvs1.MRecommend AS '@MRecommend',
                        pvs1.Recommend  AS '@Recommend',
                        @vr_old_value   AS '@OldVirtualRate',
                        @vr_new_value   AS '@NewVirtualRate'
                FROM @tbl_cust_updated pvs1
                FOR XML PATH ('Rate'), type
            ) FOR XML PATH('ROOT'), type
        ) AS vrxmlgroup
    ) AS VARCHAR(MAX))
    
EXEC  DBLOG.bodb_CustomerLog.dbo.NAP_UserLog_UpdateVirtualRateSettings
                 @CreatorId   = 862400 
                ,@PunterVRSettingsDoc = @var_str_xml
                ,@ServiceName = 'Soccer'
                ,@AdjustDate  = '2018-04-05 00:15:00'
                ,@ErrCode     = @ErrCode
                ,@ErrMsg      = @ErrMsg
                        
SELECT @ErrCode, @ErrMsg


-------------------------------change data-------------------------------------------------------
SET @var_str_xml = NULL
SELECT @var_str_xml = COALESCE(@var_str_xml + ',', '') + CONVERT(VARCHAR(12),custid) FROM @tbl_cust_updated
SELECT @var_str_xml = '<ROOT> <Rate CustIds="' + @var_str_xml +'" VirtualMultiplier="' + @vr_new_value + '" /></ROOT>'

 
EXEC Acc_CustomerUpdVirtualMultiplier_Multiple
     @VirtualMultiplier=@var_str_xml
    , @UserID='862400'
    , @IP=''
    , @SportType=1
    , @ErrCode=@ErrCode
    , @ErrMsg  = @ErrMsg
SELECT @ErrCode, @ErrMsg


