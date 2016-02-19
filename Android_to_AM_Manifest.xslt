<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.0"
xmlns:android="http://schemas.android.com/apk/res/android"
>
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
  <xsl:strip-space elements="*"/>
  <xsl:template  match="/*" >
    <application>
      <platforms>
        <platform>
          <xsl:attribute name="name">Android</xsl:attribute>
          <xsl:attribute name="pxmlns">
            <xsl:copy-of select="@xmlns" />
          </xsl:attribute>
          <xsl:attribute name="version">
            <xsl:value-of select="uses-sdk/@android:targetSdkVersion" />
          </xsl:attribute>
        </platform>
      </platforms>
      <appinfo>
        <language>en-US</language>

        <productID></productID>
        <title>
          <xsl:value-of select="application/@android:label"/>
        </title>
        <runtimetype>Silverlight</runtimetype>
        <versioncode>
          <xsl:value-of select="@android:versionCode"/>
        </versioncode>
        <versionname>
          <xsl:value-of select="@android:versionName"/>
        </versionname>
        <type>apps.normal</type>
        <author>
          <xsl:value-of select="concat(application/@android:label,' Author')"/>
        </author>
        <description>
          <xsl:value-of select="concat(application/@android:label,' description')"/>
        </description>
        <publisher>
          <xsl:value-of select="concat(application/@android:label,' Publisher')"/>
        </publisher>
        <publisherID></publisherID>
        <icon>
          <xsl:value-of select="concat(concat('Assets\',substring(application/@android:icon,11)),'.png')"/>
        </icon>

        <permissions>
          <xsl:for-each select="Capability">
            <permission>
              <xsl:value-of select="@Name"/>
            </permission>
          </xsl:for-each>
        </permissions>
        <namespace>
          <xsl:value-of select="application/@android:label"/>
        </namespace>


        <pages>
          <xsl:for-each select="application/activity">
            <xsl:if test="//application/activity/intent-filter/action/@android:name='android.intent.action.MAIN'">
              <defaultpage>
                <xsl:value-of select="concat(substring(//application/activity/@android:name,2),'.xaml')"/>
              </defaultpage>
            </xsl:if>
            <xsl:if test="//application/activity/intent-filter/action/@android:name!='android.intent.action.MAIN'">
              <page>
                <xsl:value-of select="concat(substring(//application/activity/@android:name,2),'.xaml')"/>
              </page>
            </xsl:if>

          </xsl:for-each>
        </pages>

        <Tokens>
          <PrimaryToken TokenID="cameraToken" TaskName="_default">
            <TemplateFlip>
              <SmallImageURI IsRelative="true" IsResource="false">Assets\Tiles\FlipCycleTileSmall.png</SmallImageURI>
              <Count>0</Count>
              <BackgroundImageURI IsRelative="true" IsResource="false">Assets\Tiles\FlipCycleTileMedium.png</BackgroundImageURI>
              <Title>
                <xsl:value-of select="application/@android:label"/>
              </Title>
              <BackContent />
              <BackBackgroundImageURI />
              <BackTitle />
              <DeviceLockImageURI />
              <HasLarge />
            </TemplateFlip>
          </PrimaryToken>
        </Tokens>
        <ScreenResolutions>
          <ScreenResolution Name="ID_RESOLUTION_WVGA" />
          <ScreenResolution Name="ID_RESOLUTION_WXGA" />
          <ScreenResolution Name="ID_RESOLUTION_HD720P" />
        </ScreenResolutions>
      </appinfo>
    </application>




  </xsl:template>

</xsl:stylesheet>
