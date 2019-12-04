/*
	Created: Winnie
	Date: 20191203
	Task: Delete existing data of Sporttype=211 bettype 2402 RedmineID:#124422
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
DECLARE @maxcustid INT,@Sporttype SMALLINT,@Bettype INT 
	
SELECT @Sporttype = 211
SELECT @Bettype=2402
SELECT @maxcustid=xxx

DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE SportType=@Sporttype AND Bettype=@Bettype	
DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE SportType=@Sporttype AND Bettype=@Bettype	
DELETE FROM StakeLevel WITH(ROWLOCK)  WHERE GametypeID=@Bettype
DELETE FROM StakeLevelGroupDetail WITH(ROWLOCK) WHERE ParentTypeID=@Bettype		
DELETE FROM CustStakeLevel_Agent WITH(ROWLOCK) WHERE CustID>@maxcustid AND SportType=@Sporttype AND Bettype=@Bettype
DELETE FROM CustStakeLevel_Member WITH(ROWLOCK) WHERE CustID>@maxcustid AND SportType=@Sporttype AND Bettype=@Bettype
