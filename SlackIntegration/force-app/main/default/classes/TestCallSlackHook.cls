@isTest
public class TestCallSlackHook {
      @TestSetup
    public static void prepareData(){
        urlapi__c customSettings = new urlapi__c();
        customSettings.endpoint__c = 'https://hooks.slack.com/services/';
        insert customSettings;
    }
       @isTest
    public static void TestCalloutSlackAPItoInsert(){
        Test.setMock(HttpCalloutMock.class, new MockCalloutTest());
        Test.startTest();
        List<Contact>contactList = new List<Contact>();
        Contact contact = new Contact(FirstName='NameTest',LastName='LastNameTest',Phone='111',Email = 'test@gmail.com');
        insert contact;
        contactList.add(contact);
        CallSlackHook.CalloutSlackAPI(contactList);
        Test.stopTest();
    }
    
        @isTest
    public static void TestCalloutSlackAPItoUpdate(){
        Test.setMock(HttpCalloutMock.class, new MockCalloutTest());
        Contact contact = new Contact(FirstName='NameTest',LastName='LastNameTest',Phone='111',Email = 'test@gmail.com');
        insert contact;
        Datetime DateBefore = Datetime.now().addDays(-1);
		Test.setCreatedDate(contact.Id, DateBefore);
        Test.startTest();
        List<Contact>contactList = [select id, FirstName, LastName,Phone,Email,LastModifiedDate,CreatedDate from Contact where id =: contact.id];
        contactList[0].FirstName = 'UpdatedNameTest';
        update contactList;
        CallSlackHook.CalloutSlackAPI(contactList);
        Test.stopTest();
    }

}