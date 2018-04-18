/*
    Created: 20180320@Vicky 
    Task: check if there is any balance of Virtual sport need to process
    DB: DBTRAN/bodb02
*/ 
USE bodb02
GO

DECLARE @sporttype INT = 180,
        @bettype INT = 1201


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT TOP(1) * FROM BalancePendingCreditGame WHERE bettype = @bettype
---DO NOT run the NEXT step until no Balance of Virtual Sport need to process