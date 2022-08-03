<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	exclude-result-prefixes="#all" version="2.0" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:step="http://www.stibosystems.com/step"
	xmlns:fyayc="https://foryouandyourcustomers.com/people"
	xmlns:digest="java:org.apache.commons.codec.digest.DigestUtils"
>
	<xsl:output indent="yes" method="xml"/>

	<xsl:variable name="approve" select="'N'"/>
	<xsl:variable name="context" select="'Context1'"/>
	<xsl:variable name="now" select="current-dateTime()"/>

	<xsl:template match="/fyayc:people">
		<step:STEP-ProductInformation 
			xmlns="http://www.stibosystems.com/step" 
			xsi:schemaLocation="http://www.stibosystems.com/step PIM.xsd"
			
			STEPWorkflowImportEvent="Y" 
			UseContextLocale="false" 
			WorkspaceID="Main" 
			SingleUpdateMode="N"
		>			
			
			<xsl:attribute name="ExportTime">
				<xsl:call-template name="date_fixer">
					<xsl:with-param name="dts" select="$now"/>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:attribute name="AutoApprove" select="$approve"/>
			<xsl:attribute name="ContextID" select="$context"/>

			<step:Products>
				<step:Product ID="TEAM_Home" ParentID="Product hierarchy root" UserTypeID="TEAM_Home">
					<xsl:apply-templates/>
				</step:Product>
			</step:Products>
		</step:STEP-ProductInformation>
	</xsl:template>

	<xsl:template match="fyayc:group">
		<step:Product UserTypeID="TEAM_Node">
			<xsl:attribute name="ID" select="concat('TEAM_',@ID)"/>
			<step:Name>
				<xsl:value-of select="@name"/>
			</step:Name>
			<xsl:apply-templates/>
		</step:Product>
	</xsl:template>

	<xsl:template match="fyayc:person">
		<step:Product UserTypeID="TEAM_Leaf">
			<xsl:variable name="id" select="concat(../@ID,'_',@ID)"/>
			<xsl:attribute name="ID">
				<xsl:value-of disable-output-escaping="yes" select="concat('TEAM_', digest:md5Hex(xs:string($id)))"/>
			</xsl:attribute>
			<xsl:comment>
				<xsl:value-of select="$id"/>
			</xsl:comment>
			
			
			<step:Name>
				<xsl:value-of select="@name"/>
			</step:Name>
			
			<xsl:for-each select="fyayc:contact">
				<step:ProductCrossReference Type="TEAM_Contact">
					<xsl:attribute name="ProductID">
						<xsl:value-of select="concat('TEAM_',@ID)"/>
					</xsl:attribute>
				</step:ProductCrossReference>
			</xsl:for-each>
			
			<step:Values>
				<step:Value AttributeID="TEAM_Phone">
					<xsl:value-of select="@phone"/>
				</step:Value>
				<step:Value AttributeID="TEAM_Email">
					<xsl:value-of select="@email"/>
				</step:Value>
				<step:Value AttributeID="TEAM_Role">
					<xsl:value-of select="@role"/>
				</step:Value>
				<step:Value AttributeID="TEAM_DateTime">
					<xsl:call-template name="date_fixer">
						<xsl:with-param name="dts" select="@when"/>
					</xsl:call-template>
				</step:Value>
			</step:Values>

		</step:Product>
	</xsl:template>
	
	<xsl:template match="*"/>

    <xsl:template name="date_fixer">
    	<xsl:param name="dts"/>
    	<xsl:value-of select="replace(substring(string($dts), 0, 20), 'T', ' ')"/>
    </xsl:template>
	
</xsl:stylesheet>
