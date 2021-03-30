/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*	
	Created: 20210330@Eden
	Task: Create table VRCustLockStatus_History [#152094]
	DB: DBTP/bodb_CustHistory
*/
USE bodb_CustHistory
GO
--DROP TABLE [VRCustLockStatus_History]
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VRCustLockStatus_History](
	[CustID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[UpdateTime] [datetime] NOT NULL,
	[IsLocked] [bit] NOT NULL
)
ALTER TABLE [dbo].[VRCustLockStatus_History] ADD  CONSTRAINT [DF_VRCustLockStatus_History_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO
CREATE CLUSTERED INDEX [VRCustLockStatus_His_Index] ON [dbo].[VRCustLockStatus_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)
GO