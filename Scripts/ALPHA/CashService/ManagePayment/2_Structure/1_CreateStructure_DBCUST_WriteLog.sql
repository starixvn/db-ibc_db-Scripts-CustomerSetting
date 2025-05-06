/*<info serverAlias="DBCUST-bodb_CustomerLog"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBCUST-bodb_CustomerLog
*/

--*************************Write Log*************************

USE bodb_CustomerLog


CREATE TABLE [dbo].[Cash_UserLog_RunSP](
	[logid] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userid] [int] NULL,
	[logdate] [datetime] NULL,
	[custid] [int] NULL,
	[ActionID] [int] NULL,
	[TrackingValue] [nvarchar](max) NULL,
	[TrackingValueMask] [nvarchar](max) MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL,
	[Duration] [int] NULL,
	[TrackingValue2] [nvarchar](max) NULL,
	[TrackingValueMask2] [nvarchar](max) MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL,	
	[CreatedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cash_UserLog_RunSP] ADD  CONSTRAINT [DF_Cash_UserLog_RunSP_logdate]  DEFAULT (getdate()) FOR [logdate]
GO