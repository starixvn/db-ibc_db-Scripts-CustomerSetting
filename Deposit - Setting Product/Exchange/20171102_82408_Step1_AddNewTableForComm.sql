/*
	Created by: Winnie
	Created Date: 20171103
	Description: DCS - Deposit - Add new table Dep_CustDiscountSetting_Agent 
	Database: DBCUST/CustDB
		
*/
USE CUSTDB
GO
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.filegroups where name='Dep_CustDiscountSetting_Agent_table ')
BEGIN
	ALTER DATABASE CUSTDB
	ADD FILEGROUP Dep_CustDiscountSetting_Agent_table;
END
GO

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.database_files where name='Dep_CustDiscountSetting_Agent_table_01')
BEGIN
	ALTER DATABASE CUSTDB 
	ADD FILE 
	(
		NAME = Dep_CustDiscountSetting_Agent_table_01,
		-- local dev
		--FILENAME = 'E:\SQLSERVER2008R2\IBC_DB\CustDB\Dep_CustBetSetting_Member_table_01.NDF'
		--FILENAME = 'D:\IBC_DB\bodb02\Dep_CustBetSetting_Member_table_01.NDF'
		
		-- local test
		--FILENAME = 'D:\DB233\IBC_DB\CustDB\Dep_CustDiscountSetting_Agent_table_01.NDF'
		--FILENAME = 'D:\DB234_SQLSERVER2008R2\IBC_DB\bodb02\Dep_CustDiscountSetting_Agent_table_01.NDF'
		
		--FILENAME = 'H:\USER_DB\CustDB\Dep_CustDiscountSetting_Agent_table_01.NDF'
	)
	TO FILEGROUP Dep_CustDiscountSetting_Agent_table;
END
GO

CREATE TABLE [dbo].Dep_CustDiscountSetting_Agent(
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	Discount DECIMAL(9,8) NOT NULL,
 CONSTRAINT [PK_Dep_CustDiscountSetting_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [Dep_CustDiscountSetting_Agent_Table]
) ON Dep_CustDiscountSetting_Agent_Table

GO

ALTER TABLE [dbo].Dep_CustDiscountSetting_Agent ADD CONSTRAINT [DF_Dep_CustDiscountSetting_Agent_Discount] DEFAULT ((0)) FOR Discount
GO


