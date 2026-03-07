# Eindopdracht - MBDI Mobile Development voor iOS

## Opdrachtinformatie

- **Vak:** MBDI - Mobile Development voor iOS
- **Deadline:** 8 maart 2026, 23:59
- **Uitvoering:** Per duo
- **Inleveren:** Blackboard (alleen .zip)

---

## Inleveren

Lever een `.zip` in met:

1. Code als volledig Xcode project
2. Zelf ingevulde rubric (`.pdf` of `.png`)
3. Zip-bestand (geen `.rar` etc.) — neem namen en studentnummers van beide studenten op in de bestandsnaam
4. Beide studenten leveren hetzelfde werk in. Feedback komt bij één student, het individuele cijfer bij beiden.

---

## Intro

Je gaat een zelfbedachte iOS app ontwikkelen. Je bent redelijk vrij in de keuze van je applicatie, zolang deze maar aan de minimumeisen voldoet. Bouw een app waar je mogelijk voor je werk, hobby (geen Pokémon), familie of kennissen nog wat aan hebt.

### Zelfbeoordeling

Vul de rubric zelf in en lever deze mee in. Dit maakt het nakijken efficiënter en biedt ruimte voor individuele beoordeling. De beoordeling van de docent kan afwijken van de zelfbeoordeling. De mate waarin je tijdens het assessment je uitwerking kunt toelichten weegt ook mee.

---

## Minimumeisen

- Naast een optioneel splash/inlog-screen minimaal **twee navigeerbare schermen** in de app.
- De app maakt gebruik van een **webservice** (bijv. JSON of XML). Meerdere informatie-elementen moeten gebruikt worden; het ophalen van één waarde is niet voldoende.
- Minimaal één scherm toont een **lijst in SwiftUI** met data afkomstig van het web.
- De app biedt **functionaliteit met bewerkingsmogelijkheid** (bijv. volledige CRUD op een complex object). Het persistent wijzigen van enkel een boolean of string is te simpel.
- De app is **multithreaded** geïmplementeerd — langdurige acties worden asynchroon uitgevoerd zodat de UI altijd responsief blijft.
- De app **bewaart data lokaal** op het iOS-apparaat (bijv. instellingen of opgehaalde data).
- De UI werkt goed in zowel **portrait als landscape** oriëntatie.
- De app bouwt **zonder errors en zonder warnings**.
- Tijdens uitvoer zijn er **geen crashes**.

## Extra's

| Extra | Omschrijving |
|---|---|
| Lokale cache | Webservice-data lokaal gecachet zodat de lijst direct gevuld is bij starten |
| Adaptieve UI | UI past layout aan op schermgrootte/-oriëntatie (in code verschillend opgebouwd) |
| GPS | Gebruik van locatiediensten |
| Delen | Data delen vanuit/naar andere apps |
| Eigen extra | Andere zelfbedachte uitbreiding (in overleg met docent) |

## Vormeisen

- Xcode 16 of hoger, iOS 18 of hoger
- Alle code in Swift 5 of 6
- Externe libraries alleen na goedkeuring docent; configuratie in `README.md`

---

## Rubric

**Totaal: 60 punten**

> Score wordt omgezet naar een cijfer op 10.

---

### Stabiliteit [20%] — max. 12 punten

| Beoordeling | Punten | Criterium |
|---|---|---|
| Ruim Voldoende (RV) | 12 | Applicatie crasht niet en er komen geen excepties/foutmeldingen |
| Voldoende (V) | 9 | Applicatie crasht niet maar er zijn excepties/foutmeldingen |
| Slecht (S) | 6 | Applicatie crasht eenmalig |
| Onvoldoende (O) | 3 | Applicatie crasht herhaaldelijk |

**Score Stabiliteit: &nbsp;&nbsp;&nbsp; / 12**

---

### Architectuur [30%] — max. 18 punten

| Beoordeling | Punten | Criterium |
|---|---|---|
| Zeer Goed (ZG) | 18 | Aan alle eisen van V voldaan + 3 of meer extra Apple frameworks toegepast |
| Goed (G) | 15 | Aan alle eisen van V voldaan + 2 extra Apple frameworks toegepast |
| Ruim Voldoende (RV) | 12 | Aan alle eisen van V voldaan + 1 extra Apple framework toegepast |
| Voldoende (V) | 9 | Scheiding tussen View en Controllers/Model; multithreaded implementatie (asynchroon downloaden van data) |
| Slecht (S) | 6 | Aan één van de eisen voor V is niet voldaan |
| Onvoldoende (O) | 3 | Aan twee van de eisen voor V is niet voldaan |

**Score Architectuur: &nbsp;&nbsp;&nbsp; / 18**

---

### Functionaliteit [20%] — max. 12 punten

| Beoordeling | Punten | Criterium |
|---|---|---|
| Zeer Goed (ZG) | 12 | Aan alle eisen van V voldaan + meerdere grote of kleinere extra features (anders dan Apple framework) |
| Goed (G) | 10 | Aan alle eisen van V voldaan + 1 grote of 2 kleinere extra features (anders dan Apple frameworks) |
| Ruim Voldoende (RV) | 8 | Aan alle eisen van V voldaan + 1 kleinere extra feature gerealiseerd (anders dan Apple frameworks) |
| Voldoende (V) | 6 | Aangeboden functionaliteit werkt; bewerking mogelijk; instellingen/andere data worden lokaal bewaard |
| Slecht (S) | 4 | Aan één van de eisen voor V is niet voldaan |
| Onvoldoende (O) | 2 | Aan twee van de eisen voor V is niet voldaan |

**Score Functionaliteit: &nbsp;&nbsp;&nbsp; / 12**

---

### User Interface [20%] — max. 12 punten

| Beoordeling | Punten | Criterium |
|---|---|---|
| Zeer Goed (ZG) | 12 | Aan alle eisen van V voldaan + 3 extra's |
| Goed (G) | 10 | Aan alle eisen van V voldaan + 2 extra's |
| Ruim Voldoende (RV) | 8 | Aan alle eisen van V voldaan + 1 extra (bijv. meer dan 2 schermen, mooie vormgeving, goede layout voor diverse schermgroottes) |
| Voldoende (V) | 6 | (Los van splash/inlogschermen) 2 navigeerbare schermen; lijst gebruikt; UI werkt op telefoon in landscape én portrait |
| Slecht (S) | 4 | Aan één van de eisen voor V is niet voldaan |
| Onvoldoende (O) | 2 | Aan twee van de eisen voor V is niet voldaan |

**Score User Interface: &nbsp;&nbsp;&nbsp; / 12**

---

### Code [10%] — max. 6 punten

| Beoordeling | Punten | Criterium |
|---|---|---|
| Goed (G) | 6 | Aan alle eisen van RV voldaan + mooie Swift taalconstructies (bijv. enums met functies, eigen protocollen/delegates, guard lets, etc.) |
| Ruim Voldoende (RV) | 4 | Nette code met functioneel commentaar; duidelijke functie- en variabelenamen; korte overzichtelijke functies; geen forced unwrapping van optionals |
| Voldoende (V) | 3 | Aan één van de eisen voor RV is niet voldaan |
| Slecht (S) | 2 | Aan twee van de eisen voor RV is niet voldaan |
| Onvoldoende (O) | 1 | Aan drie van de eisen voor RV is niet voldaan |

**Score Code: &nbsp;&nbsp;&nbsp; / 6**

---

## Totaalscore

| Categorie | Gewicht | Max. punten | Score |
|---|---|---|---|
| Stabiliteit | 20% | 12 | / 12 |
| Architectuur | 30% | 18 | / 18 |
| Functionaliteit | 20% | 12 | / 12 |
| User Interface | 20% | 12 | / 12 |
| Code | 10% | 6 | / 6 |
| **Totaal** | **100%** | **60** | **/ 60** |

---

## Beoordelingsdrempels

| Kwalificatie | Minimum punten |
|---|---|
| Beheersing is goed | 45 punten |
| Beheersing is (ruim) voldoende | 33 punten |
| Beheersing is nog onvoldoende | 1 punt |
| Voldeed niet aan knockouts | 0 punten |

---

## Inleverinformatie

- **Type:** Bestandsinlevering
- **Toegestaan bestandstype:** `.zip`
- **Aantal inleveringen:** Alleen de meest recente inlevering wordt bewaard
