/*
	Created: 20190627@Johnson
	Task: update VI for log actionID
	DB: DBLOG/bodb_CustomerLog
*/

;WITH t AS(
select 65018 as ActionID, N'Cập nhật trạng thái Bị đình chỉ cho Super' as ActionVI
UNION SELECT 70027, N'Cập nhật trạng thái Bị đình chỉ cho Super'
UNION SELECT 75036, N'Cập nhật trạng thái Bị đình chỉ cho Super'
UNION SELECT 70028, N'Cập nhật trạng thái Bị đình chỉ cho Master'
UNION SELECT 75037, N'Cập nhật trạng thái Bị đình chỉ cho Master'
UNION SELECT 75038, N'Cập nhật trạng thái Bị đình chỉ cho Agent'
)
UPDATE l
SET ActionNameVI = t.ActionVI
FROM LogAction l WITH(UPDLOCK,ROWLOCK)
	INNER JOIN t on l.ActionID = t.actionID
	