/*<info serverAlias="DBCUST-CustDB"></info>*/
/*	
	Created: 20231005@Tacy
	Task: Update GDG - RefWinlossLimit
	Redmine: https://redmine.nexcel.vn/issues/174511
	DB: DBCUST-CustDB
*/
USE CustDB
GO 

update SportBettypeSettingMatrix  with (rowlock, updlock)
set SporttypeRefWinlossLimit=null,
	BettypeRefWinlossLimit=null,
	RepUpdateTime=SYSDATETIME()
where SportType=236
go