/*<info serverAlias="DBLOG-bodb_CustomerLog" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250605@Johnson	
	Task: update log action for Potential Winning Limit/Threshold [redmine:#226060]
	DB: DBLOG-bodb_CustomerLog
*/

--'Update Sportsbook Potential Win Limit for customers'
UPDATE LogAction
SET ActionNameCH = N'更新客户的体育博彩潛在贏額上限'
WHERE ActionID = 854

/*
DECLARE @ActionNameEN NVARCHAR(512) = 'Add Potential Win Limit for member'

--'Add Potential Winning Limit for member'
UPDATE LogAction WITH(ROWLOCK)
SET ActionNameEN = @ActionNameEN,
    ActionNameJP = @ActionNameEN,
    ActionNameIT = @ActionNameEN,
    ActionNameKO = @ActionNameEN,
    ActionNameVI = @ActionNameEN,
    ActionNameCN = @ActionNameEN
WHERE ActionID = 265000
*/
/*
--'Add Potential Winning Limit for member'
UPDATE LogAction
SET ActionNameCS = N'为会员添加潜在赢额上限',
    ActionNameCH = N'為會員增加潛在贏額上限'
WHERE ActionID = 265000

--'Update Sportsbook Potential Win Limit for customers'
UPDATE LogAction
SET ActionNameCS = N'更新客户的体育博彩潜在赢额上限',
    ActionNameCH = N'更新客户的体育博彩潛在赢额上限'
WHERE ActionID = 854
*/

/*
--'Add Potential Winning Limit for member'
UPDATE LogAction
SET ActionNameCS = N'为会员新增潜在获胜上限',
    ActionNameCH = N'為會員新增潛在獲勝上限',
    ActionNameTH = N'เพิ่มขีดจำกัดการชนะที่เป็นไปได้สำหรับสมาชิก'
WHERE ActionID = 265000

--'Update Sportsbook Potential Win Limit for customers'
UPDATE LogAction
SET ActionNameCS = N'潜在获胜上限',
    ActionNameCH = N'潛在獲勝上限',
    ActionNameTH = N'ขีดจำกัดการชนะที่เป็นไปได้'
WHERE ActionID = 854
*/