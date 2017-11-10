/*
	Created: Johnson
	Date: 2017-10-26
	Task: Insert profile for licensee when offer comm ABS
	DB: DBCUST/CustDB
*/

--insert settingtype =9 for Allbet into Dep_ProductSetting
INSERT INTO dbo.Dep_ProductSetting(
							ProductSettingID
							,ProductID
							,SettingType
							,TemplateID
							,DisplayOrder
							,SettingLevel
							)
SELECT 	18,	21,	9, 0, 4, 1		
		
INSERT INTO dbo.Dep_ProductSettingDetail(
										ProductSettingID
										,SportType
										,BetType
										,IsLive
										,MaxDefaultValue
										,SettingStatus
										)
SELECT 18,211,2401,0,0,0
										
--offer Allbet comm for 12bet
INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT custid, 18
FROM dbo.Dep_CustSuper WITH(NOLOCK)
WHERE site IN ('Athena000'
,'12Bet'
,'9bet'
,'ABB688'
,'Aoncash'
,'Aragon88'
,'BE7'
,'Bolanation'
,'Brown888'
,'GooBet'
,'Indowin'
,'ISC888'
,'ITCBet'
,'Liga'
,'Lucky88'
,'M8bola'
,'Macaubet'
,'May88'
,'NBCbet'
,'Q8bola'
,'sbcbet'
,'UN168'
,'Unobet'
,'Uwoniwin'
,'Webet138')



