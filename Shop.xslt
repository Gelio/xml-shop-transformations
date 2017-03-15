<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:shop="http://www.mini.pw.edu.pl/~poLab/"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="html" indent="yes"/>

  <xsl:template name="Product">
    <td>
      <xsl:number value="position()"/>
    </td>
    <td>
      <xsl:value-of select="shop:Name"/>
    </td>
    <td>
      <xsl:value-of select="format-number(shop:Price, '###,###.##')"/>
    </td>
  </xsl:template>

  <xsl:template match="shop:Product1">
    <tr>
      <xsl:choose>
        <xsl:when test="position() mod 4 = 1">
          <xsl:attribute name="style">
            background-color: cornflowerblue;
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="style">
            background-color: gainsboro;
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="Product" />
      <td>
        <xsl:value-of select="shop:Length"/>
      </td>
      <xsl:variable name="type" select="shop:ProductType" />
      <td>
        <xsl:value-of select="$type"/>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="contains($type, 'A') or contains($type, 'B')">
            Yes
          </xsl:when>
          <xsl:otherwise>
            No
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="shop:Product2">
    <tr>
      <xsl:call-template name="Product" />
      <td>
        <xsl:value-of select="shop:Weight"/>
      </td>
    </tr>
  </xsl:template>

    <xsl:template match="/shop:Shop">
      <html>
        <head>
          <title>Shop</title>
        </head>
        <body>
          <div>
            <h1>Product1</h1>
            <table border="1">
              <tr>
                <th>Row</th>
                <th>Name</th>
                <th>Price</th>
                <th>Length</th>
                <th>Product Type</th>
                <th>A or B</th>
              </tr>
              <tbody>
                <xsl:apply-templates select="shop:Product1">
                  <xsl:sort select="shop:Price"/>
                </xsl:apply-templates>
              </tbody>
            </table>
          </div>

          <div>
            <h1>Product2</h1>
            <table border="1">
              <tr>
                <th>Row</th>
                <th>Name</th>
                <th>Price</th>
                <th>Weight</th>
              </tr>
              <tbody>
                <xsl:apply-templates select="shop:Product2"/>
              </tbody>
            </table>
          </div>

          <div>
            <h1>Static counter</h1>
            <table border="1">
              <tr>
                <th>Product type</th>
                <th>Count</th>
              </tr>
              <tbody>
                <tr>
                  <td>A</td>
                  <td>
                    <xsl:value-of select="count(shop:Product1[shop:ProductType = 'A'])"/>
                  </td>
                </tr>
                <tr>
                  <td>B</td>
                  <td>
                    <xsl:value-of select="count(shop:Product1[shop:ProductType = 'B'])"/>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>


          <div>
            <h1>Dynamic counter</h1>
            <table border="1">
              <tr>
                <th>Product type</th>
                <th>Count</th>
              </tr>
              <tbody>
                <xsl:for-each select="shop:Product1/shop:ProductType[not(.=preceding::*)]">
                  <tr>
                    <td>
                      <xsl:value-of select="."/>
                    </td>
                    <td>
                      <xsl:value-of select="count(//shop:Product1[shop:ProductType = current()])" />
                    </td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </div>
        </body>
      </html>
    </xsl:template>
</xsl:stylesheet>
