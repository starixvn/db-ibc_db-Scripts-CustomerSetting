/*
	Created: 20200422@Winnie
	DB: DBCHECK/CheckResultDB
	Task: Insert Rules
*/
 USE CheckResultDB
 GO

INSERT INTO Rule_Credit(RuleID,RuleName,ModifiedDate)
SELECT 72	,'S4 = M4 = A4 = 0', GETDATE()