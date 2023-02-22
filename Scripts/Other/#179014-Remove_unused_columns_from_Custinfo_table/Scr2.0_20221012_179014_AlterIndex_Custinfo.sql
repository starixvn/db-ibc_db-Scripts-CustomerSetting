/*	
	Created: 20221012@Eden
	Task: Alter Index on DB054 DB055 custinfo - remove unused columns [#179014]
	DB: DB054,DB055
*/
USE [bodb02]
GO

/****** Object:  Index [IX_CI_srecommend]    Script Date: 2/22/2023 3:11:47 AM ******/
CREATE NONCLUSTERED INDEX [IX_CI_srecommend] ON [dbo].[custInfo]
(
	[srecommend] ASC,
	[roleid] ASC
)
INCLUDE([closed],[reject]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustInfo_index]
GO

/****** Object:  Index [IX_custinfo]    Script Date: 2/22/2023 3:11:48 AM ******/
CREATE NONCLUSTERED INDEX [IX_custinfo] ON [dbo].[custInfo]
(
	[mrecommend] ASC,
	[roleid] ASC
)
INCLUDE([closed],[reject],[credit]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustInfo_index]
GO

/****** Object:  Index [IX_custinfo_1]    Script Date: 2/22/2023 3:11:48 AM ******/
CREATE NONCLUSTERED INDEX [IX_custinfo_1] ON [dbo].[custInfo]
(
	[recommend] ASC,
	[roleid] ASC
)
INCLUDE([reject],[closed],[username],[credit],[Enabled]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustInfo_index]
GO
