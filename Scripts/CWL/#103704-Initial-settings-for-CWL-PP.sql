
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20200715@Robert
	Task:	Initial settings for CWL - Add new PP games into CWL system [137283]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200715@Robert:	Initial settings  - [Redmine: #137283]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

UPDATE g
  SET 
      g.GroupName = 'RNG Keno'
FROM WinLimit_ProductGlobalSetting g
WHERE g.Productid = 8
      AND g.BetTypeID = 1501
      AND g.GroupID = 4;

UPDATE g
  SET 
      g.GroupName = 'PP - Jackpot Prize'
FROM Winlimit_Group g
WHERE g.GroupID = 33;

DELETE FROM WinLimit_ProductGlobalSetting
WHERE Productid = 32
      AND GroupID = 33;

DELETE FROM WinLimit_ProductSettingDetail
WHERE Productid = 32
      AND GroupID = 33;

DELETE FROM dbo.Winlimit_GameGroupSetting
WHERE ProductID = 32
      AND GroupID = 33;

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 32, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '4187,4188,4189,4228,4229,4230,4231,4297', 
     @GroupID = 16, 
     @GroupName = 'PP - Normal Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 32, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '4298', 
     @GroupID = 33, 
     @GroupName = 'PP - Jackpot Prize', 
     @Level101 = 0, 
     @Level102 = 0, 
     @Level1 = 0, 
     @Level2 = 1, 
     @Level3 = 0, 
     @RepresentativeBettype = 4001;

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 8, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '1527,1528,1529', 
     @GroupID = 4, 
     @GroupName = 'RNG Keno', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000, 
     @RepresentativeBettype = 1501;

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 28, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '1065', 
     @GroupID = 13, 
     @GroupName = 'Lottery', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000, 
     @RepresentativeBettype = 1021;

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 40, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '4914', 
     @GroupID = 29, 
     @GroupName = 'Table Games', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000, 
     @RepresentativeBettype = 4901;