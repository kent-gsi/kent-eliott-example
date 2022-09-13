<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:import href="import/html-head-link-meta.xsl"/>
    <xsl:import href="import/html-nav.xsl"/>
    <xsl:import href="import/html-footer.xsl"/>

    <xsl:variable name="project-title"
        select="normalize-space(document('../XML/project-config.xml')/project-config/project-title)"/>

    <xsl:template match="/">
        <xsl:param name="nav-content"/>
        <!-- root template -->
        <html class="no-js" lang="en">
            <head>
                <title> Interesting Quotes - <xsl:value-of select="$project-title"/>
                </title>
                <xsl:call-template name="html-head-link-meta"/>

            </head>
            <body>
                <!--[if lte IE 9]>
                    <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
                    <![endif]-->

                <header id="interesting-quotes" class="panel" role="banner">
                    <h1 class="headline-primary">
                        <span class="main-title">Interesting <br/>Quotes</span>
                    </h1>
                </header>

                <xsl:call-template name="html-nav">
                    <xsl:with-param name="current-tab" tunnel="yes" select="'interesting-quotes'"
                        as="xs:string"/>
                </xsl:call-template>

                <section id="interesting-quotes">
                    <div class="grid breadcrumb">
                        <span>You are here: <a href="../index.html"> Home </a>
                            <a href="#">Interesting Quotes</a>
                        </span>
                    </div>
                    <div class="grid">
                        <div class="centered grid__col--12">
                            
                            <p>This page collects some quotes where a certain name or a person a place is mentioned. Blank cell indicates that particular letter does not have relevant information. </p>
                            <h2>Places T.S. Eliot mentioned </h2>
                            <h3> Statistics</h3>
                            <xsl:call-template name="display-place-stats"/>

                            <h3> Contexts </h3>
                            <table>
                                <colgroup>
                                    <col style="width:3%"/>
                                    <col style="width:15%"/>
                                    <col style="width:12%"/>
                                    <col style="width:70%"/>
                                </colgroup>
                                <thead class="tbl-header">
                                    <tr>
                                        <th>#</th>
                                        <th>Date</th>
                                        <th>Recipient</th>
                                        <th>Context</th>
                                    </tr>
                                </thead>
                                <tbody class="tbl-content">
                                    <xsl:apply-templates mode="context-place" select="letters/*"/>
                                </tbody>
                            </table>

                            <!-- Person -->
                            <h2>People T.S. Eliot mentioned </h2>

                            <p>At present, for the sake of simplicity, we have encoded only names.
                                In the future we might also include pronouns as well as other nouns
                                referring to a person. </p>

                            <h3> Statistics</h3>
                            <xsl:call-template name="display-person-stats"/>

                            <h3> Contexts </h3>
                            <table>
                                <colgroup>
                                    <col style="width:3%"/>
                                    <col style="width:15%"/>
                                    <col style="width:12%"/>
                                    <col style="width:70%"/>
                                </colgroup>
                                <thead class="tbl-header">
                                    <tr>
                                        <th>#</th>
                                        <th>Date</th>
                                        <th>Recipient</th>
                                        <th>Context</th>
                                    </tr>
                                </thead>
                                <tbody class="tbl-content">
                                    <xsl:apply-templates mode="context-person" select="letters/*"/>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </section>

                <!-- HTML FOOTER -->
                <xsl:call-template name="html-footer"/>
            </body>
        </html>
    </xsl:template>

    <!-- TODO: -->
    <!-- quotes inside quotes -->
    <!-- should try to abstract the following two templates, possibly by passing a param. -->

    <!--                      -->
    <!-- TEMPLATES FOR PLACES -->
    <!--                      -->

    <!-- stat: PLACES -->
    <xsl:template name="display-place-stats">
        <xsl:variable name="place-name-seq" as="xs:string*">
            <xsl:for-each-group select="//quote" group-by="place-name/text()">
                <xsl:sequence select="current-grouping-key()"/>
            </xsl:for-each-group>
        </xsl:variable>

        <xsl:variable name="place-name-count-seq" as="xs:integer*">
            <xsl:for-each-group select="//quote" group-by="place-name/text()">
                <xsl:sequence select="count(current-group())"/>
            </xsl:for-each-group>
        </xsl:variable>

        <table class="stat">
            <colgroup>
                <col style="width:15%"/>
                <col style="width:12%"/>
            </colgroup>
            <thead class="tbl-header">
                <tr>
                    <th>Place</th>
                    <th>Count</th>
                </tr>
            </thead>
            <tbody class="tbl-content">
                <tr>
                    <td>
                        <xsl:for-each select="$place-name-seq">
                            <xsl:value-of select="."/>
                            <br/>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="$place-name-count-seq">
                            <xsl:value-of select="."/>
                            <br/>
                        </xsl:for-each>
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>
    <!-- context: PLACES -->
    <xsl:template mode="context-place" match="letters/*">
        <tr>
            <td>
                <!-- ID -->
                <a href="letter-{@id}.html">
                    <xsl:value-of select="@id"/>
                </a>
            </td>
            <td>
                <!-- Date -->
                <xsl:choose>
                    <xsl:when test="info/date/@type = 'supplied'">
                        <a href="letter-{@id}.html">
                            <xsl:value-of select="info/date"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <a href="letter-{@id}.html">
                            <xsl:value-of select="info/date/day"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="info/date/month"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="info/date/year"/>
                        </a>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <!-- Recipient -->
                <xsl:value-of select="info/recipient/text()"/>
            </td>
            <td class="context">
                <!-- Quotes -->
                <xsl:apply-templates select="body/para/quote[@type = 'place']"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="letter/body/para/quote[@type = 'place']">
        <xsl:choose>
            <xsl:when test="text() = ''"> Nothing! </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li>
                        <xsl:apply-templates mode="display-place-quotes"
                            select="text() | place-name"/> 
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template mode="display-place-quotes" match="place-name">
        <span class="place-name">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>

    <!--                      -->
    <!-- TEMPLATES FOR PERSON -->
    <!--                      -->
    <!-- stat: PERSON-NAMES -->
    <xsl:template name="display-person-stats">
        <xsl:variable name="person-name-seq" as="xs:string*">
            <xsl:for-each-group select="//quote" group-by="person-name/text()">
                <xsl:sequence select="current-grouping-key()"/>
            </xsl:for-each-group>
        </xsl:variable>

        <xsl:variable name="person-name-count-seq" as="xs:integer*">
            <xsl:for-each-group select="//quote" group-by="person-name/text()">
                <xsl:sequence select="count(current-group())"/>
            </xsl:for-each-group>
        </xsl:variable>

        <table class="stat">
            <colgroup>
                <col style="width:15%"/>
                <col style="width:12%"/>
            </colgroup>
            <thead class="tbl-header">
                <tr>
                    <th>Place</th>
                    <th>Count</th>
                </tr>
            </thead>
            <tbody class="tbl-content">
                <tr>
                    <td>
                        <xsl:for-each select="$person-name-seq">
                            <xsl:value-of select="."/>
                            <br/>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="$person-name-count-seq">
                            <xsl:value-of select="."/>
                            <br/>
                        </xsl:for-each>
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>

    <!-- context: PERSON NAMES -->
    <xsl:template mode="context-person" match="letters/*">
        <tr>
            <td>
                <!-- ID -->
                <a href="letter-{@id}.html">
                    <xsl:value-of select="@id"/>
                </a>
            </td>
            <td>
                <!-- Date -->
                <xsl:choose>
                    <xsl:when test="info/date/@type = 'supplied'">
                        <a href="letter-{@id}.html">
                            <xsl:value-of select="info/date"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <a href="letter-{@id}.html">
                            <xsl:value-of select="info/date/day"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="info/date/month"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="info/date/year"/>
                        </a>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <!-- Recipient -->
                <xsl:value-of select="info/recipient/text()"/>
            </td>
            <td class="context">
                <!-- Quotes -->
                <xsl:apply-templates select="body/para/quote[@type = 'person']"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="letter/body/para/quote[@type = 'person']">
        <ul>
            <li>
                <xsl:apply-templates mode="display-place-quotes" select="text() | person-name"/>
            </li>
        </ul>
    </xsl:template>

    <xsl:template mode="display-place-quotes" match="person-name">
        <span class="person-name">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>

</xsl:stylesheet>
