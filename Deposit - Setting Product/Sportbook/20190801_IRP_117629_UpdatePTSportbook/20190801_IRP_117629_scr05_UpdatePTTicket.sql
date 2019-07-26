/*
	Created: Elodie
	Task: Update PT settings of SB for licensees [RedmineID: #110111]
	DB: DBTXN/bodb02
	Date: 20190313
*/ 
USE bodb02
GO

ALTER PROCEDURE [dbo].Acc_ExecRep_09
	@TransIdList VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @IsExistBettrans BIT, @TransIdXML XML
	
	SELECT @IsExistBettrans = COUNT(1) FROM dbo.sysobjects WHERE name = 'bettrans'
	SELECT @TransIdXML = @TransIdList

	SELECT	r.value('./@T','BIGINT') AS TransId,
			r.value('./@PT','SMALLMONEY') AS PT
	INTO #tmpList
	FROM @TransIdXML.nodes('//R/C') AS RECORDS(r)

	IF @IsExistBettrans = 1
	BEGIN
		UPDATE b
		SET b.apositiontaking = t.PT,
			b.tpositiontaking = t.PT
		FROM bettrans b WITH(ROWLOCK)
			INNER JOIN #tmpList t ON b.transid=t.TransId	
	END
END	

