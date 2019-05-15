/*
	Created: 20190515@Elodie
	Task: Add trigger for CS_CustomerStatus
	DB: DBTP/bodb02
*/
USE bodb02
GO

CREATE TRIGGER [dbo].[CS_CustomerStatus_update] ON [dbo].[CS_CustomerStatus] AFTER UPDATE
AS
/*
	Created by: 20190515@Elodie
	Task: Trigger for updating [CS_CustomerStatus] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[CS_CustomerStatus_History] (
		CustId
        ,InactiveInfo
		,SuspendedInfo
		,ViewOnlyInfo
	)
	SELECT
		CustId
        ,InactiveInfo
		,SuspendedInfo
		,ViewOnlyInfo
	FROM [DELETED]
END
GO
