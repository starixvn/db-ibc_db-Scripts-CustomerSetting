/*
	Created: 20190520@Winnie
	Task: CN88 Insert country and test province RedmineID:#112637
	DB: DBCRM/bodb_CRM
*/

UPDATE [crmCountry] SET [SiteOffer]=2

INSERT INTO [dbo].[crmCountry]
           ([CountryAbb]
           ,[CountryName]
           ,[CountryCode]
           ,[isActive]
           ,[DisplayOrder]
           ,[SiteOffer])
     VALUES
           ('cn'
           ,'China'
           ,86
           ,1
           ,1
           ,1)
GO

INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],'N/A',1,1
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO

UPDATE crmLogAction 
	SET ExcludedForCn88=1
WHERE ActionID IN(500,501,704)
--------------------

INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Shandong',N'山东',1,2
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
           )
SELECT [CountryID],N'Jiangsu',N'江苏',1,3
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Shanghai',N'上海',1,4
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Zhejiang',N'浙江',1,5
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Guangdong',N'广东',1,6
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Guangzhou',N'广州',1,7
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Fuzhou',N'福州',1,8
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Xiamen',N'厦门',1,9
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Shenzhen',N'深圳',1,10
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Anhui',N'安徽',1,11
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Fujian',N'福建',1,12
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Jiangxi',N'江西',1,13
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Hubei',N'湖北',1,14
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Chongqing',N'重庆',1,15
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Chengdu',N'成都',1,16
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Anyang',N'安阳',1,17
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Hebei',N'河南',1,18
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Hunan',N'湖南',1,19
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Jiangxi',N'广西',1,20
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Heilongjiang',N'黑龙江',1,21
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Sichuan',N'四川',1,22
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Beijing',N'北京',1,23
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Hangzhou',N'杭州',1,24
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Nanchang',N'南昌',1,25
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Shijiazhuang',N'石家庄',1,26
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Shenyang',N'沈阳',1,27
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Tianjin',N'天津',1,28
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Luoyang',N'洛阳',1,29
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Nanyang',N'南阳',1,30
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO
INSERT INTO [dbo].[crmProvince]
           ([CountryID]
           ,[ProvinceName]
		   ,[ProvinceNameCS]
           ,[isActive]
           ,[DisplayOrder]
          )
SELECT [CountryID],N'Yunnan',N'云南',1,31
FROM [crmCountry] 
WHERE [CountryName]='China' AND [SiteOffer]=1
GO

