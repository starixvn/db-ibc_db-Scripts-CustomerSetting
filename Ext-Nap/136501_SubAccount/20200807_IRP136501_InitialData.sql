/*
	Created: 20200807@Johnson	
	Task: update ParentID = 0 for eaGroup
	DB: DBPOL-NAP_UserControl
*/

UPDATE eaGroup WITH(UPDLOCK,ROWLOCK)
SET ParentID = 0