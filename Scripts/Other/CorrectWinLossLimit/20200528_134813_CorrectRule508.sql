/*
	Created: 20200528@Elodie
	DB: DBCUST/CustDB
	Task: Correct rule 508
*/
USE CustDB
GO

UPDATE cs 
SET  MaxLossLimit = ucs.MaxLossLimit
FROM CustWinLossLimit_Agent cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.CustId = ci.custid
	INNER JOIN CustWinLossLimit_Agent ucs WITH (NOLOCK) ON ci.mrecommend = ucs.CustId AND cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid IN (26653779
					,27621478
					,28252193
					,29004042
					,29817319
					,30302089)
	AND ((cs.SportType = 211 AND cs.BetType = 2401) OR (cs.SportType = 241 AND cs.BetType = 3300))

UPDATE cs 
SET  MaxLossLimit = ucs.MaxLossLimit
FROM CustWinLossLimit_Agent cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.CustId = ci.custid
	INNER JOIN CustWinLossLimit_Agent ucs WITH (NOLOCK) ON ci.mrecommend = ucs.CustId AND cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid IN (26653779
					,27621478
					,28252193
					,29004042
					,29817319
					,30302089
					,32009896
					,32094748)
	AND ((cs.SportType = 219 AND cs.BetType = 1011))

UPDATE cs 
SET  MaxLossLimit = ucs.MaxLossLimit
FROM CustWinLossLimit_Agent cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.CustId = ci.custid
	INNER JOIN CustWinLossLimit_Agent ucs WITH (NOLOCK) ON ci.mrecommend = ucs.CustId AND cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid IN (26653779
					,27621478
					,29004042
					,29817319
					,30302089)
	AND ((cs.SportType = 220 AND cs.BetType = 1021))

UPDATE cs 
SET  MaxLossLimit = ucs.MaxLossLimit
FROM CustWinLossLimit_Agent cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.CustId = ci.custid
	INNER JOIN CustWinLossLimit_Agent ucs WITH (NOLOCK) ON ci.mrecommend = ucs.CustId AND cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid IN (26653779
					,27621478
					,28252193
					,29004042
					,29817319
					,30302089)
	AND ((cs.SportType = 212 AND cs.BetType = 4001))

UPDATE cs 
SET MaxLossLimit = ucs.MaxLossLimit
FROM Custwinlimit cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.CustId = ci.custid
	INNER JOIN CustWinLimit ucs WITH (NOLOCK) ON ci.mrecommend = ucs.CustId AND cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid IN (8090
					,8092
					,8346
					,17842
					,139155
					,143534
					,145733
					,185097
					,189600
					,401297
					,441836
					,443268
					,607971
					,707058
					,719165
					,819518
					,824753
					,974910
					,1001929
					,1010725
					,1021552
					,1028197
					,1028745
					,1036784
					,1118533
					,1241773
					,1247926
					,1265034
					,1386681
					,1397908
					,1403310
					,1453091
					,1519107
					,1529706
					,1539123
					,1544756
					,1562777
					,1573684
					,1631819
					,1685025
					,1686984
					,1718132
					,1731686
					,1784002
					,1789949
					,1883760
					,1887076
					,1914514
					,1964271
					,2045148
					,2048301
					,2170145
					,2201046
					,2229940
					,2246960
					,2247833
					,2248045
					,2269019
					,2388905
					,5407376
					,11657318
					,29986119
					,43151127
					,43083676
					,42978798
					,42777513
					,42085522
					,41983451
					,41592004
					,41525381
					,41457028
					,41275368
					,41225108
					,40696832
					,40658150
					,40394644
					,40258199
					,40092020
					,40079411
					,40072159
					,40062931
					,39928210
					,39680318
					,39634971
					,39576404
					,39561485
					,39538831
					,39505736
					,39499111
					,39450882
					,39435837
					,39397911
					,39373981
					,39262312
					,39177583
					,39141285
					,38932746
					,38755288
					,38481385
					,38455829
					,38346997
					,38285569
					,38258487
					,38090360
					,38065324
					,37986145
					,37977401
					,37837627
					,37593802
					,37401713
					,37058844
					,36606164
					,35914957
					,35878180
					,35503684
					,34750291
					,34160276
					,34093639
					,34070465
					,34039904
					,34012255
					,34010528
					,33809223
					,33668903
					,33600733
					,33419530
					,33344232
					,32805212
					,32715113
					,32701394
					,32543982
					,32373521
					,31613160
					,31016394
					,30391323
					,30058257
					,29983040
					,29833214
					,29663916
					,29505696
					,28937914
					,28711092
					,28563233
					,27463931
					,25749851
					,24958718
					,19852620
					,19627930
					,19465581
					,19154689
					,18870530
					,18563973
					,14774206
					,14690966
					,11899303
					,8550707
					,7757233
					,7280062
					,5389977
					,5130135
					,4855472
					,4729240
					,3824622
					,3725547
					,3274448
					,3085748
					,3019923
					,2787617
					,2786522
					,2767714
					,2597833
					,2554628
					,2536995
					,2527295
					,2471769
					,2467581
					,2431811
					,2371818
					,2340903
					,2121198
					,2007748
					,1999282
					,1984446
					,1947846
					,1909792
					,1751384
					,1577328
					,1571270
					,1531761
					,1503508
					,1389186
					,1190857
					,1151305
					,1000638
					,977703
					,825618
					,744470
					,36453879
					,30126026
					,29759428
					,29682473
					,28405799
					,25414035
					,25107854
					,24896443
					,24716753
					,24373177
					,24302159
					,24286496
					,22125466
					,22104625
					,21311962
					,20907452
					,20201541
					,19888000
					,19489119
					,19341739
					,19047769
					,18842201
					,18655742
					,18540544
					,18538188
					,18409356
					,18357640
					,18201224
					,18120486
					,17812741
					,17812597
					,17812590
					,17788118
					,17743791
					,17743779
					,17595223
					,17561222
					,17426766
					,17342911
					,17282705
					,16881074
					,16653929
					,16363857
					,15851366
					,15727030
					,15454136
					,14979928
					,14804385
					,14803410
					,14487169
					,14420886
					,14027189
					,13543693
					,13135486
					,12628624
					,12299257
					,12040432
					,11895756
					,11553228
					,11303023
					,8364246
					,8020835
					,7770178
					,7764970
					,7752132
					,7539649
					,6541121
					,6517897
					,6350625
					,6068464
					,5982872
					,5692551
					,5001197
					,4993423
					,4777679
					,4459028
					,3984327
					,3962799
					,3911096
					,3864496
					,3854738
					,3809250
					,3808135
					,3806084
					,3780710
					,3688362
					,3630661
					,3612015
					,3579926
					,3535495
					,3459180
					,3445643
					,3429530
					,3407635
					,3407238
					,3381421
					,3253851
					,3250745
					,3214790
					,3154284
					,2960699
					,2944264
					,2559964
					,2553565
					,2504103
					,39571598
					,37003302
					,36386311
					,35951142
					,33592046
					,33189047
					,33038720
					,32672214
					,31327882
					,30862926
					,29721621
					)
	AND cs.SportType = 208 AND cs.BetType = 2101

UPDATE cs 
SET  MaxLossLimit = ucs.MaxLossLimit
FROM CustWinLossLimit_Agent cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.CustId = ci.custid
	INNER JOIN CustWinLossLimit_Agent ucs WITH (NOLOCK) ON ci.mrecommend = ucs.CustId AND cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid IN (26653779
					,27621478
					,28252193
					,29004042
					,29817319
					,30302089)
	AND ((cs.SportType = 244 AND cs.BetType = 3001) OR (cs.SportType = 200 AND cs.BetType = 1611) OR (cs.SportType = 243 AND cs.BetType = 3101))

UPDATE cs 
SET  MaxLossLimit = ucs.MaxLossLimit
FROM CustWinLossLimit_Agent cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.CustId = ci.custid
	INNER JOIN CustWinLossLimit_Agent ucs WITH (NOLOCK) ON ci.mrecommend = ucs.CustId AND cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid IN (26653779
					,27621478
					,29004042
					,29817319
					,30302089)
	AND ((cs.SportType = 222 AND cs.BetType = 4901))

UPDATE cs 
SET  MaxLossLimit = ucs.MaxLossLimit
FROM CustWinLossLimit_Agent cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.CustId = ci.custid
	INNER JOIN CustWinLossLimit_Agent ucs WITH (NOLOCK) ON ci.mrecommend = ucs.CustId AND cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid IN (26653779
					,27621478
					,28252193
					,29004042
					,29817319
					,30302089
					,31896811)
	AND ((cs.SportType = 180 AND cs.BetType = 1201))