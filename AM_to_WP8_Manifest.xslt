<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.0"
xmlns:android="http://schemas.android.com/apk/res/android"
>
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
  <xsl:strip-space elements="*"/>

  <xsl:template  match="/" >
    <!-- the package name and the version of the application extracted from the appinfo tag in the AM -->

    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="application/appinfo">
    <xsl:text>&#xa;</xsl:text>
    <Deployment xmlns="http://schemas.microsoft.com/windowsphone/2012/deployment" AppPlatformVersion="8.0">
      <xsl:text>&#xa;</xsl:text>
      <DefaultLanguage xmlns="" code="en-US" />
      <xsl:text>&#xa;</xsl:text>
      <App xmlns="" >
        <xsl:attribute  name="ProductID">
          <xsl:value-of select="productID"/>
        </xsl:attribute>

        <xsl:attribute  name="Title">
          <xsl:value-of select="title"/>
        </xsl:attribute>

        <xsl:attribute  name="RuntimeType">Silverlight</xsl:attribute>

        <xsl:attribute  name="Version">
          <xsl:value-of select="versionname"/>
        </xsl:attribute>

        <xsl:attribute  name="Genre">
          <xsl:value-of select="type"/>
        </xsl:attribute>

        <xsl:attribute  name="Author">
          <xsl:value-of select="author"/>
        </xsl:attribute>

        <xsl:attribute  name="Publisher">
          <xsl:value-of select="publisher"/>
        </xsl:attribute>

        <xsl:attribute  name="PublisherID">
          <xsl:value-of select="publisherID"/>
        </xsl:attribute>

        <xsl:attribute  name="Description">
          <xsl:value-of select="description"/>
        </xsl:attribute>

        <xsl:text>&#xa;</xsl:text>
        <xsl:text>&#xa;</xsl:text>

        <IconPath>
          <xsl:attribute  name="IsRelative">true</xsl:attribute>
          <xsl:attribute  name="IsResource">false</xsl:attribute>
          <xsl:value-of select="icon"/>
        </IconPath>
        <xsl:text>&#xa;</xsl:text>
        <!-- the permissions list extracted from the permissions tag in the AM and the permissions database -->
        <xsl:text>&#xa;</xsl:text>
        <Capabilities>
          <xsl:for-each  select="Capabilities/Capability">
            <Capability>
              <xsl:attribute name="Name" >
                <xsl:value-of select="@Name"/>
              </xsl:attribute>
            </Capability>
          </xsl:for-each>
        </Capabilities>
        <xsl:text>&#xa;</xsl:text>
        <!-- the icon and label of the application extracted from the appinfo tag in the AM -->
        <xsl:text>&#xa;</xsl:text>
        <Tasks>
          <DefaultTask Name="_default" >
            <xsl:attribute name="NavigationPage" >
              <xsl:value-of select="//pages/defaultpage"/>
            </xsl:attribute>
          </DefaultTask>
        </Tasks>
        <xsl:text>&#xa;</xsl:text>


        <xsl:copy-of select="Tokens"></xsl:copy-of>
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>&#xa;</xsl:text>
        <xsl:copy-of select="ScreenResolutions"></xsl:copy-of>
        <xsl:text>&#xa;</xsl:text>
      </App>
    </Deployment>

  </xsl:template>
</xsl:stylesheet>