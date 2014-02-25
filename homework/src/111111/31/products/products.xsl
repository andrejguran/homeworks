<?xml version="1.0" encoding="UTF-8"?>
<!--
    Document   : newstylesheet.xsl
    Created on : Pondelok, 2013, apríl 8, 17:17
    Author     : Andrej
    Description:
        Purpose of transformation follows.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <xsl:text disable-output-escaping='yes'>&lt;?xml version="1.0" encoding="UTF-8"?>
        </xsl:text>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
        </xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Catalogue</title>
                <meta http-equiv="Content-Style-Type" content="text/css"/>
            </head>
            <body>
                <h1>Producers</h1>
                <div style="margin: 1em; background-color: lightgray; padding: 0.5em">
                    <strong>Quick links to producers</strong>
                    <ul>
                        <xsl:for-each select="catalogue/producer">
                            <xsl:if test="@id">
                                <li>
                                    <a href="{concat('#', @id)}">
                                        <b>
                                            <xsl:value-of select="name"/>
                                        </b> ( <xsl:value-of select="@id"/>)</a>
                                </li>
                            </xsl:if>
                        </xsl:for-each>
                    </ul>
                </div>
                <xsl:for-each select="catalogue/producer">
                    <xsl:if test="@id">
                        <div style="border: thin solid gray; margin: 1em; padding: 0.5em;">
                            <h2>
                                <a name="{@id}" id="{@id}">
                                    <xsl:value-of select="name"/>
                                </a>
                            </h2>
                            <xsl:value-of select="description"/>
                            <xsl:choose>
                                <xsl:when test="products[@visible = 'false']">
                                    <div style="color: gray;">
                                        <em>Some products but not visible</em>
                                    </div>
                                </xsl:when>
                                <xsl:when test="not(products/produces)">
                                    <div style="color: gray;">
                                        <em>No products</em>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="products/produces">
                                        <xsl:choose>
                                            <xsl:when test="@visible = 'false'">
                                                <div style="color: gray;">
                                                    <em>An invisible product</em>
                                                </div>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <div style="background-color: lightgray; margin: 0.2em; padding: 0.2em;">
                                                    <a href="{concat('#', @ref)}">
                                                        <xsl:value-of select="//product[@id = current()/@ref]/name"/>
                                                    </a>
                                                </div>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </xsl:if>
                </xsl:for-each>
                <h1>Products</h1>
                <xsl:for-each select="catalogue/product">
                    <div style="border: thin solid gray; margin: 1em; padding: 0.5em;">
                        Product:
                        <strong>
                            <a name="bread500" id="bread500">
                                <xsl:value-of select="name"/>
                            </a>
                        </strong>
                        <xsl:value-of select="description"/>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
