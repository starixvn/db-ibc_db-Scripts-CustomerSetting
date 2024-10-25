/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240715@Helios
	Task: Scale out DBCUST - Delete data accordingly basing on the table CustInfoMini_tmp with logdate <= @LogDateInfoMini_Max. And Get data From Source Table Customer to fix data [#206823]  
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/

DECLARE @LogDateInfoMini_Max DATETIME2
DECLARE @debug_message VARCHAR(500);

	SET @LogDateInfoMini_Max =  xxx

IF EXISTS (SELECT 1 
		FROM CustInfoMini_tmp cim_tmp WITH (NOLOCK) 
		LEFT JOIN Customer c WITH (NOLOCK) ON cim_tmp.CustID = c.custid
		WHERE cim_tmp.LogDate <= @LogDateInfoMini_Max
		AND c.custid IS NULL)
BEGIN

	DELETE cim
	FROM CustInfoMini cim WITH (ROWLOCK)
	INNER JOIN CustInfoMini_tmp cim_tmp WITH (NOLOCK) ON cim.CustId = cim_tmp.CustID
	LEFT JOIN Customer c WITH (NOLOCK) ON cim_tmp.CustID = c.custid
	WHERE cim_tmp.LogDate <= @LogDateInfoMini_Max
	AND c.custid IS NULL
	
	SET @debug_message = 'Curdt End Delete CustInfoMini from Source table Customer : ' + CONVERT(VARCHAR(50), GETDATE(), 121)			
	RAISERROR (@debug_message, 0, 1) WITH NOWAIT

END