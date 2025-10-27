/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
  Created: 20251027@Eden
  Task: In-House setup by GitHub Copilot
  DB: DBGLOB-GlobCustDB
  
  Revisions:
    - 20251027@Eden: Initial [RedmineID: #242260]
    
*/
-- NONCLUSTERED INDEX for RepUpdateTime
CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_UAT_RepUpdateTime] ON [dbo].[SportBettypeSettingMatrix_UAT] ([RepUpdateTime]);
GO
