use bodb_CustomerLog
go

/*
	Created: 20191217@Percy
	DB: DBLOG.bodb_CustomerLog
	Task: Add new log for Change Headline and Possess on CN88's Super
*/

declare @ActionName nvarchar(256) = 'Change Headline and Possess on Super'

insert into dbo.LogAction (ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameIT,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
values (160014, 4, 'CS_Customer_ChangeHeadline',@ActionName,@ActionName,@ActionName,@ActionName,@ActionName,@ActionName,@ActionName,0,@ActionName,@ActionName)