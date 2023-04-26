/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20230410@Johnson
	Task: Add RefResource
	DB: DBPRO/bodb02
*/

;WITH T AS (
SELECT 'SB_Comm_SMA' RefId,'1_150_1_1' ResourceId,CAST('Group A' as NVARCHAR(100)) Resource_en, CAST(N'A组' as NVARCHAR(100)) Resource_ch, CAST(N'A组' as NVARCHAR(100)) Resource_cs, CAST(N'グループ A' as NVARCHAR(100)) Resource_jp, CAST(N'กลุ่ม A' as NVARCHAR(100)) Resource_th, CAST(N'그룹 A' as NVARCHAR(100)) Resource_ko, CAST(N'Nhóm A' as NVARCHAR(100)) Resource_vn
UNION ALL SELECT 'SB_Comm_SMA','1_150_1_3','Group B', N'B组', N'B组', N'グループ B', N'กลุ่ม B', N'그룹 B', N'Nhóm B'
UNION ALL SELECT 'SB_Comm_SMA','1_150_1_7','Group C', N'C组', N'C组', N'グループ C', N'กลุ่ม C', N'그룹 C', N'Nhóm C'
UNION ALL SELECT 'SB_Comm_SMA','1_150_1_8','Group D', N'D组', N'D组', N'グループ D', N'กลุ่ม D', N'그룹 D', N'Nhóm D'
UNION ALL SELECT 'SB_Comm_SMA','1_150_1_4','Others Comm', N'其他佣金', N'其它佣金', N'その他手数料', N'ค่าคอมมิชชั่นสำหรับประเภทการเดิมพันอื่นๆ', N'다른 수수료', N'Nhóm Khác'
UNION ALL SELECT 'SB_Comm_SMA','1_150_1_5','1x2 Comm', N'獨贏盤佣金',N'独赢盘佣金', NULL, N'1x2 คอมมิชั่น',N'승무패 수수료', N'Hoa hồng cho 1x2'
UNION ALL SELECT 'SB_Comm_SMA','1_150_2_1','Myanmar Odds',N'缅甸盘', N'緬甸盤', NULL, NULL, NULL, NULL
UNION ALL SELECT 'SB_Comm_Member','1_150_1_1','Asian HDP, OU, OE', N'亚洲盘,大小盘,单双', N'亞洲盤, 大小盤, 單雙', NULL, N'ราคาต่อรองแบบแต้มต่อ สูงต่ำ และ คี่ คู่', N'아시안 핸디캡, 초과/미만, 홀짝', N'Cược chấp châu Á, Tài Xỉu, Lẻ Chẵn'
UNION ALL SELECT 'SB_Comm_Member','1_150_1_4','Other Bettypes', N'独赢盘', N'獨贏盤', NULL,N'ราคาพูล',NULL, NULL
UNION ALL SELECT 'SB_Comm_Member','1_150_1_5','1x2', NULL, NULL, NULL, NULL,N'승/무/패', NULL
UNION ALL SELECT 'SB_Comm_Member','1_150_2_1','Myanmar Odds', N'缅甸盘', N'緬甸盤', NULL, NULL,NULL, NULL
)
INSERT INTO [dbo].[RefResource]
           ([RefId]
           ,[ResourceId]
           ,[Resource_en]
           ,[Resource_ch]
           ,[Resource_cs]
           ,[Resource_jp]
           ,[Resource_it]
           ,[Resource_th]
           ,[Resource_ko]
           ,[Resource_es]     
           ,[Resource_el]
           ,[Resource_vn]
           ,[Resource_pl]
           ,[Resource_id]
           ,[Resource_hi]
           ,[Resource_mm]
           ,[Resource_fr]
           ,[Resource_ru]
           ,[Resource_pt]
           ,[Resource_de]
           ,[IsDeleted]
           ,[RepUpdateTime])
SELECT RefID, ResourceId, 
	Resource_en,
	ISNULL(Resource_ch,Resource_en),
	ISNULL(Resource_cs,Resource_en),
	ISNULL(Resource_jp,Resource_en),
	Resource_en Resource_it,
	ISNULL(Resource_th,Resource_en),
	ISNULL(Resource_ko,Resource_en),
	Resource_en as Resource_es,
	Resource_en as Resource_el,
	ISNULL(Resource_vn,Resource_en),
	Resource_en as Resource_pl,
	Resource_en as Resource_id,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,0,GETDATE()
FROM T		   
GO   

;WITH T AS 
(SELECT 'G_GT_Sport_Bettype' RefId,'1_151_9901_1' ResourceId,CAST('Saba Soccer' as NVARCHAR(100)) Resource_en, CAST(N'沙巴足球' as NVARCHAR(100)) Resource_ch, CAST(N'沙巴足球' as NVARCHAR(100)) Resource_cs, CAST(N'ฟุตบอล Saba' as NVARCHAR(100)) Resource_th,CAST(NULL as NVARCHAR(100)) Resource_ko, CAST(N'Bóng Đá Saba' as NVARCHAR(100)) Resource_vn
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_9902_1','Saba Basketball', N'沙巴篮球', N'沙巴籃球', N'บาสเกตบอล Saba', NULL, N'Bóng Rổ Saba'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_1_9','Soccer Parlay', N'足球混合过关', N'足球混合過關', N'บอลชุดฟุตบอล', NULL, N'Parlay Bóng Đá'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_152_1_9','Soccer Parlay', N'足球混合过关', N'足球混合過關', N'บอลชุดฟุตบอล', NULL, N'Parlay Bóng Đá'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_99_9','Mix Sports Parlay', N'混合体育过关', N'混合體育過關', N'กีฬาบอลชุด', N'믹스 스포츠 팔레이', NULL
UNION ALL SELECT 'G_GT_Sport_Bettype','1_152_99_9','Mix Sports Parlay', N'混合体育过关', N'混合體育過關', N'กีฬาบอลชุด', N'믹스 스포츠 팔레이', NULL
UNION ALL SELECT 'G_GT_Sport_Bettype','2_154_9908_1201','Virtual Sports', N'虚拟运动', N'虚拟运动',N'กีฬาอนิเมชั่น',N'가상 스포츠 ', NULL
)
INSERT INTO [dbo].[RefResource]
           ([RefId]
           ,[ResourceId]
           ,[Resource_en]
           ,[Resource_ch]
           ,[Resource_cs]
           ,[Resource_jp]
           ,[Resource_it]
           ,[Resource_th]
           ,[Resource_ko]
           ,[Resource_es]     
           ,[Resource_el]
           ,[Resource_vn]
           ,[Resource_pl]
           ,[Resource_id]
           ,[Resource_hi]
           ,[Resource_mm]
           ,[Resource_fr]
           ,[Resource_ru]
           ,[Resource_pt]
           ,[Resource_de]
           ,[IsDeleted]
           ,[RepUpdateTime])
SELECT RefID, ResourceId, Resource_en,
		Resource_ch,
		Resource_cs,
		Resource_en,Resource_en,
		Resource_th,
		ISNULL(Resource_ko,Resource_en)
		,Resource_en,Resource_en,
		ISNULL(Resource_vn,Resource_en),
		Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,0,GETDATE()
FROM T		   
GO

;WITH T AS 
(SELECT 'G_GT_Sport_Bettype' RefId,'1_151_1_1' ResourceId,'Soccer' Resource_en
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_2_1','Basketball'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_3_1','Football'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_5_1','Tennis'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_8_1','Baseball'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_10_1','Golf'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_11_1','Motorsports'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_99_1','Other Sports'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_43_1','E-Sports'
UNION ALL SELECT 'G_GT_Sport_Bettype','1_151_44_3','Muay Thai'
UNION ALL SELECT 'G_GT_Sport_Bettype','2_154_202_1501','RNG Keno'
UNION ALL SELECT 'G_GT_Sport_Bettype','2_154_169_3611','Sports Lottery'
UNION ALL SELECT 'G_GT_Sport_Bettype','2_154_220_1024','Lottery'
UNION ALL SELECT 'G_GT_Sport_Bettype','2_154_222_4901','Table Game'
UNION ALL SELECT 'G_GT_Sport_Bettype','2_154_161_81','Number Game'
UNION ALL SELECT 'G_GT_Sport_Bettype','2_154_164_8101','Happy 5'
)
INSERT INTO [dbo].[RefResource]
           ([RefId]
           ,[ResourceId]
           ,[Resource_en]
           ,[Resource_ch]
           ,[Resource_cs]
           ,[Resource_jp]
           ,[Resource_it]
           ,[Resource_th]
           ,[Resource_ko]
           ,[Resource_es]     
           ,[Resource_el]
           ,[Resource_vn]
           ,[Resource_pl]
           ,[Resource_id]
           ,[Resource_hi]
           ,[Resource_mm]
           ,[Resource_fr]
           ,[Resource_ru]
           ,[Resource_pt]
           ,[Resource_de]
           ,[IsDeleted]
           ,[RepUpdateTime])
SELECT RefID
	,ResourceId
	,SportName [Resource_en]
   ,SportNameCh [Resource_ch]
   ,SportNameCs [Resource_cs]
   ,SportNameJp [Resource_jp]
   ,SportNameIt [Resource_it]
   ,SportNameTh [Resource_th]
   ,SportNameKo [Resource_ko]
   ,SportNameES [Resource_es]     
   ,SportNameEL [Resource_el]
   ,SportNameVN [Resource_vn]
   ,SportNamePL [Resource_pl]
   ,SportNameID [Resource_id]
   ,SportNameHI [Resource_hi]
   ,SportNameMMR [Resource_mm]
   ,SportNameFR [Resource_fr]
   ,SportNameRU [Resource_ru]
   ,SportNamePT [Resource_pt]
   ,SportName [Resource_de]
   ,0,GETDATE()
FROM T
	INNER JOIN Sports s ON s.sportname = t.Resource_en
GO


;WITH T AS(
SELECT 'ProductGroup' RefId,'1' ResourceId,'Sportsbook' Resource_en
UNION ALL SELECT 'ProductGroup','2','RNG Games'
UNION ALL SELECT 'ProductGroup','3','Live & RNG Games'
UNION ALL SELECT 'SubGroup','1','Sportsbook'
UNION ALL SELECT 'SubGroup','2','RNG Games'
UNION ALL SELECT 'SubGroup','3','Allbet & SA Gaming'
UNION ALL SELECT 'SubGroup','4','Other Live Casino'
UNION ALL SELECT 'SubGroup','5','Allbet & SA Gaming'
UNION ALL SELECT 'SubGroup','6','Other Live Casino & RNG Games'
)
INSERT INTO [dbo].[RefResource]
           ([RefId]
           ,[ResourceId]
           ,[Resource_en]
           ,[Resource_ch]
           ,[Resource_cs]
           ,[Resource_jp]
           ,[Resource_it]
           ,[Resource_th]
           ,[Resource_ko]
           ,[Resource_es]     
           ,[Resource_el]
           ,[Resource_vn]
           ,[Resource_pl]
           ,[Resource_id]
           ,[Resource_hi]
           ,[Resource_mm]
           ,[Resource_fr]
           ,[Resource_ru]
           ,[Resource_pt]
           ,[Resource_de]
           ,[IsDeleted]
           ,[RepUpdateTime])
SELECT RefID, ResourceId, Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,0,GETDATE()
FROM T		   