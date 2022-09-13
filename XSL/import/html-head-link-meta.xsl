<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:template name="html-head-link-meta">
        
        <!-- reading project-config.xml into variables -->
        <!-- normalize-space() is essential to strip off the tabs in project-config.xml (given that tabs are there to ensure readability) -->
        
        <xsl:variable name="application-stylesheet-path" select="normalize-space(document('../../XML/project-config.xml')/project-config/application-stylesheet-path)"/>
        <xsl:variable name="project-description" select="normalize-space(document('../../XML/project-config.xml')/project-config/project-description)"/>
        
        <!-- output to html files -->
        <link rel="stylesheet" href="{$application-stylesheet-path}"/>
        <meta charset="utf-8"/>
        <meta name="description"
            content="{$project-description}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
    </xsl:template>
</xsl:stylesheet>
