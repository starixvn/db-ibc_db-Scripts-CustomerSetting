/*
	Date: 2019-07-17
	Created: Winnie
	Task: CRM CN88 crm setting management #112637
	DB: DBCRM/[bodb_CRM]
*/
USE [bodb_CRM]
GO

----------------------------
CREATE TABLE #crmSettingBettype(
	[SettingName] [nvarchar](150) ,	
	[SettingNameCS] [nvarchar](150) ,
	[SettingNameCT] [nvarchar](150),
	Removed VARCHAR(10) 
)
GO
INSERT INTO #crmSettingBettype([SettingName],[SettingNameCS],[SettingNameCT],Removed)
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'Correct Score',N'波胆',N'波膽','No'  UNION ALL 
SELECT N'FT.1X2',N'全场.独赢盘',N'全場.獨贏盤','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Combo Parlay',N'综合过关',N'綜合過關','No'  UNION ALL 
SELECT N'Next 1 Minute',N'下一分钟',N'下一分鐘','No'  UNION ALL 
SELECT N'1H Correct Score',N'上半场波胆',N'上半場波膽','No'  UNION ALL 
SELECT N'Both/One/Neither team to score',N'双方/一方/两者皆不得分',N'雙方/一方/兩者皆不得分','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'Special Bet Types',N'特别投注类别',N'特別投註類別','No'  UNION ALL 
SELECT N'1H Handicap',N'上半场让球',N'上半場讓球','No'  UNION ALL 
SELECT N'1H Over/Under',N'上半场大小盘',N'上半場大小盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'1H Odd/Even',N'上半场.单双盘',N'上半場.單雙盤','No'  UNION ALL 
SELECT N'1H 1X2',N'上半场.独赢盘',N'上半場.獨贏盤','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'FT.1X2',N'全场.独赢盘',N'全場.獨贏盤','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Combo Parlay',N'综合串关',N'綜合串關','No'  UNION ALL 
SELECT N'System Parlay',N'系统串关',N'系統串關','No'  UNION ALL 
SELECT N'Mixed Sports Parlay',N'混合运动串关',N'混合運動串關','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'1H Handicap',N'上半场让球',N'上半場讓球','No'  UNION ALL 
SELECT N'1H Over/Under',N'上半场大小盘',N'上半場大小盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'1H Odd/Even',N'上半场.单双盘',N'上半場.單雙盤','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'H/L',N'高低',N'高低','No'  UNION ALL 
SELECT N'Next OU',N'下一球大小',N'下一球大小','No'  UNION ALL 
SELECT N'Next HL',N'下一球高低',N'下一球高低','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Next Combo',N'下一球组合',N'下一球組合','No'  UNION ALL 
SELECT N'Number Wheel',N'数盘',N'數盤','No'  UNION ALL 
SELECT N'FT. OE',N'全场单双',N'全場單雙','No'  UNION ALL 
SELECT N'Next OE',N'下一球单双',N'下一球單雙','No'  UNION ALL 
SELECT N'Last ball OU',N'最后一球大小',N'最後一球大小','No'  UNION ALL 
SELECT N'1st ball OE',N'第一球单双',N'第一球單雙','No'  UNION ALL 
SELECT N'Last ball OE',N'最后一球单双',N'最後一球單雙','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'Warrior',N'斗士',N'鬥士','No'  UNION ALL 
SELECT N'1st ball OU',N'第一球大小',N'第一球大小','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'1H Handicap',N'上半场让球',N'上半場讓球','No'  UNION ALL 
SELECT N'1H Over/Under',N'上半场大小盘',N'上半場大小盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Combo Parlay',N'综合串关',N'綜合串關','No'  UNION ALL 
SELECT N'1H Moneyline',N'上半场胜负盘',N'上半場勝負盤','No'  UNION ALL 
SELECT N'Q X HDP',N'第 X 节让球',N'第 X 節讓球','No'  UNION ALL 
SELECT N'Q X OU',N'第 X 节大小',N'第 X 節大小','No'  UNION ALL 
SELECT N'Q X OE',N'第 X 节单双',N'第 X 節單雙','No'  UNION ALL 
SELECT N'Q x ML',N'第 X 节独赢',N'第 X 節獨贏','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'1H Odd/Even',N'上半场.单双盘',N'上半場.單雙盤','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'Special Bet Types',N'特别投注类别',N'特別投註類別','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Virtual Soccer',N'虚拟足球',N'虛擬足球','No'  UNION ALL 
SELECT N'Virtual Horse Racing',N'虚拟赛马',N'虛擬賽馬','No'  UNION ALL 
SELECT N'Virtual Greyhounds',N'虚拟赛狗',N'虛擬賽狗','No'  UNION ALL 
SELECT N'Virtual Tennis',N'虚拟网球',N'虛擬網球','No'  UNION ALL 
SELECT N'Virtual Speedway',N'虚拟沙地摩托车',N'虛擬沙地摩托車','No'  UNION ALL 
SELECT N'Virtual Motorsports',N'虚拟赛车',N'虛擬賽車','No'  UNION ALL 
SELECT N'Virtual Cycling',N'虚拟自行车',N'虛擬自行車','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'Big/Small',N'大/小',N'大/小','No'  UNION ALL 
SELECT N'Dragon/Tiger',N'龙/虎',N'龍/虎','No'  UNION ALL 
SELECT N'Up/Down',N'上/下',N'上/下','No'  UNION ALL 
SELECT N'Combo',N'组合',N'組合','No'  UNION ALL 
SELECT N'Five Elements',N'五金组合',N'五金組合','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Combo Parlay',N'综合串关',N'綜合串關','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'Set X Winner',N'第 x 盘获胜者',N'第 x 盤獲勝者','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Combo Parlay',N'综合串关',N'綜合串關','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'1H Handicap',N'上半场让球',N'上半場讓球','No'  UNION ALL 
SELECT N'1H Over/Under',N'上半场大小盘',N'上半場大小盤','No'  UNION ALL 
SELECT N'1H Total Run',N'',N'','No'  UNION ALL 
SELECT N'1H Runline',N'',N'','No'  UNION ALL 
SELECT N'Runline',N'',N'','No'  UNION ALL 
SELECT N'Total Run',N'',N'','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'1H Moneyline',N'上半场胜负盘',N'上半場勝負盤','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'FT.1X2',N'全场.独赢盘',N'全場.獨贏盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'Match Winner',N'(独赢) & (获胜者)',N'(獨贏) & (獲勝者)','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Combo Parlay',N'综合串关',N'綜合串關','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'H/L',N'高/低',N'高/低','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'Warrior',N'斗士',N'鬥士','No'  UNION ALL 
SELECT N'Next Combo',N'下一球组合',N'下一球組合','No'  UNION ALL 
SELECT N'Number Wheel',N'数盘',N'數盤','No'  UNION ALL 
SELECT N'1st ball OU',N'第一球大小',N'第一球大小','No'  UNION ALL 
SELECT N'Last ball OU',N'最后一球大小',N'最後一球大小','No'  UNION ALL 
SELECT N'1st ball OE',N'第一球单双',N'第一球單雙','No'  UNION ALL 
SELECT N'Last ball OE',N'最后一球单双',N'最後一球單雙','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'1H Odd/Even',N'上半场.单双盘',N'上半場.單雙盤','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'Map X ML',N'第 X 图胜负盘',N'第 X 圖勝負盤','No'  UNION ALL 
SELECT N'Special Bet Types',N'特别投注类别',N'特別投註類別','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Map X HDP',N'第 X 图让球',N'第 X 圖讓球','No'  UNION ALL 
SELECT N'Map X OU',N'第 X 图大小盘',N'第 X 圖大小盤','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'1H Handicap',N'上半场让球',N'上半場讓球','No'  UNION ALL 
SELECT N'1H Over/Under',N'上半场大小盘',N'上半場大小盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'1H Odd/Even',N'上半场.单双盘',N'上半場.單雙盤','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'System Parlay',N'串关',N'串關','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'Double chance',N'双重机会',N'雙重機會','No'  UNION ALL 
SELECT N'Total Goal',N'总进球',N'總進球','No'  UNION ALL 
SELECT N'Correct Score',N'波胆',N'波膽','No'  UNION ALL 
SELECT N'1X2',N'1X2',N'1X2','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Win',N'独赢',N'獨贏','No'  UNION ALL 
SELECT N'Place',N'位置',N'位置','No'  UNION ALL 
SELECT N'Win/Place',N'独赢/位置',N'獨贏/位置','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Correct Score',N'波胆',N'波膽','No'  UNION ALL 
SELECT N'Total Points',N'总得分',N'總得分','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Win',N'独赢',N'獨贏','No'  UNION ALL 
SELECT N'Place',N'位置',N'位置','No'  UNION ALL 
SELECT N'Win/Place',N'独赢/位置',N'獨贏/位置','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Win',N'独赢',N'獨贏','No'  UNION ALL 
SELECT N'Place',N'位置',N'位置','No'  UNION ALL 
SELECT N'Win/Place',N'独赢/位置',N'獨贏/位置','No'  UNION ALL 
SELECT N'Win',N'独赢',N'獨贏','No'  UNION ALL 
SELECT N'Place',N'位置',N'位置','No'  UNION ALL 
SELECT N'Win/Place',N'独赢/位置',N'獨贏/位置','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'Next 1 Minute',N'下一分钟',N'下一分鐘','No'  UNION ALL 
SELECT N'Next 5 Minute',N'下五分钟',N'下五分鐘','No'  UNION ALL 
SELECT N'What will happen first in next 1 minute',N'下一分钟首先会发生什么',N'下一分鐘首先會發生什麼','No'  UNION ALL 
SELECT N'What will happen first in next 5 minute',N'下五分钟首先会发生什么',N'下五分鐘首先會發生什麽','No'  UNION ALL 
SELECT N'Next 1 Minute Set Piece',N'下一分钟定位球',N'下一分鐘定點球','No'  UNION ALL 
SELECT N'Which combination will happen first in next X minutes',N'下X分钟首先会发生什么组合',N'下X分鐘首先會發生什麽組合','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'Correct Score',N'波胆',N'波膽','No'  UNION ALL 
SELECT N'FT.1X2',N'全场.独赢盘',N'全場.獨贏盤','No'  UNION ALL 
SELECT N'1H Handicap',N'上半场让球',N'上半場讓球','No'  UNION ALL 
SELECT N'1H Over/Under',N'上半场大小盘',N'上半場大小盤','No'  UNION ALL 
SELECT N'1H Correct Score',N'上半场波胆',N'上半場波膽','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'1H 1X2',N'上半场.独赢盘',N'上半場.獨贏盤','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球盘',N'全場讓球盤','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'Correct Score',N'波胆',N'波膽','No'  UNION ALL 
SELECT N'FT.1X2',N'全场.独赢盘',N'全場.獨贏盤','No'  UNION ALL 
SELECT N'1H Handicap',N'上半场让球',N'上半場讓球','No'  UNION ALL 
SELECT N'1H Over/Under',N'上半场大小盘',N'上半場大小盤','No'  UNION ALL 
SELECT N'Mix Parlay',N'混合过关',N'混合過關','No'  UNION ALL 
SELECT N'1H 1X2',N'上半场.独赢盘',N'上半場.獨贏盤','No'  UNION ALL 
SELECT N'1H Correct Score',N'上半场波胆',N'上半場波膽','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'Big/Small',N'大/小',N'大/小','No'  UNION ALL 
SELECT N'Total Points',N'总得分',N'總得分','No'  UNION ALL 
SELECT N'Colour Range',N'颜色范围',N'顏色範圍','No'  UNION ALL 
SELECT N'Single Dice Result',N'单一骰子成绩',N'單一骰子成績','No'  UNION ALL 
SELECT N'Any Triple',N'任何三倍',N'任何三倍','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'MoneyLine',N'胜负盘',N'勝負盤','No'  UNION ALL 
SELECT N'FT. OE',N'全场单双',N'全場單雙','No'  UNION ALL 
SELECT N'N/A.',N'无',N'無','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'Special Bet Types',N'特别投注类别',N'特別投註類別','No'  UNION ALL 
SELECT N'1H HDP',N'上半场让球',N'上半場讓球','No'  UNION ALL 
SELECT N'1H O/U',N'上半场大小盘',N'上半場大小盤','No'  UNION ALL 
SELECT N'Odd/Even',N'单/双',N'單/雙','No'  UNION ALL 
SELECT N'Big/Small',N'大/小',N'大/小','No'  UNION ALL 
SELECT N'Combo',N'组合',N'組合','No'  UNION ALL 
SELECT N'Four Seasons',N'四季',N'四季','No'  UNION ALL 
SELECT N'MO/ME',N'',N'','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'FT.1X2',N'全场.独赢盘',N'全場.獨贏盤','No'  UNION ALL 
SELECT N'1H 1X2',N'上半场.独赢盘',N'上半場.獨贏盤','No'  UNION ALL 
SELECT N'1H HDP',N'上半场让球',N'上半場讓球','No'  UNION ALL 
SELECT N'1H O/U',N'上半场大小盘',N'上半場大小盤','No'  UNION ALL 
SELECT N'Special Bet Types',N'特别投注类别',N'特別投註類別','No'  UNION ALL 
SELECT N'FT.HDP',N'全场让球',N'全場讓球','No'  UNION ALL 
SELECT N'FT.O/U',N'全场大小盘',N'全場大小盤','No'  UNION ALL 
SELECT N'FT.1X2',N'全场.独赢盘',N'全場.獨贏盤','No'  UNION ALL 
SELECT N'1H 1X2',N'上半场.独赢盘',N'上半場.獨贏盤','No'  UNION ALL 
SELECT N'1H HDP',N'上半场让球',N'上半場讓球','No'  UNION ALL 
SELECT N'1H O/U',N'上半场大小盘',N'上半場大小盤','No'  UNION ALL 
SELECT N'Special Bet Types',N'特别投注类别',N'特別投註類別','No'  UNION ALL 
SELECT N'Win',N'独赢',N'獨贏','No'  UNION ALL 
SELECT N'Place',N'位置',N'位置','No'  UNION ALL 
SELECT N'Win/Place',N'独赢/位置',N'獨贏/位置','No'  

UPDATE c
SET c.SettingValueCS=t.SettingNameCS,c.SettingValueCT=t.SettingNameCT,c.IsActive=1
FROM crmSetting c WITH(ROWLOCK,UPDLOCK)
INNER JOIN #crmSettingBettype t ON c.SettingValue=t.SettingName
WHERE t.Removed<>'YES' AND c.SiteOffer=1

DELETE c
FROM crmSetting c 
INNER JOIN #crmSettingBettype t ON c.SettingValue=t.SettingName
WHERE t.Removed='YES' AND c.SiteOffer=1  AND c.SettingValue<>'N/A'  AND c.SettingValue<> 'N/A.'

DELETE c
FROM crmSetting c 
WHERE c.SettingName='Bettype' AND c.SettingValue NOT IN(SELECT SettingName FROM #crmSettingBettype)

DROP TABLE #crmSettingBettype

