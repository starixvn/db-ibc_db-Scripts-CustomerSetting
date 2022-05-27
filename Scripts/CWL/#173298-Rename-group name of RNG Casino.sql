
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
Creator	 : 20220528@Robert
    Task		 : CWL - Rename CWL group name of RNG Casino to Saba Casino [#173298]
    DB		 : DBCUST/CustDB 
    Revisions: 
		 - 20220528@Robert: CWL - Rename CWL group name of RNG Casino to Saba Casino [#173298]
     Param:
*/


DECLARE 
	@tblGroup TABLE
				 (
	GroupId   INT, 
	GroupName VARCHAR(50)
				 );
INSERT INTO @tblGroup
	  SELECT 
		    3, 
		    'Saba Casino - Normal Games'
	  UNION ALL
	  SELECT 
		    17, 
		    'Saba Casino - Minor Jackpot'
	  UNION ALL
	  SELECT 
		    18, 
		    'Saba Casino - Mega Jackpot';

UPDATE g
  SET 
	 g.GroupName = t.GroupName
FROM dbo.Winlimit_Group g WITH (ROWLOCK, UPDLOCK)
	INNER JOIN @tblGroup t ON g.GroupID = t.GroupId;

UPDATE g
  SET 
	 g.GroupName = t.GroupName
FROM dbo.Winlimit_ProductGlobalSetting g WITH (ROWLOCK, UPDLOCK)
	INNER JOIN @tblGroup t ON g.GroupID = t.GroupId;
