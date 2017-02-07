/*
Copyright (c) 2016 Sreenivasulu Kolakanuru
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, 
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/**
@Description: Contains methods for serializing Apex objects into XML format and deserializing XML to Apex object.
@Author     : Sreenivasulu Kolakanuru (sreek.sf@gmail.com)
**/
public class XMLSerializer{
    
    //Private Members
    private Boolean serializeNulls = true;  							// Serializes XML nodes even if the content is null
    private String rootElement;              							// Root element to wrap around the serialized string.
    private Set<String> deSerializeAsArrayNodes = new Set<String>();	// Collection of node names to be deserialize as array.
    
    /*
@Description    : Serializes the object passed to XML string
@Parameter      : objectToSerialize = Apex object to serialize into XML
@Returns        : XML String
*/
    public String serialize(Object objectToSerialize){        
        object deSerialized = JSON.deserializeUntyped(JSON.serialize(objectToSerialize));               
        return !String.isEmpty(RootElement) ? Wrap(RootElement,serialize((Map<String,Object>)deSerialized)) : serialize((Map<String,Object>)deSerialized);     
    }
    
    /*
@Description    : Serializes the object to XML string.
@Parameter      : objectToSerialize = Apex object to serialize into XML
@Parameter      : suppressApexObjectNulls = if true, it will not serialize empty elements to XML.
@Parameter	: Name of the root element to wrap serialized string with.
@Returns        : XML String
*/
    public String serialize(object objectToSerialize,boolean suppressApexObjectNulls,String addRootElementName){
        this.SerializeNulls = !suppressApexObjectNulls;
        this.RootElement = addRootElementName;
        return serialize(objectToSerialize);
    }
    
    /*
@Description    : Converts JSON string to XML String.
@Parameter      : jsonString = jsonString
@Returns        : XML String
*/
    public String jsonToXML(String jsonString){
        object deSerialized = JSON.deserializeUntyped(jsonString);               
        return !String.isEmpty(RootElement) ? Wrap(RootElement,serialize((Map<String,Object>)deSerialized)) : serialize((Map<String,Object>)deSerialized);
    }
    
    /*
@Description    : Converts JSON string to XML String.
@Parameter      : jsonString = jsonString
@Parameter	: suppressNulls = ignores empty Json elements, if true
@Returns        : XML String
*/
    public String jsonToXML(String jsonString,boolean suppressNulls){
        this.SerializeNulls = !suppressNulls;       
        return JsonToXML(jsonString);
    }
    
    /*
@Description    : deSerializes the xml into the object of apextype
@Parameter      : xmlString = xml String to deSerialize
@Parameter      : apexType  = type of object to deSerialize to
@Returns        : object of type apexType
*/
    public Object deSerialize(String xmlString, System.Type apexType){   
        String json = XMLToJson(xmlString); 
        return System.JSON.deserialize(json,apexType);  		
    }
    
    /*
@Description    : deSerializes the xml into the object of the type passed
@Parameter      : xmlString = xml String to deSerialize
@Parameter      : apexType  = type of object to deSerialize to
@Parameter      : deSerializeNodesAsArray  = collection of node names to deserialize as array (Even if xml representation is not an array)
@Returns        : object of type apexType
*/
    public Object deSerialize(String xmlString, System.Type apexType,Set<String> deSerializeNodesAsArray){   
        this.deSerializeAsArrayNodes = toLower(deSerializeNodesAsArray);
        return deSerialize(xmlString,apexType);		
    }    
    
    /*
@Description    : deSerializes the xml string into collection of primitive data types.
@Parameter      : xmlString = xml String to deSerialize
@Returns        : collection of primitive data types
*/  
    public Object deSerializeUnTyped(String xmlString){  
        return xmlToUnTyped(xmlString);  		
    }
    
    /*
@Description    : deSerializes the xml string into collection of primitive data types.
@Parameter      : xmlString = xml String to deSerialize
@Parameter      : deSerializeNodesAsArray  = collection of node names to deserialize as array (Even if xml representation is not an array)
@Returns        : collection of primitive data types
*/
    public Object deSerializeUnTyped(String xmlString,Set<String> deSerializeNodesAsArray){  
        this.deSerializeAsArrayNodes = toLower(deSerializeNodesAsArray);
        return xmlToUnTyped(xmlString);  		
    }
    
    /*
@Description    : Converts XML string to json string
@Parameter      : xmlString = XML String to convert
@Returns        : JSON String
*/
    public  String XMLToJSON(String xmlString){
        return System.JSON.serialize(XMLToUnTyped(xmlString));
    } 
    
    /*
@Description    : Converts XML string to json string
@Parameter      : xmlString = XML String to convert
@Parameter      : deSerializeNodesAsArray  = collection of node names to deserialize as array (Even if xml representation is not an array)
@Returns        : JSON String
*/
    public  String xmlToJSON(String xmlString,Set<String> deSerializeNodesAsArray){  
        this.deSerializeAsArrayNodes = toLower(deSerializeNodesAsArray);
        return System.JSON.serialize(XMLToUnTyped(xmlString));
    }   
    
	/*
@Description    : resets serialize and deserialize options to default
*/
    public void resetDefaults(){
        this.serializeNulls = true;
        this.RootElement = null;
        this.deSerializeAsArrayNodes.clear();
    }
    
    //Helpers
    
    /*
@Description    : Serialize method
@Parameter      : objectMap = Map of String and objects
@Returns        : XML String
*/
    private String serialize(Map<String,Object> objectMap){
        String xmlString = '';    
        for(String key:objectMap.keySet()){  
            Object o = objectMap.get(key);
            if(o == null) { if(this.SerializeNulls)     xmlString += wrap(key,null); }                       
            else if(o InstanceOf List<Object> )         xmlString += serialize((List<Object>) o,key);
            else if(o InstanceOf Map<String,Object> )   xmlString += wrap(key,serialize((Map<String,Object>) o));
            else                                        xmlString += wrap(key,String.valueOf(o));                               
        }
        return xmlString;
    }
    
    /*
@Description    : Serialize method
@Parameter      : objectList = List of objects
@Parameter      : key = key to wrap all elements of the list with 
@Returns        : XML String
*/
    private String serialize(List<object> objectList, String key){
        String xmlString = '';      
        for(Object o:objectList){    
            if (o InstanceOf String)				xmlString += wrap(key,String.valueOf(o)); 	
            else if(o InstanceOf List<Object> )  	xmlString += wrap(key,serialize((List<Object>) o, key));
            else                            		xmlString += wrap(key,serialize((Map<String,Object>) o));                
        }     
        return xmlString;
    }
    
    /*
@Description    : Wraps value with key xml element
@Parameter      : key = Xml node name
@parameter	: value = xml node value
@Returns        : XML String
*/
    private String wrap(String key, String value){
        return (String.isNotBlank(value) || SerializeNulls) ? ('<' + key + '>' + (string.isBlank(value)?'':value) + '</' + key + '>') : value;
    }
    
    /*
@Description    : deSerializes the xml string into collection of primitive data types.
@Parameter      : xmlString = xml String to deSerialize
@Parameter      : deSerializeNodesAsArray  = collection of node names to deserialize as array (Even if xml representation is not an array)
@Returns        : collection of primitive data types
*/   
    private  Map<String,Object> XMLToUnTyped(String xmlString){
        xmldom xd = new xmldom(xmlString);
        xmldom.Element document = xd.ownerDocument();
        return (Map<string,object>)parseNode(document);
    }  
    
    /*
@Description    : parses an XML node
@Parameter      : e = xml node (of type xmldom.Element)
@Returns        : object
*/
    private Object parseNode(xmldom.Element e){
        if(e.childNodes.size()>0) return complexNodeToMap(e); 
        else  return e.nodeValue;  
    }
    
    /*
@Description    : Converts a complex xml node to collection of primitive types.
@Parameter      : e = xml node (of type xmldom.Element)
@Returns        : Map representation of the node.
*/
    private Map<String,object> complexNodeToMap(xmldom.Element e){       
        Map<String,object> cNodeMap = new Map<String,object>();
        for(xmldom.Element cNode : e.childNodes){                 
            if(cNodeMap.containsKey(cNode.nodeName)){                    
                object o = cNodeMap.get(cNode.nodeName);                    
                if(o InstanceOf List<object>) ((List<object>) o).add(parseNode(cNode));
                else cNodeMap.put(cNode.nodeName,new List<object>{o,parseNode(cNode)});                    
            }
            else cNodeMap.put(cNode.nodeName, deSerializeAsArrayNodes.contains(cNode.nodeName.toLowerCase())? new List<object>{parseNode(cNode)} : parseNode(cNode));
        }
        return cNodeMap;
    } 
    
    /*
@Description    : Converts all elements of the set to lower case
@Parameter      : stringSet = Set of strings to convert to lower case.
@Returns        : Converted set of strings.
*/
    private Set<String> toLower(Set<String> stringSet){
        Set<String> lowerStringSet = new Set<String>();
        for(string s:stringSet) lowerStringSet.add(s.toLowerCase());
        return lowerStringSet;
    }
}
