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
    <targetgroup naam="$file" omschrijving="$file" >
      <target naam="''" omschrijving="''" />
      <target naam="'::basedirectory'" omschrijving="'>Basismap'" />
      <target naam="'::custom menu'" omschrijving="'>Menu'" />
      <target naam="'::custom menu set'" omschrijving="'>Menuverzameling'" />
      <target naam="'::file reference'" omschrijving="'>Bestandsreferentie'" />
      <target naam="'::file status'" omschrijving="'>Status bestand'" />
      <target naam="'::global function'" omschrijving="'>globale functie'" />
      <target naam="'::layout'" omschrijving="'>Layout'" />
      <target naam="'::privileges'" omschrijving="'>Privileges'" />
      <target naam="'::script'" omschrijving="'>Script'" />
      <target naam="'::table'" omschrijving="'>Tabel'" />
      <target naam="'::theme'" omschrijving="'>Thema'" />
      <target naam="'::value list'" omschrijving="'>waardenlijst'" />
    </targetgroup>
  </xsl:template>

  <xsl:template match="File/BaseTableCatalog/BaseTable">
    <xsl:variable name="file" select="substring-before(../../@name,'.fmp12')" />
    <targetgroup naam="concat($file,'::table(',@id,')')" omschrijving="concat($file, '>Tabel:', @name)" >
      <target naam="''" omschrijving="''" />
      <target naam="'::containers'" omschrijving="'>containers'" />
      <target naam="'::field definitions'" omschrijving="'>velddefinities'" />
      <target naam="'::field index'" omschrijving="'>veldindex'" />
      <target naam="'::globals'" omschrijving="'>globals'" />
      <target naam="'::master record list'" omschrijving="'>hoofdrecordlijst'" />
      <target naam="'::records'" omschrijving="'>records'" />
    </targetgroup>
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
