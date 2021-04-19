/*
	Created: 20210416@Eden
	Task: https://nexdev.net/issues/125823
		Reactivate Customer
	DB: DBCUST.CustDB
*/
USE CustDB
declare @ErrCode int
declare @ErrMsg nvarchar(2000)

exec Dot_Dep_Customer_Archive_ReactiveCustomer_UAT4
	@CustID = xxx ,
	@ReinitOldBalance = 1,
	@ErrCode =@ErrCode OUTPUT,
	@ErrMsg = @ErrMsg OUTPUT

select @ErrCode,@ErrMsg
GO

