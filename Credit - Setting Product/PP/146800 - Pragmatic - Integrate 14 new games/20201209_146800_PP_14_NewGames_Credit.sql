/*
	Date: 20201209
	Created: Winfred 
	Task: #146800 - Pragmatic - Integrate 14 new games Dec 2020 for Credit [Redmine:146800]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG	$US
SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--=============================================
--DDD,IND,IDR,IDD,IN
SELECT 4244 ,'1.8'  ,'36'      ,1.8  ,36      ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4245 ,'1.8'  ,'360'     ,1.8  ,360     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4246 ,'2.25' ,'450'     ,2.25 ,450     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4247 ,'2.25' ,'225'     ,2.25 ,225     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4248 ,'1.8'  ,'108'     ,1.8  ,108     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4249 ,'0.9'  ,'90'      ,0.9  ,90      ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4250 ,'2.25' ,'90'      ,2.25 ,90      ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4251 ,'1.8'  ,'90'      ,1.8  ,90      ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4252 ,'1.8'  ,'90'      ,1.8  ,90      ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4253 ,'1.8'  ,'108'     ,1.8  ,108     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4254 ,'0.9'  ,'288'     ,0.9  ,288     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4256 ,'1.8'  ,'234'     ,1.8  ,234     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4257 ,'0.9'  ,'1800'    ,0.9  ,1800    ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4244 ,'1.8'  ,'36'      ,1.8  ,36      ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4245 ,'1.8'  ,'360'     ,1.8  ,360     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4246 ,'2.25' ,'450'     ,2.25 ,450     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4247 ,'2.25' ,'225'     ,2.25 ,225     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4248 ,'1.8'  ,'108'     ,1.8  ,108     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4249 ,'0.9'  ,'90'      ,0.9  ,90      ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4250 ,'2.25' ,'90'      ,2.25 ,90      ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4251 ,'1.8'  ,'90'      ,1.8  ,90      ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4252 ,'1.8'  ,'90'      ,1.8  ,90      ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4253 ,'1.8'  ,'108'     ,1.8  ,108     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4254 ,'0.9'  ,'288'     ,0.9  ,288     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4256 ,'1.8'  ,'234'     ,1.8  ,234     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4257 ,'0.9'  ,'1800'    ,0.9  ,1800    ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4244 ,'1.8'  ,'36'      ,1.8  ,36      ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4245 ,'1.8'  ,'360'     ,1.8  ,360     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4246 ,'2.25' ,'450'     ,2.25 ,450     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4247 ,'2.25' ,'225'     ,2.25 ,225     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4248 ,'1.8'  ,'108'     ,1.8  ,108     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4249 ,'0.9'  ,'90'      ,0.9  ,90      ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4250 ,'2.25' ,'90'      ,2.25 ,90      ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4251 ,'1.8'  ,'90'      ,1.8  ,90      ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4252 ,'1.8'  ,'90'      ,1.8  ,90      ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4253 ,'1.8'  ,'108'     ,1.8  ,108     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4254 ,'0.9'  ,'288'     ,0.9  ,288     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4256 ,'1.8'  ,'234'     ,1.8  ,234     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4257 ,'0.9'  ,'1800'    ,0.9  ,1800    ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4244 ,'1.8'  ,'36'      ,1.8  ,36      ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4245 ,'1.8'  ,'360'     ,1.8  ,360     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4246 ,'2.25' ,'450'     ,2.25 ,450     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4247 ,'2.25' ,'225'     ,2.25 ,225     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4248 ,'1.8'  ,'108'     ,1.8  ,108     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4249 ,'0.9'  ,'90'      ,0.9  ,90      ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4250 ,'2.25' ,'90'      ,2.25 ,90      ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4251 ,'1.8'  ,'90'      ,1.8  ,90      ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4252 ,'1.8'  ,'90'      ,1.8  ,90      ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4253 ,'1.8'  ,'108'     ,1.8  ,108     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4254 ,'0.9'  ,'288'     ,0.9  ,288     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4256 ,'1.8'  ,'234'     ,1.8  ,234     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4257 ,'0.9'  ,'1800'    ,0.9  ,1800    ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4244 ,'1.8'  ,'36'      ,1.8  ,36      ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4245 ,'1.8'  ,'360'     ,1.8  ,360     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4246 ,'2.25' ,'450'     ,2.25 ,450     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4247 ,'2.25' ,'225'     ,2.25 ,225     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4248 ,'1.8'  ,'108'     ,1.8  ,108     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4249 ,'0.9'  ,'90'      ,0.9  ,90      ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4250 ,'2.25' ,'90'      ,2.25 ,90      ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4251 ,'1.8'  ,'90'      ,1.8  ,90      ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4252 ,'1.8'  ,'90'      ,1.8  ,90      ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4253 ,'1.8'  ,'108'     ,1.8  ,108     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4254 ,'0.9'  ,'288'     ,0.9  ,288     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4256 ,'1.8'  ,'234'     ,1.8  ,234     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4257 ,'0.9'  ,'1800'    ,0.9  ,1800    ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
--=============================================
--GBP
SELECT 4244 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4245 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4246 ,'0.25' ,'5'       ,0.25 ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4247 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,12   UNION ALL	--GBP	--GBP
SELECT 4248 ,'0.2'  ,'6'       ,0.2  ,6       ,12   UNION ALL	--GBP	--GBP
SELECT 4249 ,'0.1'  ,'7'       ,0.1  ,7       ,12   UNION ALL	--GBP	--GBP
SELECT 4250 ,'0.25' ,'7.5'     ,0.25 ,7.5     ,12   UNION ALL	--GBP	--GBP
SELECT 4251 ,'0.2'  ,'6'       ,0.2  ,6       ,12   UNION ALL	--GBP	--GBP
SELECT 4252 ,'0.2'  ,'6'       ,0.2  ,6       ,12   UNION ALL	--GBP	--GBP
SELECT 4253 ,'0.2'  ,'6'       ,0.2  ,6       ,12   UNION ALL	--GBP	--GBP
SELECT 4254 ,'0.1'  ,'24'      ,0.1  ,24      ,12   UNION ALL	--GBP	--GBP
SELECT 4256 ,'0.2'  ,'16'      ,0.2  ,16      ,12   UNION ALL	--GBP	--GBP
SELECT 4257 ,'0.1'  ,'72'      ,0.1  ,72      ,12   UNION ALL	--GBP	--GBP
--=============================================
--HKK
SELECT 4244 ,'0.6'  ,'12'      ,0.6  ,12      ,67   UNION ALL	--HKK	--HKK
SELECT 4245 ,'0.6'  ,'120'     ,0.6  ,120     ,67   UNION ALL	--HKK	--HKK
SELECT 4246 ,'0.75' ,'150'     ,0.75 ,150     ,67   UNION ALL	--HKK	--HKK
SELECT 4247 ,'0.75' ,'75'      ,0.75 ,75      ,67   UNION ALL	--HKK	--HKK
SELECT 4248 ,'0.6'  ,'36'      ,0.6  ,36      ,67   UNION ALL	--HKK	--HKK
SELECT 4249 ,'0.3'  ,'30'      ,0.3  ,30      ,67   UNION ALL	--HKK	--HKK
SELECT 4250 ,'0.75' ,'30'      ,0.75 ,30      ,67   UNION ALL	--HKK	--HKK
SELECT 4251 ,'0.6'  ,'30'      ,0.6  ,30      ,67   UNION ALL	--HKK	--HKK
SELECT 4252 ,'0.6'  ,'30'      ,0.6  ,30      ,67   UNION ALL	--HKK	--HKK
SELECT 4253 ,'0.6'  ,'36'      ,0.6  ,36      ,67   UNION ALL	--HKK	--HKK
SELECT 4254 ,'0.3'  ,'96'      ,0.3  ,96      ,67   UNION ALL	--HKK	--HKK
SELECT 4256 ,'0.6'  ,'78'      ,0.6  ,78      ,67   UNION ALL	--HKK	--HKK
SELECT 4257 ,'0.3'  ,'600'     ,0.3  ,600     ,67   UNION ALL	--HKK	--HKK
--=============================================
--RM
SELECT 4244 ,'0.6'  ,'12'      ,0.6  ,12      ,2    UNION ALL	--RM	--RM
SELECT 4245 ,'0.6'  ,'120'     ,0.6  ,120     ,2    UNION ALL	--RM	--RM
SELECT 4246 ,'0.75' ,'150'     ,0.75 ,150     ,2    UNION ALL	--RM	--RM
SELECT 4247 ,'0.75' ,'75'      ,0.75 ,75      ,2    UNION ALL	--RM	--RM
SELECT 4248 ,'0.6'  ,'36'      ,0.6  ,36      ,2    UNION ALL	--RM	--RM
SELECT 4249 ,'0.3'  ,'30'      ,0.3  ,30      ,2    UNION ALL	--RM	--RM
SELECT 4250 ,'0.75' ,'30'      ,0.75 ,30      ,2    UNION ALL	--RM	--RM
SELECT 4251 ,'0.6'  ,'30'      ,0.6  ,30      ,2    UNION ALL	--RM	--RM
SELECT 4252 ,'0.6'  ,'30'      ,0.6  ,30      ,2    UNION ALL	--RM	--RM
SELECT 4253 ,'0.6'  ,'36'      ,0.6  ,36      ,2    UNION ALL	--RM	--RM
SELECT 4254 ,'0.3'  ,'96'      ,0.3  ,96      ,2    UNION ALL	--RM	--RM
SELECT 4256 ,'0.6'  ,'78'      ,0.6  ,78      ,2    UNION ALL	--RM	--RM
SELECT 4257 ,'0.3'  ,'600'     ,0.3  ,600     ,2    UNION ALL	--RM	--RM
--=============================================
--RMB, HK$
SELECT 4244 ,'1.2'  ,'24'      ,1.2  ,24      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4245 ,'1.2'  ,'240'     ,1.2  ,240     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4246 ,'1.5'  ,'300'     ,1.5  ,300     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4247 ,'1.5'  ,'150'     ,1.5  ,150     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4248 ,'1.2'  ,'72'      ,1.2  ,72      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4249 ,'0.6'  ,'42'      ,0.6  ,42      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4250 ,'1.5'  ,'40'      ,1.5  ,40      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4251 ,'1.2'  ,'42'      ,1.2  ,42      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4252 ,'1.2'  ,'42'      ,1.2  ,42      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4253 ,'1.2'  ,'42'      ,1.2  ,42      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4254 ,'0.6'  ,'144'     ,0.6  ,144     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4256 ,'1.2'  ,'96'      ,1.2  ,96      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4257 ,'0.6'  ,'660'     ,0.6  ,660     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4244 ,'1.2'  ,'24'      ,1.2  ,24      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4245 ,'1.2'  ,'240'     ,1.2  ,240     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4246 ,'1.5'  ,'300'     ,1.5  ,300     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4247 ,'1.5'  ,'150'     ,1.5  ,150     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4248 ,'1.2'  ,'72'      ,1.2  ,72      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4249 ,'0.6'  ,'42'      ,0.6  ,42      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4250 ,'1.5'  ,'40'      ,1.5  ,40      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4251 ,'1.2'  ,'42'      ,1.2  ,42      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4252 ,'1.2'  ,'42'      ,1.2  ,42      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4253 ,'1.2'  ,'42'      ,1.2  ,42      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4254 ,'0.6'  ,'144'     ,0.6  ,144     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4256 ,'1.2'  ,'96'      ,1.2  ,96      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4257 ,'0.6'  ,'660'     ,0.6  ,660     ,13   UNION ALL	--RMB	--RMB, HK$
--=============================================
--THB
SELECT 4244 ,'6'    ,'120'     ,6    ,120     ,43   UNION ALL	--THB	--THB
SELECT 4245 ,'6'    ,'1200'    ,6    ,1200    ,43   UNION ALL	--THB	--THB
SELECT 4246 ,'7.5'  ,'1500'    ,7.5  ,1500    ,43   UNION ALL	--THB	--THB
SELECT 4247 ,'7.5'  ,'750'     ,7.5  ,750     ,43   UNION ALL	--THB	--THB
SELECT 4248 ,'6'    ,'360'     ,6    ,360     ,43   UNION ALL	--THB	--THB
SELECT 4249 ,'3'    ,'300'     ,3    ,300     ,43   UNION ALL	--THB	--THB
SELECT 4250 ,'7.5'  ,'300'     ,7.5  ,300     ,43   UNION ALL	--THB	--THB
SELECT 4251 ,'6'    ,'300'     ,6    ,300     ,43   UNION ALL	--THB	--THB
SELECT 4252 ,'6'    ,'300'     ,6    ,300     ,43   UNION ALL	--THB	--THB
SELECT 4253 ,'6'    ,'360'     ,6    ,360     ,43   UNION ALL	--THB	--THB
SELECT 4254 ,'3'    ,'960'     ,3    ,960     ,43   UNION ALL	--THB	--THB
SELECT 4256 ,'6'    ,'780'     ,6    ,780     ,43   UNION ALL	--THB	--THB
SELECT 4257 ,'3'    ,'6000'    ,3    ,6000    ,43   UNION ALL	--THB	--THB
--=============================================
--Won
SELECT 4244 ,'200'  ,'4000'    ,200  ,4000    ,45   UNION ALL	--Won	--Won
SELECT 4245 ,'200'  ,'40000'   ,200  ,40000   ,45   UNION ALL	--Won	--Won
SELECT 4246 ,'250'  ,'50000'   ,250  ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4247 ,'250'  ,'25000'   ,250  ,25000   ,45   UNION ALL	--Won	--Won
SELECT 4248 ,'200'  ,'12000'   ,200  ,12000   ,45   UNION ALL	--Won	--Won
SELECT 4249 ,'100'  ,'7000'    ,100  ,7000    ,45   UNION ALL	--Won	--Won
SELECT 4250 ,'250'  ,'7000'    ,250  ,7000    ,45   UNION ALL	--Won	--Won
SELECT 4251 ,'200'  ,'7000'    ,200  ,7000    ,45   UNION ALL	--Won	--Won
SELECT 4252 ,'200'  ,'7000'    ,200  ,7000    ,45   UNION ALL	--Won	--Won
SELECT 4253 ,'200'  ,'7000'    ,200  ,7000    ,45   UNION ALL	--Won	--Won
SELECT 4254 ,'100'  ,'24000'   ,100  ,24000   ,45   UNION ALL	--Won	--Won
SELECT 4256 ,'200'  ,'16000'   ,200  ,16000   ,45   UNION ALL	--Won	--Won
SELECT 4257 ,'100'  ,'110000'  ,100  ,110000  ,45				--Won	--Won
	
UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999	
	
;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4101)

MERGE StakeLevelGroupDetail as g 
USING STAKE_TEMP s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
WHEN MATCHED THEN UPDATE SET 
					g.MinLabel = s.MinLabel,
					g.MaxLabel = s.MaxLabel,
					g.MinStake =  s.MinStake,
					g.MaxStake =  s.MaxStake
WHEN NOT MATCHED THEN 
					INSERT (StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
					VALUES (s.StakeLevelID,s.GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake)					
					 ;
DROP TABLE #StakeLevel_Temp