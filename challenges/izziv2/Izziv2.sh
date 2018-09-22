cat > script1.sh << EOF1

# 1. del - ukazi ///////////////////////////////////////////

# sestavite ukaz, ki izpise vsebino neke datoteke od 3. do 7. vrstice
head some_text.txt -n 7 | tail -n 5

# Sestavite ukaz, ki iz neke datoteke odstrani vse podvojene vrstice. (Urejenost vrstic izhodne datoteke je lahko drugačna od vhodne.) 
sort some_text.txt | uniq -u

# Sestavite ukaz, ki izpiše število uporabniških računov sistema
wc -l /etc/passwd

# Izpisite vse uporabnike, katerih user ID je vecji od 99
awk -F ':' '{ if(\$3 >= 99) print \$0 }' /etc/passwd

# Izpišite uporabniške račune iz /etc/passwd, katerih prijavna lupina je /bin/false.
# Pri tem naj bodo različna polja med seboj ločena s tabulatorjem, vrstice pa oštevilčene.
awk -F ':' '{ if(\$7 == "/bin/false") print \$0 }' /etc/passwd | tr ':' '\t'

# Izpišite prijavne lupine in število uporabnikov, ki določeno lupino uporablja. Pri tem naj bodo lupine urejene po frekvenci uporabe.
last | awk -F ' ' '{ if(\$1 != "reboot" && \$1 != '\s' && \$1 != "wtmp") print \$1 }' | sort | uniq -c

# V eni izmed zgornjih nalog zajemite podatke sredi cevovoda in jih shranite v datoteko.
last | awk -F ' ' '{ if(\$1 != "reboot" && \$1 != '\s' && \$1 != "wtmp") print \$1 }' | tee output.txt | sort | uniq -c

EOF1
chmod +x script1.sh

cat > script2.sh << EOF2

# 2. del - regularni izrazi ////////////////////////////////

# Vrstica vsebuje niz, ki se začenja na a.
egrep "[a,A]" test.txt

# Vrstica vsebuje besedo, ki se začenja na a.
egrep "(^|[[:space:]])[a, A]" test.txt

# Vrstica vsebuje besedo dolžine tri.
egrep "(^|[[:space:]])[^[:space:]]{3}([[:space:]]|$)" test.txt

# Vrstica vsebuje besedo dolžine tri, ki se začne na a ali b.
egrep "(^|[[:space:]])[a, A, b, B][^[:space:]]{2}([[:space:]]|$)" test.txt

# Vrstica vsebuje besedo dolžine tri, ki vsebuje kvečjemu eno števko.
egrep "(^|\s)[0-9][^0-9, \s][^0-9, \s]($|\s)|(^|\s)[^0-9, \s][0-9][^0-9, \s]($|\s)|(^|\s)[^0-9, \s][^0-9, \s][0-9]($|\s)|(^|\s)[^0-9, \s][^0-9, \s][^0-9, \s]($|\s)" test.txt

# Vrstica vsebuje stavek, ki se začne z malo začetnico.
egrep "\.\s*[a-z].*\." test.txt

EOF2
chmod +x script2.sh