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
    <manifest>
      <xsl:attribute  name="package">
        <xsl:value-of select="concat('edu.icpmd.',namespace)"/>
      </xsl:attribute>
      <xsl:attribute  name="android:versionCode">
        <xsl:value-of select="versioncode"/>
      </xsl:attribute>
      <xsl:attribute  name="android:versionName">
        <xsl:value-of select="versionname"/>
      </xsl:attribute>
      <xsl:text>&#xa;</xsl:text>
      <uses-sdk>
        <xsl:attribute  name="android:minSdkVersion">
          <xsl:text>14</xsl:text>
        </xsl:attribute>
        <xsl:attribute  name="android:targetSdkVersion">
          <xsl:text>17</xsl:text>
        </xsl:attribute>
      </uses-sdk>
      <!-- the permissions list extracted from the permissions tag in the AM and the permissions database -->
      <xsl:text>&#xa;</xsl:text>
      <uses-permission android:name="android.permission.CALL_PHONE"/>
      <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
      <uses-permission android:name="android.permission.SEND_SMS"/>
      <uses-permission android:name="android.permission.INTERNET"/>
      <uses-permission android:name="android.permission.VIBRATE"/>
      <xsl:for-each  select="permissions/permission">
           
      </xsl:for-each>
      <!-- the icon and label of the application extracted from the appinfo tag in the AM -->
      <xsl:text>&#xa;</xsl:text>
      <application      >
        <xsl:attribute name="android:icon" >
          <xsl:if test="contains(icon,'\')=false">
            <xsl:value-of select="translate(concat('@drawable/',substring-before(icon,'.')), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
          </xsl:if>
          <xsl:if test="contains(icon,'\')">
            <xsl:value-of select="translate(concat('@drawable/',substring-before(substring-after(icon,'\'),'.')), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:attribute name="android:label" >
          <xsl:value-of select="title"/>
        </xsl:attribute>

        <xsl:attribute name="android:theme" >@android:style/Theme.Holo.Light</xsl:attribute>
        <!-- the default activity name is extracted from the appinfo tag in the AM -->
        <xsl:text>&#xa;</xsl:text>
        <activity  >
          <xsl:attribute name="android:name" >
            <xsl:value-of select="concat(concat('edu.icpmd.',namespace),concat('.',substring-before(pages/defaultpage,'.')))"/>

          </xsl:attribute>
          <xsl:attribute name="android:label" >


            <xsl:choose>
              <xsl:when test="pages/defaultpage/@title">
                <xsl:value-of select="pages/defaultpage/@title"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="title"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:text>&#xa;</xsl:text>
          <intent-filter>
            <xsl:text>&#xa;</xsl:text>
            <action>
              <xsl:attribute name="android:name" >
                <xsl:text>android.intent.action.MAIN</xsl:text>
              </xsl:attribute>
            </action>
            <xsl:text>&#xa;</xsl:text>
            <category >
              <xsl:attribute name="android:name" >
                <xsl:text>android.intent.category.LAUNCHER</xsl:text>
              </xsl:attribute>
            </category>
            <xsl:text>&#xa;</xsl:text>
          </intent-filter>
          <xsl:text>&#xa;</xsl:text>
        </activity>
        <xsl:text>&#xa;</xsl:text>
        <xsl:for-each  select="pages/page">
          <activity  >
            <xsl:attribute name="android:name" >
              <xsl:value-of select="concat(concat('edu.icpmd.',//namespace),concat('.',substring-before(.,'.')))"/>

            </xsl:attribute>
            <xsl:attribute name="android:label" >
              <xsl:value-of select="@title"/>
            </xsl:attribute>
            <xsl:text>&#xa;</xsl:text>
            <intent-filter>
              <xsl:text>&#xa;</xsl:text>
              <category >
                <xsl:attribute name="android:name" >
                  <xsl:text>android.intent.category.DEFAULT</xsl:text>
                </xsl:attribute>
              </category>
              <xsl:text>&#xa;</xsl:text>
            </intent-filter>
            <xsl:text>&#xa;</xsl:text>
          </activity>
        </xsl:for-each>
      </application>
      <xsl:text>&#xa;</xsl:text>
    </manifest>
  </xsl:template>
</xsl:stylesheet>