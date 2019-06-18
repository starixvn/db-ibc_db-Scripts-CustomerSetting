/*
	Created: Winnie
	Date: 20190617
	Task: Delete existing data of Sporttype=165. Insert Cardclub RedmineID:#107643
	DB: DBTXN/bodb02
*/
 
DELETE FROM RefResource WHERE ResourceId='165' AND RefId='PG_GT'

INSERT INTO RefResource(RefId,ResourceId,Resource_en)
SELECT 'PG_GT','165','Card Club'