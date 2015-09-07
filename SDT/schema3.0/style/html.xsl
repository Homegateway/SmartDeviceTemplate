<?xml version="1.0" encoding="iso-8859-1"?>

<!-- - Name Spaces - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!--                                                                         -->
<!--   Explicit namespace declaration for the DAL schema required, 
       otherwise select expressions like '/Domain' don't work. An
       alternative is to remove the declaration from the input XML
       document ... -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:dal="http://homegatewayinitiative.org/xml/dal/2.0"
		xmlns="http://www.w3.org/1999/xhtml"
		
		xmlns:redirect="http://xml.apache.org/xalan/redirect" 
		extension-element-prefixes="redirect"
		version="1.0">

  <xsl:output method="xml" indent="yes"  encoding="ISO-8859-1"/>

  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <!-- HTML Output - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!--                                                                       -->
  <!-- Create a directory for the domain id with an HTML page for each       -->
  <!-- in the page. An index page contains links to all the devices.         -->
  <!--                                                                       -->
  <!-- Template param: destdir - directories will be created here            -->

  <xsl:param name="destdir"/>

  <xsl:template match="/dal:Domain">
    <xsl:variable name="domain" select="@id"/>
    <xsl:variable name="dir" select="concat($destdir,'/',$domain)"/>
    <xsl:choose>
      <xsl:when test="contains($vendor, 'SAXON 6.2')"/>
      <xsl:when test="contains($vendor, 'Apache')">
	<redirect:write file="{concat($dir,'/index.html')}">
	  <xsl:apply-templates select="." mode="domain"/>
	</redirect:write>
      </xsl:when>
    </xsl:choose>
    <xsl:for-each select="dal:Devices/*">
      <xsl:variable name="file" select="concat($domain,'/',@id,'.html')"/>
      <xsl:choose>
	<xsl:when test="contains($vendor, 'SAXON 6.2')"/>
	<xsl:when test="contains($vendor, 'Apache')">
	  <redirect:write file="{concat($dir,'/',@id,'.html')}">
	    <xsl:apply-templates select=".">
	      <xsl:with-param name="domain" select="$domain"/>
	    </xsl:apply-templates>
	  </redirect:write>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- Domain - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!--                                                                      -->
  <!--                                                                      -->
  <!--                                                                      -->

  <xsl:template match="dal:Domain" mode="domain">
    <html>
      <head>
	<title>Domain <xsl:value-of select="@id"/></title>
      </head>
      <body>
	<h1>Domain <xsl:value-of select="@id"/></h1>
	<h2>Devices</h2>
	<ul>
	  <xsl:apply-templates select="dal:Devices/*" mode="domain"/>
	</ul>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="dal:Device" mode="domain">
    <li>
      <xsl:element name="a">
	<xsl:attribute name="href">
	  <xsl:value-of select="concat(@id,'.html')"/>
	</xsl:attribute>
	<xsl:value-of select="dal:DeviceInfo/dal:Name"/>
      </xsl:element>
    </li>
  </xsl:template>

  <!-- Device - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!--                                                                      -->
  <!--                                                                      -->
  <!--                                                                      -->

  <xsl:template match="dal:Device">
    <xsl:param name="domain"/>
    <html>
      <head>
	<title>
	  <xsl:value-of select="$domain"/> / <xsl:value-of select="@id"/>
	</title>
      </head>
      <body>
	<xsl:text><b>Domain:</b> </xsl:text>
	<a href="index.html"><xsl:value-of select="$domain"/></a>

	<h2>Device <xsl:value-of select="dal:DeviceInfo/dal:Name"/></h2>

	<dl>
	  <dt><b>Vendor:</b></dt>
	  <dd><xsl:value-of select="dal:DeviceInfo/dal:Vendor"/></dd>
	  <dt><b>Device Id:</b></dt>
	  <dd><xsl:value-of select="@id"/></dd>
	</dl>

	<xsl:apply-templates select="dal:Doc"/>

	<hr/><h2>Module Summary</h2>

	<ul>
	  <xsl:for-each select="dal:Modules/*">
	    <xsl:apply-templates select="dal:extends" mode="check"/>
	    <li>
	      <xsl:value-of select="@name"/>
	      <xsl:apply-templates select="dal:extends"/>
	    </li>
	  </xsl:for-each>
	</ul>

	<hr/><h2>Module Detail</h2>

	<xsl:apply-templates select="dal:Modules/*"/>

      </body>
    </html>
  </xsl:template>

  <!-- Modules  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!--                                                                      -->
  <!-- Determine the name of the super Module (if there is one) and use it  -->
  <!-- to fetch a list of Action nodes in this Module. These are passed to  -->
  <!-- the template geerating the action documentation for the module. This -->
  <!-- This seems to be the least verbose way of getting inherited actions  -->
  <!-- and the pattern can be used for events as well                       -->

  <xsl:template match="dal:Module">
    <xsl:variable name="dm">
      <xsl:apply-templates select="dal:extends" mode="domain"/>
    </xsl:variable>
    <xsl:variable name="cl">
      <xsl:apply-templates select="dal:extends" mode="class"/>
    </xsl:variable>
    <xsl:variable 
	name="actions"
	select="//dal:Domain[@id=$dm]//dal:ModuleClass[@name=$cl]//dal:Action"/>

    <h3>
      Module <xsl:value-of select="@name"/>
      <xsl:apply-templates select="dal:extends"/>
    </h3>
    <dl>
      <dd>
	<xsl:apply-templates select="dal:Doc"/>
      </dd>
	<xsl:call-template name="do-actions">
	  <xsl:with-param name="actions" select="$actions"/>
	</xsl:call-template>
    </dl>
    <hr/>

  </xsl:template>
  
  <!-- Actions  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!--                                                                      -->
  <!-- The do-actions template is invoked for the module, and is passed any -->
  <!-- inherited actions in the parameter 'actions'. An action section is   -->
  <!-- only generated if there are any actions (inherited or otherwise).    -->
  <!-- Inherited actions are rendered before the locally defined actions    -->

  <xsl:template name="do-actions">
    <xsl:param name="actions"/>
    <xsl:if test="count($actions)!=0 or .//dal:Actions">
      <dt><b>Actions</b></dt>
      <dd>
	<dl>
	  <xsl:apply-templates select="$actions"/>
	  <xsl:apply-templates select=".//dal:Actions"/>
	</dl>
      </dd>
    </xsl:if>
  </xsl:template>

  <xsl:template match="dal:Action">
    <dt><b><xsl:value-of select="@name"/></b></dt>
    <dd>
      <xsl:apply-templates select="dal:Doc"/>
      <dl>
      <xsl:if test="dal:Arg">
	<dt><b>Arguments</b></dt>
	<xsl:apply-templates select="dal:Arg"/>
      </xsl:if>
      <xsl:if test="@type">
	<dt><b>Returns</b></dt>
	<dd><xsl:value-of select="@type"/></dd>
      </xsl:if>
      </dl>
    </dd>
  </xsl:template>

  <xsl:template match="dal:Arg">
    <dd>
      <xsl:value-of select="@type"/> 
      <xsl:text> </xsl:text>
      <xsl:value-of select="@name"/> -
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="dal:Doc"/>
    </dd>
  </xsl:template>

  <!-- Extends  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!--                                                                      -->
  <!--                                                                      -->
  <!--                                                                      -->

  <xsl:template match="dal:extends">
    <xsl:text> </xsl:text><em>extends</em><xsl:text> </xsl:text>
    <xsl:value-of select="@class"/><xsl:text> (</xsl:text>
    <xsl:value-of select="@domain"/><xsl:text>)</xsl:text>
  </xsl:template>

  <xsl:template match="dal:extends" mode="domain">
    <xsl:value-of select="@domain"/>
  </xsl:template>

  <xsl:template match="dal:extends" mode="class">
    <xsl:value-of select="@class"/>
  </xsl:template>

  <xsl:template match="dal:extends" mode="check">
    <xsl:variable name="domain" select="@domain"/>
    <xsl:variable name="class" select="@class"/>
    <xsl:variable 
	name="extends" 
	select="//dal:Domain[@id=$domain]//dal:ModuleClass[@name=$class]"/>
    <xsl:if test="count($extends)=0">
      <xsl:message terminate="yes">
	<xsl:text>Imported module class </xsl:text>
	<xsl:value-of select="$domain"/>:<xsl:value-of select="$class"/>
	<xsl:text> not found</xsl:text>
      </xsl:message>
    </xsl:if>
  </xsl:template>
  
  <!-- Documentation  - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!--                                                                      -->
  <!--                                                                      -->
  <!--                                                                      -->

  <xsl:template match="dal:em">
    <em><xsl:apply-templates/></em>
  </xsl:template>

  <xsl:template match="dal:b">
    <b><xsl:apply-templates/></b>
  </xsl:template>

  <xsl:template match="dal:p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

</xsl:stylesheet>
