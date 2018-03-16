/*	
	Created: 20170312@Winnie
	Task: DELETE FROM eaFunction 
	Redmine: https://redmine.nexcel.vn/issues/86086
	DB: DBEAS/bodb_EAS
*/
DELETE FROM eaFunction 
WHERE FuncName IN('Racing','Live Casino','Racing Betting','LiveCasino Betting','Bingo','Bingo Betting'
					,'Enable Racing','Enable Live Casino','Enable Bingo','Enable HR Fixed Odds'
					,'Enable Cockfighting Status','Edit Cockfighting Setting','Poker','Enable Poker')