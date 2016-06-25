@isTest
public class XMLSerializer_Test {
    
    static string xmlString = '<catalog><books><book><title>Advanced Apex Programming</title><subTitle>for Salesforce.com and Force.com</subTitle><authors><author>Dan Appleman</author></authors><price>39.95</price></book><book><title>Design Patterns</title><authors><author>Erich Gamma</author><author>Richard Helm</author><author>Ralph Johnson</author><author>John Vlissides</author></authors><price>37.88</price></book></books></catalog>';
   
    //Serialize test
    private static testMethod void serialize_Test(){
        clsLibrary library = new clsLibrary();
        clsCatalog catalog = new clsCatalog();
        clsBooks books = new clsBooks();
        List<clsBook> book = new List<clsBook>();
        
        clsBook book1 = new clsBook();
        book1.title = 'Advanced Apex Programming';
        clsAuthors apexAuthors = new clsAuthors();
        List<String> apexAuthor = new List<String>();
        apexAuthor.add('Dan Appleman');
        apexAuthors.author = apexAuthor;
        book1.authors = apexauthors;
        book.add(book1);
        books.book = book;
        catalog.books = books;
        library.catalog = catalog;
        
        XmlSerializer serializer = new XmlSerializer();
        String serializedWithDefaultOptions = serializer.serialize(library);
         System.debug('serializedWithDefaultOptions:' +    serializedWithDefaultOptions);
        //properties with no value serialized with default options
        System.assert(serializedWithDefaultOptions.containsIgnoreCase('<subTitle></subTitle>'));
        
        string serializedXMLWithOptions = serializer.serialize(library, true, 'Root');
        //properties without value (null or empty) are omitted with suppressApexObjectNulls setting to true
        System.assert(!serializedXMLWithOptions.containsIgnoreCase('<subTitle></subTitle>'));
        //check that the XML is wrapped with root element
        System.assert(serializedXMLWithOptions.contains('<Root>'));
        System.assert(serializedXMLWithOptions.contains('</Root>'));
        
        System.debug('serializedXMLWithOptions:' +    serializedXMLWithOptions);        
        
    }

    //deSerialize test
    private static testMethod void deSerialize_Test(){
        XmlSerializer serializer = new XmlSerializer();
        clsLibrary library = (clsLibrary)serializer.deSerialize(xmlString, clsLibrary.class,new Set<String>{'author'});  
        
        System.assertEquals(2, library.catalog.books.book.size());
        
        for(clsBook b: library.catalog.books.book){            
            if(b.title == 'Advanced Apex Programming') system.assertEquals(1, b.authors.author.size()); //Make sure author is deSerialized as list even with one element in array
            else system.assertEquals(4, b.authors.author.size());
        }
    }
    
    //deSerializeUntyped test
    private static testMethod void deSerializeUnTyped_Test(){
       XmlSerializer serializer = new XmlSerializer();
       object o = serializer.deSerializeUnTyped(xmlString, new Set<String>{'author'});          
        System.assert(o instanceOf Map<String,Object>);
        Map<String,Object> libraryMap = (Map<string,Object>)o;
        System.assert(libraryMap.containsKey('catalog'));
        serializer.resetDefaults(); //reset to default options
        object xmlToUnTypedObjectDefault = serializer.deSerializeUnTyped(xmlString);
         Map<String,Object> libraryMap1 = (Map<string,Object>)xmlToUnTypedObjectDefault;
        System.assert(libraryMap1.containsKey('catalog'));
        
        object xmlToUnTypedObjectWithOptions = serializer.deSerializeUnTyped(xmlString,new Set<String>{'author'});
         Map<String,Object> libraryMap2 = (Map<string,Object>)xmlToUnTypedObjectWithOptions;
        System.assert(libraryMap2.containsKey('catalog'));        
    }
    
    //XML to Json conversion test
   private static testMethod void XMLToJSonConversion_Test(){
        XmlSerializer serializer = new XmlSerializer();
        String jsonString = serializer.XMLToJSON(xmlString);               
        String expectedOutput = '{"catalog":{"books":{"book":[{"price":"39.95","authors":{"author":"Dan Appleman"},"subTitle":"for Salesforce.com and Force.com","title":"Advanced Apex Programming"},{"price":"37.88","authors":{"author":["Erich Gamma","Richard Helm","Ralph Johnson","John Vlissides"]},"title":"Design Patterns"}]}}}';
        System.assertEquals(expectedOutput, jsonString);
       
       String jsonStringWithConvertAsArray = serializer.XMLToJSON(xmlString,new Set<String>{'author'}); 
       System.debug('jsonStringWithConvertAsArray:' + jsonStringWithConvertAsArray);
       String expectedOutputWithArray ='{"catalog":{"books":{"book":[{"price":"39.95","authors":{"author":["Dan Appleman"]},"subTitle":"for Salesforce.com and Force.com","title":"Advanced Apex Programming"},{"price":"37.88","authors":{"author":["Erich Gamma","Richard Helm","Ralph Johnson","John Vlissides"]},"title":"Design Patterns"}]}}}';
       System.assertNotEquals(expectedOutput, jsonStringWithConvertAsArray);
       System.assertEquals(expectedOutputWithArray, jsonStringWithConvertAsArray);
    }
    
    //Json to XML converion test
    private static testMethod void JsonToXMLConversion_Test(){        
        String jsonString = '{"catalog":{"books":{"book":[{"price":"39.95","authors":{"author":"Dan Appleman"},"subTitle":"for Salesforce.com and Force.com","title":null},{"price":"37.88","authors":{"author":["Erich Gamma","Richard Helm","Ralph Johnson","John Vlissides"]},"title":"Design Patterns"}]}}}';
		XmlSerializer serializer = new XmlSerializer();
        String convertedXmlString = serializer.JSONToXML(jsonString);   

        String expectedOutputWithDefaultOptions = '<catalog><books><book><price>39.95</price><authors><author>Dan Appleman</author></authors><subTitle>for Salesforce.com and Force.com</subTitle><title></title></book><book><price>37.88</price><authors><author>Erich Gamma</author><author>Richard Helm</author><author>Ralph Johnson</author><author>John Vlissides</author></authors><title>Design Patterns</title></book></books></catalog>';
        System.assertEquals(expectedOutputWithDefaultOptions, convertedXmlString);
        
        string convertedStringWithOptions = serializer.JsonToXML(jsonString, true);
        System.debug('convertedStringWithOptions:' + convertedStringWithOptions);
        String expectedOutputWithOptions = '<catalog><books><book><price>39.95</price><authors><author>Dan Appleman</author></authors><subTitle>for Salesforce.com and Force.com</subTitle></book><book><price>37.88</price><authors><author>Erich Gamma</author><author>Richard Helm</author><author>Ralph Johnson</author><author>John Vlissides</author></authors><title>Design Patterns</title></book></books></catalog>';
        System.assertEquals(expectedOutputWithOptions, convertedStringWithOptions);
        
        
    }
     

    
    public class clsLibrary {        
        public clsCatalog catalog;
    }
     public class clsCatalog {
        public clsBooks books;
    }
    public class clsBooks {
        public List<clsBook> book;
    }
    public class clsBook {
        public String title;
        public String subTitle;
        public clsAuthors authors;
        public String price;
    }
    
    public class clsAuthors {
        public List<String> author;
    }

}