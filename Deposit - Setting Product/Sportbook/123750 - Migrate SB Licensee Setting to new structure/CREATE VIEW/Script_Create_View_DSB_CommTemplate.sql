CREATE VIEW [dbo].DSB_CommTemplate 
/*
	Created: 20191212@Eden
	Task:  - [Redmine: 107131]
	DB: DBCust/custdb - DBACC/bodbo2
*/
AS
SELECT ValueId,Value
FROM dbo.CommissionTemplate WITH (NOLOCK) 
GO