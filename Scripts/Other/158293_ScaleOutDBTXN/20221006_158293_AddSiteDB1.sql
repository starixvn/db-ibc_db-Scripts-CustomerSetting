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
WHERE site IN	('24Tech', 'MRCATSB', '24AVIA', 'allwincity', 'allwinCV', 'bdtt', 'bdtt2', 'GB888CV', 'Bobbet', 'Tianbo', 'ig128', 'A1game', 'txwl002', 'weicai', 'DingTai', 'MTech', 'shengboyun', '633esports', 'pmwint',
					'Diamond', 'ig128s', '442ball', 'Omni88', 'e8casino', 'e8casinoCV', 'asiabet88', 'TLC', 'JBO', 'Betway', 'KingFun', 'IBO', 'Kzing2', 'MANBETX', 'LS88', 'TH3', 'V03', 'XTSB', 'KZO41', 'kzsbxjCV', 'Nexus',
					'GoldenF', 'LEIHUO', 'DongYing', 'bmwbet', 'HIDZ', 'HONBET', 'Newhonbet', 'HOT99', 'XTDGT', 'LLgaming', 'IGPTech', 'AEUG', 'UG2', 'JJBGAME', 'VKGAME', 'JJBGAMECV', 'VKGAMECV', 'AJJCV', 'KeenOcean', 'K8VN',
					'Storm88', 'liv66', 'liv66SW', 'win365', 'livv88sw', 'WINHX1', 'KhmerG', 'afb99', 'khmer', 'KOKVN', 'KOKVN2', 'Lucky88', '11bet', 'Fabet', 'One88', 'Debet', 'Zbet', 'Sin88', 'Sunwin', 'Five88',
					'Red88', 'Lode88', 'Zowin', 'SV88', 'Nbet', 'OXbet', 'Sky88', 'SM88', 'SL88SW', 'ManCity', 'Mancity2', 'N88', 'N8B', 'N8G', 'NukeGaming', 'Pay4d', 'Weiwei', 'Avia', 'MARS', 'Okada',
					'BPLE', 'OkadaSW', 'AnvoFH', 'erhaozhan', 'TCbet', 'TaoCai', 'FHLMSABA', 'Titank', 'FHLMSABAS', 'SunGame', 'Sun988', 'SSSSEA', 'Sunrise', 'Sunriseb2b', 'SunriseCV', 'Ty777', 'Wanfang', 'KUTECH', 'GamingSoft', 'Dade',
					'Nbbet', 'BetDeal', 'Xtu168', 'GSCSW', 'Yibo', 'YiboCV', 'Mopgaming', 'Raisetech', 'TopGame', 'JIDU', 'Wanbo', 'ZhiFeng032', 'ZhiFeng036', 'ZhiFeng035', 'ZhiFeng021', 'ZhiFeng009', 'ZFRT082', 'mtegames', 'ZhiFeng037', 'ZFRT125',
					'ZFRT133', 'NewFuture', 'ZFRT132', 'ZhiFeng040', 'ZFRT128', 'ZFRT080', 'JIB88', 'ZhiFeng012', 'ZFRT115', 'ZFRT142', 'SAGAME88', 'ZFRT150', 'ZFRT081', 'ZFRT143', 'ZFRT166', 'ZhiFeng055', 'ZFRT156', 'ZhiFeng106', 'ZhiFeng122', 'ZFRT129',
					'ZhiFeng098', 'ZFRT165', 'ZFRT144', 'ZhiFeng147', 'ZFRT155', 'ZhiFeng026', 'ZFRT186', 'ZhiFeng156', 'ZhiFeng133', 'ZFRT126CV', 'ZFRT126', 'CENTRAL168', 'ZFRT090', 'ZF055PMW', 'ZFRT195', 'ZhiFeng138', 'ZhiFeng183', 'ZhiFeng013', 'ZFRT167', 'ZF138THB',
					'ZFRT144CV', 'ZF138VND', 'ZFRT161', 'ZhiFeng201', 'ZFRT158CV', 'Zhifeng215', 'ZhiFeng208', 'ZFRT213', 'ZhiFeng222', 'Zzun88', 'Man1878', 'NextBet', 'iBET', 'IONclub', 'Xinbo', 'HonorW', 'M8Credit', 'Ae88', 'FLC', 'OCMS',
					'Liga', 'dj888', 'JIBET', 'awc2', 'YongBao', 'Datang001', 'ISC888', 'infini88', 'Hecbet', 'Royal', 'vssports', 'DEWA', '88Macao', '9wickets', 'LSM99', 'Leng4D', 'Bonanza88', 'Senibet', 'WBS', 'OPEBET',
					'DFGame', 'OYO', 'awc', 'loc', 'wmcasino', 'OESports', 'yuanbao', 'Rakyat4DSW', 'GBET', 'Towin', 'C7YOUXICV', 'SEAL888', 'ZF026', 'starsoccer', '24AVIASL', 'H1royal', 'HFYX', 'ZhiFeng142', 'ZFRT218', 'KSTECH',
					'WLSTAR', 'ZFRT198', 'F88IN1SW', 'ZhiFeng084', 'GoldenF2CV', 'WGAMING', 'DMsports', '12B', 'Riverich', 'ZF215aTR', 'AKYL99', 'Lucklotter', 'Niu8gaming'
					)

UPDATE cs
SET cs.SiteDBGroupID = 1
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN	('24Tech', 'MRCATSB', '24AVIA', 'allwincity', 'allwinCV', 'bdtt', 'bdtt2', 'GB888CV', 'Bobbet', 'Tianbo', 'ig128', 'A1game', 'txwl002', 'weicai', 'DingTai', 'MTech', 'shengboyun', '633esports', 'pmwint',
					'Diamond', 'ig128s', '442ball', 'Omni88', 'e8casino', 'e8casinoCV', 'asiabet88', 'TLC', 'JBO', 'Betway', 'KingFun', 'IBO', 'Kzing2', 'MANBETX', 'LS88', 'TH3', 'V03', 'XTSB', 'KZO41', 'kzsbxjCV', 'Nexus',
					'GoldenF', 'LEIHUO', 'DongYing', 'bmwbet', 'HIDZ', 'HONBET', 'Newhonbet', 'HOT99', 'XTDGT', 'LLgaming', 'IGPTech', 'AEUG', 'UG2', 'JJBGAME', 'VKGAME', 'JJBGAMECV', 'VKGAMECV', 'AJJCV', 'KeenOcean', 'K8VN',
					'Storm88', 'liv66', 'liv66SW', 'win365', 'livv88sw', 'WINHX1', 'KhmerG', 'afb99', 'khmer', 'KOKVN', 'KOKVN2', 'Lucky88', '11bet', 'Fabet', 'One88', 'Debet', 'Zbet', 'Sin88', 'Sunwin', 'Five88',
					'Red88', 'Lode88', 'Zowin', 'SV88', 'Nbet', 'OXbet', 'Sky88', 'SM88', 'SL88SW', 'ManCity', 'Mancity2', 'N88', 'N8B', 'N8G', 'NukeGaming', 'Pay4d', 'Weiwei', 'Avia', 'MARS', 'Okada',
					'BPLE', 'OkadaSW', 'AnvoFH', 'erhaozhan', 'TCbet', 'TaoCai', 'FHLMSABA', 'Titank', 'FHLMSABAS', 'SunGame', 'Sun988', 'SSSSEA', 'Sunrise', 'Sunriseb2b', 'SunriseCV', 'Ty777', 'Wanfang', 'KUTECH', 'GamingSoft', 'Dade',
					'Nbbet', 'BetDeal', 'Xtu168', 'GSCSW', 'Yibo', 'YiboCV', 'Mopgaming', 'Raisetech', 'TopGame', 'JIDU', 'Wanbo', 'ZhiFeng032', 'ZhiFeng036', 'ZhiFeng035', 'ZhiFeng021', 'ZhiFeng009', 'ZFRT082', 'mtegames', 'ZhiFeng037', 'ZFRT125',
					'ZFRT133', 'NewFuture', 'ZFRT132', 'ZhiFeng040', 'ZFRT128', 'ZFRT080', 'JIB88', 'ZhiFeng012', 'ZFRT115', 'ZFRT142', 'SAGAME88', 'ZFRT150', 'ZFRT081', 'ZFRT143', 'ZFRT166', 'ZhiFeng055', 'ZFRT156', 'ZhiFeng106', 'ZhiFeng122', 'ZFRT129',
					'ZhiFeng098', 'ZFRT165', 'ZFRT144', 'ZhiFeng147', 'ZFRT155', 'ZhiFeng026', 'ZFRT186', 'ZhiFeng156', 'ZhiFeng133', 'ZFRT126CV', 'ZFRT126', 'CENTRAL168', 'ZFRT090', 'ZF055PMW', 'ZFRT195', 'ZhiFeng138', 'ZhiFeng183', 'ZhiFeng013', 'ZFRT167', 'ZF138THB',
					'ZFRT144CV', 'ZF138VND', 'ZFRT161', 'ZhiFeng201', 'ZFRT158CV', 'Zhifeng215', 'ZhiFeng208', 'ZFRT213', 'ZhiFeng222', 'Zzun88', 'Man1878', 'NextBet', 'iBET', 'IONclub', 'Xinbo', 'HonorW', 'M8Credit', 'Ae88', 'FLC', 'OCMS',
					'Liga', 'dj888', 'JIBET', 'awc2', 'YongBao', 'Datang001', 'ISC888', 'infini88', 'Hecbet', 'Royal', 'vssports', 'DEWA', '88Macao', '9wickets', 'LSM99', 'Leng4D', 'Bonanza88', 'Senibet', 'WBS', 'OPEBET',
					'DFGame', 'OYO', 'awc', 'loc', 'wmcasino', 'OESports', 'yuanbao', 'Rakyat4DSW', 'GBET', 'Towin', 'C7YOUXICV', 'SEAL888', 'ZF026', 'starsoccer', '24AVIASL', 'H1royal', 'HFYX', 'ZhiFeng142', 'ZFRT218', 'KSTECH',
					'WLSTAR', 'ZFRT198', 'F88IN1SW', 'ZhiFeng084', 'GoldenF2CV', 'WGAMING', 'DMsports', '12B', 'Riverich', 'ZF215aTR', 'AKYL99', 'Lucklotter', 'Niu8gaming'
					)

UPDATE s
SET s.SiteDBGroupID = 2
FROM Site s WITH (ROWLOCK)
WHERE site IN ('9Club','X2Dynamic','OneSports')

UPDATE cs
SET cs.SiteDBGroupID = 2
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN ('9Club','X2Dynamic','OneSports')







