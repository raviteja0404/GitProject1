public with sharing class CTLocationTracingTriggerHandler {
    
    public static void beforeInsert(List<Location_Tracing__c> newRecords){

        List<Location_Tracing__c> duplicates = CTLocationTracingController.checkDuplicates(newRecords);

        for(Location_Tracing__c record : duplicates) {
            record.addError('Duplicate record found. Location ID:'+record.Location__c +'person ID'+record.Person__c );
        
        }
    }
}