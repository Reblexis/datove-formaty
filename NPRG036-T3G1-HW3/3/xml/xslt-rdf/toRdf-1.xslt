<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:s1="http://www.example.com/schema-1"
    exclude-result-prefixes="xs s1">

    <xsl:output method="text" encoding="UTF-8"/>

    <!-- Hlavní template -->
    <xsl:template match="/">
        <xsl:text>@prefix ex: &lt;https://example.org/vocabulary/&gt; .&#10;</xsl:text>
        <xsl:text>@prefix data: &lt;https://example.org/data/&gt; .&#10;&#10;</xsl:text>

        <xsl:text>######################### SPECIALIZATIONS #########################&#10;&#10;</xsl:text>
        <xsl:apply-templates select="//s1:Specialization" mode="specialization"/>

        <xsl:text>&#10;######################### SUBJECTS #########################&#10;&#10;</xsl:text>
        <xsl:call-template name="process-subjects"/>

        <xsl:text>&#10;######################### TEACHERS #########################&#10;&#10;</xsl:text>
        <xsl:call-template name="process-teachers"/>

        <xsl:text>&#10;######################### STUDENTS #########################&#10;&#10;</xsl:text>
        <xsl:apply-templates select="//s1:Student" mode="student"/>
    </xsl:template>

    <xsl:template match="s1:Specialization" mode="specialization">
        <xsl:variable name="id" select="substring-after(@id,'https://example.org/data/')"/>
        <xsl:text>data:</xsl:text><xsl:value-of select="$id"/>
        <xsl:text> a ex:Specialization ;&#10;</xsl:text>

        <xsl:text>    ex:title </xsl:text>
        <xsl:for-each select="s1:title">
            <xsl:text>"</xsl:text><xsl:value-of select="."/>
            <xsl:text>"@</xsl:text><xsl:value-of select="@xml:lang"/>
            <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:numberOfStudents </xsl:text>
        <xsl:value-of select="s1:numberOfStudents"/>
        <xsl:text> .&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template name="process-subjects">
        <xsl:for-each select="//s1:Subject">
            <xsl:if test="not(preceding::s1:Subject[@id = current()/@id])">
                <xsl:variable name="id" select="substring-after(@id,'https://example.org/data/')"/>

                <xsl:text>data:</xsl:text><xsl:value-of select="$id"/>
                <xsl:text> a ex:Subject ;&#10;</xsl:text>

                <xsl:text>    ex:name </xsl:text>
                <xsl:for-each select="s1:name">
                    <xsl:text>"</xsl:text><xsl:value-of select="."/>
                    <xsl:text>"@</xsl:text><xsl:value-of select="@xml:lang"/>
                    <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
                </xsl:for-each>
                <xsl:text> ;&#10;</xsl:text>

                <xsl:text>    ex:code "</xsl:text>
                <xsl:value-of select="s1:code"/>
                <xsl:text>" ;&#10;</xsl:text>

                <xsl:text>    ex:teaches data:</xsl:text>
                <xsl:value-of select="substring-after(s1:Teacher/@id,'https://example.org/data/')"/>
                <xsl:text> .&#10;&#10;</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="process-teachers">
        <xsl:for-each select="//s1:Teacher">
            <xsl:if test="not(preceding::s1:Teacher[@id = current()/@id])">
                <xsl:variable name="id" select="substring-after(@id,'https://example.org/data/')"/>

                <xsl:text>data:</xsl:text><xsl:value-of select="$id"/>
                <xsl:text> a ex:Teacher ;&#10;</xsl:text>

                <xsl:text>    ex:firstName "</xsl:text>
                <xsl:value-of select="s1:firstName"/>
                <xsl:text>"@</xsl:text><xsl:value-of select="s1:firstName/@xml:lang"/>
                <xsl:text> ;&#10;</xsl:text>

                <xsl:text>    ex:lastName "</xsl:text>
                <xsl:value-of select="s1:lastName"/>
                <xsl:text>"@</xsl:text><xsl:value-of select="s1:lastName/@xml:lang"/>
                <xsl:text> ;&#10;</xsl:text>

                <xsl:text>    ex:mobileNumber </xsl:text>
                <xsl:for-each select="s1:mobileNumber">
                    <xsl:text>&lt;tel:</xsl:text><xsl:value-of select="."/>
                    <xsl:text>&gt;</xsl:text>
                    <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
                </xsl:for-each>
                <xsl:text> ;&#10;</xsl:text>

                <xsl:text>    ex:salary </xsl:text>
                <xsl:value-of select="s1:salary"/>
                <xsl:text> .&#10;&#10;</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="s1:Student" mode="student">
        <xsl:variable name="id" select="substring-after(@id,'https://example.org/data/')"/>
        <xsl:variable name="spec" select="substring-after(../@id,'https://example.org/data/')"/>

        <xsl:text>data:</xsl:text><xsl:value-of select="$id"/>
        <xsl:text> a ex:Student ;&#10;</xsl:text>

        <xsl:text>    ex:firstName "</xsl:text>
        <xsl:value-of select="s1:firstName"/>
        <xsl:text>"@</xsl:text><xsl:value-of select="s1:firstName/@xml:lang"/>
        <xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:lastName "</xsl:text>
        <xsl:value-of select="s1:lastName"/>
        <xsl:text>"@</xsl:text><xsl:value-of select="s1:lastName/@xml:lang"/>
        <xsl:text> ;&#10;</xsl:text>

        <xsl:if test="s1:mobileNumber">
            <xsl:text>    ex:mobileNumber &lt;tel:</xsl:text>
            <xsl:value-of select="s1:mobileNumber"/>
            <xsl:text>&gt; ;&#10;</xsl:text>
        </xsl:if>

        <xsl:text>    ex:studies data:</xsl:text><xsl:value-of select="$spec"/>
        <xsl:text> ;&#10;</xsl:text>

        <xsl:text>    ex:attends </xsl:text>
        <xsl:for-each select="s1:Subject">
            <xsl:text>data:</xsl:text>
            <xsl:value-of select="substring-after(@id,'https://example.org/data/')"/>
            <xsl:if test="position()!=last()">,<xsl:text> </xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text> .&#10;&#10;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
