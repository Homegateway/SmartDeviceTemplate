# RWD050

Repository for the Smart Home Device Template (SDT).

Note that this project runs under Apache 2.0 license. Read the [LICENSE](LICENSE) in this repository, or refer to [http://www.apache.org/licenses/LICENSE-2.0.html](http://www.apache.org/licenses/LICENSE-2.0.html)

Any contributions made to this project must comply with the forementioned license.

## Quick Links
- ['domain.xsd' Version 2.0](SDT/schema2.0/src/domain.xsd)
- [UML Diagram of the SDT 2.0](images/SDT2.0_UML.png)


## Content

You can find further Information here:

- [SDT Components](SDT_Components.md)
- [SDT Build System](SDT%20Build%20System.md)
- [FAQ](FAQ.md)
- [Links & References](Links.md)
- [LICENSE](LICENSE)


## Changes in 2.0
- Introduced RootDevice to handle
- Added new data types (byte, float, array, enum, date, time, datetime, blob)
- Added attributes to data points (readable, eventable)
- Added otional ``<SerialNumber>``, ``<VendorURL>`` and ``<FirmwareVersion>`` elements to DeviceInfo
- Added optional ``<Doc>`` element to Event
- Added [UML diagram](SDT_Components.md)



