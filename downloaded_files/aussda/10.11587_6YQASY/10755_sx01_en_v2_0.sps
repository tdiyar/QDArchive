* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.

*****************************************
---WAVE 1--- 10755


* 1. Build Schwartz Value Scale (SVS) according to
* http://essedunet.nsd.uib.no/cms/topics/1/4/1.html

* 1.1. Revert variable coding, provide labels and define missings.

*****************************************

RECODE
VIC1_Q33A1
VIC1_Q33A2
VIC1_Q33A3
VIC1_Q33A4
VIC1_Q33A5
VIC1_Q33A6
VIC1_Q33A7
VIC1_Q33A8
VIC1_Q33A9
VIC1_Q33A10
VIC1_Q33A11
VIC1_Q33A12
VIC1_Q33A13
VIC1_Q33A14
VIC1_Q33A15
VIC1_Q33A16
VIC1_Q33A17
VIC1_Q33A18
VIC1_Q33A19
VIC1_Q33A20
VIC1_Q33A21
VIC1_Q33A22 
        (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (7=7) (8=8) (9=9)
    INTO nSVSA1 nSVSA2 nSVSA3 
        nSVSA4 nSVSA5 nSVSA6 
        nSVSA7 nSVSA8 nSVSA9 
        nSVSA10 nSVSA11 nSVSA12 
        nSVSA13 nSVSA14 nSVSA15 
        nSVSA16 nSVSA17 nSVSA18 
        nSVSA19 nSVSA20 nSVSA21 nSVSA22.
FORMATS nSVSA1 TO nSVSA22 (f1.0).
VARIABLE LABELS
    nSVSA1 'Es ist ihr/ihm wichtig, neue Ideen zu entwickeln und kreativ zu sein. Sie/Er macht Sachen gerne auf ihre/seine eigene originelle Art und Weise.'
    nSVSA2 'Es ist ihr/ihm wichtig, reich zu sein. Sie/er möchte viel Geld haben und teure Sachen besitzen.'
    nSVSA3 'Sie/er hält es für wichtig, dass alle Menschen auf der Welt gleich behandelt werden sollten. Sie/er glaubt, dass jeder Mensch im Leben gleiche Chancen haben sollte.'
    nSVSA4 'Es ist ihr/ihm wichtig, ihre/seine Fähigkeiten zu zeigen. Sie/er möchte, dass die Leute bewundern, was sie/er tut.'
    nSVSA5 'Es ist ihr/ihm wichtig, in einem sicheren Umfeld zu leben. Sie/er vermeidet alles, was ihre/seine Sicherheit gefährden könnte.'
    nSVSA6 'Sie/er mag Überraschungen und hält immer Ausschau nach neuen Aktivitäten. Sie/er denkt, dass im Leben Abwechslung wichtig ist.'
    nSVSA7 'Sie/er glaubt, dass die Menschen tun sollten, was man ihnen sagt. Sie/er denkt, dass Menschen sich immer an Regeln halten sollten, selbst dann, wenn es niemand sieht.'
    nSVSA8 'Es ist ihr/ihm wichtig, Menschen zuzuhören, die anders sind als sie/er. Auch wenn sie/er anderer Meinung ist als andere, will sie/er die anderen trotzdem verstehen.'
    nSVSA9 'Es ist ihr/ihm wichtig, zurückhaltend bis bescheiden zu sein. Sie/er versucht, die Aufmerksamkeit nicht auf sich zu lenken.'
    nSVSA10 'Es ist ihr/ihm wichtig, Spaß zu haben. Sie/er gönnt sich selbst gerne etwas.'
    nSVSA11 'Es ist ihr/ihm wichtig, selbst zu entscheiden, was sie/er tut. Sie/er ist gerne frei bis unabhängig von anderen.'
    nSVSA12 'Es ist ihr/ihm sehr wichtig, den Menschen um sie/ihn herum zu helfen. Sie/er will für deren Wohl sorgen.'
    nSVSA13 'Es ist ihr/ihm wichtig, sehr erfolgreich zu sein. Sie/er hofft, dass die Leute ihre/seine Leistungen anerkennen.'
    nSVSA14 'Es ist ihr/ihm wichtig, dass der Staat ihre/seine persönliche Sicherheit vor allen Bedrohungen gewährleistet. Sie/er will einen starken Staat, der seine Bürger verteidigt.'
    nSVSA15 'Sie/er sucht das Abenteuer bis geht gerne Risiken ein. Sie/er will ein aufregendes Leben haben.'
    nSVSA16 'Es ist ihr/ihm wichtig, sich jederzeit korrekt zu verhalten. Sie/er vermeidet es, Dinge zu tun, die andere Leute für falsch halten könnten.'
    nSVSA17 'Es ist ihr/ihm wichtig, dass andere sie/ihn respektieren. Sie/er will, dass die Leute tun, was sie/er sagt.'
    nSVSA18 'Es ist ihr/ihm wichtig, ihren/seinen Freunden gegenüber loyal zu sein. Sie/er will sich für Menschen einsetzen, die ihr/ihm nahe stehen.'
    nSVSA19 'Sie/er ist fest davon überzeugt, dass die Menschen sich um die Natur kümmern sollten. Umweltschutz ist ihr/ihm wichtig.'
    nSVSA20 'Tradition ist ihr/ihm wichtig. Sie/er versucht, sich an die Sitten und Gebräuche zu halten, die ihr/ihm von ihrer/seiner Religion oder ihrer/seiner Familie überliefert wurden.'
    nSVSA21 'Es ist ihr/ihm wichtig, anderen Menschen zu helfen und etwas Gutes für die Allgemeinheit zu tun.'
    nSVSA22 'Sie/er lässt keine Gelegenheit aus, Spaß zu haben. Es ist ihr/ihm wichtig, Dinge zu tun, die ihr/ihm Vergnügen bereiten.'.
VALUE LABELS nSVSA1 to nSVSA22 
    1 'Ist mir überhaupt nicht ähnlich'
    2 'Ist mir nicht ähnlich'
    3 'Ist mir nur ein kleines bisschen ähnlich'
    4 'Ist mir etwas ähnlich'
    5 'Ist mir ähnlich'
    6 'Ist mir sehr ähnlich' 
    7 'Verweigerung' 
    8 'Weiß nicht'
    9 'Keine Antwort'.
Missing values nSVSA1 to nSVSA22 (7 to 9).
EXECUTE.

*****************************************
 
* 1.2. Build mean raw rating for ten values.
* Indicate in the label or the name, that this is the  mean raw rating.

*****************************************

COMPUTE VIC1_Apow = MEAN (nSVSA2, nSVSA17).
COMPUTE VIC1_Aach = MEAN (nSVSA4, nSVSA13).
COMPUTE VIC1_Ahed = MEAN (nSVSA22, nSVSA10).
COMPUTE VIC1_Asti = MEAN (nSVSA6, nSVSA15).
COMPUTE VIC1_Aself = MEAN (nSVSA1, nSVSA11).
COMPUTE VIC1_Auni = MEAN (nSVSA3, nSVSA8, nSVSA19).
COMPUTE VIC1_Aben = MEAN (nSVSA12, nSVSA18).
COMPUTE VIC1_Atra = MEAN (nSVSA9, nSVSA20).
COMPUTE VIC1_Acon = MEAN (nSVSA16, nSVSA7).
COMPUTE VIC1_Asec = MEAN (nSVSA5, nSVSA14).
EXECUTE.

VARIABLE LABELS
    VIC1_Apow 'Power – mean of raw rating'
    VIC1_Aach 'Achievement – mean of raw rating'
    VIC1_Ahed 'Hedonism – mean of raw rating'
    VIC1_Asti 'Stimulation – mean of raw rating'
    VIC1_Aself 'Self-Direction – mean of raw rating'
    VIC1_Auni 'Universalism – mean of raw rating'
    VIC1_Aben 'Benevolence – mean of raw rating'
    VIC1_Atra 'Tradition – mean of raw rating'
    VIC1_Acon 'Conformity – mean of raw rating'
    VIC1_Asec 'Security – mean of raw rating'.
EXECUTE.

*****************************************
 
* 1.3. COMPUTE each individual’s mean score on all 21 value-items 
* Call this variable MRAT.

*****************************************

COMPUTE VIC1_MRAT = Mean (nSVSA1, nSVSA2, nSVSA3, 
                                        nSVSA4, nSVSA5, nSVSA6, 
                                        nSVSA7, nSVSA8, nSVSA9, 
                                        nSVSA10, nSVSA11, nSVSA12, 
                                        nSVSA13, nSVSA14, nSVSA15, 
                                        nSVSA16, nSVSA17, nSVSA18, 
                                        nSVSA19, nSVSA20, nSVSA22).
VARIABLE LABELS VIC1_MRAT 'Mean score on all answered value items'.
EXECUTE.

*****************************************
 
* 1.4. Centre scores of each of the 10 values for an individual around that individual’s MRAT 
* Use the ten values COMPUTEd above, and subtract MRAT from each value
* Indicate in the label or the name, that this is the centred value score
* Centre scores of each of the ten values for an individual around that individual’s MRAT 
* Use the indexes COMPUTEd above and subtract MRAT.

*****************************************

COMPUTE VIC1_Cpow = VIC1_Apow - VIC1_MRAT.
COMPUTE VIC1_Cach = VIC1_Aach - VIC1_MRAT.
COMPUTE VIC1_Ched = VIC1_Ahed - VIC1_MRAT.
COMPUTE VIC1_Csti = VIC1_Asti - VIC1_MRAT.
COMPUTE VIC1_Cself = VIC1_Aself - VIC1_MRAT.
COMPUTE VIC1_Cuni = VIC1_Auni - VIC1_MRAT.
COMPUTE VIC1_Cben = VIC1_Aben - VIC1_MRAT.
COMPUTE VIC1_Ctra = VIC1_Atra - VIC1_MRAT.
COMPUTE VIC1_Ccon = VIC1_Acon - VIC1_MRAT.
COMPUTE VIC1_Csec = VIC1_Asec - VIC1_MRAT.
EXECUTE.
VARIABLE LABELS
    VIC1_Cpow 'Power - Centred value score'
    VIC1_Cach 'Achievement - Centred value score'
    VIC1_Ched 'Hedonism - Centred value score'
    VIC1_Csti 'Stimulation - Centred value score'
    VIC1_Cself 'Self-Direction - Centred value score'
    VIC1_Cuni 'Universalism - Centred value score'
    VIC1_Cben 'Benevolence - Centred value score'
    VIC1_Ctra 'Tradition - Centred value score'
    VIC1_Ccon 'Conformity - Centred value score'
    VIC1_Csec 'Security - Centred value score'.
EXECUTE.

*****************************************
 
* 1.5. COMPUTE higher-order values, hedonism is put together with openness
* Logical maximum = 6, max is obtained when a respondent has answered 6 
* on all the items indexing the HO value
* Logical minimum = 1, min is obtained when a respondent has answered 1 
* on all items indexing the HO value
* Create higher-order values.

*****************************************

COMPUTE VIC1_OTC = Mean(nSVSA6, nSVSA15, nSVSA1, 
                                    nSVSA11, nSVSA22, nSVSA10).
COMPUTE VIC1_CON = Mean(nSVSA9, nSVSA20, nSVSA16, 
                                    nSVSA7, nSVSA5, nSVSA14).
COMPUTE VIC1_Self_tr = Mean(nSVSA12, nSVSA18, nSVSA3, 
                                      nSVSA8, nSVSA19).
COMPUTE VIC1_Self_en = Mean(nSVSA2, nSVSA17, 
                                       nSVSA4, nSVSA13).
EXECUTE.
VARIABLE LABELS
    VIC1_OTC 'Openness to change'
    VIC1_CON 'Conservation'
    VIC1_Self_tr 'Self-transcendence'
    VIC1_Self_en 'Self-enhancement'.
EXECUTE.

*****************************************
 
* 1.6. COMPUTE higher-order values based on centered scales.

*****************************************

COMPUTE VIC1_selfenhancement_c=(VIC1_Cpow + VIC1_Cach) / 2.
EXECUTE.
COMPUTE VIC1_selftranscendence_c=(VIC1_Cuni + VIC1_Cben) / 2.
EXECUTE.
COMPUTE VIC1_openness_c=(VIC1_Csti + VIC1_Ched + VIC1_Cself) / 3.
EXECUTE.
COMPUTE VIC1_conservation_c=(VIC1_Ctra + VIC1_Ccon + VIC1_Csec) / 3.
EXECUTE.

VARIABLE LABELS
    VIC1_selfenhancement_c 'Self-enhancement (centered values)'
    VIC1_selftranscendence_c 'Self-trancendence (centered values)'
    VIC1_openness_c 'Openess to change (centered values)'
    VIC1_conservation_c 'Conservation (centered values)'.
EXECUTE.

*****************************************
*****************************************    
*****************************************    
*****************************************    

* Encoding: UTF-8.

*****************************************
---WAVE 2---

* 1. Build Schwartz Value Scale (SVS) according to
* http://essedunet.nsd.uib.no/cms/topics/1/4/1.html

* 1.1. Revert variable coding, provide labels and define missings.

*****************************************

RECODE
VIC2_Q75A1
VIC2_Q75A2
VIC2_Q75A3
VIC2_Q75A4
VIC2_Q75A5
VIC2_Q75A6
VIC2_Q75A7
VIC2_Q75A8
VIC2_Q75A9
VIC2_Q75A10
VIC2_Q75A11
VIC2_Q75A12
VIC2_Q75A13
VIC2_Q75A14
VIC2_Q75A15
VIC2_Q75A16
VIC2_Q75A17
VIC2_Q75A18
VIC2_Q75A19
VIC2_Q75A20
VIC2_Q75A21
VIC2_Q75A22
        (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (7=7) (8=8) (9=9)
    INTO VIC2_nSVSA1 VIC2_nSVSA2 VIC2_nSVSA3 
        VIC2_nSVSA4 VIC2_nSVSA5 VIC2_nSVSA6 
        VIC2_nSVSA7 VIC2_nSVSA8 VIC2_nSVSA9 
        VIC2_nSVSA10 VIC2_nSVSA11 VIC2_nSVSA12 
        VIC2_nSVSA13 VIC2_nSVSA14 VIC2_nSVSA15 
        VIC2_nSVSA16 VIC2_nSVSA17 VIC2_nSVSA18 
        VIC2_nSVSA19 VIC2_nSVSA20 VIC2_nSVSA21 VIC2_nSVSA22.
FORMATS VIC2_nSVSA1 TO VIC2_nSVSA22 (f1.0).
VARIABLE LABELS
    VIC2_nSVSA1 'Es ist ihr/ihm wichtig, neue Ideen zu entwickeln und kreativ zu sein. Sie/Er macht Sachen gerne auf ihre/seine eigene originelle Art und Weise.'
    VIC2_nSVSA2 'Es ist ihr/ihm wichtig, reich zu sein. Sie/er möchte viel Geld haben und teure Sachen besitzen.'
    VIC2_nSVSA3 'Sie/er hält es für wichtig, dass alle Menschen auf der Welt gleich behandelt werden sollten. Sie/er glaubt, dass jeder Mensch im Leben gleiche Chancen haben sollte.'
    VIC2_nSVSA4 'Es ist ihr/ihm wichtig, ihre/seine Fähigkeiten zu zeigen. Sie/er möchte, dass die Leute bewundern, was sie/er tut.'
    VIC2_nSVSA5 'Es ist ihr/ihm wichtig, in einem sicheren Umfeld zu leben. Sie/er vermeidet alles, was ihre/seine Sicherheit gefährden könnte.'
    VIC2_nSVSA6 'Sie/er mag Überraschungen und hält immer Ausschau nach neuen Aktivitäten. Sie/er denkt, dass im Leben Abwechslung wichtig ist.'
    VIC2_nSVSA7 'Sie/er glaubt, dass die Menschen tun sollten, was man ihnen sagt. Sie/er denkt, dass Menschen sich immer an Regeln halten sollten, selbst dann, wenn es niemand sieht.'
    VIC2_nSVSA8 'Es ist ihr/ihm wichtig, Menschen zuzuhören, die anders sind als sie/er. Auch wenn sie/er anderer Meinung ist als andere, will sie/er die anderen trotzdem verstehen.'
    VIC2_nSVSA9 'Es ist ihr/ihm wichtig, zurückhaltend bis bescheiden zu sein. Sie/er versucht, die Aufmerksamkeit nicht auf sich zu lenken.'
    VIC2_nSVSA10 'Es ist ihr/ihm wichtig, Spaß zu haben. Sie/er gönnt sich selbst gerne etwas.'
    VIC2_nSVSA11 'Es ist ihr/ihm wichtig, selbst zu entscheiden, was sie/er tut. Sie/er ist gerne frei bis unabhängig von anderen.'
    VIC2_nSVSA12 'Es ist ihr/ihm sehr wichtig, den Menschen um sie/ihn herum zu helfen. Sie/er will für deren Wohl sorgen.'
    VIC2_nSVSA13 'Es ist ihr/ihm wichtig, sehr erfolgreich zu sein. Sie/er hofft, dass die Leute ihre/seine Leistungen anerkennen.'
    VIC2_nSVSA14 'Es ist ihr/ihm wichtig, dass der Staat ihre/seine persönliche Sicherheit vor allen Bedrohungen gewährleistet. Sie/er will einen starken Staat, der seine Bürger verteidigt.'
    VIC2_nSVSA15 'Sie/er sucht das Abenteuer bis geht gerne Risiken ein. Sie/er will ein aufregendes Leben haben.'
    VIC2_nSVSA16 'Es ist ihr/ihm wichtig, sich jederzeit korrekt zu verhalten. Sie/er vermeidet es, Dinge zu tun, die andere Leute für falsch halten könnten.'
    VIC2_nSVSA17 'Es ist ihr/ihm wichtig, dass andere sie/ihn respektieren. Sie/er will, dass die Leute tun, was sie/er sagt.'
    VIC2_nSVSA18 'Es ist ihr/ihm wichtig, ihren/seinen Freunden gegenüber loyal zu sein. Sie/er will sich für Menschen einsetzen, die ihr/ihm nahe stehen.'
    VIC2_nSVSA19 'Sie/er ist fest davon überzeugt, dass die Menschen sich um die Natur kümmern sollten. Umweltschutz ist ihr/ihm wichtig.'
    VIC2_nSVSA20 'Tradition ist ihr/ihm wichtig. Sie/er versucht, sich an die Sitten und Gebräuche zu halten, die ihr/ihm von ihrer/seiner Religion oder ihrer/seiner Familie überliefert wurden.'
    VIC2_nSVSA21 'Es ist ihr/ihm wichtig, anderen Menschen zu helfen und etwas Gutes für die Allgemeinheit zu tun.'
    VIC2_nSVSA22 'Sie/er lässt keine Gelegenheit aus, Spaß zu haben. Es ist ihr/ihm wichtig, Dinge zu tun, die ihr/ihm Vergnügen bereiten.'.
VALUE LABELS VIC2_nSVSA1 to VIC2_nSVSA22 
    1 'Ist mir überhaupt nicht ähnlich'
    2 'Ist mir nicht ähnlich'
    3 'Ist mir nur ein kleines bisschen ähnlich'
    4 'Ist mir etwas ähnlich'
    5 'Ist mir ähnlich'
    6 'Ist mir sehr ähnlich' 
    7 'Verweigerung' 
    8 'Weiß nicht'
    9 'Keine Antwort'.
Missing values VIC2_nSVSA1 to VIC2_nSVSA22 (7 to 9).
EXECUTE.

*****************************************
 
* 1.2. Build mean raw rating for ten values.
* Indicate in the label or the name, that this is the  mean raw rating.

*****************************************

COMPUTE VIC2_Apow = MEAN (VIC2_nSVSA2, VIC2_nSVSA17).
COMPUTE VIC2_Aach = MEAN (VIC2_nSVSA4, VIC2_nSVSA13).
COMPUTE VIC2_Ahed = MEAN (VIC2_nSVSA22, VIC2_nSVSA10).
COMPUTE VIC2_Asti = MEAN (VIC2_nSVSA6, VIC2_nSVSA15).
COMPUTE VIC2_Aself = MEAN (VIC2_nSVSA1, VIC2_nSVSA11).
COMPUTE VIC2_Auni = MEAN (VIC2_nSVSA3, VIC2_nSVSA8, VIC2_nSVSA19).
COMPUTE VIC2_Aben = MEAN (VIC2_nSVSA12, VIC2_nSVSA18).
COMPUTE VIC2_Atra = MEAN (VIC2_nSVSA9, VIC2_nSVSA20).
COMPUTE VIC2_Acon = MEAN (VIC2_nSVSA16, VIC2_nSVSA7).
COMPUTE VIC2_Asec = MEAN (VIC2_nSVSA5, VIC2_nSVSA14).
EXECUTE.

VARIABLE LABELS
    VIC2_Apow 'Power – mean of raw rating'
    VIC2_Aach 'Achievement – mean of raw rating'
    VIC2_Ahed 'Hedonism – mean of raw rating'
    VIC2_Asti 'Stimulation – mean of raw rating'
    VIC2_Aself 'Self-Direction – mean of raw rating'
    VIC2_Auni 'Universalism – mean of raw rating'
    VIC2_Aben 'Benevolence – mean of raw rating'
    VIC2_Atra 'Tradition – mean of raw rating'
    VIC2_Acon 'Conformity – mean of raw rating'
    VIC2_Asec 'Security – mean of raw rating'.
EXECUTE.

*****************************************
 
* 1.3. COMPUTE each individual’s mean score on all 21 value-items 
* Call this variable MRAT.

*****************************************

COMPUTE VIC2_MRAT = Mean (VIC2_nSVSA1, VIC2_nSVSA2, VIC2_nSVSA3, 
                                        VIC2_nSVSA4, VIC2_nSVSA5, VIC2_nSVSA6, 
                                        VIC2_nSVSA7, VIC2_nSVSA8, VIC2_nSVSA9, 
                                        VIC2_nSVSA10, VIC2_nSVSA11, VIC2_nSVSA12, 
                                        VIC2_nSVSA13, VIC2_nSVSA14, VIC2_nSVSA15, 
                                        VIC2_nSVSA16, VIC2_nSVSA17, VIC2_nSVSA18, 
                                        VIC2_nSVSA19, VIC2_nSVSA20, VIC2_nSVSA22).
VARIABLE LABELS VIC2_MRAT 'Mean score on all answered value items'.
EXECUTE.

*****************************************
 
* 1.4. Centre scores of each of the 10 values for an individual around that individual’s MRAT 
* Use the ten values COMPUTEd above, and subtract MRAT from each value
* Indicate in the label or the name, that this is the centred value score
* Centre scores of each of the ten values for an individual around that individual’s MRAT 
* Use the indexes COMPUTEd above and subtract MRAT.

*****************************************

COMPUTE VIC2_Cpow = VIC2_Apow - VIC2_MRAT.
COMPUTE VIC2_Cach = VIC2_Aach - VIC2_MRAT.
COMPUTE VIC2_Ched = VIC2_Ahed - VIC2_MRAT.
COMPUTE VIC2_Csti = VIC2_Asti - VIC2_MRAT.
COMPUTE VIC2_Cself = VIC2_Aself - VIC2_MRAT.
COMPUTE VIC2_Cuni = VIC2_Auni - VIC2_MRAT.
COMPUTE VIC2_Cben = VIC2_Aben - VIC2_MRAT.
COMPUTE VIC2_Ctra = VIC2_Atra - VIC2_MRAT.
COMPUTE VIC2_Ccon = VIC2_Acon - VIC2_MRAT.
COMPUTE VIC2_Csec = VIC2_Asec - VIC2_MRAT.
EXECUTE.

VARIABLE LABELS
    VIC2_Cpow 'Power - Centred value score'
    VIC2_Cach 'Achievement - Centred value score'
    VIC2_Ched 'Hedonism - Centred value score'
    VIC2_Csti 'Stimulation - Centred value score'
    VIC2_Cself 'Self-Direction - Centred value score'
    VIC2_Cuni 'Universalism - Centred value score'
    VIC2_Cben 'Benevolence - Centred value score'
    VIC2_Ctra 'Tradition - Centred value score'
    VIC2_Ccon 'Conformity - Centred value score'
    VIC2_Csec 'Security - Centred value score'.
EXECUTE.

*****************************************
 
* 1.5. COMPUTE higher-order values, hedonism is put together with openness
* Logical maximum = 6, max is obtained when a respondent has answered 6 
* on all the items indexing the HO value
* Logical minimum = 1, min is obtained when a respondent has answered 1 
* on all items indexing the HO value
* Create higher-order values.

*****************************************

COMPUTE VIC2_OTC = Mean(VIC2_nSVSA6, VIC2_nSVSA15, VIC2_nSVSA1, 
                                    VIC2_nSVSA11, VIC2_nSVSA22, VIC2_nSVSA10).
COMPUTE VIC2_CON = Mean(VIC2_nSVSA9, VIC2_nSVSA20, VIC2_nSVSA16, 
                                    VIC2_nSVSA7, VIC2_nSVSA5, VIC2_nSVSA14).
COMPUTE VIC2_Self_tr = Mean(VIC2_nSVSA12, VIC2_nSVSA18, VIC2_nSVSA3, 
                                      VIC2_nSVSA8, VIC2_nSVSA19).
COMPUTE VIC2_Self_en = Mean(VIC2_nSVSA2, VIC2_nSVSA17, 
                                       VIC2_nSVSA4, VIC2_nSVSA13).
EXECUTE.
VARIABLE LABELS
    VIC2_OTC 'Openness to change'
    VIC2_CON 'Conservation'
    VIC2_Self_tr 'Self-transcendence'
    VIC2_Self_en 'Self-enhancement'.
EXECUTE.

*****************************************
 
* 1.6. COMPUTE higher-order values based on centered scales.

*****************************************

COMPUTE VIC2_selfenhancement_c=(VIC2_Cpow + VIC2_Cach) / 2.
EXECUTE.
COMPUTE VIC2_selftranscendence_c=(VIC2_Cuni + VIC2_Cben) / 2.
EXECUTE.
COMPUTE VIC2_openness_c=(VIC2_Csti + VIC2_Ched + VIC2_Cself) / 3.
EXECUTE.
COMPUTE VIC2_conservation_c=(VIC2_Ctra + VIC2_Ccon + VIC2_Csec) / 3.
EXECUTE.

VARIABLE LABELS
    VIC2_selfenhancement_c 'Self-enhancement (centered values)'
    VIC2_selftranscendence_c 'Self-trancendence (centered values)'
    VIC2_openness_c 'Openess to change (centered values)'
    VIC2_conservation_c 'Conservation (centered values)'.
EXECUTE.




*****************************************

* 2. drop all temporary files, resort and store dataset.

*****************************************

ADD FILES file *
/keep version TO filter_werte
        VIC1_Apow TO VIC2_conservation_c.
EXECUTE.

