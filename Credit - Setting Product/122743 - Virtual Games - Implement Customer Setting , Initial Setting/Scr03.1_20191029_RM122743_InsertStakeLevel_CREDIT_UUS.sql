/*
	Created By: Eden
	Created Date: 20191029
	Description: Stakelevel for Virtual Games CREDIT - UUS
	DB: DBCust/CustDB	
*/
USE CustDB
GO

DELETE  
FROM StakeLevel WITH(ROWLOCK, UPDLOCK)
WHERE GameTypeID = 4601
	  AND exchangeid = 20

DECLARE @CRE_Stake TABLE (
	[GameTypeID] [int] NOT NULL,
	[Currency] [nvarchar](max) NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL
) 
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 5.00, 500.00) -- 
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 5.00, 1000.00) -- 
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 5.00, 2000.00) -- 
 
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
			CONVERT(VARCHAR(20),CONVERT(DECIMAL(19,0),t.MinStake)) AS MinLabel,
			CONVERT(VARCHAR(20),CONVERT(DECIMAL(19,0),t.MaxStake)) AS MaxLabel,
			CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
			ExchangeId = e.exchangeid,
			GameGroupID = 0
	FROM @CRE_Stake t
     INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
END -- Insert StakeLevel */

