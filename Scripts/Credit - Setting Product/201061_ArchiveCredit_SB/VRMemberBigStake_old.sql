/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
	Created: Helios@20241028
	Task: Create new tables to store bet setting for 3rd products - Credit [Redmine: #204358]    
	DB: DBARCCUST-bodb_Customer
*/


USE bodb_Customer

/****** Object:  Table [dbo].[VRMemberBigStake_old]    Script Date: 3/5/2025 2:51:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'VRMemberBigStake_old' )
BEGIN

	CREATE TABLE [dbo].[VRMemberBigStake_old](
		[CustID] [int] NOT NULL,
		[Type] [tinyint] NOT NULL,
		[FirstBetDate] [date] NULL,
		[Status] [tinyint] NULL,
	 CONSTRAINT [PK_VRMemberBigStake_old] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[Type] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table VRMemberBigStake_old'
END

GO