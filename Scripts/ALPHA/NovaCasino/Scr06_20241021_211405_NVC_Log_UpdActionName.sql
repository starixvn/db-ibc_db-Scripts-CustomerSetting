/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20241021@Tacy
	Task: Udpdate ActionName [redmine:#211405]
	DB: DBLOG.bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

UPDATE LogAction  WITH (UPDLOCK,  ROWLOCK)
SET ActionTypeID=4
	,ActionNameEN=N'Apply Nova Casino Agent'
	,ActionNameCH=N'申請 Nova Casino 代理'
	,ActionNameCS=N'申请 Nova Casino 代理'
	,ActionNameJP=N'Apply Nova Casino Agent'
	,ActionNameTH=N'สมัครตัวแทน Nova Casino'
	,ActionNameKO=N'Apply Nova Casino Agent'
	,IsInternal=0
	,ActionNameVI=N'Đăng ký Đại lý Nova Casino'
WHERE ActionID=6067
GO