/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Elodie
	Date: 20220617
	Task: Setting job management
	DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE [dbo].[SystemSettings](
	[VID] [int] IDENTITY(1,1) NOT NULL,
	[VName] [varchar](50) NOT NULL,
	[VValue] [varchar](200) NULL,
 CONSTRAINT [PK_SystemSettings_1] PRIMARY KEY CLUSTERED 
(
	[VName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

INSERT INTO SystemSettings (VName, VValue)
SELECT 'SettingJobDeploymentDate',''
