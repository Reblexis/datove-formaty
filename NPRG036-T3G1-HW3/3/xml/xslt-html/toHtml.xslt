<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:s2="http://www.example.com/schema-2"
  exclude-result-prefixes="s2"
  version="2.0">
  
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  
  <xsl:template match="/">
    <html lang="cs">
      <head>
        <title>Budovy, učebny a předměty</title>
        <style>
          table{border-collapse:collapse; width:100%; margin:.5rem 0 1rem 0}
          th,td{border:1px solid #e5e7eb; padding:.5rem .6rem; text-align:left; vertical-align:top}
          th{background:#f5f5f7}
        </style>
      </head>
      <body>
        <h1>Budovy, učebny a předměty</h1>
        <p>(vygenerované z data-2.xml) </p>
        <xsl:apply-templates select="//s2:Building"/>
      </body>
    </html>
  </xsl:template>
  
  <!-- budova: nadpis (CS názov), adresa, súhrny, tabuľka učební -->
  <xsl:template match="s2:Building">
    <h2>
      <xsl:value-of select="s2:name[@xml:lang='cs']"/>
      
    </h2>
    <div>
      <xsl:value-of select="s2:address[@xml:lang='cs']"/>
    </div>
    <div>
      <!-- počet učební a predmetov v budove -->
      Učeben: <strong><xsl:value-of select="count(s2:Classroom)"/></strong>,
      předmětů: <strong><xsl:value-of select="count(s2:Classroom/s2:Subject)"/></strong>
    </div>
    
    <!-- tabuľka učební -->
    <table>
      <thead>
        <tr>
          <th>Učebna (cs)</th>
          <th>Kapacita</th>
          <th>Předměty (cs) – kód</th>
        </tr>
      </thead>
      <tbody>
        <!-- triedenie podľa kapacity zostupne -->
        <xsl:apply-templates select="s2:Classroom" >
          <xsl:sort select="s2:capacity" data-type="number" order="descending"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  
  <!-- učebňa (riadok tabuľky) -->
  <xsl:template match="s2:Classroom">
    <tr>
      <td><xsl:value-of select="s2:name[@xml:lang='cs']"/></td>
      <td><xsl:value-of select="s2:capacity"/></td>
      <td>
        <xsl:choose>
          <xsl:when test="s2:Subject">
            <ul>
              <xsl:apply-templates select="s2:Subject"/>
            </ul>
          </xsl:when>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>
  
  <!-- predmety v zozname -->
  <xsl:template match="s2:Subject">
    <li>
      <xsl:value-of select="s2:name[@xml:lang='cs']"/>(<xsl:value-of select="s2:code"/>)
    </li>
  </xsl:template>
  
</xsl:stylesheet>
