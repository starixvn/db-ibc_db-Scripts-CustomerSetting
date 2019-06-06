/*
	Created: 20190606@Elodie
	DB: DBCUST/CustDB
	Task: Create headline
*/

DECLARE @ErrCode INT = 0 , 
		@ErrMsg NVARCHAR(1000) = '' 

EXEC CS_DBA_Customer_HeadlineIns
	@firstname=N'CN88',
	@lastname=N'',
	@address='',
	@postal='',
	@city='',
	@state='',
	@country='',
	@phone=N'',
	@mobilephone=N'',
	@email='',
	@fax=N'',
	@refcode1=N'',
	@creator=8,
	@username='TestCN5',
	@userpwd='19D7E0DB8276A8706F78F797E4A18A',
	@site=N'CN88',
	@currency=20,
	@GroupName = 'CN88_33',
	@ErrCode = @ErrCode OUTPUT,
	@ErrMsg = @ErrMsg OUTPUT