/*
	Created: 20200309@Johnson
	Task: rollback setting for NG [redmine: 30033]
	DB: DBCUST/CUSTDB
*/

--18k rows affects
SELECT cs.*, 0 isUpdate
INTO #CustSetting3rd_History
FROM DBTP.bodb_CustHistory.dbo.CustSetting3rd_History cs (nolock)
	INNER JOIN DBTP.bodb02.dbo.custinfo ci (nolock) on cs.custid = ci.custid
WHERE srecommend = 12300617
	AND sporttype = 161
	AND UpdateTime>= '3/9/2020 1:19:00'

SELECT cs.*
INTO #CustOverride3rd_History
FROM DBTP.bodb_CustHistory.dbo.CustOverride3rd_History cs (nolock)
	INNER JOIN DBTP.bodb02.dbo.custinfo ci (nolock) on cs.custid = ci.custid
WHERE srecommend = 12300617
	AND sporttype = 161
	AND UpdateTime>= '3/9/2020 1:19:00'

DECLARE @tmp TABLE (
	[custid] [int] NOT NULL,
	[bettype] [smallint] NOT NULL,
	[sporttype] [smallint] NOT NULL,
	[apositiontaking] [smallmoney] NOT NULL,
	[mpositiontaking] [smallmoney] NOT NULL,
	[spositiontaking] [smallmoney] NOT NULL,	
	[autopositiontaking] [smallmoney] NOT NULL,
	[isautopositiontaking] [bit] NOT NULL,
	[autompositiontaking] [smallmoney] NOT NULL,
	[isautompositiontaking] [bit] NOT NULL,
	[alivepositiontaking] [smallmoney] NOT NULL,
	[mlivepositiontaking] [smallmoney] NOT NULL,
	[slivepositiontaking] [smallmoney] NOT NULL,
	[autolivepositiontaking] [smallmoney] NOT NULL,
	[isautolivepositiontaking] [bit] NOT NULL,
	[autolivempositiontaking] [smallmoney] NOT NULL,
	[isautolivempositiontaking] [bit] NOT NULL
)

WHILE (1=1)
BEGIN
	UPDATE TOP(1000) t
	SET isUpdate = 1
	OUTPUT DELETED.[custid]
      ,DELETED.[bettype]
      ,DELETED.[sporttype]
      ,DELETED.[apositiontaking]
      ,DELETED.[mpositiontaking]
      ,DELETED.[spositiontaking]     
      ,DELETED.[autopositiontaking]
      ,DELETED.[isautopositiontaking]
      ,DELETED.[autompositiontaking]
      ,DELETED.[isautompositiontaking]
      ,DELETED.[alivepositiontaking]
      ,DELETED.[mlivepositiontaking]
      ,DELETED.[slivepositiontaking]
      ,DELETED.[autolivepositiontaking]
      ,DELETED.[isautolivepositiontaking]
      ,DELETED.[autolivempositiontaking]
      ,DELETED.[isautolivempositiontaking]
	INTO @tmp([custid]
      ,[bettype]
      ,[sporttype]
      ,[apositiontaking]
      ,[mpositiontaking]
      ,[spositiontaking]     
      ,[autopositiontaking]
      ,[isautopositiontaking]
      ,[autompositiontaking]
      ,[isautompositiontaking]
      ,[alivepositiontaking]
      ,[mlivepositiontaking]
      ,[slivepositiontaking]
      ,[autolivepositiontaking]
      ,[isautolivepositiontaking]
      ,[autolivempositiontaking]
      ,[isautolivempositiontaking]	
	)  
	FROM #CustSetting3rd_History t
	WHERE isUpdate = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	UPDATE cs
	SET cs.[apositiontaking] = t.apositiontaking
      ,cs.[mpositiontaking] = t.mpositiontaking
      ,cs.[spositiontaking] = t.spositiontaking     
      ,cs.[autopositiontaking] = t.autopositiontaking
      ,cs.[isautopositiontaking] = t.isautopositiontaking
      ,cs.[autompositiontaking] = t.autompositiontaking
      ,cs.[isautompositiontaking] = t.isautompositiontaking
      ,cs.[alivepositiontaking] = t.alivepositiontaking
      ,cs.[mlivepositiontaking] = t.mlivepositiontaking
      ,cs.[slivepositiontaking] = t.slivepositiontaking
      ,cs.[autolivepositiontaking] = t.autolivepositiontaking
      ,cs.[isautolivepositiontaking] = t.isautolivepositiontaking
      ,cs.[autolivempositiontaking] = t.autolivempositiontaking
      ,cs.[isautolivempositiontaking] = t.isautolivempositiontaking
	FROM CustSetting3rd cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmp t ON cs.custid = t.custid 
							AND cs.sporttype = t.sporttype
							AND cs.bettype = t.bettype
	
	DELETE @tmp
	
	WAITFOR DELAY '0:0:1'
END	

UPDATE cs
SET cs.[minpositiontaking] = t.minpositiontaking
  ,cs.[maxpositiontaking] = t.maxpositiontaking
  ,cs.[minlivepositiontaking] = t.minlivepositiontaking
  ,cs.[maxlivepositiontaking] = t.maxlivepositiontaking
FROM custOverride3rd cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #custOverride3rd_history t ON cs.custid = t.custid 
							AND cs.sporttype = t.sporttype
							AND cs.bettype = t.bettype
	
	