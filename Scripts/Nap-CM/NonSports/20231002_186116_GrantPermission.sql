-------------------------------------------------------------------------------------------------------------
/*<info serverAlias="DBTP-bodb02"></info>*/
/*
     Created:  20231002@Winfred
     Task : In-House
     DB: DBTP-bodb02

     Revisions:
          - 20231002@Winfred: NAP CM Customer Class - Support for Non-Sports [RedmineID: #186116] 
*/
USE bodb02
GO

GRANT ALTER ON [dbo].[CustomerClassNonSports] TO [repl_ap]
GO

GRANT ALTER ON [dbo].[CustomerClassNonSports_UAT] TO [repl_ap]
GO
-------------------------------------------------------------------------------------------------------------