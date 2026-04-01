* Encoding: UTF-8.

******************************************************
*** SCHWARTZ WERTE
******************************************************

*** Genderspezifische Items in jeweils eine Variable überführen.

RECODE Q70A1 TO Q70A22 (SYSMIS=0) (1=1) (2=2) (3=3) (4=4) (5=5) (6=6).
EXECUTE.

RECODE Q71A1 TO Q71A22 (SYSMIS=0) (1=1) (2=2) (3=3) (4=4) (5=5) (6=6).
EXECUTE.

RECODE Q72A1 TO Q72A22 (SYSMIS=0) (1=1) (2=2) (3=3) (4=4) (5=5) (6=6).
EXECUTE.

COMPUTE VIC3_SV1=Q70A1 + Q71A1 + Q72A1.
EXECUTE.

COMPUTE VIC3_SV2=Q70A2 + Q71A2 + Q72A2.
EXECUTE.

COMPUTE VIC3_SV3=Q70A3 + Q71A3 + Q72A3.
EXECUTE.

COMPUTE VIC3_SV4=Q70A4 + Q71A4 + Q72A4.
EXECUTE.

COMPUTE VIC3_SV5=Q70A5 + Q71A5 + Q72A5.
EXECUTE.

COMPUTE VIC3_SV6=Q70A6 + Q71A6 + Q72A6.
EXECUTE.

COMPUTE VIC3_SV7=Q70A7 + Q71A7 + Q72A7.
EXECUTE.

COMPUTE VIC3_SV8=Q70A8 + Q71A8 + Q72A8.
EXECUTE.

COMPUTE VIC3_SV9=Q70A9 + Q71A9 + Q72A9.
EXECUTE.

COMPUTE VIC3_SV10=Q70A10 + Q71A10 + Q72A10.
EXECUTE.

COMPUTE VIC3_SV11=Q70A11 + Q71A11 + Q72A11.
EXECUTE.

COMPUTE VIC3_SV12=Q70A12 + Q71A12 + Q72A12.
EXECUTE.

COMPUTE VIC3_SV13=Q70A13 + Q71A13 + Q72A13.
EXECUTE.

COMPUTE VIC3_SV14=Q70A14 + Q71A14 + Q72A14.
EXECUTE.

COMPUTE VIC3_SV15=Q70A15 + Q71A15 + Q72A15.
EXECUTE.

COMPUTE VIC3_SV16=Q70A16 + Q71A16 + Q72A16.
EXECUTE.

COMPUTE VIC3_SV17=Q70A17 + Q71A17 + Q72A17.
EXECUTE.

COMPUTE VIC3_SV18=Q70A18 + Q71A18 + Q72A18.
EXECUTE.

COMPUTE VIC3_SV19=Q70A19 + Q71A19 + Q72A19.
EXECUTE.

COMPUTE VIC3_SV20=Q70A20 + Q71A20 + Q72A20.
EXECUTE.

COMPUTE VIC3_SV21=Q70A21 + Q71A21 + Q72A21.
EXECUTE.

COMPUTE VIC3_SV22=Q70A22 + Q71A22 + Q72A22.
EXECUTE.

*** Labels und Beschriftung vergeben.
VARIABLE LABELS
    VIC3_SV1 'Es ist ihr/ihm wichtig, neue Ideen zu entwickeln und kreativ zu sein. Sie/Er macht Sachen gerne auf ihre/seine eigene originelle Art und Weise.'
    VIC3_SV2 'Es ist ihr/ihm wichtig, reich zu sein. Sie/er möchte viel Geld haben und teure Sachen besitzen.'
    VIC3_SV3 'Sie/er hält es für wichtig, dass alle Menschen auf der Welt gleich behandelt werden sollten. Sie/er glaubt, dass jeder Mensch im Leben gleiche Chancen haben sollte.'
    VIC3_SV4 'Es ist ihr/ihm wichtig, ihre/seine Fähigkeiten zu zeigen. Sie/er möchte, dass die Leute bewundern, was sie/er tut.'
    VIC3_SV5 'Es ist ihr/ihm wichtig, in einem sicheren Umfeld zu leben. Sie/er vermeidet alles, was ihre/seine Sicherheit gefährden könnte.'
    VIC3_SV6 'Sie/er mag Überraschungen und hält immer Ausschau nach neuen Aktivitäten. Sie/er denkt, dass im Leben Abwechslung wichtig ist.'
    VIC3_SV7 'Sie/er glaubt, dass die Menschen tun sollten, was man ihnen sagt. Sie/er denkt, dass Menschen sich immer an Regeln halten sollten, selbst dann, wenn es niemand sieht.'
    VIC3_SV8 'Es ist ihr/ihm wichtig, Menschen zuzuhören, die anders sind als sie/er. Auch wenn sie/er anderer Meinung ist als andere, will sie/er die anderen trotzdem verstehen.'
    VIC3_SV9 'Es ist ihr/ihm wichtig, zurückhaltend bis bescheiden zu sein. Sie/er versucht, die Aufmerksamkeit nicht auf sich zu lenken.'
    VIC3_SV10 'Es ist ihr/ihm wichtig, Spaß zu haben. Sie/er gönnt sich selbst gerne etwas.'
    VIC3_SV11 'Es ist ihr/ihm wichtig, selbst zu entscheiden, was sie/er tut. Sie/er ist gerne frei bis unabhängig von anderen.'
    VIC3_SV12 'Es ist ihr/ihm sehr wichtig, den Menschen um sie/ihn herum zu helfen. Sie/er will für deren Wohl sorgen.'
    VIC3_SV13 'Es ist ihr/ihm wichtig, sehr erfolgreich zu sein. Sie/er hofft, dass die Leute ihre/seine Leistungen anerkennen.'
    VIC3_SV14 'Es ist ihr/ihm wichtig, dass der Staat ihre/seine persönliche Sicherheit vor allen Bedrohungen gewährleistet. Sie/er will einen starken Staat, der seine Bürger verteidigt.'
    VIC3_SV15 'Sie/er sucht das Abenteuer bis geht gerne Risiken ein. Sie/er will ein aufregendes Leben haben.'
    VIC3_SV16 'Es ist ihr/ihm wichtig, sich jederzeit korrekt zu verhalten. Sie/er vermeidet es, Dinge zu tun, die andere Leute für falsch halten könnten.'
    VIC3_SV17 'Es ist ihr/ihm wichtig, dass andere sie/ihn respektieren. Sie/er will, dass die Leute tun, was sie/er sagt.'
    VIC3_SV18 'Es ist ihr/ihm wichtig, ihren/seinen Freunden gegenüber loyal zu sein. Sie/er will sich für Menschen einsetzen, die ihr/ihm nahe stehen.'
    VIC3_SV19 'Sie/er ist fest davon überzeugt, dass die Menschen sich um die Natur kümmern sollten. Umweltschutz ist ihr/ihm wichtig.'
    VIC3_SV20 'Tradition ist ihr/ihm wichtig. Sie/er versucht, sich an die Sitten und Gebräuche zu halten, die ihr/ihm von ihrer/seiner Religion oder ihrer/seiner Familie überliefert wurden.'
    VIC3_SV21 'Es ist ihr/ihm wichtig, anderen Menschen zu helfen und etwas Gutes für die Allgemeinheit zu tun.'
    VIC3_SV22 'Sie/er lässt keine Gelegenheit aus, Spaß zu haben. Es ist ihr/ihm wichtig, Dinge zu tun, die ihr/ihm Vergnügen bereiten.'.

RECODE VIC3_SV1 to VIC3_SV22  (0=SYSMIS) (1=1) (2=2) (3=3) (4=4) (5=5) (6=6).
EXECUTE.

VALUE LABELS VIC3_SV1 to VIC3_SV22 
    6 'Ist mir überhaupt nicht ähnlich'
    5 'Ist mir nicht ähnlich'
    4 'Ist mir nur ein kleines bisschen ähnlich'
    3 'Ist mir etwas ähnlich'
    2 'Ist mir ähnlich'
    1 'Ist mir sehr ähnlich' 
    7 'Verweigerung' 
    8 'Weiß nicht'
    9 'Keine Antwort'.
Missing values VIC3_SV1 to VIC3_SV22 (7 to 9).
EXECUTE.

*****************************************
---WAVE 3---

* 1. Build Schwartz Value Scale (SVS) according to
* http://essedunet.nsd.uib.no/cms/topics/1/4/1.html

* 1.1. Revert variable coding, provide labels and define missings.

*****************************************

RECODE
VIC3_SV1
VIC3_SV2
VIC3_SV3
VIC3_SV4
VIC3_SV5
VIC3_SV6
VIC3_SV7
VIC3_SV8
VIC3_SV9
VIC3_SV10
VIC3_SV11
VIC3_SV12
VIC3_SV13
VIC3_SV14
VIC3_SV15
VIC3_SV16
VIC3_SV17
VIC3_SV18
VIC3_SV19
VIC3_SV20
VIC3_SV21
VIC3_SV22
        (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (7=7) (8=8) (9=9)
    INTO VIC3_nSVSA1 VIC3_nSVSA2 VIC3_nSVSA3 
        VIC3_nSVSA4 VIC3_nSVSA5 VIC3_nSVSA6 
        VIC3_nSVSA7 VIC3_nSVSA8 VIC3_nSVSA9 
        VIC3_nSVSA10 VIC3_nSVSA11 VIC3_nSVSA12 
        VIC3_nSVSA13 VIC3_nSVSA14 VIC3_nSVSA15 
        VIC3_nSVSA16 VIC3_nSVSA17 VIC3_nSVSA18 
        VIC3_nSVSA19 VIC3_nSVSA20 VIC3_nSVSA21 VIC3_nSVSA22.
FORMATS VIC3_nSVSA1 TO VIC3_nSVSA22 (f1.0).
VARIABLE LABELS
    VIC3_nSVSA1 'Es ist ihr/ihm wichtig, neue Ideen zu entwickeln und kreativ zu sein. Sie/Er macht Sachen gerne auf ihre/seine eigene originelle Art und Weise.'
    VIC3_nSVSA2 'Es ist ihr/ihm wichtig, reich zu sein. Sie/er möchte viel Geld haben und teure Sachen besitzen.'
    VIC3_nSVSA3 'Sie/er hält es für wichtig, dass alle Menschen auf der Welt gleich behandelt werden sollten. Sie/er glaubt, dass jeder Mensch im Leben gleiche Chancen haben sollte.'
    VIC3_nSVSA4 'Es ist ihr/ihm wichtig, ihre/seine Fähigkeiten zu zeigen. Sie/er möchte, dass die Leute bewundern, was sie/er tut.'
    VIC3_nSVSA5 'Es ist ihr/ihm wichtig, in einem sicheren Umfeld zu leben. Sie/er vermeidet alles, was ihre/seine Sicherheit gefährden könnte.'
    VIC3_nSVSA6 'Sie/er mag Überraschungen und hält immer Ausschau nach neuen Aktivitäten. Sie/er denkt, dass im Leben Abwechslung wichtig ist.'
    VIC3_nSVSA7 'Sie/er glaubt, dass die Menschen tun sollten, was man ihnen sagt. Sie/er denkt, dass Menschen sich immer an Regeln halten sollten, selbst dann, wenn es niemand sieht.'
    VIC3_nSVSA8 'Es ist ihr/ihm wichtig, Menschen zuzuhören, die anders sind als sie/er. Auch wenn sie/er anderer Meinung ist als andere, will sie/er die anderen trotzdem verstehen.'
    VIC3_nSVSA9 'Es ist ihr/ihm wichtig, zurückhaltend bis bescheiden zu sein. Sie/er versucht, die Aufmerksamkeit nicht auf sich zu lenken.'
    VIC3_nSVSA10 'Es ist ihr/ihm wichtig, Spaß zu haben. Sie/er gönnt sich selbst gerne etwas.'
    VIC3_nSVSA11 'Es ist ihr/ihm wichtig, selbst zu entscheiden, was sie/er tut. Sie/er ist gerne frei bis unabhängig von anderen.'
    VIC3_nSVSA12 'Es ist ihr/ihm sehr wichtig, den Menschen um sie/ihn herum zu helfen. Sie/er will für deren Wohl sorgen.'
    VIC3_nSVSA13 'Es ist ihr/ihm wichtig, sehr erfolgreich zu sein. Sie/er hofft, dass die Leute ihre/seine Leistungen anerkennen.'
    VIC3_nSVSA14 'Es ist ihr/ihm wichtig, dass der Staat ihre/seine persönliche Sicherheit vor allen Bedrohungen gewährleistet. Sie/er will einen starken Staat, der seine Bürger verteidigt.'
    VIC3_nSVSA15 'Sie/er sucht das Abenteuer bis geht gerne Risiken ein. Sie/er will ein aufregendes Leben haben.'
    VIC3_nSVSA16 'Es ist ihr/ihm wichtig, sich jederzeit korrekt zu verhalten. Sie/er vermeidet es, Dinge zu tun, die andere Leute für falsch halten könnten.'
    VIC3_nSVSA17 'Es ist ihr/ihm wichtig, dass andere sie/ihn respektieren. Sie/er will, dass die Leute tun, was sie/er sagt.'
    VIC3_nSVSA18 'Es ist ihr/ihm wichtig, ihren/seinen Freunden gegenüber loyal zu sein. Sie/er will sich für Menschen einsetzen, die ihr/ihm nahe stehen.'
    VIC3_nSVSA19 'Sie/er ist fest davon überzeugt, dass die Menschen sich um die Natur kümmern sollten. Umweltschutz ist ihr/ihm wichtig.'
    VIC3_nSVSA20 'Tradition ist ihr/ihm wichtig. Sie/er versucht, sich an die Sitten und Gebräuche zu halten, die ihr/ihm von ihrer/seiner Religion oder ihrer/seiner Familie überliefert wurden.'
    VIC3_nSVSA21 'Es ist ihr/ihm wichtig, anderen Menschen zu helfen und etwas Gutes für die Allgemeinheit zu tun.'
    VIC3_nSVSA22 'Sie/er lässt keine Gelegenheit aus, Spaß zu haben. Es ist ihr/ihm wichtig, Dinge zu tun, die ihr/ihm Vergnügen bereiten.'.
VALUE LABELS VIC3_nSVSA1 to VIC3_nSVSA22 
    1 'Ist mir überhaupt nicht ähnlich'
    2 'Ist mir nicht ähnlich'
    3 'Ist mir nur ein kleines bisschen ähnlich'
    4 'Ist mir etwas ähnlich'
    5 'Ist mir ähnlich'
    6 'Ist mir sehr ähnlich' 
    7 'Verweigerung' 
    8 'Weiß nicht'
    9 'Keine Antwort'.
Missing values VIC3_nSVSA1 to VIC3_nSVSA22 (7 to 9).
EXECUTE.

*****************************************
 
* 1.2. Build mean raw rating for ten values.
* Indicate in the label or the name, that this is the  mean raw rating.

*****************************************

COMPUTE VIC3_Apow = MEAN (VIC3_nSVSA2, VIC3_nSVSA17).
COMPUTE VIC3_Aach = MEAN (VIC3_nSVSA4, VIC3_nSVSA13).
COMPUTE VIC3_Ahed = MEAN (VIC3_nSVSA22, VIC3_nSVSA10).
COMPUTE VIC3_Asti = MEAN (VIC3_nSVSA6, VIC3_nSVSA15).
COMPUTE VIC3_Aself = MEAN (VIC3_nSVSA1, VIC3_nSVSA11).
COMPUTE VIC3_Auni = MEAN (VIC3_nSVSA3, VIC3_nSVSA8, VIC3_nSVSA19).
COMPUTE VIC3_Aben = MEAN (VIC3_nSVSA12, VIC3_nSVSA18).
COMPUTE VIC3_Atra = MEAN (VIC3_nSVSA9, VIC3_nSVSA20).
COMPUTE VIC3_Acon = MEAN (VIC3_nSVSA16, VIC3_nSVSA7).
COMPUTE VIC3_Asec = MEAN (VIC3_nSVSA5, VIC3_nSVSA14).
EXECUTE.

VARIABLE LABELS
    VIC3_Apow 'Power – mean of raw rating'
    VIC3_Aach 'Achievement – mean of raw rating'
    VIC3_Ahed 'Hedonism – mean of raw rating'
    VIC3_Asti 'Stimulation – mean of raw rating'
    VIC3_Aself 'Self-Direction – mean of raw rating'
    VIC3_Auni 'Universalism – mean of raw rating'
    VIC3_Aben 'Benevolence – mean of raw rating'
    VIC3_Atra 'Tradition – mean of raw rating'
    VIC3_Acon 'Conformity – mean of raw rating'
    VIC3_Asec 'Security – mean of raw rating'.
EXECUTE.

*****************************************
 
* 1.3. COMPUTE each individual’s mean score on all 21 value-items 
* Call this variable MRAT.

*****************************************

COMPUTE VIC3_MRAT = Mean (VIC3_nSVSA1, VIC3_nSVSA2, VIC3_nSVSA3, 
                                        VIC3_nSVSA4, VIC3_nSVSA5, VIC3_nSVSA6, 
                                        VIC3_nSVSA7, VIC3_nSVSA8, VIC3_nSVSA9, 
                                        VIC3_nSVSA10, VIC3_nSVSA11, VIC3_nSVSA12, 
                                        VIC3_nSVSA13, VIC3_nSVSA14, VIC3_nSVSA15, 
                                        VIC3_nSVSA16, VIC3_nSVSA17, VIC3_nSVSA18, 
                                        VIC3_nSVSA19, VIC3_nSVSA20, VIC3_nSVSA22).
VARIABLE LABELS VIC3_MRAT 'Mean score on all answered value items'.
EXECUTE.

*****************************************
 
* 1.4. Centre scores of each of the 10 values for an individual around that individual’s MRAT 
* Use the ten values COMPUTEd above, and subtract MRAT from each value
* Indicate in the label or the name, that this is the centred value score
* Centre scores of each of the ten values for an individual around that individual’s MRAT 
* Use the indexes COMPUTEd above and subtract MRAT.

*****************************************

COMPUTE VIC3_Cpow = VIC3_Apow - VIC3_MRAT.
COMPUTE VIC3_Cach = VIC3_Aach - VIC3_MRAT.
COMPUTE VIC3_Ched = VIC3_Ahed - VIC3_MRAT.
COMPUTE VIC3_Csti = VIC3_Asti - VIC3_MRAT.
COMPUTE VIC3_Cself = VIC3_Aself - VIC3_MRAT.
COMPUTE VIC3_Cuni = VIC3_Auni - VIC3_MRAT.
COMPUTE VIC3_Cben = VIC3_Aben - VIC3_MRAT.
COMPUTE VIC3_Ctra = VIC3_Atra - VIC3_MRAT.
COMPUTE VIC3_Ccon = VIC3_Acon - VIC3_MRAT.
COMPUTE VIC3_Csec = VIC3_Asec - VIC3_MRAT.
EXECUTE.

VARIABLE LABELS
    VIC3_Cpow 'Power - Centred value score'
    VIC3_Cach 'Achievement - Centred value score'
    VIC3_Ched 'Hedonism - Centred value score'
    VIC3_Csti 'Stimulation - Centred value score'
    VIC3_Cself 'Self-Direction - Centred value score'
    VIC3_Cuni 'Universalism - Centred value score'
    VIC3_Cben 'Benevolence - Centred value score'
    VIC3_Ctra 'Tradition - Centred value score'
    VIC3_Ccon 'Conformity - Centred value score'
    VIC3_Csec 'Security - Centred value score'.
EXECUTE.

*****************************************
 
* 1.5. COMPUTE higher-order values, hedonism is put together with openness
* Logical maximum = 6, max is obtained when a respondent has answered 6 
* on all the items indexing the HO value
* Logical minimum = 1, min is obtained when a respondent has answered 1 
* on all items indexing the HO value
* Create higher-order values.

*****************************************

COMPUTE VIC3_OTC = Mean(VIC3_nSVSA6, VIC3_nSVSA15, VIC3_nSVSA1, 
                                    VIC3_nSVSA11, VIC3_nSVSA22, VIC3_nSVSA10).
COMPUTE VIC3_CON = Mean(VIC3_nSVSA9, VIC3_nSVSA20, VIC3_nSVSA16, 
                                    VIC3_nSVSA7, VIC3_nSVSA5, VIC3_nSVSA14).
COMPUTE VIC3_Self_tr = Mean(VIC3_nSVSA12, VIC3_nSVSA18, VIC3_nSVSA3, 
                                      VIC3_nSVSA8, VIC3_nSVSA19).
COMPUTE VIC3_Self_en = Mean(VIC3_nSVSA2, VIC3_nSVSA17, 
                                       VIC3_nSVSA4, VIC3_nSVSA13).
EXECUTE.
VARIABLE LABELS
    VIC3_OTC 'Openness to change'
    VIC3_CON 'Conservation'
    VIC3_Self_tr 'Self-transcendence'
    VIC3_Self_en 'Self-enhancement'.
EXECUTE.

*****************************************
 
* 1.6. COMPUTE higher-order values based on centered scales.

*****************************************

COMPUTE VIC3_selfenhancement_c=(VIC3_Cpow + VIC3_Cach) / 2.
EXECUTE.
COMPUTE VIC3_selftranscendence_c=(VIC3_Cuni + VIC3_Cben) / 2.
EXECUTE.
COMPUTE VIC3_openness_c=(VIC3_Csti + VIC3_Ched + VIC3_Cself) / 3.
EXECUTE.
COMPUTE VIC3_conservation_c=(VIC3_Ctra + VIC3_Ccon + VIC3_Csec) / 3.
EXECUTE.

VARIABLE LABELS
    VIC3_selfenhancement_c 'Self-enhancement (centered values)'
    VIC3_selftranscendence_c 'Self-trancendence (centered values)'
    VIC3_openness_c 'Openess to change (centered values)'
    VIC3_conservation_c 'Conservation (centered values)'.
EXECUTE.


*****************************************

* Building two axes based on centered higher-order values,

*****************************************

COMPUTE VIC3_opendim = VIC3_openness_c - VIC3_conservation_c.
EXECUTE.
COMPUTE VIC3_Selfdim = VIC3_selftranscendence_c - VIC3_selfenhancement_c.
EXECUTE.

VARIABLE LABELS VIC3_opendim
'Bewahrung der Ordnung vs. Offenheit für Veränderung'.
EXECUTE.

VARIABLE LABELS VIC3_Selfdim
'Statuserhöhung vs. Selbsttranszendenz'.
EXECUTE.

*****************************************

* 2. Delete temp variables

*****************************************

DELETE VARIABLES VIC3_nSVSA1 TO VIC3_nSVSA22.
DELETE VARIABLES Q70 TO Q72A22.
    
RENAME VARIABLES 
(VIC3_SV1
VIC3_SV2
VIC3_SV3
VIC3_SV4
VIC3_SV5
VIC3_SV6
VIC3_SV7
VIC3_SV8
VIC3_SV9
VIC3_SV10
VIC3_SV11
VIC3_SV12
VIC3_SV13
VIC3_SV14
VIC3_SV15
VIC3_SV16
VIC3_SV17
VIC3_SV18
VIC3_SV19
VIC3_SV20
VIC3_SV21
VIC3_SV22 =
VIC3_Q70A1
VIC3_Q70A2
VIC3_Q70A3
VIC3_Q70A4
VIC3_Q70A5
VIC3_Q70A6
VIC3_Q70A7
VIC3_Q70A8
VIC3_Q70A9
VIC3_Q70A10
VIC3_Q70A11
VIC3_Q70A12
VIC3_Q70A13
VIC3_Q70A14
VIC3_Q70A15
VIC3_Q70A16
VIC3_Q70A17
VIC3_Q70A18
VIC3_Q70A19
VIC3_Q70A20
VIC3_Q70A21
VIC3_Q70A22).

*********************************************
*** INGLEHART INDEX
*********************************************

IF (Q89A1 = 1 and Q89A3 = 2) VIC3_ingl_index = 4.
IF (Q89A1 = 2 and Q89A3 = 1) VIC3_ingl_index = 4.	 
IF (Q89A2 = 1 and Q89A4 = 2) VIC3_ingl_index = 1.
IF (Q89A2 = 2 and Q89A4 = 1) VIC3_ingl_index = 1.
IF (Q89A1 = 1 and Q89A2 = 2) VIC3_ingl_index = 3.
IF (Q89A1 = 1 and Q89A4 = 2) VIC3_ingl_index = 3.
IF (Q89A3 = 1 and Q89A2 = 2) VIC3_ingl_index = 3.
IF (Q89A3 = 1 and Q89A4 = 2) VIC3_ingl_index = 3.
IF (Q89A2 = 1 and Q89A1 = 2) VIC3_ingl_index = 2.
IF (Q89A2 = 1 and Q89A3 = 2) VIC3_ingl_index = 2.
IF (Q89A4 = 1 and Q89A1 = 2) VIC3_ingl_index = 2.
IF (Q89A4 = 1 and Q89A3 = 2) VIC3_ingl_index = 2.

VARIABLE LABELS VIC3_ingl_index 'Materialismus-Postmaterialismus nach Inglehart'.

VALUE LABELS VIC3_ingl_index 4 'Materialismus' 3 'eher materielle Orientierung' 2 'eher postmaterielle Orientierung' 1 'Postmaterialismus'.
EXECUTE.


*********************************************
*** VIC2 POLID Scores
*********************************************

* Mittelwerte über alle Items berechnen.

COMPUTE VICAT2_POLID_mean = mean.16(VICAT2_Q112A1, VICAT2_Q112A2, VICAT2_Q112A3, VICAT2_Q112A6, 
    VICAT2_Q112A17, VICAT2_Q112A18, VICAT2_Q112A19, VICAT2_Q112A20, 
    VICAT2_Q112A9, VICAT2_Q112A11, VICAT2_Q112A12, VICAT2_Q112A14,
    VICAT2_Q112A22, VICAT2_Q112A23, VICAT2_Q112A24, VICAT2_Q112A25). 
Descriptives VICAT2_POLID_mean.

* Dimension: Libertarismus (zentrierte Mittelwerte)

COMPUTE VICAT2_POLIDneo =(mean.3(VICAT2_Q112A1, VICAT2_Q112A2, VICAT2_Q112A3, VICAT2_Q112A6))-VICAT_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT2_POLIDneo 'Politische Ideologieskala (POLID) - Libertarismus'.

* Dimension: Sozialismus (zentrierte Mittelwerte)

COMPUTE VICAT2_POLIDsoz =(mean.3(VICAT2_Q112A17, VICAT2_Q112A18, VICAT2_Q112A19, VICAT2_Q112A20))-VICAT_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT2_POLIDsoz 'Politische Ideologieskala (POLID) - Sozialismus'.

* Dimension: Konservativismus (zentrierte Mittelwerte)

COMPUTE VICAT2_POLIDkon =(mean.3(VICAT2_Q112A9, VICAT2_Q112A11, VICAT2_Q112A12, VICAT2_Q112A14))-VICAT_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT2_POLIDkon 'Politische Ideologieskala (POLID) - Konservativismus'.

* Dimension: Liberalismus (zentrierte Mittelwerte)

COMPUTE VICAT2_POLIDlib =(mean.3(VICAT2_Q112A22, VICAT2_Q112A23, VICAT2_Q112A24, VICAT2_Q112A25))-VICAT_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT2_POLIDkon 'Politische Ideologieskala (POLID) - Liberalismus'.

* Berechnungsvariablen löschen.

DELETE VARIABLES VICAT2_POLID_mean.


*********************************************
*** VIC2 Ideologie Scores (Alternativ)
*********************************************

* Mittelwerte über alle Items berechnen.

COMPUTE VICAT2_POLID_mean = mean.16(VICAT2_Q112A1, VICAT2_Q112A2, VICAT2_Q112A3, VICAT2_Q112A6, 
    VICAT2_Q112A16, VICAT2_Q112A18, VICAT2_Q112A21, VICAT2_Q112A20, 
    VICAT2_Q112A9, VICAT2_Q112A11, VICAT2_Q112A12, VICAT2_Q112A14,
    VICAT2_Q112A22, VICAT2_Q112A23, VICAT2_Q112A24, VICAT2_Q112A25). 
Descriptives VICAT2_POLID_mean.

* Dimension: Libertarismus (zentrierte Mittelwerte)

COMPUTE VICAT2_neo2 =(mean.3(VICAT2_Q112A1, VICAT2_Q112A2, VICAT2_Q112A3, VICAT2_Q112A6))-VICAT2_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT2_neo2 'Libertarismus2'.

* Dimension: Sozialismus (zentrierte Mittelwerte)

COMPUTE VICAT2_soz2 =(mean.3(VICAT2_Q112A16, VICAT2_Q112A18, VICAT2_Q112A21, VICAT2_Q112A20))-VICAT2_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT2_soz2 'Sozialismus2'.

* Dimension: Konservativismus (zentrierte Mittelwerte)

COMPUTE VICAT2_kon2 =(mean.3(VICAT2_Q112A9, VICAT2_Q112A11, VICAT2_Q112A12, VICAT2_Q112A14))-VICAT2_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT2_kon2 'Konservativismus2'.

* Dimension: Liberalismus (zentrierte Mittelwerte)

COMPUTE VICAT2_lib2 =(mean.3(VICAT2_Q112A22, VICAT2_Q112A23, VICAT2_Q112A24, VICAT2_Q112A25))-VICAT2_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT2_lib2 'Liberalismus2'.

* Berechnungsvariablen löschen.

DELETE VARIABLES VICAT2_POLID_mean.


*********************************************
*** VIC3 Ideologie Scores (Alternativ)
*********************************************

* Mittelwerte über alle Items berechnen.

COMPUTE VICAT3_POLID_mean = mean.16(VICAT3_Q112A1, VICAT3_Q112A2, VICAT3_Q112A3, VICAT3_Q112A4, 
    VICAT3_Q112A5, VICAT3_Q112A6, VICAT3_Q112A7, VICAT3_Q112A8, 
    VICAT3_Q112A9, VICAT3_Q112A10, VICAT3_Q112A11, VICAT3_Q112A12,
    VICAT3_Q112A13, VICAT3_Q112A14, VICAT3_Q112A15, VICAT3_Q112A16). 
Descriptives VICAT3_POLID_mean.

* Dimension: Libertarismus (zentrierte Mittelwerte)

COMPUTE VICAT3_neo =(mean.3(VICAT3_Q112A1, VICAT3_Q112A2, VICAT3_Q112A3, VICAT3_Q112A4))-VICAT3_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT3_neo 'Libertarismus'.

* Dimension: Sozialismus (zentrierte Mittelwerte)

COMPUTE VICAT3_soz =(mean.3(VICAT3_Q112A9, VICAT3_Q112A10, VICAT3_Q112A11, VICAT3_Q112A12))-VICAT3_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT3_soz 'Sozialismus'.

* Dimension: Konservativismus (zentrierte Mittelwerte)

COMPUTE VICAT3_kon =(mean.3(VICAT3_Q112A5, VICAT3_Q112A6, VICAT3_Q112A7, VICAT3_Q112A8))-VICAT3_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT3_kon 'Konservativismus'.

* Dimension: Liberalismus (zentrierte Mittelwerte)

COMPUTE VICAT3_lib =(mean.3(VICAT3_Q112A13, VICAT3_Q112A14, VICAT3_Q112A15, VICAT3_Q112A16))-VICAT3_POLID_mean.
EXECUTE.
VARIABLE LABELS VICAT3_lib 'Liberalismus'.

* Berechnungsvariablen löschen.

DELETE VARIABLES VICAT3_POLID_mean.


*********************************************
*** Filtervariablen für Schnellausfüller erstellen
*********************************************

* Schnellausfüller Schwartz-Skala.

COMPUTE VIC3_Schnellausfüller_Schwartz=99.
IF (VIC3_LOIQ70<60) VIC3_Schnellausfüller_Schwartz=1.
IF (VIC3_LOIQ70>=60) VIC3_Schnellausfüller_Schwartz=0.
VARIABLE LABELS VIC3_Schnellausfüller_Schwartz 'Schnellausfüller Schwartz Werteskala unter 60 Sekunden'.
 VALUE LABELS VIC3_Schnellausfüller_Schwartz
                    1 'Ja'
                    0 'Nein'.
MISSING VALUES VIC3_Schnellausfüller_Schwartz (99).
EXECUTE.

* Schnellausfüller Q57.

COMPUTE VICAT3_Schnellausfüller_Q57=99.
IF (VICAT3_LOIQ57<30) VICAT3_Schnellausfüller_Q57=1.
IF (VICAT3_LOIQ57>=30) VICAT3_Schnellausfüller_Q57=0.
VARIABLE LABELS VICAT3_Schnellausfüller_Q57 'Schnellausfüller Corona Skepsis unter 30 Sekunden'.
 VALUE LABELS VICAT3_Schnellausfüller_Q57
                    1 'Ja'
                    0 'Nein'.
MISSING VALUES VICAT3_Schnellausfüller_Q57 (99).
EXECUTE.

* Schnellausfüller Q104.

COMPUTE VICAT3_Schnellausfüller_Q104=99.
IF (VICAT3_LOIQ104<30) VICAT3_Schnellausfüller_Q104=1.
IF (VICAT3_LOIQ104>=30) VICAT3_Schnellausfüller_Q104=0.
VARIABLE LABELS VICAT3_Schnellausfüller_Q104 'Schnellausfüller "Gruppenbezogene Menschenfeindlichkeit" unter 30 Sekunden'.
 VALUE LABELS VICAT3_Schnellausfüller_Q104
                    1 'Ja'
                    0 'Nein'.
MISSING VALUES VICAT3_Schnellausfüller_Q104 (99).
EXECUTE.

* Schnellausfüller Ideologieskala.

COMPUTE VICAT3_Schnellausfüller_Q112=99.
IF (VICAT3_LOIQ112<77) VICAT3_Schnellausfüller_Q112=1.
IF (VICAT3_LOIQ112>=77) VICAT3_Schnellausfüller_Q112=0.
VARIABLE LABELS VICAT3_Schnellausfüller_Q112 'Schnellausfüller Ideologieskala unter 77 Sekunden'.
 VALUE LABELS VICAT3_Schnellausfüller_Q112
                    1 'Ja'
                    0 'Nein'.
MISSING VALUES VICAT3_Schnellausfüller_Q112 (99).
EXECUTE.
