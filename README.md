<a href="https://githubsfdeploy.herokuapp.com?owner=skolakan&repo=Apex-XML-Serializer">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

# Apex-XML-Serializer
Serializes and Deserializes an Apex object to XML and vice versa. It also has functionality to convert between XML and Json.

## Usage
Use the methods in the XMLSerializer class to perform round-trip XML serialization and deserialization of Apex objects.

## XMLSerializer Methods
Following are the XMLSerializer methods. 

 -**serialize(objectToSerialize )**   
	    _`Serializes Apex objects into XML content.`_
	 
 -**serialize(objectToSerialize , suppressApexObjectNulls, addRootElementName)**   
	    _`Suppresses null values when serializing Apex objects into XML content and wraps entire content with 'addRootElementName' when supplied and ignores empty objects from serializing.`_
		   
 -**deSerialize(xmlString, apexType)**   
	    _`Deserializes the specified XML string into an Apex object of the specified type.`_
      
 -**deSerialize(xmlString,apexType, deSerializeNodesAsArray)**   
        _`Deserializes the specified XML string into an Apex object of the specified type and deserializes all elements specified in 'deSerializeNodesAsArray' as array.`_
       
 -**deSerializeUnTyped(xmlString)**   
	    _`Deserializes the specified XML string into collection of primitive data types.`_

 -**deSerializeUnTyped(xmlString, deSerializeNodesAsArray)**   
	    _`Deserializes the XML string into collection of primitive data types. All node names specified in 'deSerializeNodesAsArray' will be deserialized as arrays.`_
 
 -**XMLToJSON(xmlString)**   
	    _`Converts specified XML string into JSON string.`_
		
 -**XMLToJSON(xmlString, deSerializeNodesAsArray)**   
	    _`Converts specified XML string into JSON string and converts nodes specified in 'deSerializeNodesAsArray' as arrays.`_
 
 -**JSONToXML(jsonString)**   
	    _`Converts specified JSON string to XML.`_
		
  -**JSONToXML(jsonString, suppressNulls)**    
	    _`Converts specified JSON string to XML and ignores all empty tags if 'suppressNulls' is true.`_

##Usage

Consider the following class, for example:

public class clsLibrary {
    
  public clsCatalog catalog;
    
    public clsLibrary(){
        //populate some data
        //Create a book object
        clsAuthors apexAuthors = new clsAuthors();
        List<String> apexAuthor = new List<String>();
        apexAuthor.add('Dan Appleman');
        apexAuthors.author = apexAuthor;              
        clsBook apexBook = new clsBook('Advanced Apex Programming','for Salesforce.com and Force.com',apexAuthors,null);

        //create another book object
        clsAuthors designPatternsAuthors = new clsAuthors();
        List<String> designPatternsAuthor = new List<String>{'Erich Gamma','Richard Helm','Ralph Johnson','John Vlissides'};
        designPatternsAuthors.author = designPatternsAuthor;
        clsBook designPatternsBook = new clsBook('Design Patterns',null,designPatternsAuthors,37.88);
          
        //add books to collection
        clsBooks books = new clsBooks(new List<clsBook>{apexBook,designPatternsBook});
        //add book collection to catalog 
        clsCatalog oCatalog = new clsCatalog();
        oCatalog.books = books;  
        //add catalog to library
        this.catalog = ocatalog;
    }
    
     public class clsCatalog {
        public clsBooks books;
    }
    public class clsBooks {
        public List<clsBook> book;
        
        public clsBooks(){}
        public clsBooks(List<clsBook> bookList){
            this.book = bookList;
        }
    }
    public class clsBook {
        public String title;
        public String subTitle;
        public clsAuthors authors;
        public decimal price;
        
        public clsBook(){}
        public clsBook(String bookTitle,String bookSubTitle,clsAuthors bookAuthors,decimal bookPrice){
            this.title = bookTitle;
            this.subTitle = bookSubTitle;
            this.authors = bookAuthors;
            this.price = bookPrice;
        }
    }
    
    public class clsAuthors {
        public List<String> author;
    }

}



Roundtrip XML Serialization and Deserialization: 
XMLSerializer serializer = new XMLSerializer();
clsLibrary library = new clsLibrary();

//Serialize Apex object to XML
String serializedXML = serializer.serialize(library,true, null);

//Deserialize XML back to Apex object. Pass any nodes that must be deSerialized as arrays.
clsLibrary deSerializedLibrary = (clsLibrary)serializer.deSerialize(xmlStringAgain,clsLibrary.class,new Set<String>{'author'});

System.debug('Number of books in library:' + library.catalog.books.book.size());
System.debug('Book1 title:' + library.catalog.books.book[0].title);
System.debug('Book2 title:' + library.catalog.books.book[1].title);
System.debug('Serialized XML:' + serializedXML);
System.debug('Number of books in deserialized library:' + deSerializedLibrary.catalog.books.book.size());
System.debug('Deserialized Book1 title:' + deSerializedLibrary.catalog.books.book[0].title);
System.debug('Deserialized Book2 title:' + deSerializedLibrary.catalog.books.book[1].title);
Output:
DEBUG|Number of books in library:2
DEBUG|Book1 title:Advanced Apex Programming
DEBUG|Book2 title:Design Patterns
DEBUG|Serialized XML: (pretty printed for readability)
<catalog>
    <books>
        <book>
            <title>Advanced Apex Programming</title>
            <subTitle>for Salesforce.com and Force.com</subTitle>
            <price/>
            <authors>
                <author>Dan Appleman</author>
            </authors>
        </book>
        <book>
            <title>Design Patterns</title>
            <subTitle/>
            <price>37.88</price>
            <authors>
                <author>Erich Gamma</author>
                <author>Richard Helm</author>
                <author>Ralph Johnson</author>
                <author>John Vlissides</author>
            </authors>
        </book>
    </books>
</catalog>
DEBUG|Number of books in deserialized library:2
DEBUG|Deserialized Book1 title:Advanced Apex Programming
DEBUG|Deserialized Book2 title:Design Patterns



Convert between XML and JSON:


XMLSerializer serializer = new XMLSerializer();
clsLibrary library = new clsLibrary();
//Serialize with options
string serializedXML = serializer.serialize(library,true, null);

//Convert XML to JSON
string jsonString = serializer.XMLToJson(serializedXML);

//Convert JSON to XML
string xmlStringAgain = serializer.JSonToXML(jsonString);

system.debug('Serialized XML:' + serializedXML);
system.debug('JSON from XML:' + jsonString);
system.debug('XML again from JSON:' + xmlStringAgain);


DEBUG|Serialized XML:(pretty printed for readability)
<catalog>
    <books>
        <book>
            <title>Advanced Apex Programming</title>
            <subTitle>for Salesforce.com and Force.com</subTitle>
            <authors>
                <author>Dan Appleman</author>
            </authors>
        </book>
        <book>
            <title>Design Patterns</title>
            <price>37.88</price>
            <authors>
                <author>Erich Gamma</author>
                <author>Richard Helm</author>
                <author>Ralph Johnson</author>
                <author>John Vlissides</author>
            </authors>
        </book>
    </books>
</catalog>


DEBUG|JSON from XML:(pretty printed for readability)

{
   "catalog": {
      "books": {
         "book": [
            {
               "authors": {
                  "author": "Dan Appleman"
               },
               "subTitle": "for Salesforce.com and Force.com",
               "title": "Advanced Apex Programming"
            },
            {
               "authors": {
                  "author": [
                     "Erich Gamma",
                     "Richard Helm",
                     "Ralph Johnson",
                     "John Vlissides"
                  ]
               },
               "price": "37.88",
               "title": "Design Patterns"
            }
         ]
      }
   }
}


DEBUG|XML again from JSON:(pretty printed for readability)

<catalog>
    <books>
        <book>
            <authors>
                <author>Dan Appleman</author>
            </authors>
            <subTitle>for Salesforce.com and Force.com</subTitle>
            <title>Advanced Apex Programming</title>
        </book>
        <book>
            <authors>
                <author>Erich Gamma</author>
                <author>Richard Helm</author>
                <author>Ralph Johnson</author>
                <author>John Vlissides</author>
            </authors>
            <price>37.88</price>
            <title>Design Patterns</title>
        </book>
    </books>
</catalog>

It is as simple as that.
	    
## Limitations
* XML attributes are not supported.

## Areas of interest/Future work
* Ability to replace XML tag names : Often times we need xml tag names in a format that apex would not allow as variable names like one with special characters or reserved words. It would be useful to be able to replace them in the serialization or deserialization process.
