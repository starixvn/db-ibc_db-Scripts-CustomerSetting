/*<info serverAlias="DBARCCUST-bodb_Customer" executers="" viewers=""></info>*/
/*
      Task:         Restore data Setting Super internal super account SS-USTM – Check existence of data in _old tables for CustID from username 'SS-USTM' [#12345]
      DB:           DBARCCUST-bodb_Customer
      Author:       Helios
      Created:      20250827@Helios
      Note:         IsExist = 1 (Exist data for CustID), IsExist = 0 (Not exist data for CustID)
*/
SET NOCOUNT ON;


-- Step 1: Create temp table for Username/CustID

IF OBJECT_ID('tempdb..#CustList') IS NOT NULL DROP TABLE #CustList;
CREATE TABLE #CustList (
    CustID INT NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Role VARCHAR(20) NOT NULL
);
INSERT INTO #CustList (CustID, Username, Role)
VALUES
    (160711567, 'GEOUSD', 'Member'),
    (160711306, 'AS-USTM', 'Agent'),
    (160710961, 'MS-USTM', 'Master'),
    (160709453, 'SS-USTM', 'Super');

CREATE NONCLUSTERED INDEX IX_CustList_CustID ON #CustList(CustID);


-- Step 2: Check existence for each CustID in #CustList
SELECT
    c.CustID,
    c.Username,
    c.Role,
    t.TableName,
    CASE WHEN t.IsExist IS NULL THEN 0 ELSE t.IsExist END AS IsExist
FROM #CustList c
CROSS APPLY (
    -- Scan from DBA_ArchiveAccount2_BackupAgent.sql
    SELECT 'customer_old' AS TableName, CASE WHEN EXISTS (SELECT 1 FROM customer_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END AS IsExist UNION ALL
    SELECT 'custinfo_old', CASE WHEN EXISTS (SELECT 1 FROM custinfo_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustVirtualSetting_Old', CASE WHEN EXISTS (SELECT 1 FROM CustVirtualSetting_Old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustProductStatus_old', CASE WHEN EXISTS (SELECT 1 FROM CustProductStatus_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'custsub_old', CASE WHEN EXISTS (SELECT 1 FROM custsub_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustDiscount3rd_Agent_old', CASE WHEN EXISTS (SELECT 1 FROM CustDiscount3rd_Agent_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustPTSetting3rd_Agent_old', CASE WHEN EXISTS (SELECT 1 FROM CustPTSetting3rd_Agent_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustStakeLevel_Agent_old', CASE WHEN EXISTS (SELECT 1 FROM CustStakeLevel_Agent_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustWinLossLimit_Agent_old', CASE WHEN EXISTS (SELECT 1 FROM CustWinLossLimit_Agent_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustPTGroupSetting3rd_Member_old', CASE WHEN EXISTS (SELECT 1 FROM CustPTGroupSetting3rd_Member_old WITH(NOLOCK) WHERE AgentID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustAgent_old', CASE WHEN EXISTS (SELECT 1 FROM CustAgent_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustMaster_old', CASE WHEN EXISTS (SELECT 1 FROM CustMaster_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustSuper_old', CASE WHEN EXISTS (SELECT 1 FROM CustSuper_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustSuperProfile_old', CASE WHEN EXISTS (SELECT 1 FROM CustSuperProfile_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustLoginInfo_old', CASE WHEN EXISTS (SELECT 1 FROM CustLoginInfo_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustLoginInfoSub_old', CASE WHEN EXISTS (SELECT 1 FROM CustLoginInfoSub_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustMaxPayoutSetting_Agent_old', CASE WHEN EXISTS (SELECT 1 FROM CustMaxPayoutSetting_Agent_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustProfilePicture_old', CASE WHEN EXISTS (SELECT 1 FROM CustProfilePicture_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'BetLimitControlCustSetting_old', CASE WHEN EXISTS (SELECT 1 FROM BetLimitControlCustSetting_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustPTTemplate_old', CASE WHEN EXISTS (SELECT 1 FROM CustPTTemplate_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustPTTemplateDetail_old', CASE WHEN EXISTS (SELECT 1 FROM CustPTTemplateDetail_old d WITH(NOLOCK) INNER JOIN CustPTTemplate_old t WITH(NOLOCK) ON d.TemplateID = t.TemplateID WHERE t.custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'VRAgentAutoAdjustment_old', CASE WHEN EXISTS (SELECT 1 FROM VRAgentAutoAdjustment_old WITH(NOLOCK) WHERE AgentID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'VRCustLockStatus_old', CASE WHEN EXISTS (SELECT 1 FROM VRCustLockStatus_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'VRCustSetting_old', CASE WHEN EXISTS (SELECT 1 FROM VRCustSetting_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'VRSettingManualUpdAcc_old', CASE WHEN EXISTS (SELECT 1 FROM VRSettingManualUpdAcc_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'BetSetting3rd_Agent_old', CASE WHEN EXISTS (SELECT 1 FROM BetSetting3rd_Agent_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'BetSetting_Agent_old', CASE WHEN EXISTS (SELECT 1 FROM BetSetting_Agent_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    -- Scan from DBA_ArchiveAccount2_BackupMember.sql
    SELECT 'CustDiscount3rd_Member_old', CASE WHEN EXISTS (SELECT 1 FROM CustDiscount3rd_Member_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustSettingMode3rd_old', CASE WHEN EXISTS (SELECT 1 FROM CustSettingMode3rd_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustStakeLevel_Member_old', CASE WHEN EXISTS (SELECT 1 FROM CustStakeLevel_Member_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustLoginInfo_Member_old', CASE WHEN EXISTS (SELECT 1 FROM CustLoginInfo_Member_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustWinLossLimit_Member_old', CASE WHEN EXISTS (SELECT 1 FROM CustWinLossLimit_Member_old WITH(NOLOCK) WHERE CustId = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustMaxPayoutSetting_Member_old', CASE WHEN EXISTS (SELECT 1 FROM CustMaxPayoutSetting_Member_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'WinLimit_CustGameStatus_old', CASE WHEN EXISTS (SELECT 1 FROM WinLimit_CustGameStatus_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'WinLimit_CustGameMonitoring_old', CASE WHEN EXISTS (SELECT 1 FROM WinLimit_CustGameMonitoring_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'WinLimit_CustGameMonitoring_History_old', CASE WHEN EXISTS (SELECT 1 FROM WinLimit_CustGameMonitoring_History_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'BetSetting_Member_old', CASE WHEN EXISTS (SELECT 1 FROM BetSetting_Member_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'BetSetting3rd_Member_old', CASE WHEN EXISTS (SELECT 1 FROM BetSetting3rd_Member_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'RobotList_old', CASE WHEN EXISTS (SELECT 1 FROM RobotList_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'CustQRCode_old', CASE WHEN EXISTS (SELECT 1 FROM CustQRCode_old WITH(NOLOCK) WHERE custid = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'VRMemberBigStake_old', CASE WHEN EXISTS (SELECT 1 FROM VRMemberBigStake_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END UNION ALL
    SELECT 'VRCustAutoAdjustment_old', CASE WHEN EXISTS (SELECT 1 FROM VRCustAutoAdjustment_old WITH(NOLOCK) WHERE CustID = c.CustID) THEN 1 ELSE 0 END
) t
ORDER BY c.Username, t.TableName;
