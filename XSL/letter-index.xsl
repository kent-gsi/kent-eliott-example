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
                <title> Index of Letters - <xsl:value-of select="$project-title"/>
                </title>
                <xsl:call-template name="html-head-link-meta"/>

            </head>
            <body>
                <!--[if lte IE 9]>
                    <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
                    <![endif]-->

                <header id="letter-index" class="panel" role="banner">
                    <h1 class="headline-primary">
                        <span class="main-title">Index <br/>of Letters</span>
                    </h1>

                </header>


                <xsl:call-template name="html-nav">
                    <xsl:with-param name="current-tab" tunnel="yes" select="'letter-index'"
                        as="xs:string"/>
                </xsl:call-template>

                <section id="letter-index">
                    <div class="grid breadcrumb">
                        <span>You are here: <a href="../index.html"> Home </a>
                            <a href="#">Index of Letters</a>
                        </span>
                    </div>
                    <div class="grid">
                        <div class="centered grid__col--12">
                            <p>
                                T.S. Eliot—the famed poet and essayist—and a family man, it sounds paradoxical. Indeed, to the most of us, his name is associated with true linguistic sophistication, and, unfortunately, unhappy marriages—he doesn't seem like a family man. We also rarely study him as a family man—we direct our energy to his stoeric and elite high Modernist poetry, and ironically, partly also because the influential school of literary criticism he started has rendered biographical details of individual authors less relevant. Beyond the paradox, however, he <em>must</em> be a family man to some people, at least to his families. This digital humanities project invites you to look at another side of the liteary giant; this is a database of letters Eliot wrote to his families. In those letters, he is down-to-earth, amiable, and, like everyone else, worries over petty, everyday trouble. 
                                While its title may strike you as paradoxical, you will see that Eliot, for all his magnificent poems and essays, is like everyone else—he, too, worries over petty, everyday trouble.
                            </p>
                            <table>
                                <colgroup>
                                    <col style="width:3%"/>
                                    <col style="width:20%"/>
                                    <col style="width:32%"/>
                                    <col style="width:55%"/>
                                </colgroup>
                                <thead class="tbl-header">
                                    <tr>
                                        <th>#</th>
                                        <th>Recipient</th>
                                        <th>Date</th>
                                        <th>Source</th>
                                    </tr>
                                </thead>
                                <tbody class="tbl-content">
                                    <xsl:apply-templates mode="letter-index" select="letters/*"/>
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

    <xsl:template mode="letter-index" match="letters/*">
        <tr>
            <td>
                <!-- ID -->
                <a href="letter-{@id}.html">
                    <xsl:value-of select="@id"/>
                </a>
            </td>
            <td>
                <!-- Recipient -->
                <a href="letter-{@id}.html">
                    <xsl:value-of select="info/recipient/text()"/>
                </a>
            </td>
            <td>
                <!-- Date -->
                <xsl:choose>
                    <xsl:when test="info/date/@type = 'supplied'">
                        <xsl:value-of select="info/date"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="info/date/day"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="info/date/month"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="info/date/year"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <!-- Source -->
                <!-- using the built-in template for text() -->
                <xsl:apply-templates
                    select="info/source/source-book-title/text() | info/source/source-book-title/title"
                />
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
