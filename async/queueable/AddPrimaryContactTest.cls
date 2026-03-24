@isTest
public class AddPrimaryContactTest {
    @TestSetup
    static void setup(){
        List<Account> acts = new List<Account>();
        for(Integer i = 0; i < 50; i++){
            acts.add(new Account(Name = 'Test Account' + i, BillingState = 'New York', BillingCity = 'New York', BillingCountry = 'United States'));
        }

        for(Integer i = 0; i < 50; i++){
            acts.add(new Account(Name = 'Test Account' + i, BillingState = 'California', BillingCity = 'San Francisco', BillingCountry = 'United States'));
        }

        insert acts;

        Contact con = new Contact(LastName = 'Test Contact');
        insert con;       
    }

    @isTest
    static void testQueueable(){
        Contact con = [SELECT Id , LastName FROM Contact LIMIT 1];
        String state = 'California';
        
        AddPrimaryContact updater = new AddPrimaryContact(con, state);

        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();

        System.assertEquals(50, [SELECT count() FROM Contact WHERE Account.BillingState =: state], 
        'Deveria haver 50 contatos inseridos para o estado de CA');
   }

}