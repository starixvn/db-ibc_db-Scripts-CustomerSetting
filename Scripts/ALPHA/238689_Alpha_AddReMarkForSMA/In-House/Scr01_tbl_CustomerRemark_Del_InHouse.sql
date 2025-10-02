/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250916@Dave	
	Task: In-House
	DB: 
	
	Revisions:
		- 20250916@Dave: Created [RedmineID: #238689]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerRemark_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerRemark_Del_InHouse]
	(
		[CustID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerRemark_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerRemark_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerRemark_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerRemark_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerRemark_Del_InHouse exists!!!'
END
GO
/***************************************************************************/




