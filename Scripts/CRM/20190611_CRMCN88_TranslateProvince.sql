/*
	Date: 2019-06-13
	Created: Winnie
	Task: CRM CN88 Province #112637
	DB: DBCRM/[bodb_CRM]
*/
USE [bodb_CRM]
GO

CREATE TABLE #crmProvince(
	[ProvinceName] [nvarchar](150) ,	
	[ProvinceNameCS] [nvarchar](150) ,
	[ProvinceNameCT] [nvarchar](150) 
)
GO

INSERT INTO #crmProvince([ProvinceNameCS],[ProvinceNameCT],[ProvinceName])
SELECT N'无',N'無','N/A' UNION ALL 
SELECT N'山东',N'山東','Shandong' UNION ALL 
SELECT N'江苏',N'江蘇','Jiangsu' UNION ALL 
SELECT N'上海',N'上海','Shanghai' UNION ALL 
SELECT N'浙江',N'浙江','Zhejiang' UNION ALL 
SELECT N'广东',N'廣東','Guangdong' UNION ALL 
SELECT N'广州',N'廣州','Guangzhou' UNION ALL 
SELECT N'福州',N'福州','Fuzhou' UNION ALL 
SELECT N'厦门',N'廈門','Xiamen' UNION ALL 
SELECT N'深圳',N'深圳','Shenzhen' UNION ALL 
SELECT N'安徽',N'安徽','Anhui' UNION ALL 
SELECT N'福建',N'福建','Fujian' UNION ALL 
SELECT N'江西',N'江西','Jiangxi' UNION ALL 
SELECT N'湖北',N'湖北','Hubei' UNION ALL 
SELECT N'重庆',N'重慶','Chongqing' UNION ALL 
SELECT N'成都',N'成都','Chengdu' UNION ALL 
SELECT N'安阳',N'安陽','Anyang' UNION ALL 
SELECT N'河南',N'河南','Hebei' UNION ALL 
SELECT N'湖南',N'湖南','Hunan' UNION ALL 
SELECT N'广西',N'廣西','Jiangxi' UNION ALL 
SELECT N'黑龙江',N'黑龍江','Heilongjiang' UNION ALL 
SELECT N'四川',N'四川','Sichuan' UNION ALL 
SELECT N'北京',N'北京','Beijing' UNION ALL 
SELECT N'杭州',N'杭州','Hangzhou' UNION ALL 
SELECT N'南昌',N'南昌','Nanchang' UNION ALL 
SELECT N'石家庄',N'石家莊','Shijiazhuang' UNION ALL 
SELECT N'沈阳',N'沈陽','Shenyang' UNION ALL 
SELECT N'天津',N'天津','Tianjin' UNION ALL 
SELECT N'洛阳',N'洛陽','Luoyang' UNION ALL 
SELECT N'南阳',N'南陽','Nanyang' UNION ALL 
SELECT N'云南',N'雲南','Yunnan'

UPDATE c
SET c.ProvinceNameCS=t.ProvinceNameCS,c.ProvinceNameCT=t.ProvinceNameCT
FROM crmProvince c WITH(ROWLOCK,UPDLOCK)
INNER JOIN #crmProvince t ON c.ProvinceName=t.ProvinceName

DROP TABLE #crmProvince