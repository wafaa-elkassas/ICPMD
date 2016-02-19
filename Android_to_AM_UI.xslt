<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:tools="http://schemas.android.com/tools" xmlns:android="http://schemas.android.com/apk/res/android">
  <!--<xsl:variable name="strings" select="document('../values/strings.xml')"/>-->
  <xsl:template match="/">
    <xsl:element name="page">
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>




  <xsl:template match="GridLayout">
    <xsl:element name="gridlayout">
      <xsl:attribute name="name">
        <xsl:value-of select="substring(@android:id,6)"/>
      </xsl:attribute>
  
    <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="height">
          <xsl:value-of select="substring(@android:layout_height,0, (string-length(@android:layout_height) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) != 'dp'">


        <xsl:choose>
          <xsl:when test="@android:layout_height='wrap_content'">
            <xsl:attribute name="height">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='fill_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='match_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="height">
              <xsl:value-of select="@android:layout_height"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="width">
          <xsl:value-of select="substring(@android:layout_width,0, (string-length(@android:layout_width) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) != 'dp'">
        <xsl:choose>
          <xsl:when test="@android:layout_width='wrap_content'">
            <xsl:attribute name="width">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='fill_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='match_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="width">
              <xsl:value-of select="@android:layout_width"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@android:layout_row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::android:layout_row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="rows">

        <xsl:value-of select="@android:rowCount"/>

      </xsl:attribute >

      <xsl:attribute name="columns">

        <xsl:value-of select="@android:columnCount"/>

      </xsl:attribute >

      <!--<xsl:element name="tablerow">-->
      <xsl:apply-templates select="node()"/>
      <!--</xsl:element>-->
    </xsl:element>

  </xsl:template>

  <xsl:template match="LinearLayout">
    <xsl:element name="linearlayout">
      <xsl:attribute name="name">
        <xsl:value-of select="substring(@android:id,6)"/>
      </xsl:attribute>
 
       <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="height">
          <xsl:value-of select="substring(@android:layout_height,0, (string-length(@android:layout_height) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) != 'dp'">


        <xsl:choose>
          <xsl:when test="@android:layout_height='wrap_content'">
            <xsl:attribute name="height">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='fill_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='match_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="height">
              <xsl:value-of select="@android:layout_height"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="width">
          <xsl:value-of select="substring(@android:layout_width,0, (string-length(@android:layout_width) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) != 'dp'">
        <xsl:choose>
          <xsl:when test="@android:layout_width='wrap_content'">
            <xsl:attribute name="width">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='fill_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='match_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="width">
              <xsl:value-of select="@android:layout_width"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@android:layout_row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::android:layout_row"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="TextView">
    <xsl:element name="label">

      <xsl:attribute name="name">
        <xsl:value-of select="substring(@android:id,6)"/>
      </xsl:attribute>

      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="height">
          <xsl:value-of select="substring(@android:layout_height,0, (string-length(@android:layout_height) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) != 'dp'">


        <xsl:choose>
          <xsl:when test="@android:layout_height='wrap_content'">
            <xsl:attribute name="height">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='fill_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='match_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="height">
              <xsl:value-of select="@android:layout_height"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="width">
          <xsl:value-of select="substring(@android:layout_width,0, (string-length(@android:layout_width) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) != 'dp'">
        <xsl:choose>
          <xsl:when test="@android:layout_width='wrap_content'">
            <xsl:attribute name="width">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='fill_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='match_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="width">
              <xsl:value-of select="@android:layout_width"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@android:layout_row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::android:layout_row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="text">
        
          <xsl:value-of select="@android:text"/>
        
      </xsl:attribute>

      <xsl:attribute name="isenabled">
        <xsl:value-of select="@android:enabled"/>
      </xsl:attribute>
      <xsl:attribute name="textwrapping">
        <xsl:value-of select="@TextWrapping"/>
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

  <xsl:template match="Map">
    <xsl:element name="map">

      <xsl:attribute name="name">
        <xsl:value-of select="@android:id"/>
      </xsl:attribute>

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

  <xsl:template match="TextEdit">
    <xsl:element name="textbox">

      <xsl:attribute name="name">
        <xsl:value-of select="substring(@android:id,6)"/>
      </xsl:attribute>

      <xsl:if test="@android:layout_row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::android:layout_row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="text">
        <xsl:value-of select="@android:text"/>
      </xsl:attribute>
      <xsl:attribute name="textwrapping">
        <xsl:value-of select="@TextWrapping"/>
      </xsl:attribute>
      <xsl:attribute name="isenabled">
        <xsl:value-of select="@android:enabled"/>
      </xsl:attribute>
  

        <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="height">
          <xsl:value-of select="substring(@android:layout_height,0, (string-length(@android:layout_height) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) != 'dp'">


        <xsl:choose>
          <xsl:when test="@android:layout_height='wrap_content'">
            <xsl:attribute name="height">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='fill_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='match_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="height">
              <xsl:value-of select="@android:layout_height"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="width">
          <xsl:value-of select="substring(@android:layout_width,0, (string-length(@android:layout_width) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) != 'dp'">
        <xsl:choose>
          <xsl:when test="@android:layout_width='wrap_content'">
            <xsl:attribute name="width">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='fill_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='match_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="width">
              <xsl:value-of select="@android:layout_width"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
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
    </xsl:element>

  </xsl:template>

  <xsl:template match="Button">
    <xsl:element name="button">

      <xsl:if test="@android:layout_row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::android:layout_row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="name">
        <xsl:value-of select="substring(@android:id,6)"/>
      </xsl:attribute>

      <xsl:attribute name="text">
        <xsl:value-of select="@android:text"/>
      </xsl:attribute>
      <xsl:if test="@android:onClick">
        <xsl:attribute name="click">
          <xsl:value-of select="@android:onClick"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Tap">
        <xsl:attribute name="tap">
          <xsl:value-of select="@Tap"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="isenabled">
        <xsl:value-of select="@android:enabled"/>
      </xsl:attribute>

   
    <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="height">
          <xsl:value-of select="substring(@android:layout_height,0, (string-length(@android:layout_height) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) != 'dp'">


        <xsl:choose>
          <xsl:when test="@android:layout_height='wrap_content'">
            <xsl:attribute name="height">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='fill_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='match_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="height">
              <xsl:value-of select="@android:layout_height"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="width">
          <xsl:value-of select="substring(@android:layout_width,0, (string-length(@android:layout_width) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) != 'dp'">
        <xsl:choose>
          <xsl:when test="@android:layout_width='wrap_content'">
            <xsl:attribute name="width">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='fill_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='match_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="width">
              <xsl:value-of select="@android:layout_width"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>


      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="halign">
          <xsl:value-of select="@HorizontalAlignment"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>
  </xsl:template>


  <xsl:template match="RadioButton ">
    <xsl:element name="radiobutton">


      <xsl:attribute name="name">
        <xsl:value-of select="substring(@android:id,6)"/>
      </xsl:attribute>

      <xsl:if test="@android:layout_row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::android:layout_row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="text">
        <xsl:value-of select="@Content"/>
      </xsl:attribute>
  

        <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="height">
          <xsl:value-of select="substring(@android:layout_height,0, (string-length(@android:layout_height) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) != 'dp'">


        <xsl:choose>
          <xsl:when test="@android:layout_height='wrap_content'">
            <xsl:attribute name="height">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='fill_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='match_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="height">
              <xsl:value-of select="@android:layout_height"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="width">
          <xsl:value-of select="substring(@android:layout_width,0, (string-length(@android:layout_width) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) != 'dp'">
        <xsl:choose>
          <xsl:when test="@android:layout_width='wrap_content'">
            <xsl:attribute name="width">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='fill_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='match_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="width">
              <xsl:value-of select="@android:layout_width"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="@android:onClick">
        <xsl:attribute name="click">
          <xsl:value-of select="@android:onClick"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Tap">
        <xsl:attribute name="tap">
          <xsl:value-of select="@Tap"/>
        </xsl:attribute>
      </xsl:if>


      <xsl:attribute name="isenabled">
        <xsl:value-of select="@android:enabled"/>
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

  <xsl:template match="CheckBox">
    <xsl:element name="checkbox">

      <xsl:if test="@android:layout_row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::android:layout_row"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="name">
        <xsl:value-of select="substring(@android:id,6)"/>
      </xsl:attribute>

      <xsl:attribute name="text">
        <xsl:value-of select="@Content"/>
      </xsl:attribute>

      <xsl:if test="@android:onClick">
        <xsl:attribute name="click">
          <xsl:value-of select="@android:onClick"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@Tap">
        <xsl:attribute name="tap">
          <xsl:value-of select="@Tap"/>
        </xsl:attribute>
      </xsl:if>
  
    <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="height">
          <xsl:value-of select="substring(@android:layout_height,0, (string-length(@android:layout_height) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) != 'dp'">


        <xsl:choose>
          <xsl:when test="@android:layout_height='wrap_content'">
            <xsl:attribute name="height">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='fill_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='match_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="height">
              <xsl:value-of select="@android:layout_height"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="width">
          <xsl:value-of select="substring(@android:layout_width,0, (string-length(@android:layout_width) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) != 'dp'">
        <xsl:choose>
          <xsl:when test="@android:layout_width='wrap_content'">
            <xsl:attribute name="width">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='fill_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='match_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="width">
              <xsl:value-of select="@android:layout_width"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>


      <xsl:attribute name="isenabled">
        <xsl:value-of select="@android:enabled"/>
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



  <xsl:template match="ListBox ">
    <xsl:element name="listbox">

      <xsl:attribute name="name">
        <xsl:value-of select="substring(@android:id,6)"/>
      </xsl:attribute>

      <xsl:attribute name="selectionchanged">
        <xsl:value-of select="@SelectionChanged"/>
      </xsl:attribute>

  
    <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="height">
          <xsl:value-of select="substring(@android:layout_height,0, (string-length(@android:layout_height) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) != 'dp'">


        <xsl:choose>
          <xsl:when test="@android:layout_height='wrap_content'">
            <xsl:attribute name="height">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='fill_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='match_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="height">
              <xsl:value-of select="@android:layout_height"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="width">
          <xsl:value-of select="substring(@android:layout_width,0, (string-length(@android:layout_width) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) != 'dp'">
        <xsl:choose>
          <xsl:when test="@android:layout_width='wrap_content'">
            <xsl:attribute name="width">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='fill_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='match_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="width">
              <xsl:value-of select="@android:layout_width"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:attribute name="isenabled">
        <xsl:value-of select="@android:enabled"/>
      </xsl:attribute>

      <xsl:if test="@VerticalAlignment">
        <xsl:attribute name="valign">
          <xsl:value-of select="@VerticalAlignment"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@android:layout_row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::android:layout_row"/>
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

  <xsl:template match="ImageView ">

    <xsl:element name="image">


      <xsl:attribute name="name">
        <xsl:value-of select="substring(@android:id,6)"/>
      </xsl:attribute>

  

      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="height">
          <xsl:value-of select="substring(@android:layout_height,0, (string-length(@android:layout_height) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) != 'dp'">


        <xsl:choose>
          <xsl:when test="@android:layout_height='wrap_content'">
            <xsl:attribute name="height">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='fill_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='match_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="height">
              <xsl:value-of select="@android:layout_height"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="width">
          <xsl:value-of select="substring(@android:layout_width,0, (string-length(@android:layout_width) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) != 'dp'">
        <xsl:choose>
          <xsl:when test="@android:layout_width='wrap_content'">
            <xsl:attribute name="width">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='fill_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='match_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="width">
              <xsl:value-of select="@android:layout_width"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:attribute name="isenabled">
        <xsl:value-of select="@android:enabled"/>
      </xsl:attribute>
      <xsl:if test="@android:layout_row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::android:layout_row"/>
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
      <xsl:if test="@android:src">
        <xsl:attribute name="source">
          <xsl:value-of select="@android:src"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="WebView">

    <xsl:element name="webview">

      <xsl:attribute name="name">
        <xsl:value-of select="substring(@android:id,6)"/>
      </xsl:attribute>

      <xsl:if test="@android:layout_row">
        <xsl:attribute name="row">
          <xsl:value-of select="attribute::android:layout_row"/>
        </xsl:attribute>
      </xsl:if>
  

       <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="height">
          <xsl:value-of select="substring(@android:layout_height,0, (string-length(@android:layout_height) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_height, (string-length(@android:layout_height) - string-length('dp')) + 1) != 'dp'">


        <xsl:choose>
          <xsl:when test="@android:layout_height='wrap_content'">
            <xsl:attribute name="height">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='fill_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_height='match_parent'">
            <xsl:attribute name="valign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="height">
              <xsl:value-of select="@android:layout_height"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) = 'dp'">
        <xsl:attribute name="width">
          <xsl:value-of select="substring(@android:layout_width,0, (string-length(@android:layout_width) - string-length('dp')) + 1)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="substring(@android:layout_width, (string-length(@android:layout_width) - string-length('dp')) + 1) != 'dp'">
        <xsl:choose>
          <xsl:when test="@android:layout_width='wrap_content'">
            <xsl:attribute name="width">Auto</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='fill_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:when test="@android:layout_width='match_parent'">
            <xsl:attribute name="halign">Stretch</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="width">
              <xsl:value-of select="@android:layout_width"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
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
    </xsl:element>
  </xsl:template>


</xsl:stylesheet>