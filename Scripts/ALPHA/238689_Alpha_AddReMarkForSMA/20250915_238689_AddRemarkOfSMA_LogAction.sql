/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: Dave
	Date: 20250915
	Task: Alpha_Add remark field when editing info of master/Agent/member [Redmine: 238689]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE  ActionID IN (264008);

INSERT INTO LogAction(ActionID,ActionTypeID,SPName,ActionNameEN,IsInternal)
VALUES(264008,1,'Acc_CustomerRemarkUpd','Update remark field when editing info of master/Agent/member',1);

SELECT * FROM LogAction WHERE ActionID = 264008;