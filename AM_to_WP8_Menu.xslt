<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:Controls="clr-namespace:Microsoft.Phone.Maps.Controls;assembly=Microsoft.Phone.Maps"
xmlns:phone="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone"
xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
xmlns:shell="clr-namespace:Microsoft.Phone.Shell;assembly=Microsoft.Phone"
xmlns:a="http://schemas.microsoft.com/winfx/2006/xaml/presentation">

  <xsl:template match="/">
    <xsl:element name="menu">
    <xsl:apply-templates select="phone:PhoneApplicationPage/phone:PhoneApplicationPage.ApplicationBar"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="phone:PhoneApplicationPage/phone:PhoneApplicationPage.ApplicationBar">
   
      <xsl:apply-templates select="node()"/>
   
  </xsl:template>

  <xsl:template match="shell:ApplicationBarIconButton">
    <xsl:element name="item">
      <xsl:attribute name="name">
        <xsl:value-of select="@x:Name"/>
      </xsl:attribute>
      <xsl:attribute name="text">
        <xsl:value-of select="@Text"/>
      </xsl:attribute>
      <xsl:attribute name="icon">
        <xsl:value-of select="@IconUri"/>
      </xsl:attribute>
      <xsl:attribute name="click">
        <xsl:value-of select="@Click"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>


