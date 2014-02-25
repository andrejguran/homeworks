<?xml version="1.0
<xsl:stylesheet xml
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Catalogue</title>
                <meta http-equiv="Content-Style-Type" content="text/css"/>
            </head>
            <body>
                <h1>Producers</h1>
                <xsl:for-each select="catalogue/product">
                    <div style="border: thin solid gray; background-color: rgb(184, 208, 233); margin: 1em; padding: 0.5em;">
                        Prod        </a>
                            </h2>
                            <xsl:value-of select="description"/>
                            <xsl:choose>
                                <xsl:when test="products[@visible = 'false']">
                                    <div style="color: red;">
                                        <em>Some products but not visible</em>
                                    </div>
                                </xsl:when>
                                <xsl:when test="not(products/produces)">
                                    <div style="color: red;">
                                        <em>No products</em>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="products/produces">
                                        <xsl:choose>
                                            <xsl:when test="@visible = 'false'">
                                                <div style="color: red;">
                                                    <em>An invisible product</em>
                                                </div>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <div style="background-color: lightgreen; margin: 0.2em; padding: 0.2em;">
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
                
                <div style="margin: 1em; background-color: lightgreen; padding: 0.5em">
                    <strong>Quick links to producers</strong>
                    <ul>
                        <xsl:for-each select="catalogue/producer">
                            <xsl:if test="@id">
                                <li>
                                            <xsl:value-of select="name"/>
                                </li>
                            </xsl:if>
                        </xsl:for-each>
                    </ul>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
