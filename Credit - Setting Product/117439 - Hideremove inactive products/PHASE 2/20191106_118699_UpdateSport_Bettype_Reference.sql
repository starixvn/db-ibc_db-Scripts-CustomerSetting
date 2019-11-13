/*	
	Created: 20191106@Eden
	Task: UPDATE IsActive = 0 for inactive products for Sport_Bettype_Reference
	Redmine: https://nexdev.net/issues/118699
	DB: DBTXN
*/

UPDATE a 
SET a.isActive = 0
FROM Sport_Bettype_Reference a  WITH(UPDLOCK,ROWLOCK) 
WHERE (a.Sporttype = 1 AND a.Bettype between 301 and 304) --Myanmar Odds
	OR (a.Sporttype = 50 AND a.Site = 'IMBC') --IMBC Cricket
	OR a.Sporttype IN (
						 160,163,207,206 --Lucky 3,Poker Games,Bullfighting,Cockfighting
						,154 --Horse racing Fixed Odds
						,151,152,153,201 --Racing, Financials
						,203,205,162 --Microgame (LC & RNG), SLI Live Casino
					  )

UPDATE a 
SET a.isActive = 0
FROM Sport_Bettype_Reference_Setting a WITH(UPDLOCK,ROWLOCK) 
WHERE (a.Sporttype = 1 AND a.Bettype between 301 and 304) --Myanmar Odds
	OR (a.Sporttype = 50 AND a.Site = 'IMBC') --IMBC Cricket
	OR a.Sporttype IN (
						 160,163,207,206 --Lucky 3,Poker Games,Bullfighting,Cockfighting
						,154 --Horse racing Fixed Odds
						,151,152,153,201 --Racing, Financials
						,203,205,162 --Microgame (LC & RNG), SLI Live Casino
					  )
