/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220315@Elodie
	Task: Enable Cash Out for licensees
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @ErrMsg VARCHAR(100) = '', @CustID INT = 61757440	

EXEC Acc_3rdProductUpdSuperStatus @ProductID=25,@CustID=@CustID,@IsEnable=1,@ApplyToMember=1,@UserID=10278938,@IP = '10.3.11.200',@Langkey=default,@ErrMsg=@ErrMsg OUTPUT

SELECT @ErrMsg