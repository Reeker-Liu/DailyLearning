<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="all_authors" select="//author"/>
	<xsl:variable name="last_names" select="distinct-values($all_authors/last)"/>
	<xsl:variable name="authors" select="distinct-values($all_authors)"/>
	<xsl:template match="/">
		<xsl:element name="results">
			<xsl:for-each select="$authors">
				<xsl:sort select="."/>
				<xsl:call-template name="print_author"/>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template name="print_author">
		<xsl:variable name="index" select="index-of($authors,.)"/>
		<xsl:element name="result">
			<xsl:element name="author">
				<xsl:element name="last">
					<xsl:value-of select="$last_names[$index]"/>
				</xsl:element>
				<xsl:element name="first">
					<xsl:value-of select="substring-after(.,$last_names[$index])"/>
				</xsl:element>
			</xsl:element>
			<xsl:call-template name="print_title">
				<xsl:with-param name="author_name" select="."/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<xsl:template name="print_title">
		<xsl:param name="author_name" as="xs:string"/>
		<xsl:for-each select="document('bib.xml')//book">
			<xsl:if test="author/string()=$author_name">
				<xsl:copy-of select="title"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
