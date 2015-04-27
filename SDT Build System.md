# SDT Build System
This document describes the SDT build system and how to build the SDT and validate new contributions.

## Directory Structure and Important Files
- [SDT/schema/](SDT/schema/) : Base directory
- [SDT/schema/src/](SDT/schema/src/) : Source files of the SDT.
	- [domain.rng](SDT/schema/src/domain.rng) : RELAX NG file with the SDT schema definition. This is the source file that is converted to the actual schema definition *domain.xsd* during the build. See also [http://en.wikipedia.org/wiki/RELAX_NG](http://en.wikipedia.org/wiki/RELAX_NG).  
	**Only edit this file when one wants to make changes to the SDT!**
	- [domain.xsd](SDT/schema/src/domain.xsd) : The SDT schema defintion that is generated from *domain.rng*.
	- [xml.xsd](SDT/schema/src/xml.xsd) : General schema definitions for the SDT
- [SDT/schema/test/](SDT/schema/test/) : This directory contains all XML files with SDT definitions that should be validated whether they conform to the SDT schema. This could be example definitions or contributions.
- [SDT/schema/build.xml](SDT/schema/build.xml) : This is the definition file for the ant build system.
- [SDT/schema/etc/](SDT/schema/etc/), [SDT/schema/lib/](SDT/schema/lib/), [SDT/schema/style/](SDT/schema/style/) : internal directories for the build system. Please, don't make unnecessary changes to these files.

## Installation
- Install Java on your computer
- Download and install Apache ant from [http://ant.apache.org](http://ant.apache.org)
- Clone the SDT repository from GitHub:

		git clone https://github.com/Homegateway/RWD050.git
	
## How to Use the Build System
After cloning the repository go to the directoy *SDT/schema* and run commands depending on what you want to achieve.

### Build the Schema
Running *ant* without any parameter builds the schema definition from the rng-definition [SDT/schema/src/domain.rng](SDT/schema/src/domain.rng) and writes it to [SDT/schema/src/domain.xsd](SDT/schema/src/domain.xsd)

	$ cd SDT/schema
	$ ant

### Validate SDT Definitions
You can use the build system to validate new SDT definitions or changes made to existing ones by running the following command:

	$ cd SDT/schema
	$ ant validate

The last lines of the many screens full of output you receive should look something like this:

>[schemavalidate] 2 file(s) have been successfully validated.  
>BUILD SUCCESSFUL  
>Total time: 1 second

Otherwise you most likely receive a stacktrace. Search the output for the line *BUILD FAILED*. Above this line you will find some helpful hints for the filename and line number on which the error occured (here: file *mseeb.xml* on line 66) and a reason:	

>[schemavalidate] /Users/someone/Sources/git/RWD050/SDT/schema/test/mseeb.xml:66:18: cvc-elt.1: Cannot find the declaration of element 'Domain'.    
>BUILD FAILED
