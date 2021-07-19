use bodb_CustomerLog
go

/*
	Created: 20191001@Percy
	DB: DBLOG.bodb_CustomerLog
	Task:
		Add new log for Change Headline of Super
		Change log name for Update Headline Posses on Super
*/

declare @ActionId int = 160014
		,@ActionName nvarchar(2000) = N'Change Headline and Possess on Super'
		,@ActionTypeID int = 4
		,@SPName varchar(2000) = 'CS_Customer_ChangeHeadline'
		,@IsInternal bit = 0

insert into dbo.LogAction
(
	ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP
	,ActionNameIT,ActionNameTH,ActionNameKO,ActionNameVI,ActionNameCN,IsInternal
)
values
(
	@ActionID,@ActionTypeID,@SPName,@ActionName,@ActionName,@ActionName,@ActionName
	,@ActionName,@ActionName,@ActionName,@ActionName,@ActionName,@IsInternal
)
go

--- update action Edit Possess
declare @ActionId int = 160009
		,@ActionName nvarchar(2000) = N'Update Headline Possess on Super'

update dbo.LogAction with (rowlock)
set ActionNameEN = @ActionName
	,ActionNameCH = @ActionName
	,ActionNameCS = @ActionName
	,ActionNameJP = @ActionName
	,ActionNameIT = @ActionName
	,ActionNameTH = @ActionName
	,ActionNameKO = @ActionName
	,ActionNameVI = @ActionName
	,ActionNameCN = @ActionName
where ActionID = @ActionId