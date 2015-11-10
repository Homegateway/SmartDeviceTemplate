# Examples and Contributions
[A simple example](#simpleExample)  
[Multi Socket Electrical-Extension-Block](#mseeb)

<a name="simpleExample"></a>
## A very simple SDT example
In the ideal case, a large organization or SDO would define a widely-applicable set of [ModuleClasses](SDT_Components.md#ModuleClass), each of which could be used as needed to compose the description of a complex device. In order to show the appoach, this section will create a few example ModuleClasses based on - or inspired by - featues in the Echonet Lite protocol. Please note that the examples shown in this document are very "cut down" and by no means represent a true representation of Echonet Lite.

The Echonet Consortium has standardized their specifications within IEC/ISO (IEC62394, ISO/IEC24767-1, ISO/IEC24767-2, IEC62480, ISO/IEC14543-4-1, ISO/IEC14543-4-2, IEC62457) and they provide a comprehensive collection of various types of home appliances relevant to SmartGrid applications as ECHONET Device objects (see [https://echonet.jp/spec_object_rf_en/](https://echonet.jp/spec_object_rf_en/) ).

For the example in this document, to show re-use of ModuleClass definitions, two complex devices are chosen which have some common features and hence could be expected to both use some of the same ModuleClasses: an air conditioner and a washing machine.

<table>
<tr><th>Funtionality</th><th>Air Conditioner</th><th>Washing Machine</th></tr>
<tr><td>operationStatus</td><td>operates on/off</td><td>operates on/off</td></tr>
<tr><td>measuredCumulativePowerConsumption</td><td>the cumulative power consumption</td><td>the cumulative power consumption</td></tr>
<tr><td>installationLocation</td><td>this sets/reads a string text describing the location (room) of the air-conditioner.</td><td>this sets/reads a string text describing the location (room) of the washing machine.</td></tr>
<tr><td>setTimer</td><td>(not applicable. there is no preset start for an air-conditioner)</td><td>This sets/reads use the on/off timer</td></tr>
</table>

Based on the simplified example above, the two appliances will need the ModuleClasses below:

- *air-conditioner*: operationStatus, measuredCumulativePowerConsumption, installationLocation;
- *washing-machine*: operationStatus, measuredCumulativePowerConsumption, and setTimer. 

		<ModuleClass name="operationStatus">
			<Data>
				<DataPoint name="operationStatus" writable="true">
					<Doc>This property sets/reads the ON/OFF status.</Doc>
						<DataType>
							<SimpleType type="boolean"/> 
						</DataType>
				</DataPoint>
			</Data>
			<Events>
				<Event name="operationStatus">
				</Event>
			</Events>
		</ModuleClass>

		<ModuleClass name="measuredCumulativePowerConsumption">
			<Data>
				<DataPoint name="measuredCumulativePowerConsumption" writable="false">
					<Doc>This indicates cumulative power consumption of the device in increments of 0.001kWh.</Doc>
					<DataType>
						<SimpleType type="integer"/>
					</DataType>
				</DataPoint>
			</Data>
		</ModuleClass>

		<ModuleClass name="installationLocation">
			<Data>
				<DataPoint name="installationLocation" writable="true">
					<Doc>This property indicates the installation location</Doc>
					<DataType>
						<SimpleType type="string"/>
					</DataType>
				</DataPoint>
			</Data>
			<Events>
				<Event name="installationLocation"> </Event>
			</Events>
		</ModuleClass>

		<ModuleClass name="onTimerSetting">
			<DataPoint name="onTimer" writable="true">
				<Doc>Timer value (HH:MM)</Doc>
				<DataType>
					<SimpleType type="time"/>
				</DataType>
			</DataPoint>
		</ModuleClass>

The structure and the according SDT now looks like this:

<table>
<tr><td colspan="2" width="50%"><b>Example1.SDT</b></td></tr>
<tr><td> </td><td>Namespace information</td></tr>
<tr><td> </td><td>Modules (contains ModuleClasses)</td></tr>
<tr><td> </td><td>operationStatus<ul>
	<li>measuredCumulativePowerConsumption</li>
	<li>installationLocation</li>
	<li>onTimerSetting</li></ul></td></tr>
</table>

		<?xml version="1.0" encoding="iso-8859-1"?>
		<!-- Example1 SDT inspired by some Echonet Lite examples -->
		<Domain xmlns="http://homegatewayinitiative.org/xml/dal/3.0"
			xmlns:xi="http://www.w3.org/2001/XInclude"
			id="example1.SDT">
		
		<Modules>
		<!-- Various examples for module classes -->
		<ModuleClass name="operationStatus">
			<Data>
				<DataPoint name="operationStatus" writable="true">
					<Doc>This property sets the ON/OFF status.</Doc>
						<DataType>
							<SimpleType type="boolean"/> 
						</DataType>
				</DataPoint>
			</Data>
			<Events>
				<Event name="operationStatus">
				</Event>
			</Events>
		</ModuleClass>

		<ModuleClass name="installationLocation">
			<Data>
				<DataPoint name="installationLocation" writable="true">
					<Doc>This property indicates the installation location</Doc>
					<DataType>
						<SimpleType type="string"/>
					</DataType>
				</DataPoint>
			</Data>
			<Events>
				<Event name="installationLocation"> </Event>
			</Events>
		</ModuleClass>

		<ModuleClass name="measuredCumulativePowerConsumption">
			<Data>
				<DataPoint name="measuredCumulativePowerConsumption" writable="false">
					<Doc>This indicates cumulative power consumption of the device in increments of 0.001kWh.</Doc>
					<DataType>
						<SimpleType type="integer"/>
					</DataType>
				</DataPoint>
			</Data>
		</ModuleClass>

		<ModuleClass name="onTimerSetting">
			<DataPoint name="onTimer" writable="true">
				<Doc>Timer value (HH:MM)</Doc>
				<DataType>
					<SimpleType type="time"/>
				</DataType>
			</DataPoint>
		</ModuleClass>
			</Modules>
		</Domain>


---

<a name="mseeb"></a>
### Multi Socket Electrical-Extension-Block

This example is a specification for an imaginged device, a connected extension block with multiple power socket where each of the sockets are modeled as a 
separate *SubDevice*.

[mseeb.xml](../test/mseeb.xml)


---

