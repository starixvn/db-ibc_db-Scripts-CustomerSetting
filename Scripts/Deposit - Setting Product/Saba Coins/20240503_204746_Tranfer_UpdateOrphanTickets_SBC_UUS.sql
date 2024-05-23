/*<info serverAlias="DBCTG-bodb02,DBSID-bodb02"></info>*/
/*
	Creator: Tacy@20240503
	RedmineID : DB - Saba Coin Wallet - Update to orphan tickets
		https://nexdev.net/issues/204746
*/
USE bodb02
GO

UPDATE TOP (33) t 
SET CustId = 0, Recommend = 0, MRecommend = 0 , SRecommend = 0
FROM dbo.Transfer t WITH(UPDLOCK, ROWLOCK)
WHERE bettype = 20000
AND CustId IN (119295793
			,  119295802
			,  119295788
			,  119295795
			,  119295813
			,  119295803
			,  119295814
			,  119295810
			,  119295820
			,  119295783
			,  119295806
			,  119295812
			,  119295784
			,  119295791
			,  119295821
			,  119295796
			,  119295805
			,  119295807
			,  119295785
			,  119295804
			,  119295782
			,  119295797
			,  119295798
			,  119295811
			,  119295789
			,  119295781
			,  119295750
			,  119295817
			,  119295780
			,  119295786
			,  119295819
			,  119295815)
go