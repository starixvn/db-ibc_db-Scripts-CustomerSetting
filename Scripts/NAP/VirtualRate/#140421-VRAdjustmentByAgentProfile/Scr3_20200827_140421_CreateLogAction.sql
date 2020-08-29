/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20200829@Eden
	Task: Insert LogAction for VRAdjustmentByAgentProfile [RM#140421]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	818, 'Job Update FirstBetDate For VRAgentAutoAdjustment', 'Acc_VR_AgentUpdFirstBetDate', 1, NULL, NULL  UNION ALL
SELECT	819, 'Insert new agent to VRAgentAutoAdjustment table', 'Acc_VR_AgentAutoAdjustment_Ins', 1, NULL, NULL UNION ALL
SELECT	820, 'Job Insert new agent to VRAgentAutoAdjustment table', 'Acc_VR_AgentAutoAdjustment_Ins', 1, NULL, NULL UNION ALL
SELECT	821, 'Check and Flag Abnormal agents base on VRAgentAutoAdjustment table', 'Acc_VR_AbnormalAgent_Flag', 1, NULL, NULL UNION ALL
SELECT	822, 'Job Auto Update VR = 0', 'Acc_VR_AbnormalAgent_Flag', 1, NULL, NULL UNION ALL
SELECT	823, 'Check and Unflag Abnormal agents base on VRAgentAutoAdjustment table', 'Acc_VR_AbnormalAgent_Unflag', 1, NULL, NULL UNION ALL
SELECT	824, 'Job Auto Update VR = Super''s', 'Acc_VR_AbnormalAgent_Unflag', 1, NULL, NULL 


DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

--SELECT * FROM LogAction (NOLOCK) WHERE ActionID IN(818,819,820,821,822,823,824)
