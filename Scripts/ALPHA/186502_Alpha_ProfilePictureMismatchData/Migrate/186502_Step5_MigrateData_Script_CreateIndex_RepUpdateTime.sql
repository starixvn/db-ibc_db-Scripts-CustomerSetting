/*<info serverAlias="DBCUST-bodb_Credit"></info>*/
/*
	Created by: Helios
	Date: 19/06/2023
	Task: Cover User Change Image when migrate data [Redmine:#186502]	
	DB: DBCUST/bodb_Credit 
*/

/****** Object:  Index [IX_RepUpdateTime]    Script Date: 6/19/2023 5:28:17 PM ******/
USE bodb_Credit
GO
CREATE NONCLUSTERED INDEX [IX_RepUpdateTime_ProfilePicture] ON [dbo].[ProfilePicture]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ProfilePicture]
GO

CREATE NONCLUSTERED INDEX [IX_RepUpdateTime_CustProfilePicture] ON [dbo].[CustProfilePicture]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ProfilePicture]
GO
