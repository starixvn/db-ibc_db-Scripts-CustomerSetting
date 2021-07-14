/*
	Created: 20210604@Johnson
	Task: Database structure for new source Problem account
	DB: DBCust/CustDB
*/

--setup this table into pub CustDB_CustSetting
CREATE TABLE [dbo].[Dep_CustCategoryHistory](
	[LogID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL ,
	[custid] [int] NOT NULL,
	[CategoryID] [smallint] NULL,
	[CustomerClass] [smallint] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Dep_CustCategoryHistory] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]

GO
