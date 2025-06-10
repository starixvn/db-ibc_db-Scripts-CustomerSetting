/*<info serverAlias="DBLIC-bodb_LicenseeReport"></info>*/
/*
	Created: 20250602@Tacy
	Task: [LicenseeMatchMonitoring_History] - add new column (Redmine: #227673)
	DB: DBLIC.bodb_LicenseeReport


	StatusID:	0 ~ New
				1 ~ Sending
				2 ~ Sent"
*/

USE bodb_LicenseeReport
GO

-- 1. Add new column [StatusID]
ALTER TABLE LicenseeMatchMonitoring_History ADD [StatusID] TINYINT;

-- 2. Update: NULL --> 2
DECLARE @MaxLogId INT

SELECT @MaxLogId = MAX(LogId) FROM dbo.LicenseeMatchMonitoring_History WITH(NOLOCK)

SELECT @MaxLogId AS MaxLogId

UPDATE LicenseeMatchMonitoring_History WITH (ROWLOCK, UPDLOCK)
SET [StatusID] = 2
WHERE [StatusID] IS NULL
AND LogID<=@MaxLogId;

-- 3. Default value
ALTER TABLE LicenseeMatchMonitoring_History
ADD CONSTRAINT DF_LicenseeMatchMonitoring_History_Status DEFAULT 0 FOR [StatusID];

-- 4. Missing Status:
UPDATE LicenseeMatchMonitoring_History WITH (ROWLOCK, UPDLOCK)
SET [StatusID] = 0
WHERE [StatusID] IS NULL
AND LogID>@MaxLogId;