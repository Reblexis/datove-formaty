/// Získáme 3 studenty, kteří mají nejvíce roztahané předměty po různých budovách
// Najde všechny kombinace student–předmět–učebna–budova
MATCH (st:Student)-[:ATTENDS]->(s:Subject)-[:TAKES_PLACE]->(c:Classroom)-[:IS_PART_OF]->(b:Building)

// Dá dohromady výsledky podle studentů, seskupí všechny budovy (neopakují se),
// které student navštěvuje do pole "buildings"
WITH st, collect(DISTINCT b.id) AS buildings

// Vrací celé jméno studenta a počet unikátních budov, které navštěvuje
RETURN st.firstName + " " + st.lastName AS Student, size(buildings) AS buildingCount

// Seřadí podle počtu budov a vezme 3 studenty s největším počtem
ORDER BY buildingCount DESC
LIMIT 3;