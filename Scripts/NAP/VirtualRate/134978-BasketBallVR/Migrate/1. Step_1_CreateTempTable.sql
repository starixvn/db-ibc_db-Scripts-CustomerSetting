/*
	Creator: 20200615@Eden
	Task: Create a temporaty table for data initialization - Redmine: #134978
	Run at: CustDB@DBCUST
*/
USE CustDB
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
	[srecommend] [int] NULL,
	[mrecommend] [int] NULL,
	[recommend] [int] NULL,
	[RoleID] [tinyint] NULL,
	[CustID] [int] NULL,
	[IsManuallyUpdate] BIT NULL DEFAULT(0),
	[IsFinish] BIT NULL DEFAULT(0)
) ON [PRIMARY]

GO

--Step 3: Create index
CREATE CLUSTERED INDEX CIX_BasketBallVR_CustID ON BasketBallVR_Temp(CustID)
GO
CREATE NONCLUSTERED INDEX IX_BasketBallVR_srecommend ON BasketBallVR_Temp(srecommend)
GO