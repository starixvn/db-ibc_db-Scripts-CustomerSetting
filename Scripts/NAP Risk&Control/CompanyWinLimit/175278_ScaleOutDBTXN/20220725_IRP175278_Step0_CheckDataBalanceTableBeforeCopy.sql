/*<info serverAlias="DBSIG-bodb02"></info>*/
/*
	Created: 20220725@Johnson
	Task: Compare data Winlimit_CreditGame/Winlimit_DebitGame between 2 servers DBTXN & SiteDB before copy [#RedmineID:#167819]
	DB: DBSIG/bodb02
*/

IF EXISTS (SELECT 1 FROM DBCTG.bodb02.dbo.Winlimit_CreditGame cs1 WITH(NOLOCK)
			LEFT JOIN dbo.Winlimit_CreditGame cs2 WITH(NOLOCK) ON  cs1.custid = cs2.custid
															AND cs1.winlostdate = cs2.winlostdate
															AND cs1.bettype = cs2.bettype
															AND cs1.Winlost <> cs2.Winlost
		)	
	OR 	EXISTS (SELECT 1 FROM DBCTG.bodb02.dbo.Winlimit_DebitGame cs1 WITH(NOLOCK)
			LEFT JOIN dbo.Winlimit_DebitGame cs2 WITH(NOLOCK) ON  cs1.custid = cs2.custid
															AND cs1.winlostdate = cs2.winlostdate
															AND cs1.bettype = cs2.bettype
															AND cs1.Winlost <> cs2.Winlost
		)
SELECT 1-- data is not same 
ELSE 
SELECT 2-- data is same