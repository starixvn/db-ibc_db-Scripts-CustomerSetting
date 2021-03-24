/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210224@Eden
	Task: Create table VRCustLockStatus [RM#149370]
	DB: DBCUST/CustDB fisrt (and add to CustDB_CustSetting publication when UM - Drop view before add table)
*/
SET ANSI_NULLS ON
GO
IF EXISTS(
	SELECT TOP 1 1 FROM sys.views v WHERE OBJECT_NAME(v.object_id) = 'VRCustLockStatus'
)
	DROP VIEW [dbo].VRCustLockStatus 
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VRCustLockStatus](
	[CustID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
 CONSTRAINT [PK_VRCustLockStatus] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [virtualrate_table]
) ON [virtualrate_table]

GO
--DROP TABLE VRCustLockStatus