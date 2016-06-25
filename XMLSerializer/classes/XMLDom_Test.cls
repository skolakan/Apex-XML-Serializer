@isTest
public class XMLDom_Test {

    static String xmlString = '<catalog><books><book><title>Advanced Apex Programming</title><subTitle>for Salesforce.com and Force.com</subTitle><authors><author>Dan Appleman</author></authors><price>39.95</price></book><book><title>Design Patterns</title><authors><author>Erich Gamma</author><author>Richard Helm</author><author>Ralph Johnson</author><author>John Vlissides</author></authors><price>37.88</price></book></books></catalog>';
    //trying to cover the code. As a best practice, use asserts to test the test cases.
    private static testMethod void xmlDomAllMethods_Test(){
        xmldom xd = new xmldom(xmlString);
        xmldom.Element document = xd.ownerDocument();
        List<xmldom.element> elements = xd.getElementsByTagName('book');
        String s = xd.toXmlString();
        xd.dumpAll();
        xd.getElementByTagName('book');
        xmldom.Element bookElement = document.getElementByTagName('book');
        document.removeChild(bookElement);
        document.dump();
		document.getElementsByPath('book/title');
        document.getValue('title');
        document.hasAttributes();
        document.hasChildNodes();
        document.firstChild();
        document.cloneNode();
        document.textContent();
        document.isEqualNode(bookElement);
        document.isSameNode(bookElement);
        document.ownerDocument();
    }
}