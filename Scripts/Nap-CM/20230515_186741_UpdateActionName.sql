/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230504@Luke
	Task: Update log for Limit Monthly PT Update [Redmine: #186741]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

IF EXISTS (
	SELECT TOP 1 1
	FROM dbo.LogAction
	WHERE ActionID IN (470, 471)
		AND ActionNameEN LIKE '%Daily%'
)

BEGIN
	DECLARE @NewLog AS TABLE(
		ActionID INT,
		NewActionNameEN NVARCHAR(256)
	)

	INSERT INTO @NewLog(ActionID, NewActionNameEN)
	SELECT 470, 'Create PT Update Limitation Rule By SMA Line'
	UNION ALL
	SELECT 471, 'Delete PT Update Limitation Rule By SMA Line'

	UPDATE l
	SET l.ActionNameEN = n.NewActionNameEN
		,l.ActionNameJP = n.NewActionNameEN
		,l.ActionNameKO = n.NewActionNameEN
		,l.ActionNameVI = n.NewActionNameEN
	FROM dbo.LogAction l WITH (NOLOCK) 
		INNER JOIN @NewLog n ON l.ActionID = n.ActionID
END
ELSE
	RAISERROR('ActionName is correct. No need to update.', 16, 1)