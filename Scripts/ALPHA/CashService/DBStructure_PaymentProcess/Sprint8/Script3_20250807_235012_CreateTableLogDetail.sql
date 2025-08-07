/*<info serverAlias="DBCUST-bodb_CustomerLog, DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250417@Helios
	Task: Create table Cash_UserLog_RunSP_Detail [235012]  
	DB: DBCUST-bodb_CustomerLog, DBLOG-bodb_CustomerLog
*/

--*************************Write Log*************************

USE bodb_CustomerLog
GO

CREATE TABLE [dbo].[Cash_UserLog_RunSP_Detail](
	[logid] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userid] [int] NULL,
	[logdate] [datetime] NULL,
	[custid] [int] NULL,
	[TrackingValue] [nvarchar](max) NULL,
	[TrackingValueMask] [nvarchar](max) MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL,
	[Duration] [int] NULL,
	[TrackingValue2] [nvarchar](max) NULL,
	[TrackingValueMask2] [nvarchar](max) MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cash_UserLog_RunSP_Detail] ADD  CONSTRAINT [DF_Cash_UserLog_RunSP_Detail_logdate]  DEFAULT (getdate()) FOR [logdate]
GO


GRANT SELECT ON [dbo].[Cash_UserLog_RunSP_Detail]			TO wsv_CashService;
GRANT SELECT ON [dbo].[Cash_UserLog_RunSP_Detail]			TO asv_CashService;
--GRANT UNMASK TO asv_CashService;
--GRANT UNMASK TO wsv_CashService;