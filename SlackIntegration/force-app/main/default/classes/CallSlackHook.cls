public with sharing class CallSlackHook {
    
    /*
     * Team:
     * Rivero Emmanuel
     * Perera Oscar
     * 
     * */

   @InvocableMethod
     public static void calloutslackapi(List<Contact>ContactElements ){
     String text = '';
     String template ='\n Hello {0}, This is a Test.\n LastName: {1},\n Email: {2},\n Phone: {3}';
     String body='';

     List<String>elements = new List<String>();
     Map<String,Object>message = new Map<String,Object>();  
         
         for(Contact contact : ContactElements){
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
         PostSlack(urlapi__c.getInstance().endpoint__c,JSON.serialize(message),'POST');  
         }
    }
    
	@TestVisible
    private static List<String>getelementstoserialize(Contact contact){
        List<String>fields = new List<String>();
        fields.add(contact.FirstName);
        fields.add(contact.LastName);
        fields.add(contact.Email);
        fields.add(contact.Phone);
		return fields;
    }

    @TestVisible
    @Future(Callout = true)
    private static void postslack(String url,String textBody, String method){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
		request.setMethod(method);
	    request.setHeader('Content-Type',' application/json');
        request.setBody(textBody);
        try{
		HttpResponse response = http.send(request); 
        }catch(System.CalloutException e){
            
        }
    }
    
   

}