<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:Controls="clr-namespace:Microsoft.Phone.Maps.Controls;assembly=Microsoft.Phone.Maps"
xmlns:phone="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone"
xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
xmlns:shell="clr-namespace:Microsoft.Phone.Shell;assembly=Microsoft.Phone"
xmlns:a="http://schemas.microsoft.com/winfx/2006/xaml/presentation">

  <xsl:template match="/">
    <xsl:apply-templates select="phone:PhoneApplicationPage"/>
  </xsl:template>
  <xsl:template match="phone:PhoneApplicationPage">
    <xsl:element name="page">
      <xsl:value-of select="phone:PhoneApplicationPage"/>
      <xsl:element name="class">
        <xsl:value-of select="@x:Class"/>
      </xsl:element>
      <xsl:element name="orientation">
        <xsl:attribute name="support">
          <xsl:value-of select="@SupportedOrientations"/>
        </xsl:attribute>
        <xsl:attribute name="orientation">
          <xsl:value-of select="@Orientation"/>
        </xsl:attribute>
      </xsl:element>
      <xsl:element name="systemtray">
        <xsl:attribute name="visible">
          <xsl:value-of select="@shell:SystemTray.IsVisible"/>
        </xsl:attribute>
      </xsl:element>
      <xsl:apply-templates select="node()"/>

    </xsl:element>
  </xsl:template>

  <xsl:template match="a:Grid">
    <xsl:element name="gridlayout">
      <xsl:attribute name="name">
        <xsl:value-of select="@x:Name"/>
      </xsl:attribute>
      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>
      <xsl:if test="@Grid.Row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::Grid.Row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="rows">
        <xsl:choose>
          <xsl:when test="count(a:Grid.RowDefinitions/a:RowDefinition) &gt; 0">
            <xsl:value-of select="count(a:Grid.RowDefinitions/a:RowDefinition)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="1"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute >

      <xsl:attribute name="columns">
        <xsl:choose>
          <xsl:when test="count(a:Grid.ColumnDefinitions/a:ColumnDefinition) &gt; 0">
            <xsl:value-of select="count(a:Grid.ColumnDefinitions/a:ColumnDefinition)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="1"/>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:attribute >

      <!--<xsl:element name="tablerow">-->
      <xsl:apply-templates select="node()"/>
      <!--</xsl:element>-->
    </xsl:element>

  </xsl:template>

  <xsl:template match="a:StackPanel">
    <xsl:element name="linearlayout">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>
      <xsl:if test="@Grid.Row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::Grid.Row"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="a:TextBlock">
    <xsl:element name="label">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Grid.Row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::Grid.Row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="text">
        <xsl:value-of select="@Text"/>
      </xsl:attribute>
      <xsl:attribute name="isenabled">
        <xsl:value-of select="@IsEnabled"/>
      </xsl:attribute>
      <xsl:attribute name="textwrapping">
        <xsl:value-of select="@TextWrapping"/>
      </xsl:attribute>
      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>

      <xsl:if test="@VerticalAlignment">
        <xsl:attribute name="valign">
          <xsl:value-of select="@VerticalAlignment"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="halign">
          <xsl:value-of select="@HorizontalAlignment"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>

  </xsl:template>

  <xsl:template match="Controls:Map">
    <xsl:element name="map">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="CartographicMode">
        <xsl:value-of select="@CartographicMode"/>
      </xsl:attribute>
      <xsl:attribute name="WatermarkMode">
        <xsl:value-of select="@WatermarkMode"/>
      </xsl:attribute>
      <xsl:attribute name="ColorMode">
        <xsl:value-of select="@ColorMode"/>
      </xsl:attribute>
      <xsl:attribute name="LandmarksEnabled">
        <xsl:value-of select="@LandmarksEnabled"/>
      </xsl:attribute>
    </xsl:element >
  </xsl:template>

  <xsl:template match="a:TextBox">
    <xsl:element name="textbox">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Grid.Row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::Grid.Row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="text">
        <xsl:value-of select="@Text"/>
      </xsl:attribute>
      <xsl:attribute name="textwrapping">
        <xsl:value-of select="@TextWrapping"/>
      </xsl:attribute>
      <xsl:attribute name="isenabled">
        <xsl:value-of select="@IsEnabled"/>
      </xsl:attribute>
      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>
      <xsl:if test="@VerticalAlignment">
        <xsl:attribute name="valign">
          <xsl:value-of select="@VerticalAlignment"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="halign">
          <xsl:value-of select="@HorizontalAlignment"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>

  </xsl:template>

  <xsl:template match="a:Button">
    <xsl:element name="button">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Grid.Row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::Grid.Row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="text">
        <xsl:value-of select="@Content"/>
      </xsl:attribute>
      <xsl:if test="@Click">
        <xsl:attribute name="click">
          <xsl:value-of select="@Click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Tap">
        <xsl:attribute name="tap">
          <xsl:value-of select="@Tap"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="isenabled">
        <xsl:value-of select="@IsEnabled"/>
      </xsl:attribute>

      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>
      <xsl:if test="@VerticalAlignment">
        <xsl:attribute name="valign">
          <xsl:value-of select="@VerticalAlignment"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="halign">
          <xsl:value-of select="@HorizontalAlignment"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>
  </xsl:template>


  <xsl:template match="a:RadioButton ">
    <xsl:element name="radiobutton">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Grid.Row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::Grid.Row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="text">
        <xsl:value-of select="@Content"/>
      </xsl:attribute>
      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>
      <xsl:if test="@Click">
        <xsl:attribute name="click">
          <xsl:value-of select="@Click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Checked">
        <xsl:attribute name="click">
          <xsl:value-of select="@Checked"/>
        </xsl:attribute>
      </xsl:if>     
      <xsl:if test="@Tap">
        <xsl:attribute name="tap">
          <xsl:value-of select="@Tap"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>

      <xsl:attribute name="isenabled">
        <xsl:value-of select="@IsEnabled"/>
      </xsl:attribute>

      <xsl:attribute name="checked">
        <xsl:value-of select="@Checked"/>
      </xsl:attribute>
      <xsl:attribute name="unchecked">
        <xsl:value-of select="@Unchecked"/>
      </xsl:attribute>
      <xsl:if test="@VerticalAlignment">
        <xsl:attribute name="valign">
          <xsl:value-of select="@VerticalAlignment"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="halign">
          <xsl:value-of select="@HorizontalAlignment"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="a:CheckBox">
    <xsl:element name="checkbox">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@Grid.Row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::Grid.Row"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="text">
        <xsl:value-of select="@Content"/>
      </xsl:attribute>
      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>
      <xsl:if test="@Click">
        <xsl:attribute name="click">
          <xsl:value-of select="@Click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Tap">
        <xsl:attribute name="tap">
          <xsl:value-of select="@Tap"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>

      <xsl:attribute name="isenabled">
        <xsl:value-of select="@IsEnabled"/>
      </xsl:attribute>

      <xsl:attribute name="checked">
        <xsl:value-of select="@Checked"/>
      </xsl:attribute>
      <xsl:attribute name="unchecked">
        <xsl:value-of select="@Unchecked"/>
      </xsl:attribute>
      <xsl:if test="@VerticalAlignment">
        <xsl:attribute name="valign">
          <xsl:value-of select="@VerticalAlignment"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="halign">
          <xsl:value-of select="@HorizontalAlignment"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>
  </xsl:template>


  <xsl:template match="a:HyperlinkButton">
    <xsl:element name="button">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="text">
        <xsl:value-of select="@Content"/>
      </xsl:attribute>
      <xsl:if test="@Click">
        <xsl:attribute name="click">
          <xsl:value-of select="@Click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Tap">
        <xsl:attribute name="tap">
          <xsl:value-of select="@Tap"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="isenabled">
        <xsl:value-of select="@IsEnabled"/>
      </xsl:attribute>

      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>
      <xsl:if test="@VerticalAlignment">
        <xsl:attribute name="valign">
          <xsl:value-of select="@VerticalAlignment"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="halign">
          <xsl:value-of select="@HorizontalAlignment"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="a:ListBox ">
    <xsl:element name="listbox">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="selectionchanged">
        <xsl:value-of select="@SelectionChanged"/>
      </xsl:attribute>

      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>
      <xsl:attribute name="isenabled">
        <xsl:value-of select="@IsEnabled"/>
      </xsl:attribute>

      <xsl:if test="@VerticalAlignment">
        <xsl:attribute name="valign">
          <xsl:value-of select="@VerticalAlignment"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Grid.Row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::Grid.Row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="halign">
          <xsl:value-of select="@HorizontalAlignment"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="node()"/>
    </xsl:element>

  </xsl:template>

  <xsl:template match="a:Image">

    <xsl:element name="image">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="height">
        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>
      <xsl:attribute name="isenabled">
        <xsl:value-of select="@IsEnabled"/>
      </xsl:attribute>
      <xsl:if test="@Grid.Row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::Grid.Row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@VerticalAlignment">
        <xsl:attribute name="valign">
          <xsl:value-of select="@VerticalAlignment"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="halign">
          <xsl:value-of select="@HorizontalAlignment"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Source">
        <xsl:attribute name="source">
          <xsl:value-of select="@Source"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="phone:WebBrowser">

    <xsl:element name="webview">
      <xsl:if test="@x:Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@x:Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Name">
        <xsl:attribute name="name">
          <xsl:value-of select="@Name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Grid.Row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::Grid.Row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="height">

        <xsl:value-of select="@Height"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="@Width"/>
      </xsl:attribute>
      <xsl:if test="@VerticalAlignment">
        <xsl:attribute name="valign">
          <xsl:value-of select="@VerticalAlignment"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="halign">
          <xsl:value-of select="@HorizontalAlignment"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@a:Grid.Row">
    <xsl:copy>
      <xsl:attribute name="row">
        <xsl:value-of select="."/>
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>