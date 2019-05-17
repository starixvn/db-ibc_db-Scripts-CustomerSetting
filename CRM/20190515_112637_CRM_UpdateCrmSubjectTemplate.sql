/*
	Created: 20190515@Winnie
	Task: Update crmSubjectTemplate RedmineID:#112637
	DB: DBCRM/bodb_crm
*/

UPDATE crmSubjectTemplate SET SiteOffer=2
GO

INSERT INTO crmSubjectTemplate(subject,IsActive,SiteOffer)
SELECT subject,IsActive,1
FROM crmSubjectTemplate WHERE SiteOffer=2
