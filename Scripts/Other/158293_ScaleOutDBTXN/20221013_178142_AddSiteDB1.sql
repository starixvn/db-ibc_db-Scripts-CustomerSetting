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
WHERE site IN ('allwincity','allwinCV','bdtt','bdtt2','GB888CV','Bobbet','Tianbo','DingTai','MTech','Omni88','e8casino','e8casinoCV','GoldenF','LEIHUO','DongYing',
			'bmwbet','HIDZ','HONBET','Newhonbet','HOT99','XTDGT','LLgaming','AEUG','UG2','JJBGAME','VKGAME','JJBGAMECV','VKGAMECV','KOKVN','KOKVN2','Lucky88','11bet','Fabet',
			'One88','Debet','Zbet','Sin88','Sunwin','Five88','Red88','Lode88','Zowin','SV88','Nbet','OXbet','Sky88','SM88','SL88SW','Okada','BPLE','OkadaSW','SunGame','Sun988',
			'SSSSEA','Ty777','Mopgaming','Raisetech','TopGame','ZFRT143','ZFRT166','ZhiFeng055','ZFRT156','ZhiFeng106','ZhiFeng122','ZFRT129','ZhiFeng098','ZFRT165','ZFRT144',
			'ZhiFeng147','ZFRT155','ZhiFeng026','ZFRT186','ZhiFeng156','ZhiFeng133','ZFRT126CV','ZFRT126','CENTRAL168','ZFRT090','ZF055PMW','ZFRT195','ZhiFeng138','ZhiFeng183',
			'ZhiFeng013','ZFRT167','ZF138THB','ZFRT144CV','ZF138VND','ZFRT161','ZhiFeng201','ZFRT158CV','Zhifeng215','ZhiFeng208','ZFRT213','ZhiFeng222','Zzun88','Man1878',
			'iBET','Xinbo','HonorW','M8Credit','FLC','OCMS','dj888','JIBET','awc2','YongBao','Datang001','infini88','Hecbet','Royal','vssports','DEWA','88Macao','9wickets',
			'LSM99','Leng4D','Bonanza88','Senibet','WBS','OPEBET','DFGame','OYO','awc','loc','wmcasino','OESports','yuanbao','Rakyat4DSW','GBET','Towin','C7YOUXICV','SEAL888',
			'ZF026','starsoccer','24AVIASL','H1royal','HFYX','ZhiFeng142','ZFRT218','KSTECH','WLSTAR','ZFRT198','F88IN1SW','ZhiFeng084','GoldenF2CV','WGAMING','DMsports','12B',
			'Riverich','ZF215aTR','AKYL99','Lucklotter','Niu8gaming')

UPDATE cs
SET cs.SiteDBGroupID = 1
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN ('allwincity','allwinCV','bdtt','bdtt2','GB888CV','Bobbet','Tianbo','DingTai','MTech','Omni88','e8casino','e8casinoCV','GoldenF','LEIHUO','DongYing',
			'bmwbet','HIDZ','HONBET','Newhonbet','HOT99','XTDGT','LLgaming','AEUG','UG2','JJBGAME','VKGAME','JJBGAMECV','VKGAMECV','KOKVN','KOKVN2','Lucky88','11bet','Fabet',
			'One88','Debet','Zbet','Sin88','Sunwin','Five88','Red88','Lode88','Zowin','SV88','Nbet','OXbet','Sky88','SM88','SL88SW','Okada','BPLE','OkadaSW','SunGame','Sun988',
			'SSSSEA','Ty777','Mopgaming','Raisetech','TopGame','ZFRT143','ZFRT166','ZhiFeng055','ZFRT156','ZhiFeng106','ZhiFeng122','ZFRT129','ZhiFeng098','ZFRT165','ZFRT144',
			'ZhiFeng147','ZFRT155','ZhiFeng026','ZFRT186','ZhiFeng156','ZhiFeng133','ZFRT126CV','ZFRT126','CENTRAL168','ZFRT090','ZF055PMW','ZFRT195','ZhiFeng138','ZhiFeng183',
			'ZhiFeng013','ZFRT167','ZF138THB','ZFRT144CV','ZF138VND','ZFRT161','ZhiFeng201','ZFRT158CV','Zhifeng215','ZhiFeng208','ZFRT213','ZhiFeng222','Zzun88','Man1878',
			'iBET','Xinbo','HonorW','M8Credit','FLC','OCMS','dj888','JIBET','awc2','YongBao','Datang001','infini88','Hecbet','Royal','vssports','DEWA','88Macao','9wickets',
			'LSM99','Leng4D','Bonanza88','Senibet','WBS','OPEBET','DFGame','OYO','awc','loc','wmcasino','OESports','yuanbao','Rakyat4DSW','GBET','Towin','C7YOUXICV','SEAL888',
			'ZF026','starsoccer','24AVIASL','H1royal','HFYX','ZhiFeng142','ZFRT218','KSTECH','WLSTAR','ZFRT198','F88IN1SW','ZhiFeng084','GoldenF2CV','WGAMING','DMsports','12B',
			'Riverich','ZF215aTR','AKYL99','Lucklotter','Niu8gaming')








