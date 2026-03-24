@IsTest
public class AccountProcessorTest {
    
    @IsTest
    private static void testCountContacts(){

        Account newAccount = new Account(Name = 'Test Account');
        insert newAccount;

        Contact newContact1 = new Contact(LastName = 'Test Contact1', AccountId = newAccount.Id);
        Contact newContact2 = new Contact(LastName = 'Test Contact2', AccountId = newAccount.Id);

        insert new List<Contact>{newContact1, newContact2};

        List<Id> accountIds = new List<Id>{newAccount.Id};    
        
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        Account updateAcc = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id = :newAccount.Id];

        Assert.areEqual(2, updateAcc.Number_Of_Contacts__c, 'The number of contacts should be 2');
    }
}