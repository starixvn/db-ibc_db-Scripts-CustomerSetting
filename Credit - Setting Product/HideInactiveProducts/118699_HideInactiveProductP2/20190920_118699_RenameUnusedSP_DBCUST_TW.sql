/*	
	Created: 20190920@Elodie
	Task: Rename all unused SP in DBCUST
	Redmine: https://redmine.nexcel.vn/issues/118699
	DB: DBCUST
*/
USE CustDB
GO 

EXEC sp_rename 'Dot_Dep_CustomerInsMember_Legend','DEL_Dot_Dep_CustomerInsMember_Legend'
EXEC sp_rename 'Dot_Dep_GetMinMaxBet_Cust','DEL_Dot_Dep_GetMinMaxBet_Cust'
