<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:phone="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone"
xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" >
  <xsl:template match="/">
    <xsl:apply-templates select="page"/>
  </xsl:template>
  <xsl:template match="page">
    <xsl:text>&#xa;</xsl:text>
    <phone:PhoneApplicationPage
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:phone="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone"
        xmlns:shell="clr-namespace:Microsoft.Phone.Shell;assembly=Microsoft.Phone"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        mc:Ignorable="d">
      <xsl:attribute name="x:Class">
        <xsl:value-of select="class"></xsl:value-of>
      </xsl:attribute>
      <xsl:attribute name="FontFamily">{StaticResource PhoneFontFamilyNormal}</xsl:attribute>
      <xsl:attribute name="FontSize">{StaticResource PhoneFontSizeNormal}</xsl:attribute>
      <xsl:attribute name="Foreground">{StaticResource PhoneForegroundBrush}</xsl:attribute>
      <xsl:attribute name="SupportedOrientations">
        <xsl:if test="not(orientation)">Portrait</xsl:if>
        <xsl:if test="orientation=''">Portrait</xsl:if>
        <xsl:if test="orientation!=''">
          <xsl:value-of select="orientation"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:attribute name="Orientation">
        <xsl:if test="not(orientation)">Portrait</xsl:if>
        <xsl:if test="orientation=''">Portrait</xsl:if>
        <xsl:if test="orientation!=''">
          <xsl:value-of select="orientation"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:attribute name="shell:SystemTray.IsVisible">True</xsl:attribute>

      <Grid x:Name="LayoutRoot" Background="Transparent">
        <Grid.RowDefinitions>
          <RowDefinition Height="Auto" MinHeight="149"/>
          <RowDefinition/>
        </Grid.RowDefinitions>

        <StackPanel x:Name="TitlePanel" Grid.Row="0" Margin="12,0,0,92">
          <TextBlock Margin="9,-7,0,0"  FontSize="48">
            <xsl:attribute name="Text">
              <xsl:value-of select="title"/>
            </xsl:attribute>
            <xsl:attribute name="Style">{StaticResource PhoneTextTitle1Style}</xsl:attribute>
          </TextBlock>
        </StackPanel>


        <Grid x:Name="ContentPanel" Grid.Row="1" Margin="12,0,12,0" Background="Transparent">

          <xsl:apply-templates/>
        </Grid>
      </Grid>

    </phone:PhoneApplicationPage>
  </xsl:template>

  <xsl:template match="gridlayout">
    <xsl:element name="Grid" >
      <xsl:if test="@name!=''">
        <xsl:attribute name="x:Name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="rowCount">
        <xsl:value-of select="@rows"/>
      </xsl:attribute >

      <xsl:attribute name="columnCount">
        <xsl:value-of select="@columns"/>
      </xsl:attribute >

      <xsl:if test="@row">
        <xsl:attribute name="Grid.Row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>

      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="Height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="Width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="title">
  </xsl:template>
  <xsl:template match="orientation">
  </xsl:template>

  <xsl:template match="linearlayout">
    <xsl:element name="StackPanel">
      <xsl:if test="@name!=''">
        <xsl:attribute name="x:Name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@row">
        <xsl:attribute name="Grid.Row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@valign!=''">
        <xsl:attribute name="VerticalAlignment">
          <xsl:value-of select="@valign"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@halign!=''">
        <xsl:attribute name="HorizontalAlignment">
          <xsl:value-of select="@halign"/>
        </xsl:attribute>
      </xsl:if>
      
      <xsl:if test="@height!=''">
        <xsl:attribute name="Height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="Width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="label">
    <xsl:element name="TextBlock">
      <xsl:if test="@name!=''">
        <xsl:attribute name="x:Name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="Text">
        <xsl:value-of select="@text"/>
      </xsl:attribute>
      <xsl:if test="@click!=''">
        <xsl:attribute name="Click">
          <xsl:value-of select="@click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="Height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="Width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign!=''">
        <xsl:attribute name="VerticalAlignment">
          <xsl:value-of select="@valign"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@halign!=''">
        <xsl:attribute name="HorizontalAlignment">
          <xsl:value-of select="@halign"/>
        </xsl:attribute>
      </xsl:if>


    </xsl:element>

  </xsl:template>

  <xsl:template match="textbox">
    <xsl:element name="TextBox">
      <xsl:if test="@name!=''">
        <xsl:attribute name="x:Name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="Text">
        <xsl:value-of select="@text"/>
      </xsl:attribute>

      <xsl:if test="@click!=''">
        <xsl:attribute name="Click">
          <xsl:value-of select="@click"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@height!=''">
        <xsl:attribute name="Height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="Width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign!=''">
        <xsl:attribute name="VerticalAlignment">
          <xsl:value-of select="@valign"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@halign!=''">
        <xsl:attribute name="HorizontalAlignment">
          <xsl:value-of select="@halign"/>
        </xsl:attribute>
      </xsl:if>


    </xsl:element>
  </xsl:template>

  <xsl:template match="button">
    <xsl:element name="Button">
      <xsl:if test="@name!=''">
        <xsl:attribute name="x:Name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@text!=''">
        <xsl:attribute name="Content">
          <xsl:value-of select="@text"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@click!=''">
        <xsl:attribute name="Click">
          <xsl:value-of select="@click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="Height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="Width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign!=''">
        <xsl:attribute name="VerticalAlignment">
          <xsl:value-of select="@valign"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@halign!=''">
        <xsl:attribute name="HorizontalAlignment">
          <xsl:value-of select="@halign"/>
        </xsl:attribute>
      </xsl:if>

    </xsl:element>
  </xsl:template>

  <xsl:template match="image">

    <xsl:element name="Image">
      <xsl:if test="@name!=''">
        <xsl:attribute name="x:Name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="Source">
        <xsl:value-of select="@text"/>
      </xsl:attribute>
      <xsl:if test="@click!=''">
        <xsl:attribute name="Click">
          <xsl:value-of select="@click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="Height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="Width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign!=''">
        <xsl:attribute name="VerticalAlignment">
          <xsl:value-of select="@valign"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@halign!=''">
        <xsl:attribute name="HorizontalAlignment">
          <xsl:value-of select="@halign"/>
        </xsl:attribute>
      </xsl:if>

    </xsl:element>

  </xsl:template>

  <xsl:template match="webview">

    <xsl:element name="phone:WebBrowser">
      <xsl:if test="@name!=''">
        <xsl:attribute name="x:Name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="IsScriptEnabled">
        <xsl:text>True</xsl:text>
      </xsl:attribute>
      <xsl:if test="@click!=''">
        <xsl:attribute name="Click">
          <xsl:value-of select="@click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="Height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="Width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign!=''">
        <xsl:attribute name="VerticalAlignment">
          <xsl:value-of select="@valign"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@halign!=''">
        <xsl:attribute name="HorizontalAlignment">
          <xsl:value-of select="@halign"/>
        </xsl:attribute>
      </xsl:if>

    </xsl:element>
  </xsl:template>
  <xsl:template match="class">
  </xsl:template>

</xsl:stylesheet>