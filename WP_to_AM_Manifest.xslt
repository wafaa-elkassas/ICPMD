<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.0" >
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
  <xsl:strip-space elements="*"/>
  <xsl:template  match="/*" >
    <application>
      <platforms>
        <platform>
          <xsl:attribute name="name">WindowsPhone</xsl:attribute>
          <xsl:attribute name="pxmlns">
            <xsl:copy-of select="@xmlns" />
          </xsl:attribute>
          <xsl:attribute name="version">
            <xsl:value-of select="@AppPlatformVersion" />
          </xsl:attribute>
        </platform>
      </platforms>
      <appinfo>
        <xsl:apply-templates />
      </appinfo>
    </application>
  </xsl:template>
  <xsl:template match="DefaultLanguage">
    <language>
      <xsl:value-of select="@code"/>
    </language>
  </xsl:template>
  <xsl:template match="App">
    <productID>
      <xsl:value-of select="@ProductID"/>
    </productID>
    <title>
      <xsl:value-of select="@Title"/>
    </title>
    <runtimetype>
      <xsl:value-of select="@RuntimeType"/>
    </runtimetype>
    <versioncode>1</versioncode>
    <versionname>
      <xsl:value-of select="@Version"/>
    </versionname>
    <type>
      <xsl:value-of select="@Genre"/>
    </type>
    <author>
      <xsl:value-of select="@Author"/>
    </author>
    <description>
      <xsl:value-of select="@Description"/>
    </description>
    <publisher>
      <xsl:value-of select="@Publisher"/>
    </publisher>
    <publisherID>
      <xsl:value-of select="@PublisherID"/>
    </publisherID>
    <xsl:apply-templates select="IconPath"/>
    <xsl:apply-templates select="Capabilities"/>
    <xsl:apply-templates select="Tasks"/>
    <xsl:apply-templates select="Tokens"/>
    <xsl:apply-templates select="ScreenResolutions"/>
  </xsl:template>
  <xsl:template match="IconPath">
    <icon>
      <xsl:value-of select="."/>
    </icon>
  </xsl:template>
  <xsl:template match="Capabilities">
    <permissions>
      <xsl:for-each select="Capability">
        <permission>
          <xsl:value-of select="@Name"/>
        </permission>
      </xsl:for-each>
    </permissions>
  </xsl:template>
  <xsl:template match="Tasks">
    <pages>
      <xsl:for-each select="DefaultTask">
        <defaultpage>
          <xsl:value-of select="@NavigationPage"/>
        </defaultpage>
      </xsl:for-each>
    </pages>
  </xsl:template>

  <xsl:template match="Tokens">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="ScreenResolutions">
    <xsl:copy-of select="." />
  </xsl:template>
</xsl:stylesheet>
