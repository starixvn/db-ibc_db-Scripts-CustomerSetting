/*
	Created: Winnie
	Date: 20190617
	Task:PokerShares. Update [Sport_Bettype_Reference_Setting]  RedmineID:#115529
	DB: DBTXN/bodb02
*/
  
  UPDATE [Sport_Bettype_Reference_Setting] WITH(ROWLOCK,UPDLOCK)
	SET [isActive]=1
  WHERE SportType=52