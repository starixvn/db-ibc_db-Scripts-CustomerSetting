/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: Helios
	Date: 9/9/2024 2:24:04 
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - Add Index RepUpdateTime [Redmine: #209747]   
	DB: DBCust-CustDB
*/

/****** Object:  Index [CIX_ProblemAccount_Del_InHouse]    Script Date: 12/2/2024 1:22:16 PM ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProblemAccount_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProblemAccount_Del_InHouse] ON [dbo].[ProblemAccount_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProblemAccountAction_Del_InHouse]    Script Date: 12/2/2024 1:22:34 PM ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProblemAccountAction_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProblemAccountAction_Del_InHouse] ON [dbo].[ProblemAccountAction_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END


/****** Object:  Index [CIX_ProblemAccountClassification_Del_InHouse]    Script Date: 12/2/2024 1:20:48 PM ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProblemAccountClassification_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProblemAccountClassification_Del_InHouse] ON [dbo].[ProblemAccountClassification_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProblemAccountLimitDownline_Del_InHouse]    Script Date: 12/2/2024 1:23:06 PM ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProblemAccountLimitDownline_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProblemAccountLimitDownline_Del_InHouse] ON [dbo].[ProblemAccountLimitDownline_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProblemAccountReason_Del_InHouse]    Script Date: 12/2/2024 1:23:22 PM ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProblemAccountReason_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProblemAccountReason_Del_InHouse] ON [dbo].[ProblemAccountReason_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END
