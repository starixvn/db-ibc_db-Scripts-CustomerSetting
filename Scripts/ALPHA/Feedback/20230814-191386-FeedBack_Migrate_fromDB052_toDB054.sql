/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230814@Tacy
	Task : Migrate bodb_chatbot from DB052 to DB054
		https://nexdev.net/issues/191386
	DB: DBBOT.bodb_ChatBot (DB054)
*/
/*
	- Age_FeedbackFunc
	- Age_FeedbackArea
	- CustFeedback
	- CustFeedbackArea
*/
USE [bodb_ChatBot]
GO

CREATE TABLE #CustFeedback (
			[CustID] [int] NOT NULL,
			[Subaccid] [int] NOT NULL,
			[FuncID] [int] NULL,
			[Comment] [nvarchar](4000) NULL,
			[Rate] [tinyint] NULL,
			[CreatedDate] [smalldatetime] NULL
		)

CREATE TABLE #CustFeedback_batch (
			[CustID] [int] NOT NULL,
			[Subaccid] [int] NOT NULL,
			[FuncID] [int] NULL,
			[Comment] [nvarchar](4000) NULL,
			[Rate] [tinyint] NULL,
			[CreatedDate] [smalldatetime] NULL
		)

CREATE TABLE #CustFeedbackArea (
			[CustID] [int] NOT NULL,
			[Subaccid] [int] NOT NULL,
			[FuncID] [int] NOT NULL,
			[AreaID] [int] NOT NULL
		)

------------------------------------------------------------------
--Age_FeedbackFunc
UPDATE f
SET  f.FuncNameCN3=t.FuncNameCN3
	,f.FuncNameCH=t.FuncNameCH
	,f.FuncNameCS=t.FuncNameCS
	,f.FuncNameTH=t.FuncNameTH
FROM Age_FeedbackFunc f WITH (UPDLOCK, ROWLOCK)
INNER JOIN DB052.bodb_chatbot.dbo.Age_FeedbackFunc t WITH (NOLOCK)
		ON t.FuncID=f.FuncID

------------------------------------------------------------------
--Age_FeedbackArea
UPDATE f
SET  f.AreaNameCN3=t.AreaNameCN3
	,f.AreaNameCH=t.AreaNameCH
	,f.AreaNameCS=t.AreaNameCS
	,f.AreaNameTH=t.AreaNameTH
FROM Age_FeedbackArea f WITH (UPDLOCK, ROWLOCK)
INNER JOIN DB052.bodb_chatbot.dbo.Age_FeedbackArea t WITH (NOLOCK)
		ON t.FuncID=f.FuncID
		AND T.AreaID=f.AreaID
------------------------------------------------------------------
--#CustFeedback
INSERT INTO #CustFeedback (CustID, Subaccid, FuncID, Comment, Rate, CreatedDate)
SELECT c.CustID, c.Subaccid, c.FuncID, c.Comment, c.Rate, c.CreatedDate
FROM DB052.bodb_chatbot.dbo.CustFeedback c WITH (NOLOCK)
INNER JOIN dbcust.custdb.dbo.customer ci WITH (NOLOCK)
			ON ci.custid=c.CustID
OUTER APPLY (SELECT TOP 1 1 val 
			 FROM CustFeedback t WITH (NOLOCK)
			 WHERE c.CustID=t.custid
			 AND c.Subaccid=t.Subaccid
			 AND ISNULL(c.FuncID,0)=ISNULL(t.FuncID,0)
			 AND ISNULL(c.Comment,'')=ISNULL(t.Comment,'')
			 AND c.Rate=t.Rate
			 AND c.CreatedDate=t.CreatedDate) t
WHERE t.val IS NULL AND ci.currency<>20

IF @@ROWCOUNT=0
	GOTO tb_CustFeedbackArea

WHILE (1=1)
BEGIN
	DELETE FROM #CustFeedback_batch

	DELETE TOP (3000) FROM #CustFeedback
	OUTPUT deleted.CustID, deleted.Subaccid, deleted.FuncID, deleted.Comment, deleted.Rate, deleted.CreatedDate
	INTO #CustFeedback_batch (CustID, Subaccid, FuncID, Comment, Rate, CreatedDate)

	IF @@ROWCOUNT=0
		BREAK

	INSERT INTO CustFeedback ([CustID], [Subaccid], [Comment], [Rate], [CreatedDate], [FuncID])
	SELECT c.[CustID], c.[Subaccid], c.[Comment], c.[Rate], c.[CreatedDate], c.[FuncID]
	FROM DB052.bodb_chatbot.dbo.CustFeedback c WITH (NOLOCK) 
	INNER JOIN #CustFeedback_batch t ON c.CustID=t.custid
									AND c.Subaccid=t.Subaccid
									AND ISNULL(c.FuncID,0)=ISNULL(t.FuncID,0)
									AND ISNULL(c.Comment,'')=ISNULL(t.Comment,'')
									AND c.Rate=t.Rate
									AND c.CreatedDate=t.CreatedDate
	WAITFOR DELAY '00:00:0.050'
END

------------------------------------------------------------------
--#CustFeedbackArea
tb_CustFeedbackArea:
	INSERT INTO #CustFeedbackArea (CustID, Subaccid, FuncID, AreaID)
	SELECT c.CustID, c.Subaccid, c.FuncID, c.AreaID
	FROM DB052.bodb_chatbot.dbo.CustFeedbackArea c WITH (NOLOCK)
	INNER JOIN dbcust.custdb.dbo.customer ci WITH (NOLOCK)
				ON ci.custid=c.CustID
	OUTER APPLY (SELECT TOP 1 1 val 
				 FROM CustFeedbackArea t WITH (NOLOCK)
				 WHERE c.CustID=t.custid
				 AND c.Subaccid=t.Subaccid
				 AND c.FuncID=t.FuncID				 AND c.AreaID=t.AreaID) t
	WHERE t.val IS NULL AND ci.currency<>20

	IF @@ROWCOUNT=0
	BEGIN
		DROP TABLE #CustFeedback, #CustFeedback_batch, #CustFeedbackArea
		RETURN
	END 

	INSERT INTO CustFeedbackArea ([CustID], [Subaccid], [FuncID], [AreaID], [Rate])
	SELECT c.[CustID], c.[Subaccid], c.[FuncID], c.[AreaID], c.[Rate]
	FROM DB052.bodb_chatbot.dbo.CustFeedbackArea c WITH (NOLOCK) 
	INNER JOIN #CustFeedbackArea t ON c.CustID=t.custid
								AND c.Subaccid=t.Subaccid
								AND c.FuncID=t.FuncID
								AND c.AreaID=t.AreaID

DROP TABLE #CustFeedback, #CustFeedback_batch, #CustFeedbackArea
GO