<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:android="http://schemas.android.com/apk/res/android" >
  <xsl:template match="/">
    <xsl:apply-templates select="menu"/>
  </xsl:template>
  <xsl:template match="menu">
    <xsl:element name="menu" >
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="item">
    <xsl:element name="item" >
      <xsl:if test="@name!=''">
      <xsl:attribute name="android:id" >
        <xsl:value-of select="concat('@+id/',@name)"/>
      </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="android:title">
        <xsl:value-of select="@text"/>
      </xsl:attribute>
      <xsl:attribute name="android:icon">
        <xsl:if test="contains(@icon,'/')=false">
          <xsl:value-of select="translate(concat('@drawable/',substring-before(@icon,'.')), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
        </xsl:if>
        <xsl:if test="contains(@icon,'/')">
          <xsl:value-of select="translate(concat('@drawable/',substring-before(substring-after(substring-after(@icon,'/'),'/'),'.')), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:attribute name="android:onClick">
        <xsl:value-of select="@click"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>