/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
    Created: 20250702@Tacy
    Task: Initial data for Lrf_Action and Lrf_SubType [#226373]
    DB: DBLOG-bodb_CustomerLog

    Tables:
        Lrf_ActionType
        Lrf_SubType
*/
USE bodb_CustomerLog
GO

-- Init data for Lrf_ActionType
INSERT INTO dbo.Lrf_ActionType (ActionTypeID, ActionName)
VALUES (1, 'click'),
       (2, 'switch'),
       (3, 'input'),
       (4, 'submit'),
       (5, 'change'),
       (6, 'toggle'),
       (7, 'paginatio'),
       (8, 'open_page'),
       (9, 'open_module');
GO

-- Init data for Lrf_SubType
INSERT INTO dbo.Lrf_SubType (SubTypeID, SubType)
VALUES (1,  'butto'),
       (2,  'ico'),
       (3,  'link'),
       (4,  'select'),
       (5,  'label'),
       (6,  'checkbox'),
       (7,  'radio'),
       (8,  'suggestio'),
       (9,  'tab'),
       (10, 'chart'),
       (11, 'textbox'),
       (12, 'form'),
       (13, 'table'),
       (14, 'page'),
       (15, 'module');
GO 