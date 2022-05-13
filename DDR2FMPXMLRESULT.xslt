<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="" />

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
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" /></DATA></COL>
      <COL><DATA><xsl:value-of select="$file" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::basedirectory</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Basismap')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::custom menu</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Menu')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::custom menu set</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Menuverzameling')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::file reference</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Bestandsreferentie')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::file status</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Status bestand')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::global function</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Status bestand')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::layout</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Layout')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::privileges</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Privileges')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::script</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Script')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::table</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Tabel')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::theme</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Thema')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::value list</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>waardenlijst')" /></DATA></COL>
    </ROW>
  </xsl:template>

  <xsl:template match="File/BaseTableCatalog/BaseTable">
    <xsl:variable name="file" select="substring-before(../../@name,'.fmp12')" />
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::table(<xsl:value-of select="@id" />)</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Tabel:', @name)" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::table(<xsl:value-of select="@id" />)::containers</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Tabel:', @name, '>containers')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::table(<xsl:value-of select="@id" />)::field definitions</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Tabel:', @name, '>velddefinities')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::table(<xsl:value-of select="@id" />)::field index</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Tabel:', @name, '>veldindex')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::table(<xsl:value-of select="@id" />)::globals</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Tabel:', @name, '>globals')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::table(<xsl:value-of select="@id" />)::master record list</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Tabel:', @name, '>hoofdrecordlijst')" /></DATA></COL>
    </ROW>
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::table(<xsl:value-of select="@id" />)::records</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Tabel:', @name, '>records')" /></DATA></COL>
    </ROW>
  </xsl:template>

  <xsl:template match="File/BaseDirectoryCatalog/BaseDirectoryList/BaseDirectory">
    <xsl:variable name="file" select="substring-before(../../../@name,'.fmp12')" />
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::base directory(<xsl:value-of select="@id" />)</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Basismap:', current())" /></DATA></COL>
    </ROW>
  </xsl:template>

  <xsl:template match="File/BaseTableCatalog/BaseTable/FieldCatalog/Field">
    <xsl:variable name="file" select="substring-before(../../../../@name,'.fmp12')" />
    <xsl:variable name="tableid" select="../../@id" />
    <xsl:variable name="table" select="../../@name" />
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::table(<xsl:value-of select="$tableid" />)::field definitions(<xsl:value-of select="@id" />)</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Tabel:', $table, '>Veld:',  @name)" /></DATA></COL>
    </ROW>
  </xsl:template>

  <xsl:template match="File/LayoutCatalog//Layout">
    <xsl:variable name="file" select="substring-before(./ancestor::File/@name,'.fmp12')" />
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::layout(<xsl:value-of select="@id" />)</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Layout:', @name)" /></DATA></COL>
    </ROW>
  </xsl:template>

  <!-- File/ScriptCatalog//Script werkt niet (goed) omdat Perform Script ook een Script-tag bevat en we dus heel wat duplicaten krijgen. -->

  <xsl:template match="File/ScriptCatalog">
    <xsl:apply-templates select="Script"/>
    <xsl:apply-templates select="//Group"/>
  </xsl:template>

  <xsl:template match="//Group">
    <xsl:apply-templates select="Script"/>
  </xsl:template>

  <xsl:template match="Script">
    <xsl:variable name="file" select="substring-before(./ancestor::File/@name,'.fmp12')" />
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::script(<xsl:value-of select="@id" />)</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Script:', @name)" /></DATA></COL>
    </ROW>
  </xsl:template>

  <xsl:template match="File/ThemeCatalog/Theme">
    <xsl:variable name="file" select="substring-before(../../@name,'.fmp12')" />
    <ROW xmlns="http://www.filemaker.com/fmpxmlresult">
      <COL><DATA><xsl:value-of select="$file" />::theme(<xsl:value-of select="number(@id)" />)</DATA></COL>
      <COL><DATA><xsl:value-of select="concat($file, '>Theme:', @name)" /></DATA></COL>
    </ROW>
  </xsl:template>

</xsl:stylesheet>
