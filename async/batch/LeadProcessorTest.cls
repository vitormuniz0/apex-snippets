@IsTest
public class LeadProcessorTest {
    
    @TestSetup
    private static void setup(){
        List<Lead> leads = new List<Lead>();

        for(Integer i = 0; i < 200; i++) {
            leads.add( new Lead(LastName = 'Test Lead' + i, Company = 'Test Company' + i, LeadSource = 'Web', Status = 'Open'));
        }

        insert leads;
    }

    @isTest private static void test(){

        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();

        System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}