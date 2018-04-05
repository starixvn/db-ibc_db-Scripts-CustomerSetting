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
DECLARE @vr_old_value INT
DECLARE @vr_new_value INT

SELECT @vr_old_value = 3, @vr_new_value = 1


------------------------get all custid that need to be updated, but not BA Account
INSERT INTO @tbl_cust_updated
        ( custid, VRValue, 
          sporttype, bettype, islive, 
          SRecommend, MRecommend, Recommend, 
          isfinished, enableVirtualrate, siteid)

SELECT cvs.custid, dbo.f_GetVirtualSetting(cvs.bitmapVirtual, pvs.profileID) AS VRValue
        , pvs.sporttype, pvs.bettype, pvs.islive
        , ci.srecommend, ci.mrecommend, ci.recommend
        , 0, ci.VirtualMultiplier,st.siteid
FROM dbo.CustVirtualSetting AS cvs WITH (NOLOCK)  
    INNER JOIN  dbo.ProfileVirtualSetting AS pvs WITH (NOLOCK) ON  cvs.seqNo = pvs.seqNo 
    INNER JOIN CustInfo ci WITH (NOLOCK) ON ci.CustId = cvs.custId
    INNER JOIN Customer ct WITH (NOLOCK) ON ci.CustId = ct.custId
    INNER JOIN [Site] st WITH (NOLOCK) ON st.[site] = ct.[site]
    LEFT JOIN DBLIC.bodb_licensee.dbo.[LicenseeBAHistory] WITH (NOLOCK) BA ON BA.CustID = ci.custid AND BA.Status = 'Running'
WHERE dbo.f_GetVirtualSetting(cvs.bitmapVirtual, pvs.profileID) = 3
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
                        STR(@vr_old_value) AS '@OldVirtualRate',
                        STR(@vr_new_value) AS '@NewVirtualRate'
                FROM @tbl_cust_updated pvs1
                FOR XML PATH ('Rate'), type
            ) FOR XML PATH('ROOT'), type
        ) AS vrxmlgroup
    ) AS VARCHAR(MAX))
    
EXEC  DBLOG.bodb_CustomerLog.dbo.NAP_UserLog_UpdateVirtualRateSettings
                 @CreatorId   = 862400 
                ,@PunterVRSettingsDoc = @var_str_xml
                ,@ServiceName = ''
                ,@AdjustDate  = '2018-04-05 00:15:00'
                ,@ErrCode     = @ErrCode
                ,@ErrMsg      = @ErrMsg
                        
SELECT @ErrCode, @ErrMsg


-------------------------------change data-------------------------------------------------------
DECLARE @var_custid INT,
        @EnableVirtualrate BIT=0

WHILE (1 = 1)
BEGIN
    UPDATE TOP (1) @tbl_cust_updated
    SET isfinished = 1, @var_custid = custid   
    WHERE isfinished = 0
    
    UPDATE @tbl_cust_updated
    SET isfinished = 1, @var_custid = custid   
    WHERE custid = @var_custid
    
    IF @@ROWCOUNT = 0 BREAK
    
    SELECT @var_str_xml = @var_str_xml + '<Rate SportType="' + sporttype +'" BetType="' + bettype + '" IsLive="' + islive + '" VirtualMultiplier="1" />' 
    FROM @tbl_cust_updated 
    WHERE custid = @var_custid
    
    SELECT @var_str_xml = '<ROOT>' + @var_str_xml +'</ROOT>'

 
    EXEC Acc_CustomerUpdVirtualMultiplier
         @custId = @var_custid
        ,@EnableVirtualrate = @EnableVirtualrate
        ,@virtualmultiplier = @var_str_xml
        ,@UserID = '862400'
        ,@IP = ''
        ,@IsLicenseeUser = 0
        ,@ErrCode = @ErrCode
        ,@ErrMsg  = @ErrMsg
    SELECT @ErrCode, @ErrMsg
END

