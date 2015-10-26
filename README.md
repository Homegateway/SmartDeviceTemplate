# Smart Device Template

Repository for the Smart Device Template (SDT).

**Version 3.0**

Note that this project runs under Apache 2.0 license. Read the [LICENSE](LICENSE) in this repository, or refer to [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Any contributions made to this project must comply with the aforementioned license.

## Quick Links
- ['domain.xsd' Version 3.0](SDT/schema3.0/src/domain.xsd)
- [UML Diagram of the SDT 3.0](SDT/schema3.0/docs/UML%20Diagram.md) ([source](SDT/schema3.0/docs/SDT_UML.uxf))


## Content

You can find further Information here:

- [SDT Components](SDT/schema3.0/docs/SDT_Components.md)
- [SDT Build System](SDT/schema3.0/docs/SDT%20Build%20System.md)
- [Examples](SDT/schema3.0/docs/Examples.md) 
- [FAQ](SDT/schema3.0/docs/FAQ.md)
- [Links & References](SDT/schema3.0/docs/Links.md)
- [LICENSE](LICENSE)

## Changes in 3.0
- Renamed ``<RootDevice>``to ``<Device>`` and ``<Device>`` to ``<SubDevice>``,
- Added complex data types: *Struct* and *Arrays*.
- Simplified the UML diagram. Split the UML diagram into two parts, one for the base elements and one for the data types.
- In the UML diagram: Moved ``<extends>`` into the UML ``<ModuleClass>`` element (easier to read).
- Added support to specify *Units of Measurement* to data types,
- Added ``<Doc>`` to ``<Domain>`` and other elements.
- ``<Doc>`` is now always the first part of an element.
- Changed ``<DeviceInfo>`` element to a list of ``<Characteristic>``.
- Added ``<Characteristic>`` list to ``<Modules>`` and ``<ModuleClasses>``.
- The ``<data>`` element in ``<Event>`` is now optional to support events without attached or associated data.
- In Actions: Added ``<Args>`` as a surrounding list around a list of ``<Arg>``.
- Added *Constraints* to ``<DataType>``.
- Added optional *name* attribute to ``<DataType>``. This mandatory for elements of a *struct*.
- Restructured the [RNG](SDT/schema3.0/src/domain.rng) file for better readability and maintainability.
- In the [RNG](SDT/schema3.0/src/domain.rng)/[XSD](SDT/schema3.0/src/domain.xsd): Changed cardinality of the occurrence of elements that are part of a list of elements (e.g. ``<SubDevices><SubDevice>…</SubDevice></SubDevices>`` from „zero or more“ to „one or more“ when the surrounding list element itself is optional (to avoid empty lists).



## Changes in 2.0.1
- Added missing "uri" data type.

## Changes in 2.0
- Introduced RootDevice to support hierarchical embedded devices.
- Added new data types (byte, float, array, enum, date, time, datetime, blob, uri)
- Added ``readable`` and ``eventable`` to data points.
- Added optional ``<SerialNumber>``, ``<VendorURL>`` and ``<FirmwareVersion>`` elements to DeviceInfo
- Added optional ``<Doc>`` element to Event
- Changed the optionality of the ``<DataPoint>``'s ``type`` attribute to "required".
- Added [UML diagram](SDT/schema2.0/docs/SDT_Components.md)
- Changed the namespace for the XSD from "hgi.org" to "homegatewayinitiative.org".

