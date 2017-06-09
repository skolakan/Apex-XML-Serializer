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

 -**serialize(objectToSerialize)**  
	    _`Serializes Apex objects into XML content.`_
	 
 -**serialize(objectToSerialize,suppressApexObjectNulls,addRootElementName)**  
	    _`Suppresses null values when serializing Apex objects into XML content and wraps entire content with 'addRootElementName' when supplied and ignores empty objects from serializing.`_
		   
 -**deSerialize(xmlString, apexType)**  
	    _`Deserializes the specified XML string into an Apex object of the specified type.`_
      
 -**deSerialize(xmlString,apexType,deSerializeNodesAsArray)**  
        _`Deserializes the specified XML string into an Apex object of the specified type and deserializes all elements specified in 'deSerializeNodesAsArray' as array.`_
       
 -**deSerializeUnTyped(xmlString)**  
	    _`Deserializes the specified XML string into collection of primitive data types.`_

 -**deSerializeUnTyped(xmlString,deSerializeNodesAsArray)**  
	    _`Deserializes the XML string into collection of primitive data types. All node names specified in 'deSerializeNodesAsArray' will be deserialized as arrays.`_
 
 -**XMLToJSON(xmlString)**  
	    _`Converts specified XML string into JSON string.`_
		
 -**XMLToJSON(xmlString,deSerializeNodesAsArray)**  
	    _`Converts specified XML string into JSON string and converts nodes specified in 'deSerializeNodesAsArray' as arrays.`_
 
 -**JSONToXML(jsonString)**  
	    _`Converts specified JSON string to XML.`_
		
  -**JSONToXML(jsonString,suppressNulls)**  
	    _`Converts specified JSON string to XML and ignores all empty tags if 'suppressNulls' is true.`_
	    
## Limitations
* XML attributes are not supported.

## Areas of interest/Future work
* Ability to replace tags : Often times we need xml tags in a format that apex does not allow as variable names like one with special characters or reserved words. It would be useful to be able to replace them in the serialization or deserialization process.
