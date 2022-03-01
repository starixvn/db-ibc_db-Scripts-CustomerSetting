/*
	Created by: Eden@20220301
	Task: SET NULLABLE for Some column on custinfo [Redmine:#167898]		
	DB: DBCUST/CustDB
*/
ALTER TABLE custinfo ALTER COLUMN MaxPerBall161 MONEY NULL;
ALTER TABLE custinfo ALTER COLUMN maxpermatch161 MONEY NULL;
ALTER TABLE custinfo ALTER COLUMN MaxPerMatch99MP MONEY NULL;