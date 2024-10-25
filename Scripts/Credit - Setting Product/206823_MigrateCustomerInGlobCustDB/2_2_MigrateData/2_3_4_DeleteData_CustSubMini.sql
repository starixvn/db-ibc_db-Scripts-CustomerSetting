/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240715@Helios
	Task: Scale out DBCUST - GetAdjust data accordingly basing on the table CustSubMini_tmp with logdate <= @LogDateSubMini_Max. And Get data From Source Table CustSubMini to fix data [#206823]  
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/

DECLARE @LogDateSubMini_Max DATETIME2
DECLARE @debug_message VARCHAR(500);

	SET @LogDateSubMini_Max = xxx

IF EXISTS (SELECT 1 
		FROM CustSubMini_tmp cs_tmp WITH (NOLOCK)
		LEFT JOIN custSub c WITH (NOLOCK) ON cs_tmp.subaccid = c.subaccid AND cs_tmp.CustID = c.custid
		WHERE cs_tmp.LogDate <= @LogDateSubMini_Max
		AND c.subaccid IS NULL)
BEGIN

	DELETE csm
	FROM CustSubMini csm  WITH (ROWLOCK)
	INNER JOIN CustSubMini_tmp cs_tmp WITH (NOLOCK) ON csm.subaccid = cs_tmp.subaccid AND csm.custid = cs_tmp.custid 
	LEFT JOIN custSub c WITH (NOLOCK) ON cs_tmp.subaccid = c.subaccid AND cs_tmp.CustID = c.custid
	WHERE cs_tmp.LogDate <= @LogDateSubMini_Max
	AND c.subaccid IS NULL
	
	SET @debug_message = 'Curdt End Delete CustSubMini from Source table custSub : ' + CONVERT(VARCHAR(50), GETDATE(), 121)			
	RAISERROR (@debug_message, 0, 1) WITH NOWAIT

END
