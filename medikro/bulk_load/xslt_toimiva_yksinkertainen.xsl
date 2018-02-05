<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="//E[@T='C']">
	<xsl:copy>
	
	<xsl:attribute name="table_name">
		<xsl:value-of select="../../@N"/>
	</xsl:attribute>
	
	<xsl:attribute name="column_name">
		<xsl:value-of select="./@N"/>
	</xsl:attribute>
	
	<xsl:attribute name="row_number">
		<xsl:value-of select="../position()"/>
	</xsl:attribute>
	
	<xsl:attribute name="value">
		<xsl:value-of select="./@V"/>
	</xsl:attribute>
	
  </xsl:copy>
 </xsl:template>
</xsl:stylesheet>
