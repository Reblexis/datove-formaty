<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:s2="http://www.example.com/schema-2"
    exclude-result-prefixes="s2">

    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:text>@prefix ex: &lt;https://example.org/vocabulary/&gt; .&#10;</xsl:text>
        <xsl:text>@prefix data: &lt;https://example.org/data/&gt; .&#10;&#10;</xsl:text>

        <xsl:text>######################### BUILDINGS #########################&#10;&#10;</xsl:text>
        <xsl:apply-templates select="//s2:Building" mode="building"/>

        <xsl:text>&#10;######################### CLASSROOMS #########################&#10;&#10;</xsl:text>
        <xsl:apply-templates select="//s2:Classroom" mode="classroom"/>

        <xsl:text>&#10;######################### SUBJECTS #########################&#10;&#10;</xsl:text>
        <xsl:call-template name="process-subjects"/>
    </xsl:template>

    <xsl:template match="s2:Building" mode="building">
        <xsl:variable name="id" select="substring-after(@id,'https://example.org/data/')"/>
        <xsl:text>data:</xsl:text><xsl:value-of select="$id"/>
        <xsl:text> a ex:Building ;&#10;</xsl:text>

        <xsl:text>    ex:buildingName </xsl:text>
        <xsl:for-each select="s2:name">
            <xsl:text>"</xsl:text><xsl:value-of select="."/>
            <xsl:text>"@</xsl:text><xsl:value-of select="@xml:lang"/>
            <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:address </xsl:text>
        <xsl:for-each select="s2:address">
            <xsl:text>"</xsl:text><xsl:value-of select="."/>
            <xsl:text>"@</xsl:text><xsl:value-of select="@xml:lang"/>
            <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text> .&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="s2:Classroom" mode="classroom">
        <xsl:variable name="id" select="substring-after(@id,'https://example.org/data/')"/>
        <xsl:variable name="building-id" select="substring-after(../@id,'https://example.org/data/')"/>
        <xsl:text>data:</xsl:text><xsl:value-of select="$id"/>
        <xsl:text> a ex:Classroom ;&#10;</xsl:text>

        <xsl:text>    ex:classroomName </xsl:text>
        <xsl:for-each select="s2:name">
            <xsl:text>"</xsl:text><xsl:value-of select="."/>
            <xsl:text>"@</xsl:text><xsl:value-of select="@xml:lang"/>
            <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:capacity </xsl:text><xsl:value-of select="s2:capacity"/>
        <xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:is_part_of data:</xsl:text><xsl:value-of select="$building-id"/>
        <xsl:text> .&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template name="process-subjects">
        <xsl:for-each select="//s2:Subject">
            <xsl:if test="not(preceding::s2:Subject[@id = current()/@id])">
                <xsl:variable name="id" select="substring-after(@id,'https://example.org/data/')"/>
                <xsl:text>data:</xsl:text><xsl:value-of select="$id"/>
                <xsl:text> a ex:Subject ;&#10;</xsl:text>

                <xsl:text>    ex:name </xsl:text>
                <xsl:for-each select="s2:name">
                    <xsl:text>"</xsl:text><xsl:value-of select="."/>
                    <xsl:text>"@</xsl:text><xsl:value-of select="@xml:lang"/>
                    <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
                </xsl:for-each>
                <xsl:text> ;&#10;</xsl:text>

                <xsl:text>    ex:code "</xsl:text><xsl:value-of select="s2:code"/><xsl:text>" ;&#10;</xsl:text>

                <xsl:text>    ex:takes_place </xsl:text>
                <xsl:for-each select="//s2:Subject[@id = current()/@id]">
                    <xsl:text>data:</xsl:text>
                    <xsl:value-of select="substring-after(../@id,'https://example.org/data/')"/>
                    <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
                </xsl:for-each>
                <xsl:text> .&#10;&#10;</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
