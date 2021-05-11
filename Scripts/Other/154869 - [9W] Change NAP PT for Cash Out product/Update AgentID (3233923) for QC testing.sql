/*<info serverAlias="DBCUST-CustDB"></info>*/
 /*
	Created: 20210511@Tina
	Task: [9W] Change NAP PT for Cash Out product [RedmineID:#154869]
	DB: DBCUST/CustDB
*/


--UPDATE AgentID = 3233923 for supporting QC (site: spondemo và currency: 20 (UUS))


UPDATE TradeComm WITH (ROWLOCK,UPDLOCK) SET Licenseecomm = 0.015 WHERE AgentID = 3233923 AND IsBA = 0


SELECT * FROM TradeComm WHERE AgentID = 3233923 AND IsBA = 0