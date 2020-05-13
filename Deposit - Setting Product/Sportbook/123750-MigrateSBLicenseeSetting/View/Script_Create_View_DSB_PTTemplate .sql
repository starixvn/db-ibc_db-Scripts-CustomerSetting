CREATE VIEW [dbo].DSB_PTTemplate 
/*
	Created: 20191212@Eden
	Task:  - [Redmine: 107131]
	DB: DBCust/custdb - DBACC/bodbo2
*/
AS
SELECT ValueId,Value
FROM dbo.PositionTakingTemplate  WITH (NOLOCK) 
GO