trigger OpportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    //testing
    // git testing
    if (Trigger.isInsert && Trigger.isAfter) {
        // Insert logic
   Set<Id> accountIds = new Set<Id>();

        for (Opportunity opportunity : Trigger.new) {
            accountIds.add(opportunity.AccountId);
        }

        List<Account> accountsToUpdate = [SELECT Id, (SELECT Amount FROM Opportunities) 
                                          FROM Account WHERE Id IN :accountIds];

        for (Account account : accountsToUpdate) {
            Decimal totalAmount = 0;

            for (Opportunity opportunity : account.Opportunities) {
                totalAmount += opportunity.Amount != null ? opportunity.Amount : 0;
                // In this example, if opportunity.Amount is not null, totalAmount will be 
                // increased by the value of opportunity.Amount. 
                // If opportunity.Amount is null, it will not affect totalAmount (adding 0).
            }

            account.Sum_of_Amount__c = totalAmount;
        }

        update accountsToUpdate;
    }
    
    
    if (Trigger.isUpdate && Trigger.isAfter) {
        Set<Id> accountIds = new Set<Id>();
        
        for (Opportunity opp : Trigger.new) {
            Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
            if (opp.Amount != oldOpp.Amount) {
                accountIds.add(opp.AccountId);
            }
        }
        
        List<Account> accountsToUpdate = [SELECT Id, (SELECT Amount FROM Opportunities) 
                                          FROM Account WHERE Id IN :accountIds];
        
        for (Account account : accountsToUpdate) {
            Decimal totalAmount = 0;
            
            for (Opportunity opportunity : account.Opportunities) {
                totalAmount += opportunity.Amount != null ? opportunity.Amount : 0;
            }
            
            account.Sum_of_Amount__c = totalAmount;
        }
        
        update accountsToUpdate;
    }
    
    if (Trigger.isDelete && Trigger.isAfter) {
        // Delete logic (similar to insert/update logic)
   Set<Id> accountIds = new Set<Id>();

        for (Opportunity opportunity : Trigger.old) {
            accountIds.add(opportunity.AccountId);
        }

        List<Account> accountsToUpdate = [SELECT Id, (SELECT Amount FROM Opportunities) 
                                          FROM Account WHERE Id IN :accountIds];

        for (Account account : accountsToUpdate) {
            Decimal totalAmount = 0;

            for (Opportunity opportunity : account.Opportunities) {
                totalAmount += opportunity.Amount != null ? opportunity.Amount : 0;
                // In this example, if opportunity.Amount is not null, totalAmount will be 
                // increased by the value of opportunity.Amount. 
                // If opportunity.Amount is null, it will not affect totalAmount (adding 0).
            }

            account.Sum_of_Amount__c = totalAmount;
        }

        update accountsToUpdate;
    }
    
    
    if (Trigger.isUndelete && Trigger.isAfter) {
        // Undelete logic (similar to insert/update logic)
   Set<Id> accountIds = new Set<Id>();

        for (Opportunity opportunity : Trigger.new) {
            accountIds.add(opportunity.AccountId);
        }
        
        List<Account> accountsToUpdate = [SELECT Id, (SELECT Amount FROM Opportunities) 
                                          FROM Account WHERE Id IN :accountIds];

        for (Account account : accountsToUpdate) {
            Decimal totalAmount = 0;

            for (Opportunity opportunity : account.Opportunities) {
                totalAmount += opportunity.Amount != null ? opportunity.Amount : 0;
                // In this example, if opportunity.Amount is not null, totalAmount will be 
                // increased by the value of opportunity.Amount. 
                // If opportunity.Amount is null, it will not affect totalAmount (adding 0).
            }

            account.Sum_of_Amount__c = totalAmount;
        }

        update accountsToUpdate;
    }
    
}