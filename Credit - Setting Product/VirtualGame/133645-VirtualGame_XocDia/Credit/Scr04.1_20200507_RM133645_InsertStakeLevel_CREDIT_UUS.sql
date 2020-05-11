/*
	Created By: Eden
	Created Date: 20200507
	Description: Stakelevel for Virtual Games CREDIT - UUS -XocDia
	DB: DBCust/CustDB	
*/
USE CustDB
GO

DELETE  
FROM StakeLevel WITH(ROWLOCK, UPDLOCK)
WHERE GameTypeID = 4602
	  AND exchangeid = 20

DECLARE @CRE_Stake TABLE (
	[GameTypeID] [int] NOT NULL,
	[Currency] [nvarchar](max) NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL,
	[MinLabel] [varchar](20) NULL,
	[MaxLabel] [varchar](20) NULL
) 
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UUS', 5.00, 2500.00, '5', '2,500') -- 
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UUS', 5.00, 5000.00, '5', '5,000') -- 
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UUS', 5.00, 10000.00, '5', '10,000') -- 
 
BEGIN --/* Insert StakeLevel
	INSERT INTO StakeLevel(
		 GameTypeID
		,MinLabel
		,MaxLabel
		,MinStake
		,MaxStake
		,ExchangeId
		,GameGroupID
	)
	SELECT	t.GameTypeID,
			t.MinLabel,
			t.MaxLabel,
			CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
			ExchangeId = e.exchangeid,
			GameGroupID = 0
	FROM @CRE_Stake t
     INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
	ORDER BY t.GameTypeID,e.exchangeid,MaxStake
END -- Insert StakeLevel */

