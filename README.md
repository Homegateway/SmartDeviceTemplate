# RWD050

Repository for the Smart Home Device Template (SDT).

Note that this project runs under Apache 2.0 license. Read the [LICENSE](LICENSE) in this repository, or refer to [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Any contributions made to this project must comply with the forementioned license.

## Quick Links
- ['domain.xsd' Version 2.0](SDT/schema2.0/src/domain.xsd)
- [UML Diagram of the SDT 2.0](SDT/schema2.0/docs/images/SDT2.0_UML.png) ([source](SDT/schema2.0/docs/SDT_UML.uxf))


## Content

You can find further Information here:

- [SDT Components](SDT/schema2.0/docs/SDT_Components.md)
- [SDT Build System](SDT/schema2.0/docs/SDT%20Build%20System.md)
- [Examples](SDT/schema2.0/docs/Examples.md) 
- [FAQ](SDT/schema2.0/docs/FAQ.md)
- [Links & References](SDT/schema2.0/docs/Links.md)
- [LICENSE](LICENSE)


## Changes in 2.0
- Introduced RootDevice to support hierarchical embedded devices.
- Added new data types (byte, float, array, enum, date, time, datetime, blob, uri)
- Added ``readable`` and ``eventable`` to data points.
- Added otional ``<SerialNumber>``, ``<VendorURL>`` and ``<FirmwareVersion>`` elements to DeviceInfo
- Added optional ``<Doc>`` element to Event
- Changed the optionality of the ``<DataPoint>``'s ``type`` attribute to "required".
- Added [UML diagram](SDT/schema2.0/docs/SDT_Components.md)

---

# To Be Discussed (Remove this later!)
## Versions
### Rational
A device vendor is free to add new functionality to a device and to change or to remove existing functionality from a device by a firmware update or changes in the configuration. These changes may mean that the device functionality and a description in SDT become "out of sync" because currently an application developer has only little means to associate a specific firmware version or device configuration to a version of a SDT description. 

Even then the developer needs to manage different versions of the same SDT device description because there might be devices of the same type but with different firmware versions/configurations on a network. 

The version information must be available to applications at runtime.

### Proposal
To solve this problem SDT components that can be influenced by firmware updates or configuration changes must be distinguishable by some kind of version scheme. Since different versions in the structure, attributes and elements of the SDT description as well as data types are already indicated by the "version number" of the SDT (e.g."http://hgi.org/xml/dal/2.0") only the components that are instantiated for the devices etc need to indicate their current version.

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


## Domain / namespace
The SDL now uses the namespace "homegateway.org" as a namespace to identify the schema (also used for includes). The namespace is **not** a URL, but uniquely identifies the namespace and *should* be registered by HGI.




