<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- an example of XSLT 1.0 way: redundant; for ad-hoc FireFox compatibility only -->
    <!-- <xsl:template match="//title">
        <i>
            <xsl:value-of select="." />
        </i>
    </xsl:template> -->

    <xsl:template mode="#all" match="//title">
        <i class="title">
            <xsl:value-of select="." />
        </i>
    </xsl:template>
    <xsl:template mode="#all" match="//emphasis">
        <em>
            <xsl:value-of select="." />
        </em>
    </xsl:template>
    <xsl:template mode="#all" match="//link">
        <a href="{@to}">
            <xsl:value-of select="." />
        </a>
    </xsl:template>    
</xsl:stylesheet>