/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/

/*
    Created: 20250521@Tacy
    Task: Lic - Insert new actionlog [RedmineID: #227673]
    DB: DBLOG-bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

-- Insert data into LogActionType_lic
INSERT INTO LogActionType_lic (ActionTypeId, ActionTypeName)
VALUES
    (10, 'MONITORING_CHANGE'),
    (11, 'CONFIG_CHANGE'),
    (12, 'ALERT_TRIGGERED');

-- Insert data into LogAction_lic
INSERT INTO LogAction_lic (ActionID, ActionTypeID, SPName, ActionName)
VALUES
    (4001, 10, 'Lrf_LicenseeMatchMonitoring_Ins', 'Add Monitoring Match'),
    (4002, 10, 'Lrf_LicenseeMatchMonitoring_Upd', 'Remove Monitoring Match'),
    (4003, 11, 'Lrf_LicenseeMatchMonitoringSetting_Ins', 'Create Alert Rule'),
    (4004, 11, 'Lrf_LicenseeMatchMonitoringSetting_Upd', 'Update Alert Rule'),
    (4005, 11, 'Lrf_LicenseeMatchMonitoringSetting_Del', 'Remove Alert Rule'),
    (4006, 12, 'Task_MatchMonitoring_UpdateMatchAlert', 'Alert Fired');