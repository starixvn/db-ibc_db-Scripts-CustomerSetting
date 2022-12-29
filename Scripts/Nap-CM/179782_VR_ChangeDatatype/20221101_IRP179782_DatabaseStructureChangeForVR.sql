/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20221101@Johnson    
    Task : Database structure change for VR	[redmine:#179782]
    DB: DBCUST/CustDB
*/

ALTER TABLE CustSettingAutoSuspend ALTER COLUMN AutoSuspendLive VARBINARY(128)

ALTER TABLE CustSettingAutoSuspend ALTER COLUMN AutoSuspendNonLive VARBINARY(128)

ALTER TABLE CustSettingAutoSuspend ALTER COLUMN OverrideASLive VARBINARY(128)

ALTER TABLE CustSettingAutoSuspend ALTER COLUMN OverrideASNonLive VARBINARY(128)