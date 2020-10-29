# stibo-step-integration-samples

These are the sample files from the users group session.

![XML -> XSLT -> STEP](xml-xslt-step.png)

# data.fyayc.xml

sample xml file using schema namespaces that can be used to define and validate the xml data

# schema.png

Defines the attributes, elements and parent child relationships, as well as a List Of Values called an Enumeration.

![FYAYC XML Schema](fyayc-schema.png)

# PIM.xsd

The Stibo schema for STEP.XML format data, Stibo uses this format to import and export all of our structure, data, logic and configuration, it is the primary Stibo data format for offline storage.

When systems are migrated from one system to another, we use STEP.XML formats.

[STEP.XML doco](https://service.stibosystems.com/documentation/latest/Default.html#data_exchange/data_formats/stepxml_format.html)

# exported.step.xml

The configuration used for our demonstration in STEP.XML format.

# transform.xslt

converts FYAYC XML into STEP.XML

# data.step.xml

The output from the xslt transform that can be directly loaded into STEP as STEP.XML format.

# imported.xlsx

sample input file for Excel

# exported.xlsm

sample smart sheet export from STEP




