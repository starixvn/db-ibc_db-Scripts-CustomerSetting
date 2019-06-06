/*
	Created: 20190606@Elodie
	DB: DBCUST/CustDB
	Task: Create headline
*/

DECLARE @ErrCode INT = 0 , 
		@ErrMsg NVARCHAR(1000) = '' 

EXEC CS_DBA_Customer_HeadlineIns
	@firstname=N'',
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
	@username='MainSH05',
	@userpwd='56E8A2D78170E87C928E480797CC73',
	@site=N'CN88',
	@currency=35,
	@GroupName = 'CN88_00',
	@ErrCode = @ErrCode OUTPUT,
	@ErrMsg = @ErrMsg OUTPUT