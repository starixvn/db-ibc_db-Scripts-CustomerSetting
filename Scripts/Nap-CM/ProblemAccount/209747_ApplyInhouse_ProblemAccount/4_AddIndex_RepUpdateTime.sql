/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBACC-bodb02"></info>*/
/*
	Created: Helios
	Date: 9/9/2024 2:24:04 
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - Create new structure Distributor [Redmine: #209747]   
	DB: DBCustRepl-ReplCustDB,IRS_DBACC-bodb02
*/

/****** Object:  Index [IX_ProblemAccount_RepUpdateTime]    Script Date: 12/2/2024 1:22:16 PM ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'IX_ProblemAccount_RepUpdateTime')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_ProblemAccount_RepUpdateTime] ON [dbo].[ProblemAccount]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [IX_ProblemAccountAction_RepUpdateTime]    Script Date: 12/2/2024 1:22:34 PM ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'IX_ProblemAccountAction_RepUpdateTime')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_ProblemAccountAction_RepUpdateTime] ON [dbo].[ProblemAccountAction]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END


/****** Object:  Index [IX_ProblemAccountClassification_RepUpdateTime]    Script Date: 12/2/2024 1:20:48 PM ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'IX_ProblemAccountClassification_RepUpdateTime')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_ProblemAccountClassification_RepUpdateTime] ON [dbo].[ProblemAccountClassification]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [IX_ProblemAccountLimitDownline_RepUpdateTime]    Script Date: 12/2/2024 1:23:06 PM ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'IX_ProblemAccountLimitDownline_RepUpdateTime')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_ProblemAccountLimitDownline_RepUpdateTime] ON [dbo].[ProblemAccountLimitDownline]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [IX_ProblemAccountReason_RepUpdateTime]    Script Date: 12/2/2024 1:23:22 PM ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'IX_ProblemAccountReason_RepUpdateTime')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_ProblemAccountReason_RepUpdateTime] ON [dbo].[ProblemAccountReason]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END
