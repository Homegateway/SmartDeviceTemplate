# SDT Build System
This document describes the SDT build system and how to build the SDT and validate new contributions.

The files referenced in this document point to version **2.0** of the SDT.

## Directory Structure and Important Files
- [SDT/schema2.0/](../..) : Base directory
- [SDT/schema2.0/src/](../src/) : Source files of the SDT.
	- [domain.rng](../src/domain.rng) : RELAX NG file with the SDT schema definition. This is the source file that is converted to the actual schema definition *domain.xsd* during the build. See also [http://en.wikipedia.org/wiki/RELAX_NG](http://en.wikipedia.org/wiki/RELAX_NG).  
	**Only edit this file when one wants to make changes to the SDT!**
	- [domain.xsd](../src/domain.xsd) : The SDT schema defintion that is generated from *domain.rng*.
	- [xml.xsd](../src/xml.xsd) : General schema definitions for the SDT
- [SDT/schema2.0/test/](../test/) : This directory contains all XML files with SDT definitions that should be validated whether they conform to the SDT schema. This could be example definitions or contributions.
- [SDT/schema2.0/build.xml](../build.xml) : This is the definition file for the ant build system.
- [SDT/schema2.0/etc/](../etc/), [SDT/schema2.0/style/](../style/) : internal directories for the build system. Please, don't make unnecessary changes to these files.
 	- [SDT/schema2.0/etc/dal.rnc](../etc/dal.rnc) : This file contains various configuration parameter to convert the file [domain.rng](../src/domain.rng) to schema file. **The important parameter to change when changing the namespace or the version number is**:

			default namespace xsl = "http://homegatewayinitiative.org/xml/dal/2.0"

	- [SDT/schema2.0/etc/schemas.xml](../etc/schemas.xml) : This file contains the header for the schema file. **This must be changed when changing the namespace or the version number.**

- [SDT/schema2.0/lib/](lib/) : Tasks for the ant-based build system. See also [SDT Build System Components and Licenses](SDT%20Build%20System%20Components%20and%20Licenses.md).

## Installation
- Install Java on your computer
- Download and install Apache ant from [http://ant.apache.org](http://ant.apache.org)
- Clone the SDT repository from GitHub:

		$ git clone https://github.com/Homegateway/RWD050.git
	
## How to Use the Build System
After cloning the repository go to the directoy *SDT/schema* and run commands depending on what you want to achieve.

### Build the Schema
Running *ant* without any parameter builds the schema definition from the rng-definition [SDT/schema2.0/src/domain.rng](../src/domain.rng) and writes it to [SDT/schema2.0/src/domain.xsd](../src/domain.xsd)

	$ cd SDT/schema
	$ ant

### Validate SDT Definitions
You can use the build system to validate new SDT definitions or changes made to existing ones by running the following command:

	$ cd SDT/schema
	$ ant validate

The output after a successful validation should look like this:

>[schemavalidate] 2 file(s) have been successfully validated.  
>BUILD SUCCESSFUL  
>Total time: 1 second

Otherwise you most likely receive a stacktrace or some other error messages. Search the output for the line *BUILD FAILED*. Above this line you will find some helpful hints for the filename and line number on which the error occured (here: file *mseeb.xml* on line 66) and a reason:	

>[schemavalidate] /Users/someone/Sources/git/RWD050/SDT/schema/test/mseeb.xml:66:18: cvc-elt.1: Cannot find the declaration of element 'Domain'.    
>BUILD FAILED

---

##  Editing
As mentioned above, the actual schema definition is defined in the file [domain.rng](../src/domain.rng) and converted to the XML schema definition [domain.xsd](../src/domain.xsd) during the build process. 

**All changes to the schema must therefore be made in [domain.rng](../src/domain.rng), NOT [domain.xsd](../src/domain.xsd) !**

You may need to make additional changes in the following files, e.g. when the name space or the version number need to be adjusted.

PLEASE ONLY EDIT THESE FILES IF NECESSARY. 

- [SDT/schema2.0/build.xml](../build.xml)  
e.g. in the *ant* target "validate"
- [SDT/schema2.0/etc/dal.rnc](../etc/dal.rnc)  
e.g. the entry "default namespace xsl"
- [SDT/schema2.0/etc/schema.xmlns](../etc/schema.xmlns)
- [SDT/schema2.0/etc/schemas.xml](../etc/schemas.xml)
