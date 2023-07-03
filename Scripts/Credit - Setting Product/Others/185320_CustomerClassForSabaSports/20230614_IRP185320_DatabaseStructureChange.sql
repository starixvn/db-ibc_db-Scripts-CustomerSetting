/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20230703@Johnson
	Task: Add new table customer class setting [#RedmineID:#185320]
	DB: DBCust/CustDB
*/


CREATE TABLE [dbo].[CustomerClassSetting](
	[custid] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[CustomerClass] [smallint] NULL,
	[ModifiedDate] [datetime]
 CONSTRAINT [PK_CustomerClassSetting] PRIMARY KEY CLUSTERED 
(
	[custid] ASC,
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]

GO



