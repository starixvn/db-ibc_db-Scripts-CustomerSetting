/*
Creator	 : 20190529@Robert
    Task		 : Initialize CWL Settings [#113674]
    DB		 : DBCUST/CustDB 
    Revisions: 
		 - 20190515@Robert: #113674 - Risk & Control - Rename Keno into Keno RNG
     Param:
*/


UPDATE g
	  SET
		 g.GroupName = 'RNG Keno'
FROM Winlimit_Group g WITH (ROWLOCK, UPDLOCK)
WHERE g.GroupID = 4;

