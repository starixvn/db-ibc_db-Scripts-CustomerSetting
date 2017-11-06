/*
	Created by: Winnie
	Created Date: 20171103
	Description: DCS  Add Table 
	Database: DBTP/bodb_CustHistory
		
*/

-------

USE bodb_CustHistory

GO


CREATE TABLE [dbo].[Dep_CustDiscountSetting_Agent_history](
	UpdateTime datetime NOT NULL,
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	Discount DECIMAL(9,8) NOT NULL
) ON Dep_CustSetting3rd_table

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
