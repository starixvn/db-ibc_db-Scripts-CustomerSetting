/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20230925@Johnson
	Task: update RefResource
	DB: DBPRO/bodb02
*/

/*
;WITH T AS(
SELECT 'ProductGroup' RefId,'1' ResourceId,'Sportsbook' Resource_en, N'体育博彩' as Resource_cs, N'體育博彩' Resource_ch , N'กีฬ่า' Resource_th, NULL Resource_vn
UNION ALL SELECT 'ProductGroup','2','RNG Games', N'RNG游戏', N'RNG遊戲', N'เกมส์อาร์เอ็นจี', N'Trò chơi RNG'
UNION ALL SELECT 'ProductGroup','3','Live & RNG Casino',N'现场及RNG娱乐城', N'現場及RNG娛樂城', N'คาสิโนสดและ RNG', NULL
UNION ALL SELECT 'ProductGroup','4','Other Games', N'其他游戏', N'其他遊戲', N'เกมส์อื่นๆ', N'Trò Chơi Khác'
UNION ALL SELECT 'SubGroup','1','Sportsbook',N'体育博彩', N'體育博彩', N'กีฬ่า', NULL
UNION ALL SELECT 'SubGroup','2','RNG Games', NULL, NULL,  N'เกมส์อาร์เอ็นจี', N'Trò chơi RNG'
UNION ALL SELECT 'SubGroup','4','Live Casino', N'娱乐厅', N'娛樂廳', N'คาสิโนเกมสด', NULL
UNION ALL SELECT 'SubGroup','6','Live & RNG Casino',N'现场及RNG娱乐城', N'現場及RNG娛樂城', N'คาสิโนสดและ RNG', NULL
--UNION ALL SELECT 'SubGroup','7','IBCBet Live Casino'--comm
--UNION ALL SELECT 'SubGroup','8','IBCBet Live Casino'--PT IBCIndo
UNION ALL SELECT 'SubGroup','9','Bitcoin', N'比特币', N'比特幣', N'บิตคอยน์', NULL
UNION ALL SELECT 'SubGroup','10','Bitcoin', N'比特币', N'比特幣', N'บิตคอยน์', NULL
)
UPDATE rs
SET rs.Resource_cs= ISNULL(t.Resource_cs,rs.Resource_cs),
	rs.Resource_ch = ISNULL(t.Resource_ch,rs.Resource_ch),
	rs.Resource_th = ISNULL(t.Resource_th,rs.Resource_th),
	rs.Resource_vn = ISNULL(t.Resource_vn,rs.Resource_vn),
	rs.RepUpdateTime = SYSDATETIME()
FROM RefResource rs
	INNER JOIN T ON rs.RefID = t.RefID AND rs.ResourceId = t.ResourceId
*/


UPDATE RefResource WITH(ROWLOCK)
SET Resource_vn = N'Live & RNG Casino',
	RepUpdateTime = SYSDATETIME()
WHERE Resource_en = 'Live & RNG Casino'