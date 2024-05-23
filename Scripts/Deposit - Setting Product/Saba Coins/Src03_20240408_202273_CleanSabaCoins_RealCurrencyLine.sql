/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Creator: Tacy@20240409
	RedmineID : https://nexdev.net/issues/202273

	Remark: Remove unused currency for new licensee 'SabaCoins'
			- currency:	2 (RM)	
			- currency:	20 (UUS)	
		and CashOut dummy account: SBC & YNG
*/

USE CustDB
GO

---------------------------------
--real currency
declare @username varchar(30)

select @username=username
from customer with (nolock)
where site='SabaCoins' 
	and roleid=4
	and currency=2

declare @ErrCode as int
declare @ErrMsg as varchar( 200)
exec DBA_CustomerDel @username=@username, @ErrCode= @ErrCode OUTPUT, @ErrMsg=@ErrMsg OUTPUT
select @ErrCode,@ErrMsg
go 

---------------------------------
--UUS currency
declare @usernameUUS varchar(30)

select @usernameUUS=username
from customer with (nolock)
where site='SabaCoins' 
	and roleid=4
	and currency=20 

declare @ErrCode as int
declare @ErrMsg as varchar( 200)
exec DBA_CustomerDel @username=@usernameUUS, @ErrCode= @ErrCode OUTPUT, @ErrMsg=@ErrMsg OUTPUT
select @ErrCode,@ErrMsg
go 

---------------------------------
--CashOut dummy account: SBC
declare @usernameCO varchar(30)

select @usernameCO=username
from customer with (nolock)
where site='SabaCoins' 
	and currency=213 
	and username like '%CashOut'

declare @ErrCode as int
declare @ErrMsg as varchar( 200)
exec DBA_CustomerDel @username=@usernameCO, @ErrCode= @ErrCode OUTPUT, @ErrMsg=@ErrMsg OUTPUT
select @ErrCode,@ErrMsg
go 

---------------------------------
--CashOut dummy account: YNG
declare @usernameCO varchar(30)

select @usernameCO=username
from customer with (nolock)
where site='SabaCoins' 
	and currency=72 
	and username like '%CashOut'

declare @ErrCode as int
declare @ErrMsg as varchar( 200)
exec DBA_CustomerDel @username=@usernameCO, @ErrCode= @ErrCode OUTPUT, @ErrMsg=@ErrMsg OUTPUT
select @ErrCode,@ErrMsg
go 