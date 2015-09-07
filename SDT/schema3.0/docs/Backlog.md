# Backlog
To Be Discussed

[Versions](#Versions)  
[Namespace](#Namespace)  
[Roles](#Roles)  
[Optionals](#Optionals)  


<a name="Versions"></a>
## Versions
### Rational
A device vendor is free to add new functionality to a device and to change or to remove existing functionality from a device by a firmware update or changes in the configuration. These changes may mean that the device functionality and a description in SDT become "out of sync" because currently an application developer has only little means to associate a specific firmware version or device configuration to a version of a SDT description. 

Even then the developer needs to manage different versions of the same SDT device description because there might be devices of the same type but with different firmware versions/configurations on a network. 

The version information must be available to applications at runtime.

### Proposal
To solve this problem SDT components that can be influenced by firmware updates or configuration changes must be distinguishable by some kind of version scheme. Since different versions in the structure, attributes and elements of the SDT description as well as data types are already indicated by the "version number" of the SDT (e.g."http://hgi.org/xml/dal/3.0") only the components that are instantiated for the devices etc need to indicate their current version.

The proposal is to add a *version* attribute to the following SDT components:

- RootDevice
- Device
- ModuleClass

*Event*, *Action* etc don't need an version number because a change in one of those components must be indicated by a different version  in the ModuleClass.

The *version* attribute is just a string value without a defined format.

### Further Discussion
Does HGI define the version format? Or is this up to the vendors to provide their own? 

At least the governing entity that managed all the different needs to define this format since it must be in agreement between the device vendors, driver provider, DAL provider and application developer.

Format suggestion: define the format of the version string as "major.minor.revision" with the following semantics for each number:

- **revision**: minimal change, internal bugfix, no change to data, formats or API.
- **minor**: Change to the API that could be incompatible to the previous version. Added or removed interfaces or modules, changes in data formats.
- **major**: Redesign of the overall structure and architecture.

The "numbers" could be just integer number, but may also contain letters, e.g. "1.0.1a".

---

<a name="Namespace"></a>
## Domain / Namespace
### Issue
The SDL now uses the namespace "homegatewayinitiative.org" as a namespace to identify the schema (also used for includes). The namespace is **not** a URL, but uniquely identifies the namespace and *should* be registered by HGI.

That said, most validating parsers expect **that the namesapce IS a valid URL** or that at least there is a server on the other end rejecting the request. A timeout / no connection / no answer / ... leads to an error.

Therefore, we cannot use the namespace "homegateway.org" because parsers don't get an answer from this address.

---

<a name="Roles"></a>
## Roles
### Proposal
The proposal is to add a  *role* to *RootDevice* / *Device*. DECT ULE defines roles such as client and server for direct communication of appliances without a local hub. Depending on the assigned role a device might support different functions.

Example:
	
	<RootDevice name id=”xyz” role=”something”>’
	...
	</RootDevice>

---

<a name="Optionals"></a>
## Optionals
### Rational
Introduce optional *Actions* in *ModuleClasses* to reduce the number of possible combinations. Some technologies offers flexibility in defining requireed and optional *Actions*, *DataPoints* and *Events*´. The alternative is to define similar *ModuleClasses* that offers the variants of required and optional elements.

DECT ULE, for example, has optional actions.

### Proposal
Add an attribute to *Actions* to mark them as optional in a ModuleClass. Perhaps *DataPoints* and *Events* as well.

Example:

	...
	<Action name=”abc” optional=”true”>
	...
	</Action>

The default without the optional attribute would be  ``optional="false"``, meaning required).




