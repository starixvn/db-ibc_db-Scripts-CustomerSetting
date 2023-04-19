/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230418@Tacy
	Task: correct NEW customers' site - PRO
		 https://nexdev.net/issues/181596 [RedmineID: #181596]

	Database: DBCUST/CustDB
*/
/*
	- @site='yUT', @Headline_List='ZU01'
	- @site='y789', @Headline_List='ET789HL'
	- @site='y889', @Headline_List='BC1,SD67,DTF233,8U01,V3901,8K01,DTE113,DTE131,ET889HL,DTE249,XU1,9S'
	- @site='yOther'
*/
UPDATE c
SET c.site=ca.site
FROM Customer c WITH (ROWLOCK, UPDLOCK)
INNER JOIN Customer ca WITH (NOLOCK) ON ca.custid=c.recommend
WHERE c.custid IN (
86316404,
86316406,
86316447,
86316460,
86316609,
86316710,
86317074,
86317482,
86317589,
86317722,
86317949)