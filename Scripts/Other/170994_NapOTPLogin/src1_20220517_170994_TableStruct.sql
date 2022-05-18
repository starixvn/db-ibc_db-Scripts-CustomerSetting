/*<info serverAlias="DBPOL-Nap_UserControl"></info>*/
/*
	Created: 20220517@Winfred
	Task : NAP OTP Login requried for VPN's users [redmine:#170994]
	DB: DBPOL/NAP_UserControl
*/

USE Nap_UserControl
GO

--DROP TABLE [dbo].[AdminOTP]
CREATE TABLE [dbo].[AdminOTP](
	[CustID] [INT] NOT NULL,
	[SecretKey]  [NVARCHAR](50) NULL,
	[IgnoreOTP] [BIT] NULL DEFAULT((0)),
	[System] [VARCHAR](10) NULL,
	[Modifier] [INT] NULL,
	[ModifiedDate] [DATETIME] NULL,
	[Creator] [INT] NULL,
	[CreatedDate] [DATETIME] NULL
) ON [NAP_UserControl_table]
GO

CREATE CLUSTERED INDEX [PK_AdminOTP] ON [dbo].[AdminOTP] 
(
	[CustID] ASC,
	[System] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [NAP_UserControl_table]
GO

