/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20240201@Johnson
	Task: LAP - Restructure Player Commission
	DB: DBCUST/bodb_Licensee
*/

CREATE TABLE [dbo].[LicenseeGroupDiscount](
	[GroupDiscountID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LicenseeID] [int] NOT NULL,
	[GroupName] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[color] [varchar](20) NULL,
	[IsDefault] [bit] NOT NULL,
 CONSTRAINT [PK_LicenseeGroupDiscount] PRIMARY KEY CLUSTERED 
(
	[GroupDiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [licensee_table]
) ON [licensee_table]
GO

ALTER TABLE [dbo].[LicenseeGroupDiscount] ADD  CONSTRAINT [DF_LicenseeGroupDiscount_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

CREATE TABLE [dbo].[LicenseeCustDiscount](
	[LicenseeID] [int] NOT NULL,
	[CustID] [int] NOT NULL,
	[GroupDiscountID] [int] NOT NULL,	
 CONSTRAINT [PK_LicenseeCustDiscount] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [licensee_table]
) ON [licensee_table]
GO

CREATE TABLE [dbo].[LicenseeGroupDiscountDetail](
	[GroupDiscountID] [int] NOT NULL,
	[Licenseeid] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Discount] [decimal](9, 8) NULL,
 CONSTRAINT [PK_LicenseeGroupCommDetail] PRIMARY KEY CLUSTERED 
(
	[GroupDiscountID] ASC,
	[Licenseeid] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [licensee_table]
) ON [licensee_table]

GO
