/*
	Created: 20190816@Johnson
	Task: change headline for supers set wrong headline
	DB: DBCUST/CustDB
*/

--super : TP078, Headline : TPG022

EXEC DBA_CS_SuperUpdHeadlineInfo @SuperID = 38158179,-- TP078
								@HeadlineID = 37465192 --TPG022