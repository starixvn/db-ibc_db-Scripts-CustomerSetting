/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240715@Helios
	Task: Scale out DBCUST - GetAdjust data accordingly basing on the table CustInfoMini_tmp with logdate <= @LogDateInfoMini_Max. And Get data From Source Table Customer/Dep_Customer_Archived to fix data [#206823]  
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/

DECLARE @LogDateInfoMini_Max DATETIME2
DECLARE @debug_message VARCHAR(500);

	SET @LogDateInfoMini_Max = xxx

IF EXISTS (SELECT 1 FROM CustInfoMini_tmp WITH (NOLOCK) WHERE LogDate <= @LogDateInfoMini_Max)
BEGIN

	UPDATE cim
		SET
			cim.username2	=  c.username2
		    , cim.recommend	=  c.recommend
		    , cim.mrecommend	=  c.mrecommend
		    , cim.srecommend	=  c.srecommend
		    , cim.roleid		=  c.roleid
		    , cim.Site		=  c.site
		    , cim.Currency	=  c.Currency
		    , cim.RepUpdateTime =  SYSDATETIME ()
	FROM CustInfoMini cim WITH (ROWLOCK , UPDLOCK)
	INNER JOIN CustInfoMini_tmp cim_tmp WITH (NOLOCK) ON cim.CustId = cim_tmp.CustID
	INNER JOIN Customer c WITH (NOLOCK) ON cim_tmp.CustID = c.custid
	WHERE cim_tmp.LogDate <= @LogDateInfoMini_Max

	SET @debug_message = 'Curdt End Adjust CustInfoMini from Source table CustInfoMini: ' + CONVERT(VARCHAR(50), GETDATE(), 121)			
	RAISERROR (@debug_message, 0, 1) WITH NOWAIT

	UPDATE cim
		SET
			cim.username2	=  dca.username2
		    , cim.recommend	=  c.recommend
		    , cim.mrecommend	=  c.mrecommend
		    , cim.srecommend	=  c.srecommend
		    , cim.roleid		=  1
		    , cim.Site		=  c.site
		    , cim.Currency	=  c.Currency
		    , cim.RepUpdateTime =  SYSDATETIME ()
	FROM CustInfoMini cim WITH (ROWLOCK , UPDLOCK)
	INNER JOIN CustInfoMini_tmp cim_tmp WITH (NOLOCK)  ON cim.CustID = cim_tmp.CustID
	INNER JOIN Dep_Customer_Archived dca WITH (NOLOCK) ON cim_tmp.CustID = dca.CustID
	INNER JOIN Customer c WITH (NOLOCK) ON dca.Recommend = c.CustID
	WHERE  dca.Status = 'completed'
	AND cim_tmp.LogDate <= @LogDateInfoMini_Max
	
	SET @debug_message = 'Curdt End Adjust CustInfoMini from Source table Dep_Customer_Archived: ' + CONVERT(VARCHAR(50), GETDATE(), 121)			
	RAISERROR (@debug_message, 0, 1) WITH NOWAIT

END
