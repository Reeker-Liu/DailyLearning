<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:element name="book">
			<xsl:apply-templates select="/book/section"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="section" name="print">
		<xsl:copy>
			<xsl:copy-of select="./@*"/>
			<xsl:copy-of select="./title"/>
			<xsl:for-each select="./section">
				<xsl:call-template name="print"/>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
