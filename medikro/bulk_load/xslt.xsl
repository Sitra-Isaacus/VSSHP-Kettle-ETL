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

		<xsl:attribute name="path">
			<xsl:call-template name="genPath"/>
	      	</xsl:attribute>

		<xsl:attribute name="depth_of_node">
			<xsl:value-of select="count(ancestor::*)"/>
	      	</xsl:attribute>
	
	  	</xsl:copy>
	 </xsl:template>


	<xsl:template name="genPath">
	    <xsl:param name="prevPath"/>
	    <xsl:variable name="currPath" select="concat('/',name(),'[',
	      count(preceding-sibling::*[name() = name(current())])+1,']',$prevPath)"/>
	    <xsl:for-each select="parent::*">
	      <xsl:call-template name="genPath">
		<xsl:with-param name="prevPath" select="$currPath"/>
	      </xsl:call-template>
	    </xsl:for-each>
	    <xsl:if test="not(parent::*)">
	      <xsl:value-of select="$currPath"/>      
	    </xsl:if>
  	</xsl:template>


</xsl:stylesheet>
