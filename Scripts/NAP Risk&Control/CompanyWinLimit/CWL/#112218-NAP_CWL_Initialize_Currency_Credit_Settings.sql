/*<info serverAlias="DBCUST-CUSTDB" executers="bodbAdminNet" viewers="" isFunction="0" isNested="0"></info>*/
/*
Creator	 : 20190515@Robert
    Task		 : Initialize CWL Settings [#112218]
    DB		 : DBCUST/CustDB 
    Revisions: 
		 - 20190515@Robert: #112218 - CWL - New site CN88 integration
     Param:
		  @CurrencyIds    VARCHAR(500) = '1,2,3,4,5,6,9,12,13,15,16,17,20,21,22,30,31,32,33,34,35,36,37,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89';
*/


UPDATE p
	  SET
		 p.IsBlockedTransfer = 0
FROM WinLimit_ProductSettingDetail p WITH (ROWLOCK, UPDLOCK)
WHERE SiteID IN(SELECT siteid
			 FROM Site WITH (NOLOCK)
			 WHERE isLicensee = 0)
	 AND IsBlockedTransfer = 1;

EXEC NAP_CWL_Initialize_Currency_Credit_Settings
	@CurrencyIds = '1,2,3,4,5,6,9,12,13,15,16,17,20,21,22,30,31,32,33,34,35,36,37,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89';