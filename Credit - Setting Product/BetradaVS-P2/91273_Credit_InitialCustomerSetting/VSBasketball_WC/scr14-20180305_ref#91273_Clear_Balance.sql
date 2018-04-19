/*
    Created: 20180320@Vicky 
    Task: Clear balance of Virtual sport
    DB: DBTRAN/bodb02
*/ 
USE bodb02
GO

DECLARE @sporttype INT = 180,
        @bettype INT = 1201


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Please make sure no record of VS in table BalancePendingCreditGame before run this step
DELETE FROM BalanceCreditGame WHERE bettype = @bettype
DELETE FROM BalanceDebitGame WHERE bettype = @bettype