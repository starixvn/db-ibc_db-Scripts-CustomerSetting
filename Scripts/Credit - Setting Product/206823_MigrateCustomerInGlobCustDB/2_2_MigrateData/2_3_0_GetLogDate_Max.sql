/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240715@Helios
	Task: Scale out DBCUST - Credit Customer in GlobCustDB - Get max logdate from CustInfoMini_tmp/CustSubMini_tmp: @logdate_max [#206823]  
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/


SELECT MAX(cimt.LogDate) AS LogDateInfoMini_Max FROM CustInfoMini_tmp cimt WITH (NOLOCK)

SELECT MAX(cimt.LogDate) AS LogDateSubMini_Max FROM CustSubMini_tmp cimt WITH (NOLOCK)