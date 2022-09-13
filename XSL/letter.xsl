<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- output to multiple html files -->
    <xsl:output method="html" indent="yes"/>
    <xsl:template match="/">
        <xsl:for-each select="/letters/letter/@id">
            <xsl:result-document method="html" href="../HTML/letter-{.}.html">
                <xsl:apply-templates mode="outputHTML" select="parent::node()"/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

    <!-- shared among xslts -->
    <xsl:import href="import/html-head-link-meta.xsl"/>
    <xsl:import href="import/html-nav.xsl"/>
    <xsl:import href="import/xsl-match-all.xsl"/>

    <xsl:variable name="project-title"
        select="normalize-space(document('../XML/project-config.xml')/project-config/project-title)"/>

    <!-- mode: technically redudant, and yet it perpares for future templates which might also query /letters/letter -->
    <!--       good for semantics as well -->
    <xsl:template mode="outputHTML" match="/letters/letter">
        <!-- root template -->
        <html class="no-js" lang="en">
            <head>
                <title> Letter <xsl:value-of select="@id"/>
                    <xsl:text> - </xsl:text>
                    <xsl:value-of select="info/output-title-prefix"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="info/recipient/text()"/>
                    <xsl:text> - </xsl:text>
                    <xsl:value-of select="$project-title"/>
                </title>
                <xsl:call-template name="html-head-link-meta"/>
            </head>
            <body>
                <!--[if lte IE 9]>
                    <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
                    <![endif]-->
                <xsl:call-template name="html-nav">
                    <xsl:with-param name="current-tab" tunnel="yes" select="'letter-index'"
                        as="xs:string"/>
                </xsl:call-template>

                <header id="letter-index" class="panel" role="banner">
                    <h1 class="headline-primary">
                        <span class="main-title">Letter <xsl:value-of select="@id"/></span>
                        <br/>
                        <span class="source-book-title">
                            <i>from </i>
                            <xsl:value-of select="info/source/source-book-title"/>
                        </span>
                    </h1>

                </header>

                <section id="letter-container">
                    <xsl:apply-templates select="info"/>
                    <xsl:apply-templates select="body"/>
                </section>

                <!-- HTML FOOTER -->
                <div class="grid">
                    <footer class="grid__col--12 panel--padded--centered" role="contentinfo">
                        <div class="footnotes">
                            <h3 id="footnote-label">Footnotes</h3>
                            <ol>
                                <xsl:apply-templates mode="footnotes" select=".//note"/>
                            </ol>
                        </div>
                        <p>
                            <a rel="license"
                                href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
                                <img alt="Creative Commons License" style="border-width:0"
                                    src="https://i.creativecommons.org/l/by-nc-sa/4.0/80x15.png"/>
                            </a>
                        </p>
                    </footer>
                </div>
            </body>
        </html>
    </xsl:template>

    <!--                                       -->
    <!-- Template for letter/info starts here  -->
    <!--                                       -->
    <xsl:template match="info">
        <h2 class="grid">
            <span>
                <xsl:value-of select="output-title-prefix"/>
            </span>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="recipient"/>
        </h2>
        <div class="grid">
            <div class="centered grid__col--12">
                <div class="breadcrumb">
                    <span>You are here: <a href="../index.html"> Home </a>
                        <a href="letter-index.html">Index of Letters</a>
                        <a href="#">Letter <xsl:value-of select="parent::node()/@id"/>
                        </a>
                    </span>
                </div>
                <div id="letter-info">
                    <h3> Eliot at age <xsl:value-of select="tse-age"/></h3>
                    <p id="source">
                        <span class="source-archive-status">
                            <xsl:value-of select="source/source-archive-status"/>
                        </span>
                        <xsl:text> </xsl:text>
                        <span>
                            <xsl:value-of select="source/source-archive-name"/>
                        </span>
                    </p>
                    <p id="date">
                        <xsl:choose>
                            <xsl:when test="date/@type = 'supplied'">
                                <xsl:value-of select="date"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="date/day"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="date/month"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="date/year"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </p>
                    <p id="address">
                        <xsl:choose>
                            <xsl:when test="address/@type = 'full'">
                                <xsl:value-of select="address/address-line"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="address/city"/>
                                <xsl:text> </xsl:text>
                                <span class="postcode">
                                    <xsl:value-of select="address/postcode"/>
                                </span>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="address/text() | address/title"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </p>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="recipient">
        <xsl:apply-templates select="text()"/>
        <xsl:apply-templates select="note"/>
    </xsl:template>


    <!--                                       -->
    <!-- Template for letter/body starts here  -->
    <!--                                       -->
    <xsl:template match="body">
        <div id="letter-body" class="grid">
            <p>
                <xsl:value-of select="greeting/greeting-text"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="greeting/greeting-name"/>
                <xsl:value-of select="greeting/greeting-punct"/>
            </p>
            <xsl:apply-templates select="para"/>
            <p>
                <xsl:value-of select="closer/closer-text"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="closer/closer-name"/>
            </p>
            <p>
                <xsl:apply-templates select="postscript" />
            </p>
        </div>
    </xsl:template>

    <xsl:template match="closer/closer-name">
        <div class="closer-name">
            <p>
                <xsl:apply-templates select="text()"/>
                <xsl:apply-templates select="note"/>
            </p>
        </div>
    </xsl:template>




    <xsl:template match="para">

        <p>
            <xsl:apply-templates select="text() | quote | note | title | emphasis | list"/>
        </p>
        <!--<b>end para</b><br />-->
    </xsl:template>
    <!--
    <xsl:template match="*" mode="para">
        <xsl:if test="para">
            <p>
                <xsl:for-each select="para">
                    <xsl:value-of select="."/>
                </xsl:for-each>
            </p>
        </xsl:if>
        <xsl:if test="note">
            <xsl:apply-templates select="note" mode="inBody"/>
        </xsl:if>
        <xsl:if test="quote">
            <xsl:for-each select="quote">
                <xsl:value-of select="."/>
            </xsl:for-each>
        </xsl:if>        
    </xsl:template>
    -->


    <xsl:template match="quote">
        <xsl:apply-templates select="text() | note |  title | emphasis | place-name | person-name"/>
    </xsl:template>

    <xsl:template match="list">
        <!--<b>start match list</b>-->
        <xsl:if test="@type = 'unnumbered'">
            <ul class="unnumbered">
                <xsl:for-each select="item">
                    <li>
                        <xsl:apply-templates select="text()"/>
                        <xsl:apply-templates select="note"/>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
        <!--<b>end match list</b>-->
    </xsl:template>

    <xsl:template match="note">
        <!--<b>start match note</b>-->
        <a aria-describedby="footnote-label" href="#footnote-{@n}">
            <xsl:apply-templates select="text()"/>
        </a>
        <!--<b>end match note</b>-->
    </xsl:template>

    <xsl:template match="note/text()"/>



    <xsl:template mode="footnotes" match="/letters/letter//note">
        <!--<xsl:for-each select="//note">-->

        <!-- The  -->
        <li id="footnote-{position()}">
            <span class="footnote-label"> p. <xsl:choose>
                    <!-- Notes that appear before the first page break (i.e. notes for the first page of each letter) won't have any preceding page break, so we need to supply the fist page number as encoded in <source-book-page-no-start>.  -->
                    <!-- CONDITION: (1) print preceding page-break/@pn if it exists -->
                    <xsl:when test="(preceding::page-break/@pn)[last()] &gt;= '1'">
                        <xsl:value-of select="(preceding::page-break/@pn)[last()]"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- CONDITION (2): print <source-book-page-no-start> otherwise  -->
                        <!-- the following select: (nots under body) | (notes within recipient)  -->
                        <xsl:value-of select="preceding::info//descendant::source-book-page-no-start | ancestor::info//descendant::source-book-page-no-start"/>
                    </xsl:otherwise>
                </xsl:choose> , n <xsl:value-of select="@n"/>
            </span>
            <xsl:text> </xsl:text>
            <xsl:apply-templates mode="footnotes" select="text() | title | link"/>
        </li>

        <!-- </xsl:for-each>-->

    </xsl:template>

    <xsl:template mode="footnotes" match="//note/text()">
        <!-- COMPATIBILITY: disable-output-escaping not supported by FireFox -->
        <xsl:value-of select="." disable-output-escaping="yes"/>
    </xsl:template>

</xsl:stylesheet>
