<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*" />

  <xsl:template name="row">
    <xsl:param name="naam"/>
    <xsl:param name="omschrijving"/>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$naam" /></DATA></COL>
      <COL><DATA><xsl:value-of select="$omschrijving" /></DATA></COL>
    </ROW>
  </xsl:template>

  <xsl:template match="/FMPReport">
    <FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">
    	<METADATA>
    		<FIELD NAME="Naam" TYPE="TEXT"/>
    		<FIELD NAME="Omschrijving" TYPE="TEXT"/>
    	</METADATA>
      <RESULTSET>
        <xsl:apply-templates select="File"/>
        <xsl:apply-templates select="File/BaseDirectoryCatalog/BaseDirectoryList/BaseDirectory"/>
        <xsl:apply-templates select="File/BaseTableCatalog/BaseTable"/>
        <xsl:apply-templates select="File/BaseTableCatalog/BaseTable/FieldCatalog/Field"/>
        <xsl:apply-templates select="File/LayoutCatalog//Layout"/>
        <xsl:apply-templates select="File/ScriptCatalog"/>
        <xsl:apply-templates select="File/ThemeCatalog/Theme"/>
      </RESULTSET>
    </FMPXMLRESULT>
  </xsl:template>

  <xsl:template match="File">
    <xsl:variable name="file" select="substring-before(@name,'.fmp12')" />
    <target naam="$file" omschrijving="$file" />
    <target naam="concat($file,'::basedirectory')" omschrijving="concat($file, '>Basismap')" />
    <target naam="concat($file,'::custom menu')" omschrijving="concat($file, '>Menu')" />
    <target naam="concat($file,'::custom menu set')" omschrijving="concat($file, '>Menuverzameling')" />
    <target naam="concat($file,'::file reference')" omschrijving="concat($file, '>Bestandsreferentie')" />
    <target naam="concat($file,'::file status')" omschrijving="concat($file, '>Status bestand')" />
    <target naam="concat($file,'::global function')" omschrijving="concat($file, '>globale functie')" />
    <target naam="concat($file,'::layout')" omschrijving="concat($file, '>Layout')" />
    <target naam="concat($file,'::privileges')" omschrijving="concat($file, '>Privileges')" />
    <target naam="concat($file,'::script')" omschrijving="concat($file, '>Script')" />
    <target naam="concat($file,'::table')" omschrijving="concat($file, '>Tabel')" />
    <target naam="concat($file,'::theme')" omschrijving="concat($file, '>Thema')" />
    <target naam="concat($file,'::value list')" omschrijving="concat($file, '>waardenlijst')" />
  </xsl:template>

  <xsl:template match="File/BaseTableCatalog/BaseTable">
    <xsl:variable name="file" select="substring-before(../../@name,'.fmp12')" />
    <target naam="concat($file,'::table(',@id,')')" omschrijving="concat($file, '>Tabel:', @name)" />
    <target naam="concat($file,'::table(',@id,')::containers')" omschrijving="concat($file, '>Tabel:', @name, '>containers')" />
    <target naam="concat($file,'::table(',@id,')::field definitions')" omschrijving="concat($file, '>Tabel:', @name, '>velddefinities')" />
    <target naam="concat($file,'::table(',@id,')::field index')" omschrijving="concat($file, '>Tabel:', @name, '>veldindex')" />
    <target naam="concat($file,'::table(',@id,')::globals')" omschrijving="concat($file, '>Tabel:', @name, '>globals')" />
    <target naam="concat($file,'::table(',@id,')::master record list')" omschrijving="concat($file, '>Tabel:', @name, '>hoofdrecordlijst')" />
    <target naam="concat($file,'::table(',@id,')::records')" omschrijving="concat($file, '>Tabel:', @name, '>records')" />
  </xsl:template>

  <xsl:template match="File/BaseDirectoryCatalog/BaseDirectoryList/BaseDirectory">
    <xsl:variable name="file" select="substring-before(../../../@name,'.fmp12')" />
    <target naam="concat($file,'::base directory(',@id,')')" omschrijving="concat($file, '>Basismap:', current())" />
  </xsl:template>

  <xsl:template match="File/BaseTableCatalog/BaseTable/FieldCatalog/Field">
    <xsl:variable name="file" select="substring-before(../../../../@name,'.fmp12')" />
    <xsl:variable name="tableid" select="../../@id" />
    <xsl:variable name="table" select="../../@name" />
    <target naam="concat($file,'::table(',$tableid,')::field definitions(',@id,')')" omschrijving="concat($file, '>Tabel:', $table, '>Veld:',  @name)" />
  </xsl:template>

  <xsl:template match="File/LayoutCatalog//Layout">
    <xsl:variable name="file" select="substring-before(./ancestor::File/@name,'.fmp12')" />
    <target naam="concat($file,'::layout(',@id,')')" omschrijving="concat($file, '>Layout:', @name)" />
  </xsl:template>

  <!-- We moeten geneste Script-tags ontwijken omdat Perform Script ook een Script-tag bevat en we dus anders heel wat duplicaten krijgen. -->

  <xsl:template match="File/ScriptCatalog//Script[not(ancestor::Script)]">
    <xsl:variable name="file" select="substring-before(./ancestor::File/@name,'.fmp12')" />
    <target naam="concat($file,'::script(',@id,')')" omschrijving="concat($file, '>Script:', @name)" />
  </xsl:template>

  <xsl:template match="File/ThemeCatalog/Theme">
    <xsl:variable name="file" select="substring-before(../../@name,'.fmp12')" />
    <target naam="concat($file,'::theme(',number(@id),')')" omschrijving="concat($file, '>Thema:', @name)" />
  </xsl:template>

</xsl:stylesheet>
