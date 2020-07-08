/*
	Creator: 20200615@Eden
	Task: Create a temporaty table for data initialization at replication server and  transfer data - Redmine: #134978
	Run at: all replication of custdb_CustSetting publication exclude DBCUST/CUSTDB (exp : DBACC@bodb02)
*/
USE bodb02
GO
--DROP TABLE BasketBallVR_Temp

CREATE TABLE [dbo].[BasketBallVR_Temp](
	[VRValue_HDPLive] [money] NULL,
	[VRValue_HDPNonLive] [money] NULL,
	[VRValue_OULive] [money] NULL,
	[VRValue_OUNonLive] [money] NULL,
	[VRValue_OELive] [money] NULL,
	[VRValue_OENonLive] [money] NULL,
	[VRValue_MNLive] [money] NULL,
	[VRValue_MNNonLive] [money] NULL,
	[HasSameVR] [bit] NULL DEFAULT ((1)),
	[CustID] [int] NULL,
	[IsManuallyUpdate] BIT NULL DEFAULT(0),
	[IsFinish] BIT NULL DEFAULT(0)
) ON [PRIMARY]

GO

--Step 3: Create a non clustered index
CREATE CLUSTERED INDEX CIX_CustID ON BasketBallVR_Temp(CustID)
GO

INSERT INTO [dbo].[BasketBallVR_Temp](
	 VRValue_HDPLive
	,VRValue_HDPNonLive
	,VRValue_OULive
	,VRValue_OUNonLive
	,VRValue_OELive
	,VRValue_OENonLive
	,VRValue_MNLive
	,VRValue_MNNonLive
	,HasSameVR
	,CustID
	,IsManuallyUpdate
	,IsFinish
)
SELECT  VRValue_HDPLive
	,VRValue_HDPNonLive
	,VRValue_OULive
	,VRValue_OUNonLive
	,VRValue_OELive
	,VRValue_OENonLive
	,VRValue_MNLive
	,VRValue_MNNonLive
	,HasSameVR
	,CustID
	,IsManuallyUpdate
	,IsFinish
FROM DBCUST.CUSTDB.dbo.BasketBallVR_Temp WITH(NOLOCK)