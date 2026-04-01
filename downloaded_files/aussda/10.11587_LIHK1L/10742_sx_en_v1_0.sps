* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.

*****************************************

* Build Schwartz Value Scale (SVS) according to
* http://essedunet.nsd.uib.no/cms/topics/1/4/1.html

* THE SUBSEQUENT RECODE COMMANDS REVERSE THE ORIGINAL
  CODING OF THE SCHWARTZ VALUE ITEMS (FROM THE ESS) TO A CODING
  WHERE HIGH NUMBERS STAND FOR HIGH PREFERENCES.

*****************************************
 
RECODE Q21_1 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV1.
VARIABLE LABELS  SV1 'Self_Direction1'.

RECODE Q21_2 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS)  (ELSE=Copy) INTO SV2.
VARIABLE LABELS  SV2 'Power1'.

RECODE Q21_3 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS)  (ELSE=Copy) INTO SV3.
VARIABLE LABELS  SV3 'Universalism1'.

RECODE Q21_4 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS)  (ELSE=Copy) INTO SV4.
VARIABLE LABELS  SV4 'Achievement1'.

RECODE Q21_5 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS)  (ELSE=Copy) INTO SV5.
VARIABLE LABELS  SV5 'Security1'.

RECODE Q21_6 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS)  (ELSE=Copy) INTO SV6.
VARIABLE LABELS  SV6 'Stimulation1'.

RECODE Q21_7 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV7.
VARIABLE LABELS  SV7 'Conformity1'.

RECODE Q21_8 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV8.
VARIABLE LABELS  SV8 'Universalism2'.

RECODE Q21_9 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV9.
VARIABLE LABELS  SV9 'Tradition1'.

RECODE Q21_10 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV10.
VARIABLE LABELS  SV10 'Hedonism1'.

RECODE Q21_11 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV11.
VARIABLE LABELS  SV11 'Self_Direction2'.

RECODE Q21_12 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV12.
VARIABLE LABELS  SV12 'Benevolence1'.

RECODE Q21_13 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV13.
VARIABLE LABELS  SV13 'Achievement2'.

RECODE Q21_14 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV14.
VARIABLE LABELS  SV14 'Security2'.

RECODE Q21_15 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV15.
VARIABLE LABELS  SV15 'Stimulation2'.

RECODE Q21_16 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV16.
VARIABLE LABELS  SV16 'Conformity2'.

RECODE Q21_17 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV17.
VARIABLE LABELS  SV17 'Power2'.

RECODE Q21_18 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV18.
VARIABLE LABELS  SV18 'Benevolence2'.

RECODE Q21_19 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV19.
VARIABLE LABELS  SV19 'Universalism3'.

RECODE Q21_20 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV20.
VARIABLE LABELS  SV20 'Tradition2'.

RECODE Q21_22 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (-1=SYSMIS) (98=SYSMIS) (ELSE=Copy) INTO SV21.
VARIABLE LABELS  SV21 'Hedonism'.
EXECUTE.

*****************************************

* The subsequent commands calculate the mean rating across ALL Schwartz items including the newly developed one. SPSS defines the "TO" 
command on the basis of variable position in the file, so here this means - as SV21 is the last of the Schwartz items in the file - that 
the mean rating of ALL Schwartz items is calculated.

*****************************************

COMPUTE MRAT=mean(SV1 to SV21). 
EXECUTE.

VARIABLE LABELS MRAT
'MRAT Mean score on all answered value items'.
EXECUTE.


*****************************************
 
* The subsequent commands calculate raw scores for the TEN basic values of Schwartz.

*****************************************

COMPUTE SEraw = MEAN(SV5, SV14).
COMPUTE COraw = MEAN(SV7, SV16).
COMPUTE TRraw = MEAN(SV9, SV20).
COMPUTE BEraw = MEAN(SV12, SV18).
COMPUTE UNraw = MEAN(SV3, SV8, SV19).
COMPUTE SDraw = MEAN(SV1, SV11).
COMPUTE STraw = MEAN(SV6, SV15).
COMPUTE HEraw = MEAN(SV10, SV21).
COMPUTE ACraw = MEAN(SV4, SV13).
COMPUTE POraw = MEAN(SV2, SV17).
EXECUTE.


VARIABLE LABELS POraw
'Power – mean of raw rating'.
EXECUTE.

VARIABLE LABELS ACraw
'Achievement – mean of raw rating'.
EXECUTE.

VARIABLE LABELS HEraw
'Hedonism – mean of raw rating'.
EXECUTE.

VARIABLE LABELS STraw 
'Stimulation – mean of raw rating'.
EXECUTE.

VARIABLE LABELS SDraw 
'Self-Direction – mean of raw rating'.
EXECUTE.

VARIABLE LABELS UNraw 
'Universalism – mean of raw rating'.
EXECUTE.

VARIABLE LABELS BEraw 
'Benevolence – mean of raw rating'.
EXECUTE.

VARIABLE LABELS TRraw
'Tradition – mean of raw rating'.
EXECUTE.

VARIABLE LABELS COraw 
'Conformity – mean of raw rating'.
EXECUTE.

VARIABLE LABELS SEraw 
'Security – mean of raw rating'.
EXECUTE.


*****************************************
 
* The subsequent commands calculate centered/ipsatized scores for the TEN basic values of Schwartz.

*****************************************


COMPUTE SEcenter = MEAN(SV5, SV14) - mrat.
COMPUTE COcenter = MEAN(SV7, SV16) - mrat.
COMPUTE TRcenter = MEAN(SV9, SV20) - mrat.
COMPUTE BEcenter = MEAN(SV12, SV18) - mrat.
COMPUTE UNcenter = MEAN(SV3, SV8, SV19) - mrat.
COMPUTE SDcenter = MEAN(SV1, SV11) - mrat.
COMPUTE STcenter = MEAN(SV6, SV15) - mrat.
COMPUTE HEcenter = MEAN(SV10, SV21) - mrat.
COMPUTE ACcenter = MEAN(SV4, SV13) - mrat.
COMPUTE POcenter = MEAN(SV2, SV17) - mrat.
EXECUTE.


VARIABLE LABELS POcenter
'Power - Centred value score'.
EXECUTE.

VARIABLE LABELS ACcenter
'Achievement - Centred value score'.
EXECUTE.

VARIABLE LABELS HEcenter
'Hedonism - Centred value score'.
EXECUTE.

VARIABLE LABELS STcenter
'Stimulation - Centred value score'.
EXECUTE.

VARIABLE LABELS SDcenter
'Self-Direction - Centred value score'.
EXECUTE.

VARIABLE LABELS UNcenter
'Universalism - Centred value score'.
EXECUTE.

VARIABLE LABELS BEcenter
'Benevolence - Centred value score'.
EXECUTE.

VARIABLE LABELS TRcenter
'Tradition - Centred value score'.
EXECUTE.

VARIABLE LABELS COcenter
'Conformity - Centred value score'.
EXECUTE.

VARIABLE LABELS SEcenter
'Security - Centred value score'.
EXECUTE.


*****************************************
 
* The subsequent commands calculate the centered higher order values of the short Portraits values scale.

*****************************************

COMPUTE selfenhancement=(POcenter + ACcenter) / 2.
EXECUTE.
COMPUTE selftrancendence=(UNcenter + BEcenter) / 2.
EXECUTE.
COMPUTE openness=(STcenter + SDcenter + HEcenter) / 3.
EXECUTE.
COMPUTE conservation=(SEcenter + COcenter + TRcenter) / 3.
EXECUTE.


VARIABLE LABELS openness
'Openness to change - Mean of centered values'.
EXECUTE.

VARIABLE LABELS conservation
'Conservation - Mean of centered values'.
EXECUTE.

VARIABLE LABELS selftrancendence
'Self-transcendence - Mean of centered values'.
EXECUTE.

VARIABLE LABELS selfenhancement
'Self-enhancement - Mean of centered values'.
EXECUTE.


*****************************************

* Building two axes

*****************************************

COMPUTE axes_openness=openness - conservation.
EXECUTE.
COMPUTE axes_selftranscendence=selftrancendence - selfenhancement.
EXECUTE.


VARIABLE LABELS axes_openness
'Axes Openness: Conservation vs. Openness for Change'.
EXECUTE.

VARIABLE LABELS axes_selftranscendence
'Axes Self Dimension: Self Enhancement vs. Self Transcendence'.
EXECUTE.


*****************************************

* Build Davis Empathy Score

*****************************************

MISSING VALUES 
Q31_1(-1, 98). 
EXECUTE.

MISSING VALUES 
Q31_2(-1, 98). 
EXECUTE.

MISSING VALUES 
Q31_3(-1, 98). 
EXECUTE.

MISSING VALUES 
Q31_4(-1, 98). 
EXECUTE.

COMPUTE Davis_Empathy_Score=(Q31_1 + Q31_2 + Q31_3 + Q31_4)/4.
EXECUTE.

VARIABLE LABELS Davis_Empathy_Score
'Davis Empathy Score'.
EXECUTE.

MISSING VALUES 
Davis_Empathy_Score(96). 
EXECUTE.

VALUE LABELS Davis_Empathy_Score
96 'Not asked'.
EXECUTE.


*****************************************

* Build Inglehart Index

*****************************************

MISSING VALUES 
Q32_1(95, 98). 
EXECUTE.

MISSING VALUES 
Q32_2(95, 98). 
EXECUTE.


IF Q32_1=3 AND Q32_2=1 inglehart_index=4.
IF Q32_1=1 AND Q32_2=3 inglehart_index=4.
IF Q32_1=1 AND Q32_2=2 inglehart_index=3.
IF Q32_1=3 AND Q32_2=2 inglehart_index=3.
IF Q32_1=1 AND Q32_2=4 inglehart_index=3.
IF Q32_1=3 AND Q32_2=4 inglehart_index=3.
IF Q32_1=2 AND Q32_2=1 inglehart_index=2.
IF Q32_1=4 AND Q32_2=1 inglehart_index=2.
IF Q32_1=2 AND Q32_2=3 inglehart_index=2.
IF Q32_1=4 AND Q32_2=3 inglehart_index=2.
IF Q32_1=2 AND Q32_2=4 inglehart_index=1.
IF Q32_1=4 AND Q32_2=2 inglehart_index=1.
IF Q32_1=96 OR Q32_2=96 inglehart_index=96.
IF Q32_1=97 OR Q32_2=97 inglehart_index=97.


VARIABLE LABELS inglehart_index
'Inglehart Index'.
EXECUTE.


MISSING VALUES 
inglehart_index(96, 97). 
EXECUTE.

VALUE LABELS inglehart_index 
4 'Materialism' 
3 'rather materialist' 
2 'rather post-materialist' 
1 'Postmaterialism'
96 'Differently measured'
97 'Not computed'.
EXECUTE.


*****************************************

* Build Big Five personality traits

*****************************************

MISSING VALUES 
Q30_1(-1, 98). 
EXECUTE.

MISSING VALUES 
Q30_2(-1, 98). 
EXECUTE.

MISSING VALUES 
Q30_3(-1, 98). 
EXECUTE.

MISSING VALUES 
Q30_4(-1, 98). 
EXECUTE.

MISSING VALUES 
Q30_5(-1, 98). 
EXECUTE.

MISSING VALUES 
Q30_6(-1, 98). 
EXECUTE.

MISSING VALUES 
Q30_7(-1, 98). 
EXECUTE.

MISSING VALUES 
Q30_8(-1, 98). 
EXECUTE.

MISSING VALUES 
Q30_9(-1, 98). 
EXECUTE.

MISSING VALUES 
Q30_10(-1, 98). 
EXECUTE.

RECODE Q30_1 Q30_3 Q30_4 Q30_5 Q30_7 (1=5) (2=4) (3=3) (4=2) (5=1) (96=96) (ELSE=SYSMIS) INTO persrec1 persrec2 persrec3 persrec4 persrec5.
EXECUTE.
COMPUTE Extraversion_Scale=(persrec1 + Q30_6) / 2.
EXECUTE.
COMPUTE Neuroticism_Scale=(persrec3 + Q30_9) / 2.
EXECUTE.
COMPUTE Agreeableness_Scale=(persrec5 + Q30_2) / 2.
EXECUTE.
COMPUTE Conscientiousness_Scale=(persrec2 + Q30_8) / 2.
EXECUTE.
COMPUTE Openness_Scale=(persrec4 + Q30_10) / 2.
EXECUTE.


VARIABLE LABELS Extraversion_Scale
'Extraversion Scale'.
EXECUTE.

MISSING VALUES 
Extraversion_Scale(96). 
EXECUTE.

VALUE LABELS Extraversion_Scale 
96 'Differently measured '.
EXECUTE.

VARIABLE LABELS Neuroticism_Scale
'Neuroticism Scale'.
EXECUTE.

MISSING VALUES 
Neuroticism_Scale(96). 
EXECUTE.

VALUE LABELS Neuroticism_Scale 
96 'Differently measured '.
EXECUTE.

VARIABLE LABELS Agreeableness_Scale
'Agreeableness Scale'.
EXECUTE.

MISSING VALUES 
Agreeableness_Scale(96). 
EXECUTE.

VALUE LABELS Agreeableness_Scale 
96 'Differently measured '.
EXECUTE.

VARIABLE LABELS Conscientiousness_Scale
'Conscientiousness Scale'.
EXECUTE.

MISSING VALUES 
Conscientiousness_Scale(96). 
EXECUTE.

VALUE LABELS Conscientiousness_Scale
96 'Differently measured '.
EXECUTE.

VARIABLE LABELS Openness_Scale
'Openness Scale'.
EXECUTE.

MISSING VALUES 
Openness_Scale(96). 
EXECUTE.

VALUE LABELS Openness_Scale 
96 'Differently measured '.
EXECUTE.


*****************************************

* Build Big Five personality traits separately for Sweden 

*****************************************

RECODE Q30_1_SWE 
    Q30_3_SWE 
    Q30_7_SWE 
    Q30_8_SWE 
    Q30_10_SWE 
    Q30_14_SWE 
    (1=5) (2=4) (3=3) (4=2) (5=1) (ELSE=SYSMIS) INTO persrec1_SWE persrec2_SWE persrec3_SWE persrec4_SWE persrec5_SWE persrec6_SWE.
EXECUTE.

COMPUTE Extraversion_Scale_SWE=(persrec1_SWE + Q30_6_SWE + Q30_11_SWE) / 3.
EXECUTE.

COMPUTE Neuroticism_Scale_SWE=(Q30_4_SWE + Q30_9_SWE + persrec6_SWE) / 3.
EXECUTE.

COMPUTE Agreeableness_Scale_SWE=(Q30_2_SWE + persrec3_SWE + Q30_12_SWE) / 3.
EXECUTE.

COMPUTE Conscientiousness_Scale_SWE=(persrec2_SWE + persrec4_SWE + Q30_13_SWE) / 3.
EXECUTE.

COMPUTE Openness_Scale_SWE=(Q30_5_SWE + persrec5_SWE + Q30_15_SWE) / 3.
EXECUTE.


VARIABLE LABELS Extraversion_Scale_SWE
'Extraversion Scale for Sweden'.
EXECUTE.

VARIABLE LABELS Neuroticism_Scale_SWE
'Neuroticism Scale for Sweden'.
EXECUTE.

VARIABLE LABELS Agreeableness_Scale_SWE
'Agreeableness Scale for Sweden'.
EXECUTE.

VARIABLE LABELS Conscientiousness_Scale_SWE
'Conscientiousness Scale for Sweden'.
EXECUTE.

VARIABLE LABELS Openness_Scale_SWE
'Openness Scale for Sweden'.
EXECUTE.


*****************************************

* Delete Variables that are no longer needed 

*****************************************

DELETE VARIABLES
persrec1
persrec2
persrec3
persrec4
persrec5
persrec1_SWE
persrec2_SWE
persrec3_SWE
persrec4_SWE
persrec5_SWE
persrec6_SWE
SV1
SV2
SV3
SV4
SV5
SV6
SV7
SV8
SV9
SV10
SV11
SV12
SV13
SV14
SV15
SV16
SV17
SV18
SV19
SV20
SV21.
EXECUTE.
