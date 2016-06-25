<a href="https://githubsfdeploy.herokuapp.com?owner=skolakan&repo=Apex-XML-Serializer">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

# Apex-XML-Serializer
Serializes and Deserializes an Apex object to XML and vice versa. It also has functionality to convert between XML and Json.

##Usage
Use the methods in the XMLSerializer class to perform round-trip XML serialization and deserialization of Apex objects.

##XMLSerializer Methods
The following are methods for XMLSerializer. 

 - serialize(objectToSerialize)
 	    Serializes Apex objects into XML content.
	 
 - serialize(objectToSerialize,suppressApexObjectNulls,addRootElementName)
		Suppresses null values when serializing Apex objects into XML content and wraps entire content with 'addRootElementName' when supplied and ignores empty objects from serializing.
		   
 - deSerialize(xmlString, apexType)
		Deserializes the specified XML string into an Apex object of the specified type.
      
 - deSerialize(xmlString,apexType,deSerializeNodesAsArray)
        Deserializes the specified XML string into an Apex object of the specified type and deserializes all elements specified in 'deSerializeNodesAsArray' as array.
       
 - deSerializeUnTyped(xmlString)
		Deserializes the specified XML string into collection of primitive data types.
 - deSerializeUnTyped(xmlString,deSerializeNodesAsArray)
		Deserializes the XML string into collection of primitive data types. All node names specified in 'deSerializeNodesAsArray' will be deserialized as arrays.
 
 - XMLToJSON(xmlString)
		Converts specified XML string into JSON string.
		
 - XMLToJSON(xmlString,deSerializeNodesAsArray)
		Converts specified XML string into JSON string and converts nodes specified in 'deSerializeNodesAsArray' as arrays.
 
 - JSONToXML(jsonString)
		Converts specified JSON string to XML.
		
  - JSONToXML(jsonString,suppressNulls)
		Converts specified JSON string to XML and ignores all empty tags if 'suppressNulls' is true

