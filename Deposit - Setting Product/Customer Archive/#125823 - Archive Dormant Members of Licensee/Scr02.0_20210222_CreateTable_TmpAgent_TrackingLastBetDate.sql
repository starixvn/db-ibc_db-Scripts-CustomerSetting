/*
	Created: Eden
	Date: 20210222
	Task: Create table TmpAgent_Cust_TrackingLastBetDate to keep isProcessed status [RM:#125823]
	DB: DBACC - Clone DB
*/
USE bodb02
GO
--DROP TABLE TmpAgent_Cust_TrackingLastBetDate
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TmpAgent_Cust_TrackingLastBetDate](
	AgentID int,
	isProcessed BIT DEFAULT 0
PRIMARY KEY CLUSTERED 
(
	AgentID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Primary]
) ON [Primary]

GO

INSERT INTO TmpAgent_Cust_TrackingLastBetDate (AgentID)
SELECT DISTINCT cust.custid
FROM customer cust WITH (NOLOCK)
	INNER JOIN custInfo ci (NOLOCK) ON cust.custid = ci.custid
	LEFT JOIN TmpAgent_Cust_TrackingLastBetDate tmp WITH(NOLOCK) ON cust.custid = tmp.AgentID
WHERE cust.roleid = 2
	AND cust.srecommend IN (SELECT custid FROM bodb02.dbo.Dep_CustSuper (NOLOCK))
	AND cust.username NOT LIKE '%ACC%'
	AND tmp.AgentID IS NULL