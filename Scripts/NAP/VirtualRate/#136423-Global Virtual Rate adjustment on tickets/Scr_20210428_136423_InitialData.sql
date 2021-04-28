/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210428@Eden
	Task: Initial data for VRSettingRule, VRSettingRuleDetail, VRSettingRuleDetail_NotApply base on exsting Rule on place bet SPs [RM#136423]
	DB: DBCUST/CustDB
*/
--TRUNCATE TABLE VRSettingRuleDetail_NotApply
--TRUNCATE TABLE VRSettingRuleDetail
--TRUNCATE TABLE VRSettingRule 
DECLARE @ID INT
--> Rule 1
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	1 as SiteType --credit
	,'p' AS Betfrom
	,0 AS StakeRM_From
	,80 AS StakeRM_To
	,0 AS VR_From
	,0 AS VR_To
	,2 AS VRStatus --All
	,'' AS BeginTime
	,'' AS EndTime
	,2 as LiveIndicator
	,1 AS Adjustmenttype --fixed value
	,1.00 AS AdjustmentValue
	,1
	,'Low Stake for Soccer, credit, phone betting: 0%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,1 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID


INSERT INTO VRSettingRuleDetail_NotApply(
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,329 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

--------------------------------------
--> Rule 2
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	1 as SiteType --credit
	,'' AS Betfrom
	,0 AS StakeRM_From
	,80 AS StakeRM_To
	,0 AS VR_From
	,0 AS VR_To
	,2 AS VRStatus --All
	,'' AS BeginTime
	,'' AS EndTime
	,2 as LiveIndicator
	,1 AS Adjustmenttype --fixed value
	,1.00 AS AdjustmentValue
	,2
	,'Low Stake for Soccer, credit, class 8,9,10: 0%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,1 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,8 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,1 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,9 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,1 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,10 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

INSERT INTO VRSettingRuleDetail_NotApply(
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,329 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

--------------------------------------
--> Rule 3
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	1 as SiteType --credit
	,'' AS Betfrom
	,0 AS StakeRM_From
	,80 AS StakeRM_To
	,0 AS VR_From
	,0 AS VR_To
	,2 AS VRStatus --All
	,'' AS BeginTime
	,'' AS EndTime
	,2 as LiveIndicator
	,1 AS Adjustmenttype --fixed value
	,0.01 AS AdjustmentValue
	,3
	,'Low Stake for Soccer, credit: -99%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,1 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

INSERT INTO VRSettingRuleDetail_NotApply(
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,329 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
--UNION ALL
--SELECT @ID as RuleID
--	,0 as Sporttype
--	,0 as Bettype
--	,0 as SiteID
--	,8 as CustomerClass
--	,0 as DateOfWeek
--	,0 as LeagueGroupID
--	,0 as LeagueID
--UNION ALL
--SELECT @ID as RuleID
--	,0 as Sporttype
--	,0 as Bettype
--	,0 as SiteID
--	,9 as CustomerClass
--	,0 as DateOfWeek
--	,0 as LeagueGroupID
--	,0 as LeagueID
--UNION ALL
--SELECT @ID as RuleID
--	,0 as Sporttype
--	,0 as Bettype
--	,0 as SiteID
--	,10 as CustomerClass
--	,0 as DateOfWeek
--	,0 as LeagueGroupID
--	,0 as LeagueID
--select @ID
--select * from [VRSettingRule]

--------------------------------------
--> Rule 4
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	0 as SiteType --All
	,'' AS Betfrom
	,0 AS StakeRM_From
	,499.9999 AS StakeRM_To
	,0 AS VR_From
	,0.99 AS VR_To
	,1 AS VRStatus --Enabled
	,'' AS BeginTime
	,'' AS EndTime
	,2 as LiveIndicator
	,1 AS Adjustmenttype --fixed value
	,0.01 AS AdjustmentValue
	,4
	,'Low Stake for Soccer, credit&Licensee: -99%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,1 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

INSERT INTO VRSettingRuleDetail_NotApply(
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,329 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

--------------------------------------
--> Rule 5
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	1 as SiteType --Credit
	,'' AS Betfrom
	,0 AS StakeRM_From
	,199.9999 AS StakeRM_To
	,0 AS VR_From
	,0.99 AS VR_To
	,1 AS VRStatus --Enabled
	,'' AS BeginTime
	,'' AS EndTime
	,2 as LiveIndicator
	,1 AS Adjustmenttype --fixed value
	,0.01 AS AdjustmentValue
	,5
	,'Low Stake for Basketball, credit: -99%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,2 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

INSERT INTO VRSettingRuleDetail_NotApply(
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,329 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

--------------------------------------
--> Rule 6
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	2 as SiteType --Licensee
	,'' AS Betfrom
	,0 AS StakeRM_From
	,99.9999 AS StakeRM_To
	,0 AS VR_From
	,0.99 AS VR_To
	,1 AS VRStatus --Enabled
	,'' AS BeginTime
	,'' AS EndTime
	,2 as LiveIndicator
	,1 AS Adjustmenttype --fixed value
	,0.01 AS AdjustmentValue
	,6
	,'Low Stake for Basketball, Haifa, IBM, Mansion88: -99%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,2 as Sporttype
	,0 as Bettype
	,44 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,2 as Sporttype
	,0 as Bettype
	,165 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,2 as Sporttype
	,0 as Bettype
	,34 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
--------------------------------------
--> Rule 7
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	2 as SiteType --Licensee
	,'' AS Betfrom
	,0 AS StakeRM_From
	,399.9999 AS StakeRM_To
	,0 AS VR_From
	,0.99 AS VR_To
	,1 AS VRStatus --Enabled
	,'' AS BeginTime
	,'' AS EndTime
	,2 as LiveIndicator
	,1 AS Adjustmenttype --fixed value
	,0.01 AS AdjustmentValue
	,7
	,'Low Stake for Basketball, Other Licensees: -99%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,2 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

INSERT INTO VRSettingRuleDetail_NotApply(
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,44 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,165 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,34 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,329 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
--------------------------------------
--> Rule 8
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	2 as SiteType --All
	,'' AS Betfrom
	,0 AS StakeRM_From
	,0 AS StakeRM_To
	,0 AS VR_From
	,0.99 AS VR_To
	,1 AS VRStatus --Enabled
	,'06:00' AS BeginTime
	,'20:00' AS EndTime
	,1 as LiveIndicator --Live
	,2 AS Adjustmenttype --fixed value
	,-0.03 AS AdjustmentValue
	,8
	,'By Hour Soccer, all days: VR -3%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,1 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

INSERT INTO VRSettingRuleDetail_NotApply(
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,329 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
--------------------------------------
--> Rule 9
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	2 as SiteType --All
	,'' AS Betfrom
	,0 AS StakeRM_From
	,0 AS StakeRM_To
	,0 AS VR_From
	,0.99 AS VR_To
	,1 AS VRStatus --Enabled
	,'20:00' AS BeginTime
	,'00:00' AS EndTime
	,1 as LiveIndicator --Live
	,2 AS Adjustmenttype --fixed value
	,-0.02 AS AdjustmentValue
	,9
	,'By Hour Soccer, Week days, >= 20:00 (GMT-4): VR -2%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,1 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

INSERT INTO VRSettingRuleDetail_NotApply(
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,329 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,1 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,7 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

--------------------------------------
--> Rule 9
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	2 as SiteType --All
	,'' AS Betfrom
	,0 AS StakeRM_From
	,0 AS StakeRM_To
	,0 AS VR_From
	,0.99 AS VR_To
	,1 AS VRStatus --Enabled
	,'00:00' AS BeginTime
	,'01:00' AS EndTime
	,1 as LiveIndicator --Live
	,2 AS Adjustmenttype --fixed value
	,-0.02 AS AdjustmentValue
	,10
	,'By Hour Soccer, Week days, 00:00 to 01:00 AM (GMT-4): VR -2%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,1 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

INSERT INTO VRSettingRuleDetail_NotApply(
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,329 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,1 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
UNION ALL
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,7 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

--------------------------------------
--> Rule 10
INSERT INTO [VRSettingRule](
	 SiteType
	,Betfrom
	,StakeRM_From
	,StakeRM_To
	,VR_From
	,VR_To
	,VRStatus
	,BeginTime
	,EndTime
	,LiveIndicator
	,Adjustmenttype
	,AdjustmentValue
	,Priority
	,RuleName
	,Status
)
SELECT 	2 as SiteType --All
	,'' AS Betfrom
	,0 AS StakeRM_From
	,0 AS StakeRM_To
	,0 AS VR_From
	,0.99 AS VR_To
	,1 AS VRStatus --Enabled
	,'01:00' AS BeginTime
	,'06:00' AS EndTime
	,1 as LiveIndicator --Live
	,2 AS Adjustmenttype --fixed value
	,0.03 AS AdjustmentValue
	,10
	,'By Hour Soccer, 01:00 to 06:00 AM (GMT-4): VR +3%'
	,1

SELECT @ID = SCOPE_IDENTITY()

INSERT INTO [VRSettingRuleDetail](
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,1 as Sporttype
	,0 as Bettype
	,0 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID

INSERT INTO VRSettingRuleDetail_NotApply(
	 RuleID
	,Sporttype
	,Bettype
	,SiteID
	,CustomerClass
	,DateOfWeek
	,LeagueGroupID
	,LeagueID
)
SELECT @ID as RuleID
	,0 as Sporttype
	,0 as Bettype
	,329 as SiteID
	,0 as CustomerClass
	,0 as DateOfWeek
	,0 as LeagueGroupID
	,0 as LeagueID
--UNION ALL
--SELECT @ID as RuleID
--	,0 as Sporttype
--	,0 as Bettype
--	,0 as SiteID
--	,0 as CustomerClass
--	,6 as DateOfWeek
--	,0 as LeagueGroupID
--	,0 as LeagueID
--UNION ALL
--SELECT @ID as RuleID
--	,0 as Sporttype
--	,0 as Bettype
--	,0 as SiteID
--	,0 as CustomerClass
--	,7 as DateOfWeek
--	,0 as LeagueGroupID
--	,0 as LeagueID
-----------------------Return Data-------------------
--Update Priority = Priority * 10
UPDATE [VRSettingRule] WITH(ROWLOCK)
SET Priority = Priority * 10

/*
SELECT r.*,'---------' as '---------' ,rd.*
FROM [VRSettingRule] r WITH(NOLOCK)
INNER JOIN [VRSettingRuleDetail] rd WITH(NOLOCK)
	ON r.ruleid = rd.ruleid
ORDER BY r.Priority

select * from VRSettingRuleDetail_NotApply

*/