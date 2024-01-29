/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240104@Helios
	Task: Create New Structure Temp Table [#199368]
		https://nexdev.net/issues/199368
	DB: DBCust/CustDB
	-- RUN AT ALL REPLICATED SERVERS & DBCUST & DBTEST -- 
*/


/****** Object:  Table [dbo].[Tmp_CleanUpCustomerSetting]    Script Date: 1/4/2024 9:14:19 AM ******/ 

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tmp_CleanUpCustomerSetting](
	[CustID]		[INT]			NOT NULL
	PRIMARY KEY CLUSTERED (CustID)
)


-- DROP TABLE Tmp_CleanUpCustomerSetting