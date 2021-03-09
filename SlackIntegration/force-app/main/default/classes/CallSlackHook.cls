public with sharing class CallSlackHook {

   @InvocableMethod
     public static void CalloutSlackAPI(List<Contact> c){
     String text = '';
     String template ='\n Hello {0}, This is a Test.\n LastName: {1},\n Email: {2},\n Phone: {3}';
     Contact contact = c[0];
     List<String>elements = new List<String>();
     Map<String,Object>message = new Map<String,Object>();         
         if( contact.LastModifiedDate > contact.CreatedDate ){
             elements = getElementsToSerialize(contact);
             text = String.format(template,elements);
             text+=',\n Status: Record Updated ';
         }else{
             elements = getElementsToSerialize(contact);
             text = String.format(template,elements);
             text+=',\n Status: Record Created ';
         }
          message.put('text',text);
         String body = JSON.serialize(message);
         PostSlack(urlapi__c.getInstance().endpoint__c,body,'POST');
    }
    
    public static List<String>getElementsToSerialize(Contact contact){
        List<String>fields = new List<String>();
        fields.add(contact.FirstName);
        fields.add(contact.LastName);
        fields.add(contact.Email);
        fields.add(contact.Phone);
		return fields;
    }

    @Future(Callout = true)
    public static void PostSlack(String url,String textBody, String method){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
		request.setMethod(method);
	    request.setHeader('Content-Type',' application/json');
        request.setBody(textBody);
		HttpResponse response = http.send(request); 
    }

}