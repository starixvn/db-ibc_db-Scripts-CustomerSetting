/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230828@Helios
	Task: Inital Data Setting SportBettypeSettingMatrix in Replicate in house  [#189389] 
	DB: DBCUST-CustDB
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	UPDATE
		tmp SET
			tmp.ProductID = ps.ProductID
		,	RepUpdateTime	  = SYSDATETIME ()

	FROM SportBettypeSettingMatrix tmp WITH (ROWLOCK , UPDLOCK)
	LEFT JOIN ProductSettingDetail ps WITH (NOLOCK) ON tmp.RealProductId = ps.RealProductId
	WHERE ps.ProductID <> ISNULL(tmp.ProductID ,0)
			AND ps.SettingStatus <=1	UPDATE t		SET			ProductID = RealProductId		,	RepUpdateTime	  = SYSDATETIME ()	FROM SportBettypeSettingMatrix t WITH (ROWLOCK , UPDLOCK)	WHERE RealProductId IN (2,30,4,33,26) OR (RealProductId = 1 and SportType NOT IN (43,44))		UPDATE t		SET 			ProductID =  ps.ProductID		,	RepUpdateTime	  = SYSDATETIME ()		FROM SportBettypeSettingMatrix t WITH (ROWLOCK , UPDLOCK)	INNER JOIN ProductSettingDetail ps WITH (NOLOCK) ON t.SportType = ps.SportType	WHERE (t.RealProductId IN (34,75,60,55,56,61,62,67,68,73,72,32,36,22)		OR (ps.RealProductId = 16 and ps.SportType IN (43,44)))		AND ps.SettingStatus <= 1	UPDATE t		SET 			ProductID =  5		,	RepUpdateTime	  = SYSDATETIME ()	FROM SportBettypeSettingMatrix t WITH (ROWLOCK , UPDLOCK)	WHERE t.RealProductId IN (27)