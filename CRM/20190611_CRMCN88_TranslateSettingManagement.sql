/*
	Date: 2019-06-13
	Created: Winnie
	Task: CRM CN88 crm setting management #112637
	DB: DBCRM/[bodb_CRM]
*/
USE [bodb_CRM]
GO

CREATE TABLE #crmSettingManage(
	[SettingName] [nvarchar](150) ,	
	[SettingNameCS] [nvarchar](150) ,
	[SettingNameCT] [nvarchar](150),
	Removed VARCHAR(10) 
)
GO

INSERT INTO #crmSettingManage([SettingName],[SettingNameCS],[SettingNameCT],Removed)
SELECT N'Phone',N'电话',N'電話','NULL'  UNION ALL 
SELECT N'Email',N'电邮',N'電郵','NULL'  UNION ALL 
SELECT N'MSN',N'MSN',N'MSN','Yes'  UNION ALL 
SELECT N'Skype',N'SKYPE',N'SKYPE','NULL'  UNION ALL 
SELECT N'LiveChat',N'在线聊',N'在線聊','NULL'  UNION ALL 
SELECT N'N/A',N'无',N'無','Yes'  UNION ALL 
SELECT N'Yahoo',N'雅虎',N'雅虎','NULL'  UNION ALL 
SELECT N'WeChat',N'微信',N'微信','NULL'  UNION ALL 
SELECT N'Line',N'LINE',N'LINE','NULL'  UNION ALL 
SELECT N'What''sApp',N'What''sApp',N'What''sApp','NULL'  UNION ALL 
SELECT N'QQ',N'QQ',N'QQ','NULL'  UNION ALL 
SELECT N'LetsTalk',N'',N'','NULL'  UNION ALL 
SELECT N'China',N'中国',N'中國','No'  UNION ALL 
SELECT N'Refer to [Provinces of China] Sheet',N'',N'','NULL'  UNION ALL 
SELECT N'[TBD]',N'',N'','NULL'  UNION ALL 
SELECT N'[TBD]',N'',N'','NULL'  UNION ALL 
SELECT N'[TBD]',N'',N'','NULL'  UNION ALL 
SELECT N'[TBD]',N'',N'','NULL'  UNION ALL 
SELECT N'Guest',N'用户',N'用戶','no'  UNION ALL 
SELECT N'Member',N'会员',N'會員','no'  UNION ALL 
SELECT N'Agent',N'代理',N'代理','no'  UNION ALL 
SELECT N'Master',N'总代理',N'總代理','no'  UNION ALL 
SELECT N'Super',N'超级总代理',N'超級總代理','no'  UNION ALL 
SELECT N'Headline',N'',N'','no'  UNION ALL 
SELECT N'Soccer',N'足球',N'足球','no'  UNION ALL 
SELECT N'Other Sports',N'其它运动',N'其它運動','no'  UNION ALL 
SELECT N'Casino',N'娱乐城',N'娛樂城','yes'  UNION ALL 
SELECT N'Horse Racing',N'赛马',N'賽馬','yes'  UNION ALL 
SELECT N'Bingo',N'宾果',N'賓果','yes'  UNION ALL 
SELECT N'Basket Ball',N'',N'','yes'  UNION ALL 
SELECT N'Number Game',N'百练赛',N'百練賽','no'  UNION ALL 
SELECT N'Basketball',N'篮球',N'籃球','no'  UNION ALL 
SELECT N'Others',N'',N'','yes'  UNION ALL 
SELECT N'Bet2',N'',N'','yes'  UNION ALL 
SELECT N'Greyhound Racing',N'赛狗',N'賽狗','yes'  UNION ALL 
SELECT N'Mini Games',N'迷你娱乐城',N'迷你娛樂城','yes'  UNION ALL 
SELECT N'Live Casino',N'娱乐场',N'娛樂場','yes'  UNION ALL 
SELECT N'Olympic 2012',N'奥林匹克 2012',N'奧林匹克 2012','yes'  UNION ALL 
SELECT N'Poker',N'扑克',N'撲克','yes'  UNION ALL 
SELECT N'Harness Racing',N'赛车',N'賽車','yes'  UNION ALL 
SELECT N'Virtual Sports',N'虚拟运动',N'虛擬運動','No'  UNION ALL 
SELECT N'Keno',N'快乐彩',N'快樂彩','No'  UNION ALL 
SELECT N'Sportbook',N'',N'','yes'  UNION ALL 
SELECT N'Gold Deluxe',N'',N'','yes'  UNION ALL 
SELECT N'Asian Gaming',N'',N'','yes'  UNION ALL 
SELECT N'Muay Thai',N'泰拳',N'泰拳','No'  UNION ALL 
SELECT N'Superlive',N'',N'','yes'  UNION ALL 
SELECT N'Bettrade',N'',N'','yes'  UNION ALL 
SELECT N'Tennis',N'网球',N'網球','no'  UNION ALL 
SELECT N'Baseball',N'棒球',N'棒球','no'  UNION ALL 
SELECT N'Cricket',N'板球',N'板球','no'  UNION ALL 
SELECT N'Turbo Number Game',N'快速百练赛',N'快速百練賽','no'  UNION ALL 
SELECT N'E-Sports',N'电子竞技',N'電子競技','no'  UNION ALL 
SELECT N'Colossus Bet',N'',N'','yes'  UNION ALL 
SELECT N'Outright',N'优胜冠军',N'優勝冠軍','no'  UNION ALL 
SELECT N'Microgaming',N'',N'','yes'  UNION ALL 
SELECT N'Badminton',N'羽毛球',N'羽毛球','No'  UNION ALL 
SELECT N'American Football',N'美式足球',N'美式足球','No'  UNION ALL 
SELECT N'Darts',N'飞镖',N'飛鏢','No'  UNION ALL 
SELECT N'Field Hockey',N'草地曲棍球',N'草地曲棍球','No'  UNION ALL 
SELECT N'Golf',N'高尔夫',N'高爾夫','No'  UNION ALL 
SELECT N'Ice Hockey',N'冰上曲棍球',N'冰上曲棍球','No'  UNION ALL 
SELECT N'Motorsport',N'赛车',N'賽車','No'  UNION ALL 
SELECT N'Rugby',N'橄榄球',N'橄欖球','No'  UNION ALL 
SELECT N'Snooker/Pool',N'斯诺克/台球',N'斯諾克/臺球','No'  UNION ALL 
SELECT N'Volleyball',N'排球',N'排球','No'  UNION ALL 
SELECT N'Athletics',N'田径',N'田徑','No'  UNION ALL 
SELECT N'Boxing/MMA',N'拳击/MMA',N'拳擊/MMA','No'  UNION ALL 
SELECT N'Cycling',N'自行车',N'自行車','No'  UNION ALL 
SELECT N'Diving',N'潜水',N'潛水','No'  UNION ALL 
SELECT N'Entertainment',N'娱乐',N'娛樂','No'  UNION ALL 
SELECT N'Handball',N'手球',N'手球','No'  UNION ALL 
SELECT N'Netball',N'篮网球',N'籃網球','No'  UNION ALL 
SELECT N'Squash',N'壁球',N'壁球','No'  UNION ALL 
SELECT N'Swimming',N'游泳',N'遊泳','No'  UNION ALL 
SELECT N'Water Polo',N'水球',N'水球','No'  UNION ALL 
SELECT N'Virtual Soccer',N'虚拟足球',N'虛擬足球','No'  UNION ALL 
SELECT N'Virtual Horse Racing',N'虚拟赛马',N'虛擬賽馬','No'  UNION ALL 
SELECT N'Virtual Tennis',N'虚拟网球',N'虛擬網球','No'  UNION ALL 
SELECT N'Virtual Greyhound',N'虚拟赛马',N'虛擬賽馬','No'  UNION ALL 
SELECT N'Virtual Speedway',N'虚拟沙地摩托车',N'虛擬沙地摩托車','No'  UNION ALL 
SELECT N'Virtual Motorsports',N'虚拟赛车',N'虛擬賽車','No'  UNION ALL 
SELECT N'Macau Games',N'',N'','yes'  UNION ALL 
SELECT N'N/A.',N'无',N'無','yes'  UNION ALL 
SELECT N'Table Tennis',N'乒乓球',N'乒乓球','No'  UNION ALL 
SELECT N'ALLBET',N'欧博',N'歐博','yes'  UNION ALL 
SELECT N'Fishing World',N'',N'','yes'  UNION ALL 
SELECT N'Fast Market',N'快速市场',N'快速市場','No'  UNION ALL 
SELECT N'Cash Out',N'兑现',N'兌現','yes'  UNION ALL 
SELECT N'Virtual Soccer League',N'虚拟足球联赛',N'虛擬足球聯賽','no'  UNION ALL 
SELECT N'Virtual Soccer Nation',N'虚拟足球国家',N'虛擬足球國家','no'  UNION ALL 
SELECT N'Keno Lottery',N'快乐彩乐透',N'快樂彩樂透','no'  UNION ALL 
SELECT N'Kabaddi',N'',N'','no'  UNION ALL 
SELECT N'Lucky3',N'',N'','yes'  UNION ALL 
SELECT N'Bullfighting',N'斗牛',N'鬥牛','yes'  UNION ALL 
SELECT N'Virtual Basketball',N'虚拟篮球',N'虛擬籃球','no'  UNION ALL 
SELECT N'Pragmatic Play',N'',N'','yes'  UNION ALL 
SELECT N'Poker Game',N'扑克游戏',N'撲克遊戲','yes'  UNION ALL 
SELECT N'Happy5',N'快乐 5',N'快樂 5','no'  UNION ALL 
SELECT N'Virtual Soccer World Cup',N'虚拟足球世界杯',N'虛擬足球世界杯','no'  UNION ALL 
SELECT N'Virtual Soccer Asian',N'虚拟足球亚洲',N'虛擬足球亞洲','no'  UNION ALL 
SELECT N'Virtual Cycling',N'虚拟自行车',N'虛擬自行車','no'  UNION ALL 
SELECT N'Satisfied',N'满意',N'滿意','No'  UNION ALL 
SELECT N'Unsatisfied',N'不满意',N'不滿意','No'  UNION ALL 
SELECT N'Neutral',N'中立',N'中立','No'  UNION ALL 
SELECT N'inefficient',N'低效率',N'低效率','No'  UNION ALL 
SELECT N'Pending',N'待定',N'待定','No'  UNION ALL 
SELECT N'Closed',N'已关',N'已關','No'  UNION ALL 
SELECT N'Solved',N'已解决',N'已解決','No'  UNION ALL 
SELECT N'Deleted',N'已删除',N'已刪除','No'  UNION ALL 
SELECT N'Checked',N'已检查',N'已檢查','No'  UNION ALL 
SELECT N'KIV',N'待留意',N'待留意','yes'  UNION ALL 
SELECT N'Open',N'开启',N'開啟','No'  UNION ALL 
SELECT N'Claimed',N'',N'','yes'  UNION ALL 
SELECT N'Expired',N'已逾期',N'已逾期','yes'  UNION ALL 
SELECT N'Cancelled',N'已取消',N'已取消','yes'  UNION ALL 
SELECT N'Enabled',N'已开启',N'已開啟','no'  UNION ALL 
SELECT N'Disabled',N'已关闭',N'已關閉','no'  UNION ALL 
SELECT N'Comment',N'意见',N'意見','No'  UNION ALL 
SELECT N'English',N'英文',N'英文','Yes'  UNION ALL 
SELECT N'Mandarin',N'',N'','No'  UNION ALL 
SELECT N'Cantonese',N'',N'','No'  UNION ALL 
SELECT N'Thai',N'泰文',N'泰文','Yes'  UNION ALL 
SELECT N'Hokkien',N'福建',N'福建','Yes'  UNION ALL 
SELECT N'Bahasa Indo',N'印尼文',N'印尼文','Yes'  UNION ALL 
SELECT N'Korean',N'韩文',N'韓文','Yes'  UNION ALL 
SELECT N'Indo',N'印尼文',N'印尼文','Yes'  UNION ALL 
SELECT N'Vietnamese',N'越南文',N'越南文','Yes'  UNION ALL 
SELECT N'Indian',N'印度文',N'印度文','Yes'  UNION ALL 
SELECT N'Mr',N'先生',N'先生','No'  UNION ALL 
SELECT N'Ms',N'小姐',N'小姐','No'  UNION ALL 
SELECT N'CN88',N'CN88',N'CN88','No'  UNION ALL 
SELECT N'CN88',N'CN88',N'CN88','No'  UNION ALL 
SELECT N'Done',N'已完成',N'已完成','No'  UNION ALL 
SELECT N'Request to call back',N'要求致电',N'要求致電','No'  UNION ALL 
SELECT N'No need to call',N'无需致电',N'無需致電','No'  UNION ALL 
SELECT N'No reply',N'无回应',N'無回應','No'  UNION ALL 
SELECT N'Uncontactable',N'失联',N'失聯','No'  UNION ALL 
SELECT N'Internal account',N'内部账号',N'內部賬號','No'  UNION ALL 
SELECT N'Never touch',N'勿动',N'勿動','No'  UNION ALL 
SELECT N'Kept for reference',N'用于参考',N'用於參考','No'  UNION ALL 
SELECT N'Sportsbook',N'体育',N'體育','No'  UNION ALL 
SELECT N'Virtual Sports',N'虚拟运动',N'虛擬運動','No'  UNION ALL 
SELECT N'Racing',N'赛马',N'賽馬','Yes'  UNION ALL 
SELECT N'Gaming',N'娱乐游戏',N'娛樂遊戲','Yes'  UNION ALL 
SELECT N'NG2',N'百练赛 2',N'百練賽 2','Yes'  UNION ALL 
SELECT N'9Wickets',N'',N'','Yes'  UNION ALL 
SELECT N'Exchange',N'',N'','Yes'  UNION ALL 
SELECT N'Numbers',N'数字',N'數字','No'  UNION ALL 
SELECT N'MainCategory',N'主范畴',N'主範疇','NULL'  UNION ALL 
SELECT N'Communication',N'通讯工具',N'通訊工具','NULL'  UNION ALL 
SELECT N'SiteCategory',N'',N'','NULL'  UNION ALL 
SELECT N'Product',N'产品',N'產品','NULL'  UNION ALL 
SELECT N'Bet Type',N'投注类别',N'投註類別','NULL'  UNION ALL 
SELECT N'SubCategory',N'副范畴',N'副範疇','NULL'  UNION ALL 
SELECT N'BetType',N'投注类别',N'投註類別','NULL'  UNION ALL 
SELECT N'LicenseeType',N'Licensee Type',N'Licensee Type','NULL'  UNION ALL 
SELECT N'Status',N'状态',N'狀態','NULL'  UNION ALL 
SELECT N'InformHeadlineStatus',N'',N'','NULL'  UNION ALL 
SELECT N'Site',N'网站',N'網站','NULL'  UNION ALL 
SELECT N'SubProduct',N'副产品',N'副產品','NULL'  UNION ALL 
SELECT N'Station',N'',N'','NULL'  UNION ALL 
SELECT N'Title',N'标题',N'標題','NULL'  UNION ALL 
SELECT N'Response',N'反应',N'反應','NULL'  UNION ALL 
SELECT N'Language',N'语系',N'語系','NULL'  UNION ALL 
SELECT N'Role',N'角色',N'角色','NULL'  UNION ALL 
SELECT N'Inform New Product',N'',N'','NULL' 

UPDATE c
SET c.IsActive=0
FROM crmSetting c WITH(ROWLOCK,UPDLOCK)
WHERE c.SiteOffer=1

UPDATE c
SET c.SettingValueCS=t.SettingNameCS,c.SettingValueCT=t.SettingNameCT,c.IsActive=1
FROM crmSetting c WITH(ROWLOCK,UPDLOCK)
INNER JOIN #crmSettingManage t ON c.SettingValue=t.SettingName
WHERE t.Removed<>'YES' AND c.SiteOffer=1

UPDATE c
SET c.SettingnameCS=t.SettingNameCS,c.SettingNameCT=t.SettingNameCT,c.IsActive=1
FROM crmSetting c WITH(ROWLOCK,UPDLOCK)
INNER JOIN #crmSettingManage t ON c.SettingName=t.SettingName
WHERE t.Removed<>'YES' AND c.SiteOffer=1

UPDATE c
SET c.CountryNameCS=t.SettingNameCS,c.CountryNameCT=t.SettingNameCT
FROM crmCountry c WITH(ROWLOCK,UPDLOCK)
INNER JOIN #crmSettingManage t ON c.CountryName=t.SettingName
WHERE t.Removed<>'YES' AND c.SiteOffer=1

DELETE c
FROM crmSetting c 
INNER JOIN #crmSettingManage t ON c.SettingValue=t.SettingName
WHERE t.Removed='YES' AND c.SiteOffer=1

DROP TABLE #crmSettingManage
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
WHERE t.Removed='YES' AND c.SiteOffer=1

DROP TABLE #crmSettingBettype

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK) 
SET SettingValueCS=NULL
WHERE SiteOffer=1 AND SettingValueCS=''

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK) 
SET SettingValueCT=NULL
WHERE SiteOffer=1 AND SettingValueCT=''

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK) 
SET SettingNameCS=NULL
WHERE SiteOffer=1 AND SettingNameCS=''

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK) 
SET SettingNameCT=NULL
WHERE SiteOffer=1 AND SettingNameCT=''