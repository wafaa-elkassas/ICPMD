<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:android="http://schemas.android.com/apk/res/android" xmlns:tools="http://schemas.android.com/tools" >

  <xsl:template match="/">
    <xsl:apply-templates select="page"/>
  </xsl:template>
  <xsl:template match="page">
    <xsl:element name="LinearLayout">
      <xsl:attribute name="tools:context">
        <xsl:value-of select="concat('.',substring-after(class,'.'))"/>
      </xsl:attribute>
      <xsl:attribute name="android:layout_width">
        <xsl:text>match_parent</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="android:layout_height">
        <xsl:text>match_parent</xsl:text>
      </xsl:attribute>

      <xsl:if test="orientation='Portrait'">
        <xsl:attribute name="android:orientation">vertical</xsl:attribute>
      </xsl:if>

      <xsl:if test="orientation='Landscape'">
        <xsl:attribute name="android:orientation">horizontal</xsl:attribute>
      </xsl:if>


      <xsl:if test="orientation/@orientation">
        <xsl:choose>
          <xsl:when test="orientation/@orientation='Portrait'">
            <xsl:attribute name="android:orientation">
              <xsl:text>vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="orientation/@orientation='Landscape'">
            <xsl:attribute name="android:orientation">
              <xsl:text>horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>

      </xsl:if>

      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="gridlayout">
    <xsl:element name="GridLayout" >
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="android:rowCount">
        <xsl:value-of select="@rows"/>
      </xsl:attribute >

      <xsl:attribute name="android:columnCount">
        <xsl:value-of select="@columns"/>
      </xsl:attribute >

      <xsl:if test="@row">
        <xsl:attribute name="android:layout_row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>

      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="android:layout_height">
          <xsl:value-of select="concat(@height,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="android:layout_width">
          <xsl:value-of select="concat(@width,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height=''">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width=''">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
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
    <xsl:element name="LinearLayout">
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@row">
        <xsl:attribute name="android:layout_row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="not(@height)">
        <xsl:attribute name="android:layout_height">match_parent</xsl:attribute>
      </xsl:if>

      <xsl:if test="not(@width)">
        <xsl:attribute name="android:layout_width">match_parent</xsl:attribute>
      </xsl:if>

      <xsl:if test="//orientation='Portrait'">
        <xsl:attribute name="android:orientation">vertical</xsl:attribute>
      </xsl:if>

      <xsl:if test="//orientation='Landscape'">
        <xsl:attribute name="android:orientation">horizontal</xsl:attribute>
      </xsl:if>

      <xsl:if test="not(@orientation)">
        <xsl:attribute name="android:orientation">vertical</xsl:attribute>
      </xsl:if>

      <xsl:if test="@height!=''">
        <xsl:attribute name="android:layout_height">
          <xsl:value-of select="concat(@height,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="android:layout_width">
          <xsl:value-of select="concat(@width,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height=''">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width=''">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="label">
    <xsl:element name="TextView">
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@row">
        <xsl:attribute name="android:layout_row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>

      </xsl:if>
      <xsl:attribute name="android:text">
        <xsl:value-of select="@text"/>
      </xsl:attribute>
      <xsl:if test="@height!=''">
        <xsl:attribute name="android:layout_height">
          <xsl:value-of select="concat(@height,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="android:layout_width">
          <xsl:value-of select="concat(@width,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height=''">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width=''">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@width='Auto'">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height='Auto'">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign">
        <xsl:choose>
          <xsl:when test="@valign='Bottom'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>bottom</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Top'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>top</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@halign">
        <xsl:choose>
          <xsl:when test="@halign='Left'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>left</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Right'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>right</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

    </xsl:element>

  </xsl:template>

  <xsl:template match="textbox">
    <xsl:element name="EditText">
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@row">
        <xsl:attribute name="android:layout_row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>

      </xsl:if>
      <xsl:attribute name="android:text">
        <xsl:value-of select="@text"/>
      </xsl:attribute>
      <xsl:if test="@height!=''">
        <xsl:attribute name="android:layout_height">
          <xsl:value-of select="concat(@height,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="android:layout_width">
          <xsl:value-of select="concat(@width,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height=''">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@width='Auto'">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@height='Auto'">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@width=''">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign">
        <xsl:choose>
          <xsl:when test="@valign='Bottom'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>bottom</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Top'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>top</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@halign">
        <xsl:choose>
          <xsl:when test="@halign='Left'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>left</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Right'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>right</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

    </xsl:element>
  </xsl:template>
  <xsl:template match="checkbox">
    <xsl:element name="CheckBox">
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="android:text">
        <xsl:value-of select="@text"/>
      </xsl:attribute>
      <xsl:if test="@click">
        <xsl:attribute name="android:onClick">
          <xsl:value-of select="@click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@row">
        <xsl:attribute name="android:layout_row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>

      </xsl:if>
      <xsl:if test="@tap">
        <xsl:attribute name="android:onClick">
          <xsl:value-of select="@tap"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="android:layout_height">
          <xsl:value-of select="concat(@height,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="android:layout_width">
          <xsl:value-of select="concat(@width,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height=''">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width=''">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign">
        <xsl:choose>
          <xsl:when test="@valign='Bottom'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>bottom</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Top'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>top</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@halign">
        <xsl:choose>
          <xsl:when test="@halign='Left'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>left</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Right'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>right</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

    </xsl:element>
  </xsl:template>

  <xsl:template match="radiobutton">
    <xsl:element name="RadioButton">
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="android:text">
        <xsl:value-of select="@text"/>
      </xsl:attribute>
      <xsl:if test="@click">
        <xsl:attribute name="android:onClick">
          <xsl:value-of select="@click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@row">
        <xsl:attribute name="android:layout_row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>

      </xsl:if>
      <xsl:if test="@tap">
        <xsl:attribute name="android:onClick">
          <xsl:value-of select="@tap"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="android:layout_height">
          <xsl:value-of select="concat(@height,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="android:layout_width">
          <xsl:value-of select="concat(@width,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height=''">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width=''">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign">
        <xsl:choose>
          <xsl:when test="@valign='Bottom'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>bottom</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Top'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>top</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@halign">
        <xsl:choose>
          <xsl:when test="@halign='Left'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>left</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Right'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>right</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

    </xsl:element>
  </xsl:template>
  <xsl:template match="button">
    <xsl:element name="Button">
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="android:text">
        <xsl:value-of select="@text"/>
      </xsl:attribute>
      <xsl:if test="@click">
        <xsl:attribute name="android:onClick">
          <xsl:value-of select="@click"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@row">
        <xsl:attribute name="android:layout_row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>

      </xsl:if>
      <xsl:if test="@tap">
        <xsl:attribute name="android:onClick">
          <xsl:value-of select="@tap"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="android:layout_height">
          <xsl:value-of select="concat(@height,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="android:layout_width">
          <xsl:value-of select="concat(@width,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height=''">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width=''">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign">
        <xsl:choose>
          <xsl:when test="@valign='Bottom'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>bottom</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Top'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>top</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@halign">
        <xsl:choose>
          <xsl:when test="@halign='Left'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>left</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Right'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>right</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

    </xsl:element>
  </xsl:template>
  <xsl:template match="map">
    <xsl:element name="fragment">
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="android:layout_height">
        <xsl:text>match_parent</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="android:layout_width">
        <xsl:text>match_parent</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="android:name">
        <xsl:text>com.google.android.gms.maps.MapFragment</xsl:text>
      </xsl:attribute>
    </xsl:element>
  </xsl:template >


  <xsl:template match="listbox">
    <xsl:element name="ListView">
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="android:layout_height">
          <xsl:value-of select="concat(@height,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@row">
        <xsl:attribute name="android:layout_row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>

      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="android:layout_width">
          <xsl:value-of select="concat(@width,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height=''">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width=''">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign">
        <xsl:choose>
          <xsl:when test="@valign='Bottom'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>bottom</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Top'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>top</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@halign">
        <xsl:choose>
          <xsl:when test="@halign='Left'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>left</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Right'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>right</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>
      <xsl:apply-templates select="t"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="image">
    <xsl:element name="ImageView">
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="android:layout_height">
          <xsl:value-of select="concat(@height,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="android:layout_width">
          <xsl:value-of select="concat(@width,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height=''">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width=''">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@source!=''">
        <xsl:attribute name="android:src">

          <xsl:if test="contains(@source,'/')=false">
            <xsl:value-of select="translate(concat('@drawable/',substring-before(@source,'.')), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
          </xsl:if>
          <xsl:if test="contains(@source,'/')">
            <xsl:value-of select="translate(concat('@drawable/',substring-before(substring-after(@source,'/'),'.')), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
          </xsl:if>

        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign">
        <xsl:choose>
          <xsl:when test="@valign='Bottom'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>bottom</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Top'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>top</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@halign">
        <xsl:choose>
          <xsl:when test="@halign='Left'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>left</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Right'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>right</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

    </xsl:element>

  </xsl:template>

  <xsl:template match="webview">

    <xsl:element name="WebView">
      <xsl:if test="@name!=''">
        <xsl:attribute name="android:id">
          <xsl:value-of select="concat('@+id/',@name)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height!=''">
        <xsl:attribute name="android:layout_height">
          <xsl:value-of select="concat(@height,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@row">
        <xsl:attribute name="android:layout_row">
          <xsl:value-of select="@row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width!=''">
        <xsl:attribute name="android:layout_width">
          <xsl:value-of select="concat(@width,'dp')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height=''">
        <xsl:attribute name="android:layout_height">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width=''">
        <xsl:attribute name="android:layout_width">
          <xsl:text>wrap_content</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign">
        <xsl:choose>
          <xsl:when test="@valign='Bottom'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>bottom</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_vertical</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@valign='Top'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>top</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@halign">
        <xsl:choose>
          <xsl:when test="@halign='Left'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>left</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Center'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>center_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Stretch'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>fill_horizontal</xsl:text>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@halign='Right'">
            <xsl:attribute name="android:layout_gravity">
              <xsl:text>right</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

    </xsl:element>
  </xsl:template>
  <xsl:template match="class">
  </xsl:template>

</xsl:stylesheet>