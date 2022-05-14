<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias" version="1.0">

  <xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*" />

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="targetgroup">
    <xsl:apply-templates select="node()"/>
  </xsl:template>
  
  <xsl:template match="target[not(parent::targetgroup)]">
    <axsl:call-template name="row">
      <axsl:with-param name="naam" select="{@naam}"/>
      <axsl:with-param name="omschrijving" select="{@omschrijving}"/>
    </axsl:call-template>
  </xsl:template>
  
  <xsl:template match="target[parent::targetgroup]">
    <axsl:call-template name="row">
      <axsl:with-param name="naam" select="{concat('concat(',../@naam,', ',@naam,')')}"/>
      <axsl:with-param name="omschrijving" select="{concat('concat(',../@omschrijving,', ',@omschrijving,')')}"/>
    </axsl:call-template>
  </xsl:template>
  
  <xsl:template match="comment()"/>

</xsl:stylesheet>
