/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250916@Dave	
	Task: In-House
	DB: 
	
	Revisions:
		- 20250916@Dave: Created [RedmineID: #238689]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerRemark')
BEGIN
	CREATE TABLE [dbo].[CustomerRemark]
	(
		[CustID] [INT] NOT NULL
		,[SuperRemark] [NVARCHAR](200) NULL
		,[MasterRemark] [NVARCHAR](200) NULL
		,[AgentRemark] [NVARCHAR](200) NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerRemark] PRIMARY KEY CLUSTERED ([CustID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerRemark] ADD CONSTRAINT [DF_CustomerRemark_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerRemark] ADD CONSTRAINT [DF_CustomerRemark_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_CustomerRemark_RepUpdateTime] ON [dbo].[CustomerRemark] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerRemark exists!!!'
END
GO
/***************************************************************************/




