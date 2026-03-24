@isTest
public class DailyLeadProcessorTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2042';
    
    @TestSetup
    private static void setup(){
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            leads.add( new Lead(LastName = 'Test Lead' + i, Company = 'Test Company' + i, Status = 'Open'));
        }
        insert leads;
    }

    @IsTest 
    static void test(){

        Test.startTest();

        String jobId = System.schedule('DailyLeadProcessor', CRON_EXP, new DailyLeadProcessor());

        CronTrigger cronTrigger = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];

        System.assertEquals(0, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce' LIMIT 200], 'Lead updated before job has run');

        Test.stopTest();

        
        System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce' LIMIT 200], 'Lead updated after job has run, sucessfully');
    }
}