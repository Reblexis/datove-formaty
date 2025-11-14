<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:s3="http://www.example.com/schema-3"
    exclude-result-prefixes="s3">

    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:text>@prefix ex: &lt;https://example.org/vocabulary/&gt; .&#10;</xsl:text>
        <xsl:text>@prefix data: &lt;https://example.org/data/&gt; .&#10;&#10;</xsl:text>

        <xsl:text>######################### BUILDINGS #########################&#10;&#10;</xsl:text>
        <xsl:apply-templates select="//s3:Building" mode="building"/>

        <xsl:text>&#10;######################### TEACHERS #########################&#10;&#10;</xsl:text>
        <xsl:apply-templates select="//s3:Teacher" mode="teacher"/>

        <xsl:text>&#10;######################### SUBJECTS #########################&#10;&#10;</xsl:text>
        <xsl:call-template name="process-subjects"/>
    </xsl:template>

    <xsl:template match="s3:Building" mode="building">
        <xsl:variable name="id" select="substring-after(@id,'https://example.org/data/')"/>
        <xsl:if test="not(preceding::s3:Building[@id = current()/@id])">
            <xsl:text>data:</xsl:text><xsl:value-of select="$id"/>
            <xsl:text> a ex:Building ;&#10;</xsl:text>

            <xsl:text>    ex:buildingName </xsl:text>
            <xsl:for-each select="s3:name">
                <xsl:text>"</xsl:text><xsl:value-of select="."/>
                <xsl:text>"@</xsl:text><xsl:value-of select="@xml:lang"/>
                <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
            </xsl:for-each>
            <xsl:text> ;&#10;</xsl:text>

            <xsl:text>    ex:address </xsl:text>
            <xsl:for-each select="s3:address">
                <xsl:text>"</xsl:text><xsl:value-of select="."/>
                <xsl:text>"@</xsl:text><xsl:value-of select="@xml:lang"/>
                <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
            </xsl:for-each>
            <xsl:text> .&#10;&#10;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="s3:Teacher" mode="teacher">
        <xsl:variable name="id" select="substring-after(@id,'https://example.org/data/')"/>
        <xsl:text>data:</xsl:text><xsl:value-of select="$id"/>
        <xsl:text> a ex:Teacher ;&#10;</xsl:text>

        <xsl:text>    ex:firstName "</xsl:text><xsl:value-of select="s3:firstName"/>
        <xsl:text>"@</xsl:text><xsl:value-of select="s3:firstName/@xml:lang"/><xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:lastName "</xsl:text><xsl:value-of select="s3:lastName"/>
        <xsl:text>"@</xsl:text><xsl:value-of select="s3:lastName/@xml:lang"/><xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:mobileNumber </xsl:text>
        <xsl:for-each select="s3:mobileNumber">
            <xsl:text>&lt;tel:</xsl:text><xsl:value-of select="."/>
            <xsl:text>&gt;</xsl:text>
            <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:salary </xsl:text><xsl:value-of select="s3:salary"/><xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:residesIn data:</xsl:text>
        <xsl:value-of select="substring-after(s3:Building/@id,'https://example.org/data/')"/>
        <xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:teaches </xsl:text>
        <xsl:for-each select="s3:Subject">
            <xsl:text>data:</xsl:text><xsl:value-of select="substring-after(@id,'https://example.org/data/')"/>
            <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text> .&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template name="process-subjects">
        <xsl:for-each select="//s3:Subject">
            <xsl:if test="not(preceding::s3:Subject[@id = current()/@id])">
                <xsl:variable name="id" select="substring-after(@id,'https://example.org/data/')"/>
                <xsl:text>data:</xsl:text><xsl:value-of select="$id"/>
                <xsl:text> a ex:Subject ;&#10;</xsl:text>

                <xsl:text>    ex:name </xsl:text>
                <xsl:for-each select="s3:name">
                    <xsl:text>"</xsl:text><xsl:value-of select="."/>
                    <xsl:text>"@</xsl:text><xsl:value-of select="@xml:lang"/>
                    <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
                </xsl:for-each>
                <xsl:text> ;&#10;</xsl:text>

                <xsl:text>    ex:code "</xsl:text><xsl:value-of select="s3:code"/><xsl:text>" ;&#10;</xsl:text>

                <xsl:text>    ex:teaches </xsl:text>
                <xsl:text>data:</xsl:text>
                <xsl:value-of select="substring-after(../@id,'https://example.org/data/')"/>
                <xsl:text> .&#10;&#10;</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
