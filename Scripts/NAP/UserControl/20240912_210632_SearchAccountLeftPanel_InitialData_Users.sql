/*<info serverAlias="DBPOL-NAP_UserControl"></info>*/

/*
	Created: 20240912@Helios
	Task : NAP - Improve security - Permission Control - Add 2 permission - Not allow user to access Internal Alpha and Not allow to view left-panel via NAP Accounting [RedmineID: #210632]  
	DB: DBPOL-NAP_UserControl   
*/

USE NAP_UserControl
GO

--> Acc_MemberPolicy : Default Is Read

UPDATE m
SET m.policy     = 1,
	m.modifydate = CURRENT_TIMESTAMP
FROM Acc_MemberPolicy m WITH (ROWLOCK, UPDLOCK)
INNER JOIN acc_functioninfo af WITH (NOLOCK) ON  m.FuncID = af.FuncID 
WHERE af.FuncName = '[SearchAccountLeftPanel]'


---------------------------------------------------------------------

DECLARE
	@ParentID_Level1 INT,
	@ParentID_Level2 INT

UPDATE m
SET m.policy     = 1,
	m.modifydate = CURRENT_TIMESTAMP,
	@ParentID_Level1 = af.ParentID
FROM Acc_MemberPolicy m WITH (ROWLOCK, UPDLOCK)
INNER JOIN acc_functioninfo af WITH (NOLOCK) ON  m.FuncID = af.FuncID
WHERE af.FuncName = '[AccessAgencySite]' 

UPDATE m
SET m.policy     = 1,
	m.modifydate = CURRENT_TIMESTAMP,
	@ParentID_Level2 = af.ParentID
FROM Acc_MemberPolicy m WITH (ROWLOCK, UPDLOCK)
INNER JOIN acc_functioninfo af WITH (NOLOCK) ON  m.FuncID = af.FuncID
WHERE af.FuncName = '[ViewInfo]'
AND af.FuncID = @ParentID_Level1
AND m.Policy = 0

UPDATE m
SET m.policy     = 1,
	m.modifydate = CURRENT_TIMESTAMP
FROM Acc_MemberPolicy m WITH (ROWLOCK, UPDLOCK)
INNER JOIN acc_functioninfo af WITH (NOLOCK) ON  m.FuncID = af.FuncID
WHERE af.FuncName = '[Customer]'
AND af.FuncID = @ParentID_Level2
AND m.Policy = 0