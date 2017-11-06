
/*
	CREATEd by: Winnie
	CREATEd Date: 20171103
	Description: DCS Deposit- #5 - CREATE Trigger on replicated table to insert data into DCS History tables
	
	Database: DBTP/bodb02 (local dev: server232 -   local test: server234)
	
*/

USE bodb02
GO

CREATE TRIGGER [dbo].[Dep_CustDiscountSetting_Agent_update] ON [dbo].Dep_CustDiscountSetting_Agent AFTER UPDATE
AS
/*
	Created by: 20171103@Winnie
	Task: Trigger for updating [Dep_CustDiscountSetting_Agent] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[Dep_CustDiscountSetting_Agent_History] (
		[CustID],
		[SportType],
		[BetType],
		Discount 
		
	)
	SELECT
		[CustID],
		[SportType],
		[BetType],
		Discount 
	FROM [DELETED]
END

GO
