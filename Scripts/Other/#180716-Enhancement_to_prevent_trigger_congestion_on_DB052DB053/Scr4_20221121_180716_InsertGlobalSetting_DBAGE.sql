/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: 20221121@Eden
	Task: Insert global setting [#180716]
	DB: DBAGE/bodb02
*/
USE bodb02
GO
INSERT INTO WLMonitored_Service_GlobalSetting(ServiceName,SettingName,SettingValue,UpdatedTime)
SELECT 'WLMonitored_Setting_Sync','LastID','0', GETDATE()
WHERE NOT EXISTS(SELECT 1 
				FROM WLMonitored_Service_GlobalSetting WITH(NOLOCK) 
				WHERE ServiceName = 'WLMonitored_Setting_Sync' 
					AND SettingName = 'LastID'
		)


INSERT INTO SystemSettings(VName,VValue)
SELECT 'SettingJobDeploymentDate',''
WHERE NOT EXISTS(SELECT 1 
				FROM SystemSettings WITH(NOLOCK) 
				WHERE VName = 'SettingJobDeploymentDate'
				)