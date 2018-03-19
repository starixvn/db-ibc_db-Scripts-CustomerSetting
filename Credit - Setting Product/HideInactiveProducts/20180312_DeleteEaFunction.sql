/*	
	Created: 20170312@Winnie
	Task: DELETE FROM eaFunction 
	Redmine: https://redmine.nexcel.vn/issues/86086
	DB: DBEAS/bodb_EAS
*/
DELETE FROM eaFunction 
WHERE FuncName IN('Racing','Live Casino','Racing Bet Setting','LiveCasino Bet Setting','Bingo','Bingo Bet Setting'
					,'Enable Racing','Enable Live Casino','Enable Bingo','Enable HR Fixed Odds'
					,'Enable Cockfighting Status','Edit Cockfighting Setting','Poker','Enable Poker')