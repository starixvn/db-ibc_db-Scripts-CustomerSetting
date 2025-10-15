/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20251015@Dave
	Task: Database - bodb02 : Game : Task_BalanceUpd enhance - [Redmine: #241703]
	DB: DBPRO-bodb02
*/
USE bodb02;
GO

UPDATE sbm
SET sbm.ExtraInfo = JSON_MODIFY(ISNULL(sbm.ExtraInfo, '{}'), '$.IsSMAwlExcluded', 1)
FROM SportBettypeMatrix sbm WITH(ROWLOCK, UPDLOCK)
WHERE sbm.Bettype IN (2199,2399,2499,2999,4298,3150,8695,7698,11295,3897,11399,15199,11999,13995,15899);


SELECT sbm.BetType, sbm.ExtraInfo, JSON_VALUE(sbm.ExtraInfo, '$.IsSMAwlExcluded') AS IsSMAwlExcluded
FROM SportBettypeMatrix sbm WITH(ROWLOCK, UPDLOCK)
WHERE sbm.Bettype IN (2199,2399,2499,2999,4298,3150,8695,7698,11295,3897,11399,15199,11999,13995,15899);
