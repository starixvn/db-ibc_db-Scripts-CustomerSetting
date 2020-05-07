/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBCUST.CUSTDB
*/
USE bodb_Report
GO
BEGIN
	SET NOCOUNT ON
	declare @status varchar(200)
	declare @from smalldatetime, @to smalldatetime, @fromEx smalldatetime, @toEx smalldatetime
	declare @_from smalldatetime, @_to smalldatetime

	select @status = VValue from bodb02.dbo.Systemsettings with (nolock) where VName = 'aa_Stmt_Status'

	if @status IN('Stage 4 - Done', 'Stage 1 - Running')--start routine - Load statement for stage 1 (3 months)
	begin
		select @from = convert(varchar(10), dateadd(MM, -3, getdate()), 120)

		set @status = 'Stage 1 - Running'

		truncate table tempCustID
	end
	else if @status IN('Stage 1 - Done', 'Stage 2 - Running') --continue load statement for stage 2: load more 1-month statement (4 months)
	begin
		select @from = VValue from bodb02.dbo.Systemsettings with (nolock) where VName = 'aa_Stmt_EndDate'
		select @from =  dateadd(dd, 1, @from)

		set @status = 'Stage 2 - Running'
	end
	else if @status IN('Stage 2 - Done', 'Stage 3 - Running') --continue load statement for stage 3: load more statement (7 months)
	begin
		select @from = VValue from bodb02.dbo.Systemsettings with (nolock) where VName = 'aa_Stmt_EndDate'
		select @from =  dateadd(dd, 1, @from)

		select @fromEx = convert(varchar(10), dateadd(MM, -7, getdate()), 120)

		select @toEx = VValue from bodb02.dbo.Systemsettings with (nolock) where VName = 'aa_Stmt_StartDate'
		select @toEx =  dateadd(dd, -1, @toEx)

		set @status = 'Stage 3 - Running'
	end
	else if @status IN('Stage 3 - Done', 'Stage 4 - Running') --continue load statement for stage 2: load more 1-month statement (4 months)
	begin
		select @from = VValue from bodb02.dbo.Systemsettings with (nolock) where VName = 'aa_Stmt_EndDate'
		select @from =  dateadd(dd, 1, @from)

		set @status = 'Stage 4 - Running'
	end
	else return

	update bodb02.dbo.Systemsettings with(rowlock, updlock) set VValue = @status where VName = 'aa_Stmt_Status'


	--update status after load statement data
	if (@status like '%Running')
		update bodb02.dbo.Systemsettings with(rowlock, updlock) set VValue = replace(@status, 'Running', 'Done') where VName = 'aa_Stmt_Status'

	if (@status = 'Stage 1 - Running')
		update bodb02.dbo.Systemsettings with(rowlock, updlock) set VValue = @from where VName = 'aa_Stmt_StartDate'
	else if(@status = 'Stage 3 - Running')
		update bodb02.dbo.Systemsettings with(rowlock, updlock) set VValue = @fromEx where VName = 'aa_Stmt_StartDate'


	update bodb02.dbo.Systemsettings with(rowlock, updlock) set VValue = @to where VName = 'aa_Stmt_EndDate'
END