/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20220610
	Task: Update data table Site, Dep_CustSuper [RedmineID:#178142]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE s
SET s.SiteDBGroupID = 1
FROM Site s WITH (ROWLOCK)
WHERE site IN ('24Tech','MRCATSB','24AVIA','ig128','A1game','txwl002','weicai','shengboyun','633esports','pmwint','Diamond','ig128s','442ball','asiabet88','TLC','JBO',
				'Betway','KingFun','IBO','Kzing2','MANBETX','LS88','TH3','V03','XTSB','KZO41','kzsbxjCV','Nexus','IGPTech','AJJCV','KeenOcean','K8VN','Storm88','liv66',
				'liv66SW','win365','livv88sw','WINHX1','KhmerG','afb99','khmer','ManCity','Mancity2','N88','N8B','N8G','NukeGaming','Pay4d','Weiwei','Avia','MARS','AnvoFH',
				'erhaozhan','TCbet','TaoCai','FHLMSABA','Titank','FHLMSABAS','Sunrise','Sunriseb2b','SunriseCV','Wanfang','KUTECH','GamingSoft','Dade','Nbbet','BetDeal',
				'Xtu168','GSCSW','Yibo','YiboCV','JIDU','Wanbo','ZhiFeng032','ZhiFeng036','ZhiFeng035','ZhiFeng021','ZhiFeng009','ZFRT082','mtegames','ZhiFeng037','ZFRT125',
				'ZFRT133','NewFuture','ZFRT132','ZhiFeng040','ZFRT128','ZFRT080','JIB88','ZhiFeng012','ZFRT115','ZFRT142','SAGAME88','ZFRT150','ZFRT081','NextBet','IONclub',
				'Ae88','Liga','ISC888')


UPDATE cs
SET cs.SiteDBGroupID = 1
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN ('24Tech','MRCATSB','24AVIA','ig128','A1game','txwl002','weicai','shengboyun','633esports','pmwint','Diamond','ig128s','442ball','asiabet88','TLC','JBO',
				'Betway','KingFun','IBO','Kzing2','MANBETX','LS88','TH3','V03','XTSB','KZO41','kzsbxjCV','Nexus','IGPTech','AJJCV','KeenOcean','K8VN','Storm88','liv66',
				'liv66SW','win365','livv88sw','WINHX1','KhmerG','afb99','khmer','ManCity','Mancity2','N88','N8B','N8G','NukeGaming','Pay4d','Weiwei','Avia','MARS','AnvoFH',
				'erhaozhan','TCbet','TaoCai','FHLMSABA','Titank','FHLMSABAS','Sunrise','Sunriseb2b','SunriseCV','Wanfang','KUTECH','GamingSoft','Dade','Nbbet','BetDeal',
				'Xtu168','GSCSW','Yibo','YiboCV','JIDU','Wanbo','ZhiFeng032','ZhiFeng036','ZhiFeng035','ZhiFeng021','ZhiFeng009','ZFRT082','mtegames','ZhiFeng037','ZFRT125',
				'ZFRT133','NewFuture','ZFRT132','ZhiFeng040','ZFRT128','ZFRT080','JIB88','ZhiFeng012','ZFRT115','ZFRT142','SAGAME88','ZFRT150','ZFRT081','NextBet','IONclub',
				'Ae88','Liga','ISC888')

--UPDATE s
--SET s.SiteDBGroupID = 2
--FROM Site s WITH (ROWLOCK)
--WHERE site IN ('9Club','X2Dynamic','OneSports')

--UPDATE cs
--SET cs.SiteDBGroupID = 2
--FROM Dep_CustSuper cs WITH (ROWLOCK)
--WHERE site IN ('9Club','X2Dynamic','OneSports')







