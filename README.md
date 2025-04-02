# Proiect: Nivelă electronică

## Descriere
Acest proiect constă în dezvoltarea unei nivele electronice utilizând afișaje 7-segmente, un senzor de accelerare și o interfață VGA pentru afișare grafică.

## Etape de implementare

### Etapa 0
- Afișarea cerc pe afișaj 6 x 7-segmente.
- Poziția este determinată de switch-uri, secvențial.
- Miscare giratorie a cercului in functie de viteza data de la switch-uri.

### Etapa 1
- Accesarea SPI și a senzorului de accelerare (citire DEVID).

### Etapa 2
- Configurarea senzorului de accelerare conform necesităților proiectului.

### Etapa 3
- Afișare nivelă bidimensională pe afișaj 6 x 7-segmente.
- Deplasarea cifrelor pe afișaj în funcție de înclinarea pe axele X și Y.

### Bonus
- Afișare pe monitor VGA a cercului care se mișcă pe ecran în funcție de înclinarea machetei.

## Cerințe
- Utilizarea unui mediu EDA pentru proiectare.
- Crearea unui modul de proiectare.
- Studierea unor resurse bibliografice relevante.

## Livrabile
- Predare Etapa 0: Afișaj 6 x 7-segmente.
- Predare Etapa 1: Interfațare SPI și citire senzor.
- Predare Etapa 2: Configurare senzor și afișare pe afișaj 7-segmente.
- Predare Etapa 3: Interfațare axele X, Y și afișare cerc VGA.

## Evaluare
- **Etapa 2:** 7-8 puncte.
- **Etapa 3:** 9-10 puncte.
- **Bonus:** peste 10 puncte.

## Concluzie
Acest proiect are scopul de a implementa o nivelă electronică folosind afișaje 7-segmente și un senzor de accelerare, cu posibilitatea de extindere la afișare VGA.

