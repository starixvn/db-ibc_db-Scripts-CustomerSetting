/*
	Created by: Winnie
	Created Date: 20171103
	Description: DCS  Add Table 
	Database: DBTP/bodb_CustHistory
		
*/

-------

USE bodb_CustHistory

GO

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.filegroups where name='Dep_CustDiscountSetting_Agent_table ')
BEGIN
	ALTER DATABASE bodb_CustHistory
	ADD FILEGROUP Dep_CustDiscountSetting_Agent_table;
END
GO

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.database_files where name='Dep_CustDiscountSetting_Agent_table_01')
BEGIN
	ALTER DATABASE bodb_CustHistory 
	ADD FILE 
	(
		NAME = Dep_CustDiscountSetting_Agent_table_01,
		-- local dev
		--FILENAME = 'N'E:\IBC_DB\bodb_CustHistory\Dep_CustDiscountSetting_Agent_table_01.NDF''
		--FILENAME = 'D:\IBC_DB\bodb02\Dep_CustBetSetting_Member_table_01.NDF'
		
		-- local test
		--FILENAME = 'D:\DB233\IBC_DB\CustDB\Dep_CustDiscountSetting_Agent_table_01.NDF'
		--FILENAME = 'D:\DB234_SQLSERVER2008R2\IBC_DB\bodb_CustHistory\Dep_CustDiscountSetting_Agent_table_01.NDF.NDF'
		
		--FILENAME = 'H:\USER_DB\CustDB\Dep_CustDiscountSetting_Agent_table_01.NDF'
	)
	TO FILEGROUP Dep_CustDiscountSetting_Agent_table;
END
GO

CREATE TABLE [dbo].[Dep_CustDiscountSetting_Agent_history](
	UpdateTime datetime NOT NULL,
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	Discount DECIMAL(9,8) NOT NULL
) ON Dep_CustDiscountSetting_Agent_table

GO
ALTER TABLE [dbo].[Dep_CustDiscountSetting_Agent_history] ADD  CONSTRAINT [DF_Dep_CustDiscountSetting_Agent_history_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO

ALTER TABLE [dbo].[Dep_CustDiscountSetting_Agent_history] ADD  DEFAULT ((0)) FOR Discount
GO

CREATE CLUSTERED INDEX [Dep_CustDiscountSetting_Agent_His_Index] ON [dbo].[Dep_CustDiscountSetting_Agent_history] 
(
	[UpdateTime] ASC,
	[CustID] ASC
) 
GO
