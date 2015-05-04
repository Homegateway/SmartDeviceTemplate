# SDT Components

In this document an overview about the SDT 2.0 ødefinitions and component hierarchy is given.

## SDT Overview
The followng UML diagram presents an overview about the SDT components.

![](images/SDT2.0_UML.png)

The syntax used in the diagram to model an XML Schema Definition (XSD) as an UML diagram follows the following approaches:

- [Design XML schemas using UML](http://www.ibm.com/developerworks/library/x-umlschem/)
- [UML For W3C XML Schema Design](http://www.xml.com/pub/a/2002/08/07/wxs_uml.html)


## Components
-TBD

---

### Domain
The *Domain* is the top-level component that defines all modules and devices of a domain. A *Domain* can import definitions of other domains.

![](images/Domain.png)

#### Example

	<Domain xmlns:xi="http://www.w3.org/2001/XInclude"
    	xmlns="http://hgi.org/xml/dal/2.0" 
    	id="org.hgi">
    	<Imports>
      	  <xi:include href="./dal-core.xml" parse="xml" />
    	</Imports>
    	<Modules>
    		<!-- Modules go here -->
    	</Modules>
    	<RootDevices>
    		<!-- RootDevices go here -->
		</RootDevices>
	</Domain>


---

### RootDevice
#### DeviceInfo

### Device

### Module, ModuleClass, ModuleDef

### Action

### Data
#### DataPoint

### Event




