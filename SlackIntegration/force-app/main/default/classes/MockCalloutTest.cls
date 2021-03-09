@isTest
global class MockCalloutTest implements HttpCalloutMock {
  global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('https://hooks.slack.com/services/', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('ok');
        res.setStatusCode(200);
        return res;
    }
}