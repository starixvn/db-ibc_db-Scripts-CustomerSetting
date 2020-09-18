/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200827@Eden
	Task: alter table VRAgentAutoAdjustment add column VR0_Date 
		  remove FirstBetDate column [RM#141927]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
ALTER TABLE  [dbo].[VRAgentAutoAdjustment] ADD VR0_Date	DATE NULL
GO
DROP INDEX VRAgentAutoAdjustment.IX_FirstBetDate
ALTER TABLE VRAgentAutoAdjustment DROP COLUMN FirstBetDate