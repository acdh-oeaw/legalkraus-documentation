<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <pattern>
        <rule context="tei:TEI">
            <!-- Gültiges Format der xml:id von TEI -->
            <assert test="matches(@xml:id,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}')">Attribut "xml:id" von TEI ungültig. Muss dem Muster D_[0-9]{6}-[0-9]{3}-[0-9]{3} entsprechen.</assert>
            
            <!-- @prev und @next -->
            <report test="@prev eq ''">Attribut "prev" ist leer. Vorangehendes Dokument eintragen.</report>
            <report test="@next eq ''">Attribut "next" ist leer. Folgendes Dokument eintragen.</report>
            <assert test="matches(@prev,'https://legalkraus.acdh.oeaw.ac.at/id/D_[0-9]{6}-[0-9]{3}-[0-9]{3}')">Attribut "prev" (vorangehendes Dokument) ungültig. Muss dem Muster https://legalkraus.acdh.oeaw.ac.at/id/D_[0-9]{6}-[0-9]{3}-[0-9]{3} entsprechen.</assert>
            <assert test="matches(@next,'https://legalkraus.acdh.oeaw.ac.at/id/D_[0-9]{6}-[0-9]{3}-[0-9]{3}')">Attribut "next" (folgendes Dokument) ungültig. Muss dem Muster https://legalkraus.acdh.oeaw.ac.at/id/D_[0-9]{6}-[0-9]{3}-[0-9]{3} entsprechen.</assert>
        </rule>
        
        <!-- editor -->
        <rule context="tei:titleStmt">
            <assert test="tei:editor">Element "editor" fehlt. Kein Herausgeber/Hauptverantwortlicher angegeben.</assert>
        </rule>
        <rule context="tei:editor">
            <assert test="starts-with(@ref,'#')">Ungültiger Wert des Attributs "ref". Soll auf den Herausgeber verweisen, bsp. "#IL"</assert>
        </rule>
        
        <!-- publicationStmt -->
        <rule context="tei:publicationStmt">
            <!-- ids -->
            <report test="not(tei:idno[@subtype='legalkraus'])">"idno" vom Typ "legalkraus" fehlt.</report>
            <report role="warning" test="not(tei:idno[@subtype='krausonline'])">"idno" vom Typ "krausonline" fehlt. Keine Verknüpfung mit Kraus Online möglich!</report>
            <report role="warning" test="not(tei:idno[@subtype='transkribus'])">"idno" vom Typ "transkribus" fehlt. Dokument nicht in Transkribus oder noch nicht verknüpft!</report>
        </rule>
        
        <!-- sourceDesc -->
        <rule context="tei:sourceDesc">
            <!-- hier weiter -->
            <assert test="tei:listWit">"listWit" fehlt. Textzeugen nicht angelegt.</assert>
            <report test="tei:listWit[count(tei:witness) = 1]" role="information">Nur 1 Textzeuge angelegt.</report>
            <report test="tei:listWit[count(tei:witness) &gt; 1]" role="information">Mehrere Textzeugen vorhanden.</report>
        </rule>
        
        <!-- Textzeugen -->
        <rule context="tei:witness">
            <!-- ID -->
            <assert test="matches(@xml:id,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}')">Attribut "xml:id" des Textzeugen entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}'</assert>
        </rule>
        
        <!-- Schreiberhände -->
        <rule context="tei:profileDesc">
            <assert test="tei:handNotes" role="information">Keine Schreiberhände angelegt.</assert>
        </rule>
        
        <!-- rs -->
        <rule context="tei:rs[@type= 'person' or @type= 'place' or @type= 'institution']">
            <assert test="matches(@ref,'https://') or starts-with(@ref,'#')">Wert in Attribut "ref" ist kein Verweis.</assert>
            <assert test="@ref" role="warning">Attribut "ref" fehlt.</assert>
            <report test="@ref/string() eq ''" role="warning">Fehlender Wert des Attributs "ref".</report>
        </rule>
        
        <!-- rs in rs 
        <rule context="tei:rs">
            <assert test="tei:rs/tei:rs" role="warning">Element rs in rs überprüfen, doppelte Verlinkung.</assert>
        </rule> -->
        
        <!-- Personen -->
        <rule context="tei:rs[@type='person']">
            <assert test="matches(@ref,'https://pmb.acdh.oeaw.ac.at/entity/')" role="warning">Verweis auf Person nicht mit der PMB verknüpft.</assert>
        </rule>
        
        <!-- Zeilenumbruch -->
        <rule context="tei:lb[not(@break)]">
            <report test=".[preceding-sibling::text()[1][ends-with(.,'- ')]]" role="warning">Zeilenumbruch im Wort nicht mit Attribut "break" markiert. Leerzeichen davor entfernen.</report>
        </rule>
        
        <!-- Zeilenumbruch im Wort -->
        <rule context="tei:lb[@break='no']">
            <report test=".[preceding-sibling::text()[1][ends-with(.,'- ')]]" role="warning">Bindestrich und Leerzeichen vor dem Umbruch im Wort entfernen.</report>
            <report test=".[preceding-sibling::text()[1][ends-with(.,' ')]]" role="warning">Leerzeichen vor dem Umbruch im Wort entfernen.</report>
            <report test=".[preceding-sibling::text()[1][ends-with(.,'-')]]" role="warning">Bindestrich vor dem Umbruch im Wort entfernen.</report>
        </rule>
        
        <!-- quote -->
        <rule context="tei:quote">
            <assert test="@xml:id" role="warning">Element quote hat kein Attribut "xml:id".</assert>
            <report test="@xml:id/string() eq ''" role="warning">Fehlender Wert des Attributs "xml:id".</report>
            <assert test="matches(@xml:id,'https://')">Wert in Attribut "ref" ist kein Verweis.</assert>
            <report test="starts-with(@xml:id,'#')" role="warning">Attribut "xml:id" zuerst definieren, dann darauf verweisen.</report>
            <assert test="@ref" role="warning">Attribut "ref" fehlt.</assert>
            <report test="@ref/string() eq ''" role="warning">Fehlender Wert des Attributs "ref".</report>
            <assert test="matches(@ref,'https://') or starts-with(@ref,'#')">Wert in Attribut "ref" ist kein Verweis.</assert>
        </rule>
        
        <!-- hi -->
        <rule context= "tei:hi">
            <assert test="@rend" role="warning">Das Attribut “rend” fehlt.</assert>
        </rule>
        
        <!-- date when-iso -->
        <rule context="tei:date">
            <assert test="matches(@when-iso,'[0-9]{4}-[0-9]{2}-[0-9]{2}')">Form ungültig. Muss dem Schema YYYY-MM-DD entsprechen.</assert>
        </rule>
        
    </pattern>
</schema>