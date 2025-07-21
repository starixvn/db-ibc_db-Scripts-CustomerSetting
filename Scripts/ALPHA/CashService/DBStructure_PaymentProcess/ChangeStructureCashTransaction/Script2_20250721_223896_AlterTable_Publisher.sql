/*<info serverAlias="DBSIC-bodb02"></info>*/
/*
	Created: 20250421@Eden
	Task:  Remove Identity of CashTransaction Table [#RedmineID:#223896]
		Step 1: Create CashTransaction_Temp table without identity column
		Step 2: migrate data CashTransaction --> CashTransaction_Temp table 
		Step 3: Rename CashTransaction --> Del_CashTransaction
				Rename CashTransaction_Temp --> CashTransaction
	DB: DBSIC-bodb02
*/

-- Step 1 : Create CashTransaction_Temp table without identity column------------------------
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashTransaction_Temp](
	[TransId] [bigint] NOT NULL,
	[CustId] [int] NOT NULL,
	[TransactionTypeID] [tinyint] NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[Amount] [money] NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[Creator] [int] NOT NULL,
	[Remark] [nvarchar](1000) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[SiteDBGroupID] [smallint] NULL,
	[TransferRefNo] [bigint] NULL,
	[OperatedBy] [int] NULL,
	[OperatedTime] [datetime] NULL,
	[SubAccID] [int] NULL,
	[PaymentType] [tinyint] NULL,
	[PaymentMethod] [tinyint] NULL,
	[PaymentFrom] [varchar](100) MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL,
	[PaymentTo] [varchar](100) MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL,
	[PaySlip] [varbinary](max) NULL,
	[ExtraInfo] [nvarchar](1000) NULL,
	[AdjustCreditAmt] [money] NULL
	CONSTRAINT [PK_CashTransaction_1] PRIMARY KEY CLUSTERED 
(
	[TransId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]

GO

-- Index for CashTransaction
CREATE NONCLUSTERED INDEX IX_CashTransaction_RepUpdateTime ON [dbo].[CashTransaction_Temp] (RepUpdateTime ASC) ON [DATA];
GO
CREATE NONCLUSTERED INDEX IX_CreatedTime ON [dbo].[CashTransaction_Temp] (CreatedTime ASC) ON [DATA];
GO
CREATE NONCLUSTERED INDEX IX_TypeID_Status ON [dbo].[CashTransaction_Temp] (CustId, TransactionTypeID, StatusId) ON [DATA];

ALTER TABLE [dbo].[CashTransaction_Temp] ADD  DEFAULT ([dbo].[f_get_bettrans_transid]()) FOR [TransId]
GO

GRANT EXECUTE ON OBJECT::dbo.get_bettrans_transid TO wsv_CashService;
GRANT EXECUTE ON OBJECT::dbo.get_bettrans_transid TO asv_CashService;
GO
-- Step 2 : migrate data CashTransaction --> CashTransaction_Temp table----------------------------------------
--TRUNCATE TABLE [CashTransaction_Temp]
INSERT INTO [CashTransaction_Temp](
	TransId
	,CustId
	,TransactionTypeID
	,StatusId
	,Amount
	,CreatedTime
	,Creator
	,Remark
	,RepUpdateTime
	,SiteDBGroupID
	,TransferRefNo
	,OperatedBy
	,OperatedTime
	,SubAccID
	,PaymentType
	,PaymentMethod
	,PaymentFrom
	,PaymentTo
	,PaySlip
	,ExtraInfo
	,AdjustCreditAmt
	)
	SELECT TransId
		,CustId
		,TransactionTypeID
		,StatusId
		,Amount
		,CreatedTime
		,Creator
		,Remark
		,RepUpdateTime
		,SiteDBGroupID
		,TransferRefNo
		,OperatedBy
		,OperatedTime
		,SubAccID
		,PaymentType
		,PaymentMethod
		,PaymentFrom
		,PaymentTo
		,PaySlip
		,ExtraInfo
		,AdjustCreditAmt
FROM CashTransaction WITH(NOLOCK)

-- Step 3 :Step 3: Rename CashTransaction --> Del_CashTransaction ----------------------------------------
				-- Rename CashTransaction_Temp --> CashTransaction ----------------------------------------

EXEC sp_rename 'CashTransaction','DEL_CashTransaction'
EXEC sp_rename 'CashTransaction_Temp','CashTransaction'

/*
EXEC sp_rename 'CashTransaction','CashTransaction_Temp'
EXEC sp_rename 'DEL_CashTransaction','CashTransaction'
*/

--select * FROM CashTransaction WITH(NOLOCK) WHERE TransID > 2860
--select * FROM CashTransaction_Temp WITH(NOLOCK) WHERE TransID > 2860