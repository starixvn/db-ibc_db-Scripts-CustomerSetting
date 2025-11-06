/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Johnson@20251110
	Description: Delete existing settings for  new sports on UAT [redmine: #242260]
	DB: DBCust/CustDB	
*/
DECLARE @__delaytime VARCHAR(10)

WHILE (1=1)
BEGIN
	DELETE TOP (1000) CustPTSetting3rd_Agent WITH(ROWLOCK)
	OUTPUT DELETED.CustID, DELETED.SportType, DELETED.BetType, DELETED.IsLive, dbo.f_GetDateTime2()
	INTO CustPTSetting3rd_Agent_Del_InHouse(CustID,SportType,BetType,IsLive,RepUpdateTime)
	WHERE SportType IN (9916,9917)
	AND BetType = 2400

	IF @@ROWCOUNT = 0
		BREAK;

    SELECT @__delaytime = dbo.f_DelayTime('CS_Adhoc')
	WAITFOR DELAY @__delaytime     
END


WHILE (1=1)
BEGIN
	DELETE TOP (1000) CustPTSetting3rd_Member WITH(ROWLOCK)
	OUTPUT DELETED.CustID, DELETED.SportType, DELETED.BetType, DELETED.IsLive, dbo.f_GetDateTime2()
	INTO CustPTSetting3rd_Member_Del_InHouse(CustID,SportType,BetType,IsLive,RepUpdateTime)
	WHERE SportType IN (9916,9917)
	AND BetType = 2400

	IF @@ROWCOUNT = 0
		BREAK;

    SELECT @__delaytime = dbo.f_DelayTime('CS_Adhoc')
	WAITFOR DELAY @__delaytime   
END

DELETE CustPTTemplateDetail WITH(ROWLOCK)
OUTPUT DELETED.TemplateID,DELETED.GroupID,DELETED.SubGroupID,dbo.f_GetDateTime2()
INTO CustPTTemplateDetail_Del_InHouse(TemplateID,GroupID,SubGroupID,RepUpdateTime)
WHERE SubGroupID IN (11,12,13)
	AND GroupID = 3