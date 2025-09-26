<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Reiside info</title>
			</head>
			<body>
				<h2>Kõik reisid</h2>
				<xsl:for-each select="reisid/reis">
					<xsl:sort
						select="number(translate(translate(lennujaam/hind, '€', ''), ',', '.'))"
						data-type="number"
						order="ascending"/>

					<h1>
						<xsl:value-of select="sihtkoht"/>
					</h1>
					<ul>
						<li>
							<strong>Lennujaam nimi:</strong>
							<xsl:value-of select="lennujaam/nimi"/>
						</li>
						
						<!--https://www.w3schools.com/xml/ref_xsl_el_variable.asp-->
						<!--https://learn.microsoft.com/en-us/previous-versions/dotnet/netframework-4.0/ms256119(v=vs.100)-->						
						<!--Hindade teksti säilitamine-->
						<xsl:variable name="priceText" select="lennujaam/hind"/>
						<!--Muuda tekst numbriks
							1. eemalda € märk
							2. asenda koma punktiga-->
						<xsl:variable name="priceNumber"
						  select="number(translate(translate($priceText, '€', ''), ',', '.'))"/>
						<li>
							<strong>Hind:</strong>
							<span>
								<xsl:attribute name="style">
									<xsl:if test="$priceNumber &gt; 200">
										<xsl:text>color:red; font-weight:bold;</xsl:text>
									</xsl:if>
								</xsl:attribute>
								<xsl:value-of select="$priceText"/>
							</span>
						</li>
						<li style="background-color: yellow;">
							<strong>Transport lennu number:</strong>
							<xsl:value-of select="transport/@lennu_number"/>
						</li>
						<li style="background-color: yellow;">
							<strong>Transpordi liik:</strong>
							<xsl:value-of select="transport/transpordi_liik"/>
						</li>
						<li style="background-color: yellow;">
							<strong>Saabumis aeg:</strong>
							<xsl:value-of select="normalize-space(transport/@saabumis_aeg)"/>
						</li>
						<li style="background-color: yellow;">
							<strong>Lennu kestus (tunnid):</strong>
							<xsl:value-of select="transport/lennu_kestus"/>
						</li>
					</ul>
				</xsl:for-each>

				<h2>Ainult China sihtkohad</h2>
				<xsl:for-each select="reisid/reis[sihtkoht='China']">
					<ul>
						<li>
							<strong>Lennujaam:</strong>
							<xsl:value-of select="lennujaam/nimi"/>
						</li>
						<li>
							<strong>Hind:</strong>
							<xsl:value-of select="lennujaam/hind"/>
						</li>
						<li>
							<strong>Lennu number:</strong>
							<xsl:value-of select="transport/@lennu_number"/>
						</li>
						<li>
							<strong>Transpordi liik:</strong>
							<xsl:value-of select="transport/transpordi_liik"/>
						</li>
						<li>
							<strong>Saabumis aeg:</strong>
							<xsl:value-of select="normalize-space(transport/@saabumis_aeg)"/>
						</li>
						<li>
							<strong>Lennu kestus (tunnid):</strong>
							<xsl:value-of select="transport/lennu_kestus"/>
						</li>
					</ul>
				</xsl:for-each>

				<h2>Kõik reisid tabelina</h2>
				<p>
					<strong>Oma ülesanded:</strong> Hiina lennud (helesinine), Lennud &gt; 3 tundi (heleroheline), Air Canada lennud (helekollane)
				</p>
				<style>
					table {
					border-collapse: collapse;
					}
					th, td {
					border: 1px solid black;
					padding: 5px;
					}
				</style>
				<table>
					<thead>
						<tr>
							<th>Sihtkoht</th>
							<th>Lennujaam</th>
							<th>Hind</th>
							<th>Lennu number</th>
							<th>Transpordi liik</th>
							<th>Saabumis aeg</th>
							<th>Lennu kestus</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="reisid/reis">
							<tr>
								<xsl:attribute name="style">
									<xsl:if test="transport/lennu_kestus &gt; 3">background-color: lightgreen;</xsl:if>
									<xsl:if test="transport/transpordi_liik='Air Canada'">background-color: lightyellow;</xsl:if>
									<xsl:if test="sihtkoht='China'">background-color: lightblue;</xsl:if>
								</xsl:attribute>
								<td>
									<xsl:value-of select="sihtkoht"/>
								</td>
								<td>
									<xsl:value-of select="lennujaam/nimi"/>
								</td>
								<td>
									<xsl:value-of select="lennujaam/hind"/>
								</td>
								<td>
									<xsl:value-of select="transport/@lennu_number"/>
								</td>
								<td>
									<xsl:value-of select="transport/transpordi_liik"/>
								</td>
								<td>
									<xsl:value-of select="normalize-space(transport/@saabumis_aeg)"/>
								</td>
								<td>
									<xsl:value-of select="transport/lennu_kestus"/>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
