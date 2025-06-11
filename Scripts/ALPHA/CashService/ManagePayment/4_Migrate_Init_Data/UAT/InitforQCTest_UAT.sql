/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Support QC Test [223896]   
	DB: DBCUST-AgencyCashService
*/

Update a set PaymentMethodStatus = 3 , RepUpdateTime = SYSDATETIME()
from [CashPaymentProviderAPIConfig] a WITH (ROWLOCK,UPDLOCK)
WHERE AgentID in (94410950,92503436,236663391) AND PaymentMethodId in (1,2,5)

Update a set PaymentMethodStatus = 2 , RepUpdateTime = SYSDATETIME()
from [CashPaymentProviderAPIConfig] a WITH (ROWLOCK,UPDLOCK)
WHERE AgentID in (94410950,92503436,236663391) AND PaymentMethodId in (4,6)


Update a set PaymentMethodStatus = 4 , RepUpdateTime = SYSDATETIME()
from [CashPaymentProviderAPIConfig] a WITH (ROWLOCK,UPDLOCK)
WHERE AgentID in (94410950,92503436,236663391)  AND PaymentMethodId in (3) 