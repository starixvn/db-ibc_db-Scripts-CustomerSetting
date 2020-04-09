/*
	Created: 20200326@Elodie
	Task: Insert product profile for Table Games
	DB: DBCUST/CustDB
*/

USE NAP_UserControl
GO

UPDATE dbo.eaFunction WITH (ROWLOCK)
SET FuncName = 'Enable RNGLottery Status',
	FuncKey = 'EnableRNGLottery',
	FuncDesc = 'Enable RNGLottery Status'
WHERE FuncKey = 'EnableLottery'

UPDATE dbo.eaFunction WITH (ROWLOCK)
SET FuncName = 'Edit RNGLottery Setting',
	FuncKey = 'RNGLotterySetting',
	FuncDesc = 'Edit RNGLottery Setting'
WHERE FuncKey = 'LotterySetting'

UPDATE dbo.eaFunction WITH (ROWLOCK)
SET FuncName = 'Edit RNGLottery Betting Limit',
	FuncKey = 'RNGLotteryBetting',
	FuncDesc = 'Edit RNGLottery Betting Limit'
WHERE FuncKey = 'LotteryBetting'

SELECT * FROM dbo.eaFunction WITH (NOLOCK)