/*
	Created: 2020505@Johnson
	Task : Initial data for source sportb/bettype system setting for auto feedback[redmine:#130949]
	DB: DBCRM/bodb_CRM	
*/
SELECT 	'Product' as SettingName,	'Sportsbook' as SettingValue,	'Sportsbook' as SourceMapping
INTO #tmpSetting
UNION ALL SELECT 	'SubProduct',	'Basketball',	'Basketball'
UNION ALL SELECT 	'SubProduct',	'Tennis',	'Tennis'
UNION ALL SELECT 	'SubProduct',	'Baseball',	'Baseball'
UNION ALL SELECT 	'SubProduct',	'Muay Thai',	'Muay Thai'
UNION ALL SELECT 	'SubProduct',	'Cricket',	'Cricket'
UNION ALL SELECT 	'SubProduct',	'E-Sports',	'E-Sports'
UNION ALL SELECT 	'SubProduct',	'Badminton',	'Badminton'
UNION ALL SELECT 	'SubProduct',	'Soccer',	'Soccer'
UNION ALL SELECT 	'SubProduct',	'Other Sports',	'Other Sports'
UNION ALL SELECT 	'SubProduct',	'American Football',	'Footbal'
UNION ALL SELECT 	'SubProduct',	'Darts',	'Darts'
UNION ALL SELECT 	'SubProduct',	'Table Tennis',	'Table Tennis'
UNION ALL SELECT 	'SubProduct',	'Field Hockey',	'Field Hockey'
UNION ALL SELECT 	'SubProduct',	'Golf',	'Golf'
UNION ALL SELECT 	'SubProduct',	'Ice Hockey',	'Ice Hockey'
UNION ALL SELECT 	'SubProduct',	'Motorsport',	'Motorsports'
UNION ALL SELECT 	'SubProduct',	'Rugby',	'Rugby'
UNION ALL SELECT 	'SubProduct',	'Snooker/Pool',	'Snooker/Pool'
UNION ALL SELECT 	'SubProduct',	'Volleyball',	'Volleyball'
UNION ALL SELECT 	'SubProduct',	'Athletics',	'Athletics'
UNION ALL SELECT 	'SubProduct',	'Boxing/MMA',	'Boxing/MMA'
UNION ALL SELECT 	'SubProduct',	'Cycling',	'Cycling'
UNION ALL SELECT 	'SubProduct',	'Poker',	'Poker'
UNION ALL SELECT 	'SubProduct',	'Diving',	'Diving'
UNION ALL SELECT 	'SubProduct',	'Entertainment',	'Entertainment'
UNION ALL SELECT 	'SubProduct',	'Handball',	'Handball'
UNION ALL SELECT 	'SubProduct',	'Netball',	'Netball'
UNION ALL SELECT 	'SubProduct',	'Squash',	'Squash'
UNION ALL SELECT 	'SubProduct',	'Swimming',	'Swimming'
UNION ALL SELECT 	'SubProduct',	'Water Polo',	'Water Polo'
UNION ALL SELECT 	'SubProduct',	'Kabaddi',	'Kabaddi'
UNION ALL SELECT 	'Bettype',	'FT.HDP',	'Handicap'
UNION ALL SELECT 	'Bettype',	'OE',	'Odd/Even'
UNION ALL SELECT 	'Bettype',	'FT.O/U',	'Over/Under'
UNION ALL SELECT 	'Bettype',	'Correct Score',	'Correct Score'
UNION ALL SELECT 	'Bettype',	'FT.1X2',	'FT.1X2'
UNION ALL SELECT 	'Bettype',	'MoneyLine',	'MoneyLine'
UNION ALL SELECT 	'Bettype',	'Total Goal',	'Total Goal'
UNION ALL SELECT 	'Bettype',	'1H Handicap',	'1H Handicap'
UNION ALL SELECT 	'Bettype',	'1H Over/Under',	'1H Over/Under'
UNION ALL SELECT 	'Bettype',	'Mix Parlay',	'Mix Parlay'
UNION ALL SELECT 	'Bettype',	'Outright',	'Outright'
UNION ALL SELECT 	'Bettype',	'Total Corners',	'Total Corners'
UNION ALL SELECT 	'Bettype',	'1H Odd/Even',	'1H Odd/Even'
UNION ALL SELECT 	'Bettype',	'Clean Sheet',	'Clean Sheet'
UNION ALL SELECT 	'Bettype',	'First Goal/Last Goal',	'First Goal/Last Goal'
UNION ALL SELECT 	'Bettype',	'1H 1X2',	'1H 1X2'
UNION ALL SELECT 	'Bettype',	'HT/FT',	'HT/FT'
UNION ALL SELECT 	'Bettype',	'Substitutes',	'Substitutes'
UNION ALL SELECT 	'Bettype',	'Next Goal',	'Next Goal'
UNION ALL SELECT 	'Bettype',	'Next Corner',	'Next Corner'
UNION ALL SELECT 	'Bettype',	'Double chance',	'Double chance'
UNION ALL SELECT 	'Bettype',	'Draw No Bet',	'Draw No Bet'
UNION ALL SELECT 	'Bettype',	'Both/One/Neither team to score',	'Both/One/Neither Team To Score'
UNION ALL SELECT 	'Bettype',	'To win to nil',	'To Win To Nil'
UNION ALL SELECT 	'Bettype',	'3Way Handicap',	'3-Way Handicap'
UNION ALL SELECT 	'Bettype',	'5 min O/U',	'5 min O/U'
UNION ALL SELECT 	'Bettype',	'15 min O/U',	'15 min O/U'
UNION ALL SELECT 	'Bettype',	'30 min O/U',	'30 min O/U'
UNION ALL SELECT 	'Bettype',	'45 min O/U',	'45 min O/U'
UNION ALL SELECT 	'Bettype',	'60 min O/U',	'60 min O/U'
UNION ALL SELECT 	'Bettype',	'End of day O/U',	'End of day O/U'
UNION ALL SELECT 	'Bettype',	'5 min OE',	'5 min OE'
UNION ALL SELECT 	'Bettype',	'15 min OE',	'15 min OE'
UNION ALL SELECT 	'Bettype',	'30 min OE',	'30 min OE'
UNION ALL SELECT 	'Bettype',	'45 min OE',	'45 min OE'
UNION ALL SELECT 	'Bettype',	'60 min OE',	'60 min OE'
UNION ALL SELECT 	'Bettype',	'System Parlay',	'System Parlay'
UNION ALL SELECT 	'Bettype',	'Next 1 Minute',	'Next 1 Minute'
UNION ALL SELECT 	'Bettype',	'Next 5 Minute',	'Next 5 Minutes'
UNION ALL SELECT 	'Bettype',	'What will happen first in next 1 minute',	'What will happen first in next 1 minute'
UNION ALL SELECT 	'Bettype',	'What will happen first in next 5 minute',	'What will happen first in next 5 minutes'
UNION ALL SELECT 	'Bettype',	'Next 1 Minute Set Piece',	'Next 1 Minute Set Piece'
UNION ALL SELECT 	'Bettype',	'1H Moneyline',	'1H Moneyline'
UNION ALL SELECT 	'Bettype',	'1H Correct Score',	'1H Correct Score'
UNION ALL SELECT 	'Bettype',	'1H Correct Score',	'1H Correct Score (aos)'
UNION ALL SELECT 	'Bettype',	'Which combination will happen first in next X minutes',	'Which combination will happen first in next 1 min'
UNION ALL SELECT 	'Bettype',	'Which combination will happen first in next X minutes',	'Which combination will happen first in next 5 mins'
UNION ALL SELECT 	'Bettype',	'Q X HDP',	'Quarter X Handicap'
UNION ALL SELECT 	'Bettype',	'Q X OU',	'Quarter X Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Total Kills Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Total Towers Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Total Roshans Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Total Barracks Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Total Turrets Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Total Dragons Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Total Barons Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Total Inhibitors Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Total Tyrants Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Total Overlords Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Rounds Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Clutches Handicap'
UNION ALL SELECT 	'Bettype',	'Map X HDP',	'Map X Round Y Total Kills Handicap'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Total Kills Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Total Towers Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Total Roshans Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Total Barracks Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Total Turrets Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Total Dragons Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Total Barons Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Total Inhibitors Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Total Tyrants Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Total Overlords Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Duration Over/Under (Mins)'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Rounds Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X OU',	'Map X Round Y Total Kills Over/Under'
UNION ALL SELECT 	'Bettype',	'Map X ML',	'Map X Moneyline'
UNION ALL SELECT 	'Bettype',	'Map X ML',	'Map X Round Y Moneyline'
UNION ALL SELECT 	'Bettype',	'Q X OE',	'Quarter X Odd/Even'
UNION ALL SELECT 	'Bettype',	'Q x ML',	'Quarter X Moneyline'

INSERT INTO crmSettingMapping(SettingID, SourceMapping)
SELECT SettingID, sourceMapping
FROM #tmpsetting t
INNER JOIN crmSetting s (NOLOCK) ON t.settingvalue = s.settingvalue 
							AND t.settingName = s.SettingName	
WHERE s.SettingName = 'product'
	AND siteoffer = 2
	
INSERT INTO crmSettingMapping(SettingID, SourceMapping)
SELECT SettingID, sourceMapping
FROM #tmpsetting t
INNER JOIN crmSetting s (NOLOCK) ON t.settingvalue = s.settingvalue 
							AND t.settingName = s.SettingName	
WHERE s.SettingName = 'subproduct'
	AND siteoffer = 2	

INSERT INTO crmSettingMapping(SettingID, SourceMapping)
SELECT SettingID, sourceMapping
FROM #tmpsetting t
INNER JOIN crmSetting s (NOLOCK) ON t.settingvalue = s.settingvalue 
							AND t.settingName = s.SettingName	
WHERE s.SettingName = 'bettype'
	AND siteoffer = 2