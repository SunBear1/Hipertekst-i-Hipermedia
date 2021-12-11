<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <head>
  	<meta charset="UTF-8" />
	<title>Hypertext hypermedia</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="lolxml.css" />
  </head>
  <body>
   <h1>LEAGUE OF LEGENDS</h1>
	 <ul>
        <li><a href="index.html">Home</a></li>
        <li><a class="active" href="lol.html">League of Legends</a></li>
        <li><a  href="csgo.html">Counter Strike</a></li>
        <li><a  href="ov.html">Overwatch</a></li>
        <li class="dropdown">
            <a class="dropbtn">Dropdown</a>
            <div class="dropdown-content">
                <a href="galeria.html">Galeria</a>
                <a href="form.html">Formularz</a>
            </div>
        </li>
    </ul>
    <br></br>
    <br></br>
      <xsl:apply-templates select="Esport/turnieje/turniej/media/image"/>
      <br></br>
      <br></br>
      <xsl:apply-templates select="Esport/zrodla/links/link"/>

    <div>
      <br></br>
      <br></br>
      <xsl:apply-templates select="Esport/ligi/liga"/>
    </div>
    <br></br>
    <br></br>
    <ul>
      <li>
        
      </li>
    </ul>
    <br></br>
    <xsl:call-template name="notatka"/>
    <br></br>
    <br></br>
    <xsl:call-template name="info"/>
    <br></br>
    <br></br>
    <xsl:call-template name="druzyny"/>
    <br></br>
    <br></br>
    <br></br>
    <xsl:call-template name="liczby"/>
    <br></br>
    <br></br>
    <br></br>
    <br></br>
    <br></br>
    <br></br>
    <br></br>
    <br></br>
    <br></br>
    <footer>XSLT 2019 Łukasz Niedźwiadek </footer>
  </body>
  </html>
</xsl:template>

<xsl:template match="media/image">
		<img>
			<xsl:attribute name="src">
				<xsl:value-of select="@source"/>
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:value-of select="."/>
			</xsl:attribute>
		</img>
</xsl:template>

<xsl:template match="links/link">
		<ol class="xd">
      <xsl:number/>
			<a>
			<xsl:attribute name="href">
				<xsl:value-of select="@source"/>
        <br></br>
			</xsl:attribute>
			<xsl:value-of select="."/>
       
			</a>
		</ol>
</xsl:template>

 <xsl:variable name="tabela">
   <tr>
     <th>Nazwa ligi</th>
     <th>Organizator</th>
     <th>Zwycięzca</th>
   </tr>
 </xsl:variable>

  <xsl:template match="ligi/liga">
			<xsl:if test="@region='europa'">
			<table>
        <xsl:copy-of select="$tabela" />
        <xsl:apply-templates select="information"/>
			</table>
       </xsl:if>
</xsl:template>
  
<xsl:template match="liga[@region='europa']/information">
		<tr>
			<td><xsl:value-of select="nazwa"/></td>
			<td><xsl:value-of select="organizator"/></td>
      <td><xsl:value-of select="zwyciezca"/></td>
		</tr>
</xsl:template>
  
 <xsl:template name="liczby">
    <table>
      <tr>
        <th>Turniej</th>
        <th>Pula nagród</th>
        <th>pierwsze miejsce</th>
        <th>drugie miejsce</th>
        <th>trzecie miejsce</th>
      </tr>
      <tr>
        <td>Worlds</td>
        <td>
          <xsl:value-of select='format-number(987654321, "#")' />.55 $
        </td>
        <td>
          <xsl:value-of select='format-number(0.4375, "#.0%")' />
        </td>
        <td>
          <xsl:value-of select='format-number(0.3122, "#.0%")' />
        </td>
        <td>
          <xsl:number value="1876" grouping-size="1"
              grouping-separator="#" format="I"/>
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <xsl:template name="druzyny">
    <table border ="1">
      <tr>
        <th>LP</th>
        <th>Nazwa</th>
        <th>Organizator</th>
        <th>Zwycięzca</th>
        <th>MVP</th>
      </tr>
      <xsl:for-each select="Esport/ligi/liga/information">
        <xsl:sort select="." order="ascending"/>
        <tr>
          <td>
            <xsl:number value="position()" format="A" />
          </td>
          <td>
            <xsl:value-of select="nazwa" />
          </td>
          <td>
            <xsl:value-of select="organizator" />
          </td>
          <td>
            <xsl:value-of select="zwyciezca" />
          </td>
          <td>
            <xsl:if test="MVP[@sezon='wiosna']">
              <xsl:value-of select="MVP" />
            </xsl:if>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
  
  <xsl:template name="info">
    <xsl:if test="Esport/ligi/liga">
      <h1>
        <xsl:value-of select="Esport/ligi/liga/information/nazwa" />
      </h1>
      <p>
        W ultralidze najlepszą drużyną jest  <span>
          <xsl:value-of select="Esport/ligi/liga/information/zwyciezca" />
        </span> mającą na swoim koncie już <span>
          <xsl:value-of select="Esport/ligi/liga/information/zwyciezca/@ilosc_tytulow" />
        </span>  tytułów mistrza.

      <br></br>
    </p>
    </xsl:if>
  </xsl:template>

  <xsl:template name="notatka">
    <table border ="1">
      <tr>
        <th>NAZWA</th>
        <th>Notatka</th>
      </tr>
      <xsl:for-each select="Esport/turnieje/turniej">
        <tr>
          <td>
            <xsl:value-of select="nazwa"/>
          </td>
          <xsl:choose>
            <xsl:when test="tekst">
              <td>
                <br></br>
                <xsl:value-of select="tekst"/>
                <br></br>
              </td>
            </xsl:when>
            <xsl:otherwise>
              <td>
                <br></br>
                Brak notatki
                <br></br>
              </td>
            </xsl:otherwise>
          </xsl:choose>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>


</xsl:stylesheet>