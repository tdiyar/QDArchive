* Encoding: UTF-8.

****************************************************
    
*   Dieses Skript korrigiert die Nullkorrelation für Haushaltseinkommen zwischen den Wellen.
   
*    Datum: Januar 2024
*    Autor: Alexander Seymer
*    Kontakt: alexander.seymer@plus.ac.at

****************************************************
    
*    1. SETUP ENVIRONMENT

****************************************************
* Arbeitsverzeichnis definieren.
CD 'C:\Users\seymer\Documents\Sync\Arbeit\Projects\Values in Crisis\LorenzCheck'.

* Aufräumenen der Arbeitsumgebung.
DATASET CLOSE ALL.

****************************************************
    
*    2. ÖFFNEN DER DATEN

****************************************************
* VIC Welle 1.
GET 
  FILE='05_Submission_to_AUSSDA_WA\VIC1_10659_da_de_v1_0_UPDATE_Dez_2023.zsav'. 
DATASET NAME VIC1.

* VIC Welle 1 und 2.
GET 
  FILE='05_Submission_to_AUSSDA_WA\VIC12_10755_da_de_v1_0_UPDATE_Dez_2023.zsav'. 
DATASET NAME VIC12.

* VIC Welle 1,2 und 3.
GET 
  FILE='05_Submission_to_AUSSDA_WA\VIC123_10801_da_de_v1_0_UPDATE_Dez_2023.zsav'. 
DATASET NAME VIC123.

****************************************************
    
*    3. Korrekturen VIC1

****************************************************

DATASET ACTIVATE VIC1.

* Speichern des neuen Datensatzes.
SAVE OUTFILE='06_Submission_to_AUSSDA_AS\VIC1_10659_da_de_v1_0_UPDATE_Dez_2023.zsav'
  /ZCOMPRESSED.
DATASET CLOSE VIC1.


****************************************************
    
*    4. Korrekturen VIC12

****************************************************

DATASET ACTIVATE VIC12.

* Korrektur VIC2_Q90.
MISSING VALUES VICAT2_Q90 (9).

* Korrektur VIC2_Q103.
MISSING VALUES VICAT2_Q103 (9).

* Korrektur VIC2_Q114.
MISSING VALUES VICAT2_Q114 (10 THRU HI).

* Speichern des neuen Datensatzes.
SAVE OUTFILE='06_Submission_to_AUSSDA_AS\VIC12_10755_da_de_v1_0_UPDATE_Dez_2023.zsav'
  /ZCOMPRESSED.
DATASET CLOSE VIC12.


****************************************************
    
*    5. Korrekturen VIC123

****************************************************

DATASET ACTIVATE VIC123.

* Korrektur VIC3_Q105.
VARIABLE LABELS VIC3_Q105 'Denken Sie, dass unsere Regierung in erster Linie versuchen sollte, die Probleme in unserem Land selbst zu lösen, oder sollte sie versuchen, globale Probleme durch Zusammenarbeit mit anderen Ländern zu lösen?'.

* Speichern des neuen Datensatzes.
SAVE OUTFILE='06_Submission_to_AUSSDA_AS\VIC123_10801_da_de_v1_0_UPDATE_Dez_2023.zsav'
  /ZCOMPRESSED.
DATASET CLOSE VIC123.

