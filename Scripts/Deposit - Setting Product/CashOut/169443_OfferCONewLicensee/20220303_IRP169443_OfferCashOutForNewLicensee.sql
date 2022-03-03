/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220303@Johnson
	Task: Enable Cash Out for licensees
	DB: DBCust/CustDB
*/
--JiuyouSuperIN (61339784)
declare @p8 varchar(100)
set @p8=''
exec Acc_3rdProductUpdSuperStatus @ProductID=25,@CustID=61339784,@IsEnable=1,@ApplyToMember=1,@UserID=10278938,@IP = '10.3.11.200',@Langkey=default,@ErrMsg=@p8 output
select @p8
GO

--ZFRT132SuperINH (60086232)
declare @p8 varchar(100)
set @p8=''
exec Acc_3rdProductUpdSuperStatus @ProductID=25,@CustID=60086232,@IsEnable=1,@ApplyToMember=1,@UserID=10278938,@IP = '10.3.11.200',@Langkey=default,@ErrMsg=@p8 output
select @p8