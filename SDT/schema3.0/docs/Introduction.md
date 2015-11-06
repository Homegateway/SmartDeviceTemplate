# Introduction to the SDT

The Smart Device Template (SDT) is a template which is used to model the capabilities, actions and events of connected devices. The intent of the SDT is to be able to model any type of connected device using a well accepted and standardised format. The main application of SDT is to enable a uniformly structured Application Programmer’s Interface (API) to applications that need to interact with connected devices. Usually, these applications would communicate to devices using an Abstraction Layer as an intermediary logic. The Abstraction Layer „hides“ the technology-specific, native language format of devices of different technology type from the applications.

## The goal

Interoperability for smart-home and other IoT-related applications and Internet-of-Things devices and services is a key objective that is not currently easy to meet, because of the many types of technology specific device interfaces in wide deployment. There is no accepted standard.

A major goal for service providers is that software developers should be able to write application software which would handle most of the commonly used functions for any device, irrespective of the device technology. Furthermore, software developers should not have to make major changes to the software in case a new device of similar function but of a different interface technology is used.
If these goals were fully or even partly met, major advantages can be obtained:

- Service Providers would be more able to deploy and support select new technology types of devices, because existing software application code could be more easily adapted to the new device technology.
- Devices of multiple technology types could be deployed and supported by the same platform (e.g. a Home Gateway), and applications could more easily communicate with them simultaneously.
- Devices of multiple technology types could be deployed by a service provider in different regions or homes, but common application code could be used to support applications. For example, a home automation application could support ECHONET devices in one set of homes, and ZigBee devices in another
- Makers of software application code can more easily support multiple device technology types
- Vendors using newer device technologies could more easily bring their products to new markets.

The interoperability benefits can potentially partially obtain even without a fully complete interoperability of the SDT. For example, the most common functions can be modeled with SDT, and more particular functions can be modeled with technology-specific, proprietary, or seldom-used aspects. 

## How should SDT work? 

The basic concept is that a manufacturer, organisation or global SDO would define its preferred Smart Device Template, in XML, specified by and based on an XSD. Using that XSD, manufacturers or indeed hobbyists could "describe" existing or new devices by means of XML files, specifying the capabilities and the parameters needed to control the devices.  

Assuming that the XML files conform to the specified XSD and to some guidelines described in this document, software developers could readily create APIs able to "parse" the XML-descriptions of devices and (assuming the underlying LAN technology of the device is supported by the software/hardware environment in the gateway) operate the equipment. 

The key to making software reliably interoperate with various technologies is to define in the SDT a finite and convenient to use number of functions (which is the decision of the SDO which are commonly used and can therefore be reliably re-used in software for one type of device or another.

For the convenience of users and developers, it would also be possible to collect the device descriptions of common "modules" (types of) appliances so that the operations of "a generic air-conditioner" could be agreed and re-used often, adapting descriptions of special models with just some special features added as local extensions. Agreeing on the definition of "a generic XYZ appliance" is rather time-consuming, so such "repository" may not become standardised, however the basic approach has huge benefits even if such an archive (also known as a "hierarchical ontology") is never formally agreed.

The sections below explain this in more detail.

## How does the SDT approach simplify software development?

Simplification is achieved in software development by first developing methods to handle common or general functions, then treating necessary "uncommon" functions as extensions; treating each functionality as an individual special case does not scale. Identifying the general functions is often called "abstracting".  

There are four major levels of progressively greater abstraction in the signaling and software along the path between a sensor (or actuator) and a software application installed in the cloud:

1. a LAN protocol can provide a common set of signaling methods for all compatible sensors/actuators/devices (abstraction at the LAN-controller)
2. a local gateway software can provide common functions to operate diverse kinds of LAN-controllers (abstraction in the local gateway) 
3. an IoT platform in the WAN can interoperate with a number of WAN protocols supported by different kinds of gateways (abstraction at the IoT platform)
4. software in the Cloud can interact with diverse IoT platforms and other software applications (abstraction in the Cloud)

The concept of the SDT was created in order to make life easier for the software developer working particularly at the second level, creating software for local gateways to interact with devices connected by various kinds of (wireless) LAN technologies/protocols. The same information written into XML instantiations of the SDT do describe sensors or appliances can also be very valuable, however, to applications in the Cloud, helping to interpret the data.

Currently every software developed for home gateways or internet-of-things gateways needs to be capable of using various different protocols (ZigBee, UPnP, EchonetLite, DECT ULE, etc) to interact with a range of devices designed for the home environment. This adds extreme overheads in integrating, checking and updating code. The purpose of SDT is to describe devices and device services in a way which is independent of the LAN technology, in a format which is convenient and reliable for integration in modern code (Java, C/C++, ...). 

In general a description of device (or complex appliance) behaviour can be made in many ways, with various kinds of constraints:

1. no constraints (e.g. using OWL 2.0 or even more "flexibly" RDF)
2. moderate constraints (e.g. using XML and a related extensible XSD template)
3.	strict constraints (typical for a device certified to interoperate with a specific LAN protocol)

HGI chose to use the approach "moderate constraints" (XSD based) because for software development it offers ease of use and a good compromise. In particular, if there are few or no constraints on control parameters then few automatic checks can be made to detect if the software parameters are appropriate for each device integrated. XML and XSD languages were chosen because they are familiar to many developers, can be parsed with common software tools, and can still be created and interpreted by humans if necessary.

HGI believes that Device information models based on XML and extensible XSD need some guidelines. If every possible feature of every existing LAN technology and appliance were allowed to be described in any formally correct way, then the results would be a modern Babel, no better than today's system of widely different and wildly competing automation protocols. 

Therefore HGI proposes to recommend a certain structure (template) for the information model(s), but to allow extensions. Naturally, the more industry consensus is achieved for a single recommended template, the greater the utility for software developers (and users). 

## Related aspects which are out of scope of the SDT 

Not directly part of this work is a related but separate aspect of every gateway software development: a "device abstraction layer" which can translate between (1) software APIs written based on a particular SDT and (2) the "commands" expected by several different LAN protocols and their hardware controllers. 

Programmers developing a "device abstraction layer" for software in a gateway need to create run-time representations of all the recognized devices, their operations and their actual states. This internal "information model" needs to be updated in real time as the devices and the users interact. Programmers may be tempted to use the SDT structure to organize their real-time information model, adding additional information elements for the current state of each device, for some kind of "history" of commands sent/acknowledged, the user etc. This is an efficient approach BUT it must be clear that the real-time state information and history of events, etc, can NOT be represented in a pre-defined SDT not in an XML giving specific details for a device.

The SDT defines the structure of all compliant XML descriptions. Each XML description of a specific device is definable at the time of manufacture of the device and can therefore only contain "static" information: (a) manufacturer data in the form of documentation elements and properties, (b) device capability information detailing the firmware operations and types/meanings of input/output variables. 
