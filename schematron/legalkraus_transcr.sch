<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <pattern>
        <rule context="tei:TEI">
            <!-- Gültiges Format der xml:id von TEI -->
            <assert test="matches(@xml:id,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}.xml')">Attribut "xml:id" von TEI ungültig. Muss dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}.xml' entsprechen.</assert>
            
            <!-- @prev und @next -->
            <report test="@prev eq ''">Attribut "prev" ist leer. Vorangehendes Dokument eintragen.</report>
            <report test="@next eq ''">Attribut "next" ist leer. Folgendes Dokument eintragen.</report>
            <assert test="matches(@prev,'https://id.acdh.oeaw.ac.at/legalkraus/D_[0-9]{6}-[0-9]{3}-[0-9]{3}.xml')">Attribut "prev" (vorangehendes Dokument) ungültig. Muss dem Muster 'https://id.acdh.oeaw.ac.at/legalkraus/D_[0-9]{6}-[0-9]{3}-[0-9]{3}.xml' entsprechen.</assert>
            <assert test="matches(@next,'https://id.acdh.oeaw.ac.at/legalkraus/D_[0-9]{6}-[0-9]{3}-[0-9]{3}.xml')">Attribut "next" (folgendes Dokument) ungültig. Muss dem Muster 'https://id.acdh.oeaw.ac.at/legalkraus/D_[0-9]{6}-[0-9]{3}-[0-9]{3}.xml' entsprechen.</assert>
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
            <assert test="matches(@xml:id,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}')">Attribut "xml:id" von witness ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}'.</assert>
        </rule>
        
        <!-- Beilagen im Body -->
        <rule context="tei:ab[@type='appendix']">
            <!-- ID -->
            <assert test="matches(@source,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-acc[0-9]{3}')">Attribut "xml:id" ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-acc[0-9]{3}'.</assert>
            <assert test="matches(@source,'https://') or starts-with(@source,'#')">Wert in Attribut "source" ist kein Verweis.</assert>
            <assert test="@source" role="warning">Attribut "source" fehlt.</assert>
            <report test="@source/string() eq ''" role="warning">Fehlender Wert des Attributs "source".</report>
        </rule>
        
        <!-- Beilagen im Header -->
        <rule context="tei:accMat">
            <!-- ID -->
            <assert test="matches(@xml:id,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-acc[0-9]{3}')">Attribut "xml:id" ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-acc[0-9]{3}'.</assert>
            <assert test="matches(@source,'https://') or starts-with(@source,'#')">Wert in Attribut "source" ist kein Verweis.</assert>
            <assert test="@source" role="warning">Attribut "source" fehlt.</assert>
            <report test="@source/string() eq ''" role="warning">Fehlender Wert des Attributs "source".</report>
        </rule>
        
        <!-- mehrere Textzeugen mit divs -->
        <rule context="tei:div[@type='wit']">
            <!-- ID -->
            <assert test="matches(@xml:id,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit-div[0-9]{3}')">Attribut "xml:id" von div ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit-div[0-9]{3}'.</assert>
            <assert test="matches(@source,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}')">Attribut "source" von div ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}' (Verweis auf witness fehlgeschlagen).</assert>
            <assert test="starts-with(@source,'#')">Wert in Attribut "source" ist kein Verweis.</assert>
            <assert test="@source" role="warning">Attribut "source" fehlt.</assert>
            <report test="@source/string() eq ''" role="warning">Fehlender Wert des Attributs "source".</report>
        </rule>
        
        <!-- mehrere Dokumente mit divs -->
        <rule context="tei:div[@type='doc']">
            <!-- ID -->
            <assert test="matches(@xml:id,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-doc-div[0-9]{3}')">Attribut "xml:id" von div ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-doc-div[0-9]{3}'.</assert>
            <assert test="matches(@source,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}')">Attribut "source" von div ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}' (Verweis auf Dokument fehlgeschlagen).</assert>
            <assert test="matches(@source,'https://') or starts-with(@source,'#')">Wert in Attribut "source" ist kein Verweis.</assert>
            <assert test="@source" role="warning">Attribut "source" fehlt.</assert>
            <report test="@source/string() eq ''" role="warning">Fehlender Wert des Attributs "source".</report>
        </rule>
        
        <!-- Schreiberhände -->
        <rule context="tei:profileDesc">
            <assert test="tei:handNotes" role="information">Keine Schreiberhände angelegt.</assert>
        </rule>
        
        <rule context="tei:handNote">
            <assert test="matches(@xml:id,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attribut "xml:id" von handNote ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}'.</assert>
            
            <assert test="matches(@source,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}')">Attribut "source" von div ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}' (Verweis auf Dokument fehlgeschlagen).</assert>
            <assert test="starts-with(@source,'#')">Wert in Attribut "source" ist kein Verweis.</assert>
            <assert test="@source" role="warning">Attribut "source" fehlt.</assert>
            <report test="@source/string() eq ''" role="warning">Fehlender Wert des Attributs "source".</report>
            
            <assert test="matches(@scribeRef,'https://') or starts-with(@scribeRef,'#')">Wert in Attribut "scribeRef" ist kein Verweis.</assert>
            <assert test="@scribeRef" role="warning">Attribut "scribeRef" fehlt.</assert>
            <report test="@scribeRef/string() eq ''" role="warning">Fehlender Wert des Attributs "scribeRef".</report>
            
            <assert test="@resp" role="warning">Attribut "resp" fehlt.</assert>
            <report test="@resp/string() eq ''" role="warning">Fehlender Wert des Attributs "resp".</report>
            <assert test="starts-with(@resp,'#')">Wert in Attribut "resp" ist kein Verweis.</assert>
        </rule>

        <!-- hs. Bearbeitungen -->
        <rule context="tei:add">
            <assert test="matches(@hand,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attributwert von "hand" ist ungültig, entspricht nicht dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}'.</assert>
        </rule>
        
        <rule context="tei:del">
            <assert test="matches(@hand,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attributwert von "hand" ist ungültig, entspricht nicht dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}'.</assert>
        </rule>
        
        <rule context="tei:subst">
            <assert test="matches(@hand,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attributwert von "hand" ist ungültig, entspricht nicht dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}'.</assert>
        </rule>
        
        <rule context="tei:seg[@type='transposition']">
            <assert test="matches(@xml:id,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}_seg[0-9]{3}')">Attributwert von "xml:id" ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-seg[0-9]{3}'.</assert>
        </rule>
        
        <rule context="tei:metamark[@function='transposition']">
            <assert test="matches(@hand,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attributwert von "hand" ist ungültig, entspricht nicht dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}'.</assert>
            <assert test="matches(@target,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}_seg[0-9]{3}')">Attributwert von "target" ist ungültig, entspricht nicht dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}_seg[0-9]{3}'.</assert>
        </rule>
        
        <rule context="tei:transpose">
            <assert test="matches(@hand,'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attributwert von "hand" ist ungültig, entspricht nicht dem Muster 'D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}'.</assert>
        </rule>
        
        <rule context="tei:transpose/ptr">
            <assert test="matches(@target,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}_seg[0-9]{3}')">Attributwert von "target" ist ungültig, entspricht nicht dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}_seg[0-9]{3}'.</assert>
        </rule>
        
        <rule context= "tei:hi[@hand]">
            <assert test="matches(@hand,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attribut "hand" ungültig. Muss dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}' entsprechen.</assert>
        </rule>
        
        <rule context= "tei:restore">
            <assert test="matches(@hand,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attribut "hand" ungültig. Muss dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}' entsprechen.</assert>
        </rule>
        
        <rule context= "tei:note[@hand]">
            <assert test="matches(@hand,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attribut "hand" ungültig. Muss dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}' entsprechen.</assert>
        </rule>
        
        <rule context= "tei:metamark[@function='marginal']">
            <assert test="matches(@hand,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attribut "hand" ungültig. Muss dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}' entsprechen.</assert>
        </rule>
        
        <rule context= "tei:lem">
            <assert test="matches(@wit,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}')">Attribut "wit" ungültig. Muss dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}' entsprechen.</assert>
            <assert test="matches(@hand,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attribut "hand" ungültig. Muss dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}' entsprechen.</assert>
        </rule>
        
        <rule context= "tei:rdg">
            <assert test="matches(@wit,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}')">Attribut "wit" ungültig. Muss dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-wit[0-9]{2}' entsprechen.</assert>
            <assert test="matches(@hand,'#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}')">Attribut "hand" ungültig. Muss dem Muster '#D_[0-9]{6}-[0-9]{3}-[0-9]{3}-hand[0-9]{2}' entsprechen.</assert>
        </rule>
       
        <!-- rs -->
        <rule context="tei:rs[@type= 'person' or @type= 'place' or @type= 'institution' or @type='work']">
            <assert test="matches(@ref,'https://') or starts-with(@ref,'#')">Wert in Attribut "ref" ist kein Verweis.</assert>
            <assert test="@ref" role="warning">Attribut "ref" fehlt.</assert>
            <report test="@ref/string() eq ''" role="warning">Fehlender Wert des Attributs "ref".</report>
        </rule>
        
        <!-- doppelte Verlinkung -->
        <rule context="tei:rs">
            <assert test="count(tei:rs) = count(tei:rs[not(@ref=parent::tei:rs/@ref)])" role="warning">Element rs in rs überprüfen, doppelte Verlinkung.</assert>
        </rule>
                
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
        
        <!-- xml:id für Zeilenumbruch -->
        <rule context="tei:lb">
            <assert test="@xml:id" role="warning">Element lb hat kein Attribut "xml:id".</assert>
        </rule>
        
        <!-- xml:id für Paragraphen -->
        <rule context="tei:p">
            <assert test="@xml:id" role="warning">Element p hat kein Attribut "xml:id".</assert>
        </rule>
        
        <!-- quote -->
        <rule context="tei:quote">
            <assert test="@xml:id" role="warning">Element quote hat kein Attribut "xml:id".</assert>
            <report test="@xml:id/string() eq ''" role="warning">Fehlender Wert des Attributs "xml:id".</report>
            <report test="starts-with(@xml:id,'#')" role="warning">Attribut "xml:id" darf nicht mit "#" beginnen.</report>
            <assert test="@source" role="warning">Attribut "source" fehlt.</assert>
            <report test="@source/string() eq ''" role="warning">Fehlender Wert des Attributs "source".</report>
            <assert test="matches(@source,'https://') or starts-with(@source,'#')">Wert in Attribut "source" ist kein Verweis.</assert>
        </rule>
        
        <!-- wörtliche Rede -->
        <rule context="tei:q[type='spoken']">
            <assert test="matches(@who,'https://') or starts-with(@who,'#')">Wert in Attribut "who" ist kein Verweis.</assert>
            <assert test="@who" role="warning">Attribut "who" fehlt.</assert>
            <report test="@who/string() eq ''" role="warning">Fehlender Wert des Attributs "who".</report>
        </rule>
        
        <!-- rend für hi -->
        <rule context= "tei:hi">
            <assert test="@rend" role="warning">Das Attribut “rend” fehlt.</assert>
        </rule>
        
        <!-- ISO-Format -->
        <rule context="tei:date[@when-iso]">
            <assert test="matches(@when-iso,'[0-9]{4}-[0-9]{2}-[0-9]{2}')" role="warning">Form ungültig. Muss dem Schema YYYY-MM-DD entsprechen.</assert>
        </rule>
        
        <rule context="tei:date[@notBefore-iso]">
            <assert test="matches(@notBefore-iso,'[0-9]{4}-[0-9]{2}-[0-9]{2}')" role="warning">Form ungültig. Muss dem Schema YYYY-MM-DD entsprechen.</assert>
        </rule>
        
        <rule context="tei:date[@notAfter-iso]">
            <assert test="matches(@notAfter-iso,'[0-9]{4}-[0-9]{2}-[0-9]{2}')" role="warning">Form ungültig. Muss dem Schema YYYY-MM-DD entsprechen.</assert>
        </rule>
        
        <!-- sortDate bei creation -->
        <rule context="tei:creation/date">
            <assert test="tei:creation/date[@when-iso]" role="warning">Attribut "when-iso" fehlt.</assert>
            <assert test="tei:creation/date[@type, 'sortDate']" role="warning">Attributwert "sortDate" bei "type" fehlt.</assert>
        </rule>
        
        <!-- Arbeitsschritte revisionDesc -->
        <rule context="tei:revisionDesc">
            <assert test="tei:change[@type, 'header_facsimile']">Arbeitsschritt "TEI-Header und Faksimile" ausstehend.</assert>
            <assert test="tei:change[@type, 'structure']">Arbeitsschritt "Textgliederung" ausstehend.</assert>
            <assert test="tei:change[@type, 'references']">Arbeitsschritt "Referenzen" ausstehend.</assert>
            <assert test="tei:change[@type, 'typography']">Arbeitsschritt "Typographisches" ausstehend.</assert>
            <assert test="tei:change[@type, 'intertexts']">Arbeitsschritt "Intertexte" ausstehend.</assert>
            <assert test="tei:change[@type, 'corrections']">Arbeitsschritt "Korrekturen" ausstehend.</assert>
        </rule>
        
        <!-- Verlinkung von Intertexten -->
        <rule context="tei:note[type='intertext']">
            <assert test="@source" role="warning">Attribut "source" fehlt.</assert>
            <report test="@source/string() eq ''" role="warning">Fehlender Wert des Attributs "source".</report>
            <assert test="matches(@source,'https://fackel.oeaw.ac.at/f/')">Wert in Attribut "source" ist kein Verweis auf die "Fackel".</assert>
        </rule>
        
        <!-- Paratexte -->
        <rule context="tei:note[type='paratext']">
            <assert test="@resp" role="warning">Attribut "resp" fehlt.</assert>
            <assert test="matches(@resp,'law-firm')">Wert in Attribut "resp" ist kein Verweis auf Sameks Kanzlei.</assert>
        </rule>
        
        <!-- Stempel -->
        <rule context="tei:stamp">
            <assert test="@source" role="warning">Attribut "source" fehlt.</assert>
            <report test="@source/string() eq ''" role="warning">Fehlender Wert des Attributs "source".</report>
        </rule>
        
    </pattern>
</schema>