<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    version="1.0">
    <xsl:param name="mode">xhtml</xsl:param>
    <xsl:param name="data.file">cv.data.xml</xsl:param>
    <xsl:output method="html"/>
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="$mode='xhtml'">
                <xsl:apply-templates mode="xhtml"/>                
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="node()|@*" mode="xhtml">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="xhtml"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xhtml:div[@id='mainArea']" mode="xhtml">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:for-each select="document($data.file)/root/employment">
                <xhtml:div class="row">
                    <xhtml:div class="span6">
                        <xhtml:h3><xsl:value-of select="name"/></xhtml:h3>
                        <xhtml:h4><xsl:value-of select="where"/> <xhtml:small><xsl:value-of select="from"/> — <xsl:value-of select="to"/></xhtml:small></xhtml:h4>
                        <xhtml:p><xsl:value-of select="description"/></xhtml:p>
                        
                        <xhtml:dl class="dl-horizontal">
                            <xhtml:dt>Role</xhtml:dt>
                            <xhtml:dd><xsl:value-of select="role"/></xhtml:dd>
                            <xhtml:dt>Contributions</xhtml:dt>                               
                                <xsl:for-each select="contribution">
                                    <xhtml:dd><xsl:value-of select="text()"/></xhtml:dd>    
                                </xsl:for-each>
                        </xhtml:dl>
                        <!-- <p class="detail">Some of the people and organizations I follow and meetups I attend: Paul Irish, Jeffrey Zeldman, Addy Osmani, Remy Sharp, 32signals, John Resig, London Web Standards, LeanStartupBCN, FestUp, The UX Booth, Sucuri, Jacob Nielsen, TechCrunch, Google Code Blog, Dirson, 1stWebDesigner, ReadWriteWeb, CSS Tricks, A List Apart, Web Design Ledger, Smashing Magazine, I Love Typography, jQuery Blog, Inspect Element, SEOmoz, Six Revisions, Mozilla blog, Mat Cutts, Kabytes, Added Bytes, Ben Nadel, NCZOnline, Mark Otto…</p> -->
                    </xhtml:div>
                    
                    <xhtml:div class="span4">
                        <xhtml:dl class="dl-horizontal">
                            <xsl:for-each select="tools">
                            <xhtml:dt><xsl:value-of select="@name"/></xhtml:dt>
                            <xhtml:dd>
                                <xsl:for-each select="tool">
                                    <xsl:if test="not(position()=1)">,</xsl:if>
                                    <xsl:choose>
                                        <xsl:when test="@link">
                                            <xhtml:a href="{@link}"><xsl:value-of select="text()"/></xhtml:a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xhtml:span><xsl:value-of select="text()"/></xhtml:span>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                            </xhtml:dd>
                            </xsl:for-each>
                        </xhtml:dl>
                    </xhtml:div>
                </xhtml:div>
            </xsl:for-each>
            
            <xsl:if test="count(document($data.file)/root/education) &gt; 0">
                <xhtml:div class="row">
                    <xhtml:div id="education" class="span10">
                        <xhtml:h2>Education</xhtml:h2>
                    </xhtml:div>
                </xhtml:div>
                <xhtml:div class="row">
                    <xhtml:div class="span10">
                        <xhtml:dl>
                            <xsl:for-each select="document($data.file)/root/education">
                                <xhtml:dt>
                                    <xhtml:a href="{@link}"><xsl:value-of select="text()"/></xhtml:a>
                                    <xsl:if test="details">
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="details"/>
                                    </xsl:if>
                                    <xsl:if test="when">
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="when"/>
                                    </xsl:if>
                                </xhtml:dt>
                            </xsl:for-each>
                        </xhtml:dl>
                    </xhtml:div>
                </xhtml:div>
            </xsl:if>
           
            <xsl:for-each select="document($data.file)/root/recommendation">
                <xhtml:h4><xsl:value-of select="from/name"/> — <span class="title"><xsl:value-of select="from/title"/></span></xhtml:h4>
                <xhtml:blockquote>
                    <xhtml:p>“<xsl:for-each select="text()"><xsl:copy/></xsl:for-each>”</xhtml:p>
                </xhtml:blockquote>
            </xsl:for-each> 
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>
