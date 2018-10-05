/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DBLIC/bodb_PlaytechCS
*/
IF @@SERVERNAME NOT IN ('DB052','DB215','DB231') RETURN

USE bodb_PlaytechCS
GO
EXEC sp_rename 'Task_DOT_GoldDeluxe_DailySummary_DanielTest', 'DEL_Task_DOT_GoldDeluxe_DailySummary_DanielTest'