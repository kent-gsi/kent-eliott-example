<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:import href="import/html-head-link-meta.xsl"/>
    <xsl:import href="import/html-nav.xsl"/>
    <xsl:import href="import/html-footer.xsl"/>
    <xsl:import href="import/xsl-match-all.xsl"/>

    <xsl:variable name="project-title"
        select="normalize-space(document('../XML/project-config.xml')/project-config/project-title)"/>

    <xsl:template match="/">
        <xsl:param name="nav-content"/>
        <!-- root template -->
        <html class="no-js" lang="en">
            <head>
                <title> Components of Each Letter - <xsl:value-of select="$project-title"/>
                </title>
                <xsl:call-template name="html-head-link-meta"/>

            </head>
            <body>
                <!--[if lte IE 9]>
                    <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
                    <![endif]-->

                <header id="letter-components" class="panel" role="banner">
                    <h1 class="headline-primary">
                        <span class="main-title">Components <br/>of Letters</span>
                    </h1>

                </header>


                <xsl:call-template name="html-nav">
                    <xsl:with-param name="current-tab" tunnel="yes" select="'letter-components'"
                        as="xs:string"/>
                </xsl:call-template>

                <section id="letter-components">
                    <div class="grid breadcrumb">
                        <span>You are here: <a href="../index.html"> Home </a>
                            <a href="#">Component of Letters</a>
                        </span>
                    </div>
                    <div class="grid">
                        <div class="centered grid__col--12">
                            <table>
                                <colgroup>
                                    <col style="width:3%"/>
                                    <col style="width:20%"/>
                                    <col style="width:24%"/>
                                    <col style="width:20%"/>
                                    <col style="width:17%"/>
                                    <col style="width:16%"/>
                                </colgroup>
                                <thead class="tbl-header">
                                    <tr>
                                        <th>#</th>
                                        <th>Date</th>
                                        <th>Address</th>
                                        <th>Greeting</th>
                                        <th>Closer</th>
                                        <th>Signature</th>
                                    </tr>
                                </thead>

                                <tbody class="tbl-content">
                                    <xsl:apply-templates mode="letter-components" select="letters/*"
                                    />
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

    <xsl:template mode="letter-components" match="letters/*">
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
                <!-- Address -->
                <xsl:choose>
                    <xsl:when test="info/address/@type = 'full'">
                        <xsl:value-of select="info/address/address-line"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="info/address/city"/>
                        <xsl:text> </xsl:text>
                        <span class="postcode">
                            <xsl:value-of select="info/address/postcode"/>
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="info/address/text() | info/address/title"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

            <td>
                <!-- Greeting -->
                <xsl:value-of select="body/greeting/greeting-text"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="body/greeting/greeting-name"/>
                <xsl:value-of select="body/greeting/greeting-punct"/>
            </td>
            <td>
                <!-- Closer -->
                <xsl:value-of select="body/closer/closer-text"/>
            </td>
            <td>
                <!-- Signature -->
                <xsl:value-of select="body/closer/closer-name/text()"/>
            </td>
        </tr>
    </xsl:template>



</xsl:stylesheet>
