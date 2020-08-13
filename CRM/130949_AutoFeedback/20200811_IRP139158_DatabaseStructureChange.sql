/*
	Created: 20200811@Johnson
	Task: CRM - Missing create feedback for Void Abnormal Bet [redemine: #139158]
	DB: DBCRM/bodb_CRM
*/
--step 1: rename table crmMessageImport to crmMessageImport_tmp
sp_rename 'crmMessageImport', 'crmMessageImport_tmp'
GO

sp_rename 'PK_crmMessageImport', 'PK_crmMessageImport_tmp'
GO
--end step 1
---------------------------------------------------------------

----------------------------------------------------------------
--step 2: create table crmMessageImport again

CREATE TABLE [dbo].[crmMessageImport](
	[MessageID] [int] NOT NULL,
	[RequestID] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[IsProcessed] [bit] NULL,	
 CONSTRAINT [PK_crmMessageImport] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC,
	[RequestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE crmMessageImport ADD CONSTRAINT DF_crmMessageImport_IsProcessed DEFAULT 0 FOR IsProcessed
GO
--end step 2
----------------------------------------------------------------

----------------------------------------------------------------
--Step 3: Import data from crmMessageImport_tmp to new table crmMessageImport

INSERT INTO crmMessageImport(MessageId,RequestID,CreatedDate,IsProcessed)
SELECT DISTINCT vh.MessageId, vh.RequestId,GETDATE(),0
FROM dbacc.bodb02.dbo.TicketVoiding_VoidingHistory vh WITH(NOLOCK)
	INNER JOIN dbacc.bodb02.dbo.TicketVoiding_Request r WITH (NOLOCK) ON vh.RequestId = r.RequestId 
														AND r.IssueTypeId = 11 --abnormal bets
WHERE vh.CreatedDate >= GETDATE() - 1
	AND vh.StatusId = 2 --tickets void successfully
ORDER BY MessageId ASC 

--update isProcessed for msg already created fb
UPDATE c
SET c.CreatedDate = t.CreatedDate,
	c.IsProcessed = t.IsProcessed
FROM crmMessageImport c WITH(UPDLOCK,ROWLOCK)
	INNER JOIN crmMessageImport_tmp t WITH(NOLOCK) ON c.MessageID = t.MessageID
GO
--end step 3	
----------------------------------------------------------------

----------------------------------------------------------------
--step4: add new column into table SystemSetting
ALTER TABLE  SystemSetting ADD ServiceName VARCHAR(100)

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET ServiceName = 'AutoFB'

GO
--end step 4
----------------------------------------------------------------

--step 5: drop table crmMessageImport_tmp after done release
--wait signal from dev team to check service ok before run this step
DROP TABLE crmMessageImport_tmp


