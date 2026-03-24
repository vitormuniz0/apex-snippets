public class AddPrimaryContact  implements Queueable{

    private Contact cntt;
    private String uf;

    public AddPrimaryContact(Contact sobj , String uf) {
        this.cntt = (Contact)sobj;
        this.uf = uf;
    }

    public void execute(QueueableContext context){
        List<Account> acts = [SELECT Id FROM Account WHERE BillingState = :uf LIMIT 200];
        List<Contact> contactsToInsert = new List <Contact>();

        for(Account act : acts){
            Contact clonedContact = cntt.clone(false, false, false, false);
            clonedContact.AccountId = act.Id;
            contactsToInsert.add(clonedContact);
        }
        
        if(!contactsToInsert.isEmpty()){
            insert contactsToInsert;   
        }  
    }

}