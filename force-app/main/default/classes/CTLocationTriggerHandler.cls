public with sharing class CTLocationTriggerHandler {
   
    public static void beforeInsert(List<Location__c> newRecords){
       for(Location__c location : newRecords) {
        location.Status__C = 'Green';
       }

    }

    public static void beforeUpdate(List<Location__c> newRecords, Map<Id, Location__c> oldLocationMap){
        for(Location__c location : newRecords) {
      
            if(location.Status__c != oldLocationMap.get(location.Id).Status__c){

                location.Status_Update_Date__c = Date.today();
            }
        }
 
     }

     public static void afterUpdate(List<Location__c> newRecords, Map<Id, Location__c> oldLocationMap){
        Set<Id> locationChange = new Set<Id>();
        for(Location__c location : newRecords) {
      
            if(location.Status__c == 'Red'&& oldLocationMap.get(location.Id).Status__c != 'Red'){

                locationChange.add(location.Id);
            }
        }

        List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationsByLocationIds(locationChange);
        Set<Id> PersonsList = new Set<Id>();
        for(Location_Tracing__c location : locationTraces){
            PersonsList.add(location.Person__c);

        }

        List<Person__C> personsToUpdate = new List<Person__C>();

        for(Id personId : PersonsList){
            personsToUpdate.add(new Person__c(Id=personId, Health_Status__c='Yellow'));

        }

        if(personsToUpdate != null && personsToUpdate.size() >0){

            update personsToUpdate;
        }



 
     }
}