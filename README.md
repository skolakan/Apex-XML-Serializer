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

 - _serialize(objectToSerialize)_  
	    Serializes Apex objects into XML content.
	 
 - _serialize(objectToSerialize,suppressApexObjectNulls,addRootElementName)_  
	    Suppresses null values when serializing Apex objects into XML content and wraps entire content with 'addRootElementName' when supplied and ignores empty objects from serializing.
		   
 - _deSerialize(xmlString, apexType)_  
	    Deserializes the specified XML string into an Apex object of the specified type.
      
 - _deSerialize(xmlString,apexType,deSerializeNodesAsArray)_  
            Deserializes the specified XML string into an Apex object of the specified type and deserializes all elements specified in 'deSerializeNodesAsArray' as array.
       
 - _deSerializeUnTyped(xmlString)_  
	    Deserializes the specified XML string into collection of primitive data types.

 - _deSerializeUnTyped(xmlString,deSerializeNodesAsArray)_  
	    Deserializes the XML string into collection of primitive data types. All node names specified in 'deSerializeNodesAsArray' will be deserialized as arrays.
 
 - _XMLToJSON(xmlString)_  
	    Converts specified XML string into JSON string.
		
 - _XMLToJSON(xmlString,deSerializeNodesAsArray)_  
	    Converts specified XML string into JSON string and converts nodes specified in 'deSerializeNodesAsArray' as arrays.
 
 - _JSONToXML(jsonString)_  
	    Converts specified JSON string to XML.
		
  - _JSONToXML(jsonString,suppressNulls)_  
	    Converts specified JSON string to XML and ignores all empty tags if 'suppressNulls' is true