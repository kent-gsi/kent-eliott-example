<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
   
    <xsl:template name="html-nav">
        
        <!--xsl:param is more robust xsl:variable and is therefore reserved for more complex situations (in this case a tunnel parameter)  -->
        <xsl:param name="current-tab" tunnel="yes" as="xs:string" required="yes" />
        <!-- local variables are defined through xsl:variable -->
        <xsl:variable name="default-class-name" select="'nav__item'" as="xs:string" />
        <xsl:variable name="active-class-name" select="'nav__item--current'" as="xs:string" />
        
        <nav id="navigation" class="navbar" role="navigation">
            <span id="toggle" class="icn--nav-toggle is-displayed-mobile">
                <b class="srt">Toggle</b>
            </span>
            <ul id="nav-items" class="nav is-collapsed-mobile">
                <li class="nav__item">
                    <a href="../index.html">Home</a>
                </li>
                <li>
                    <xsl:attribute name="class">
                        <xsl:choose>
                            <xsl:when test="$current-tab = 'letter-index'">
                                <xsl:value-of select="$active-class-name"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$default-class-name" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <a href="letter-index.html">Letter index</a>
                </li>

                <li>
                    <xsl:attribute name="class">
                        <xsl:choose>
                            <xsl:when test="$current-tab = 'letter-components'">
                                <xsl:value-of select="$active-class-name"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$default-class-name" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <a href="letter-components.html">Components of Letters</a>
                </li>
                <li>
                    <xsl:attribute name="class">
                        <xsl:choose>
                            <xsl:when test="$current-tab = 'interesting-quotes'">
                                <xsl:value-of select="$active-class-name"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$default-class-name" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <a href="interesting-quotes.html">Interesting Quotes</a>
                </li>
            </ul>

        </nav>

    </xsl:template>


</xsl:stylesheet>
