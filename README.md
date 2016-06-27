<a href="https://githubsfdeploy.herokuapp.com?owner=skolakan&repo=Apex-XML-Serializer">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

# Apex-XML-Serializer
Serializes and Deserializes an Apex object to XML and vice versa. It also has functionality to convert between XML and Json.

##Usage
Use the methods in the XMLSerializer class to perform round-trip XML serialization and deserialization of Apex objects.

##XMLSerializer Methods
Following are the XMLSerializer methods. 

 -**`serialize(objectToSerialize)`**  
	    _Serializes Apex objects into XML content._
	 
 -**`serialize(objectToSerialize,suppressApexObjectNulls,addRootElementName)`**  
	    _Suppresses null values when serializing Apex objects into XML content and wraps entire content with 'addRootElementName' when supplied and ignores empty objects from serializing._
		   
 -**`deSerialize(xmlString, apexType)`**  
	    _Deserializes the specified XML string into an Apex object of the specified type._
      
 -**`deSerialize(xmlString,apexType,deSerializeNodesAsArray)`**  
        _Deserializes the specified XML string into an Apex object of the specified type and deserializes all elements specified in 'deSerializeNodesAsArray' as array._
       
 -**`deSerializeUnTyped(xmlString)`**  
	    _Deserializes the specified XML string into collection of primitive data types._

 -**`deSerializeUnTyped(xmlString,deSerializeNodesAsArray)`**  
	    _Deserializes the XML string into collection of primitive data types. All node names specified in 'deSerializeNodesAsArray' will be deserialized as arrays._
 
 -**`XMLToJSON(xmlString)`**  
	    _Converts specified XML string into JSON string._
		
 -**`XMLToJSON(xmlString,deSerializeNodesAsArray)`**  
	    _Converts specified XML string into JSON string and converts nodes specified in 'deSerializeNodesAsArray' as arrays._
 
 -**`JSONToXML(jsonString)`**  
	    _Converts specified JSON string to XML._
		
  -**`JSONToXML(jsonString,suppressNulls)`**  
	    _Converts specified JSON string to XML and ignores all empty tags if 'suppressNulls' is true._