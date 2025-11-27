/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
        Created: Tacy@20250818
        Task: OFA Live - Integrate new product - Implement Setting and Initial data [RedmineID: #236233]
        DB: DBTXN-bodb02
*/

USE bodb02
GO

DECLARE @ProductType VARCHAR(20) = 'Live Casino',
                   @ProductID    TINYINT = 113,
                   @Bettype        SMALLINT

SET @Bettype = CASE WHEN @ProductType='RNG Casino' THEN 4001 ELSE 12250 END


IF EXISTS (
        SELECT TOP 1 1
        FROM WinLimit_ProductOffer WITH (NOLOCK)
        WHERE ProductID = @ProductID AND BetType = @Bettype
)
BEGIN
        UPDATE p 
        SET p.IsActive_SMA = 1
        FROM WinLimit_ProductOffer p WITH (ROWLOCK, UPDLOCK)
        WHERE ProductID = @ProductID AND BetType = @Bettype
END
ELSE
BEGIN
        INSERT INTO WinLimit_ProductOffer(ProductID, BetType, IsActive_SMA, IsActive_Company)
        VALUES (@ProductID, @Bettype, 1, 0)
END
