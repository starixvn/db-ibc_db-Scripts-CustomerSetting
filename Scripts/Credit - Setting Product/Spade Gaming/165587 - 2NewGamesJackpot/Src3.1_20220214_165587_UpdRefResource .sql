/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20220214
	Task:  Upd dummy sport RedmineID:#165587
	DB: DBPRO /bodb02
	P/s :  Upd dummy sport
*/

DELETE FROM RefResource WHERE ResourceId='9904' AND RefId='DummySport'
--Insert Remoting ref dummy sport
DECLARE @RefId		VARCHAR(20)		= 'DummySport',
	@ResourceId		VARCHAR(20)		= 9904,
	@Resource_en	NVARCHAR(50)	= 'Jackpot',
	@Resource_ch	NVARCHAR(50)	= N'積寶',
	@Resource_cs	NVARCHAR(50)	= N'积宝',
	@Resource_jp	NVARCHAR(50)	= NULL,
	@Resource_it	NVARCHAR(50)	= NULL,
	@Resource_th	NVARCHAR(50)	= N'แจ็คพอต',
	@Resource_ko	NVARCHAR(50)	= NULL,
	@Resource_es	NVARCHAR(50)	= NULL,
	@Sort1			INT				= NULL,
	@Sort2			INT				= NULL,
	@Resource_el	NVARCHAR(50)	= NULL,
	@Resource_vn	NVARCHAR(50)	= NULL,
	@Resource_pl	NVARCHAR(50)	= NULL,
	@Resource_id	NVARCHAR(50)	= NULL,
	@Resource_hi	NVARCHAR(50)	= NULL,
	@Resource_mm	NVARCHAR(50)	= NULL,
	@Resource_fr	NVARCHAR(50)	= NULL,
	@Resource_ru	NVARCHAR(50)	= NULL,
	@Resource_pt	NVARCHAR(50)	= NULL,
	@Resource_de	NVARCHAR(50)	= NULL
							   
INSERT INTO RefResource (RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_jp, Resource_it, Resource_th, Resource_ko, Resource_es, Sort1, Sort2, Resource_el, Resource_vn, Resource_pl, Resource_id, Resource_hi, Resource_mm, Resource_fr, Resource_ru, Resource_pt, Resource_de)
SELECT @RefId, @ResourceId, @Resource_en, @Resource_ch, @Resource_cs, @Resource_jp, @Resource_it, @Resource_th, @Resource_ko, @Resource_es, @Sort1, @Sort2, @Resource_el, @Resource_vn, @Resource_pl, @Resource_id, @Resource_hi, @Resource_mm, @Resource_fr, @Resource_ru, @Resource_pt, @Resource_de