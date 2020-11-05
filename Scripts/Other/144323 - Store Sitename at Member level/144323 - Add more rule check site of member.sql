/*<info serverAlias="DBCHECK-CheckResultDB" executers="" viewers="" isFunction="0"></info>*/
GO
/*
	Created: 20201104@Tin
	Task: check site of member difference with site of Agent [Redmine: #143077] 
	DB: DBCHECK.CheckResultDB
*/

USE [CheckResultDB]
GO

INSERT INTO Rule_Credit(RuleId, RuleName)
SELECT 426 RuleId, 'Member level: member.site <> agent.site' RuleName
WHERE NOT EXISTS (SELECT 1 FROM Rule_Credit WITH (NOLOCK) WHERE RuleId = 426)