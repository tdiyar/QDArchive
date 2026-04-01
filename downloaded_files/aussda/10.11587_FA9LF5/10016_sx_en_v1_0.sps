

**____________________________________________________________________________________
** Replication File - Medien Journal 3/ 2017**
** "Digital Mobility" and Data Quality*

** Daniela Wetzelhütter - daniela.wetzelhuetter@fh-linz.at**
** FH OÖ, Campus Linz

** Pages: 29 - 48**
**____________________________________________________________________________________


*-----------------------------------------------------.
*OPEN DATAFILE and SAVE IT.
*-----------------------------------------------------.

*OPEN  ->  adjust PATH. 
GET
  FILE='C:\Users\dwetz_000\Desktop\AUSSDA\DigitalMobilityDatenfile.sav'.

*SAVE -> adjust PATH. 
SAVE OUTFILE='C:\Users\dwetz_000\Desktop\AUSSDA\mbjku_context_finx1.sav'.

*be sure that data is not wighted or filtered. 
weight off. 
filter off.




*------------------------------------------------------------------------------------------------------------------.
*Abstract.
*------------------------------------------------------------------------------------------------------------------.

*NOTE: those who reacted to the invitation and therefore reached the welcome-page, but did not turn to the next page are not incuded in the data set;
            The respective information is provided by the online-survey template.

*## Culculating response-rates -> see also Table 1.
*Note: figures in the paper are partly rounded.

*Total-Population: N=17491 (18371-880),
*Gross-Sample: n=2483.
Compute TP=17491.
Compute GS=2483.

*#CALC ResponseRate-Gross-Sample.
compute RR_GS=(GS/TP)*100.
fre var RR_GS.


*Calc Proportion of NET-Sample.
*Net-Sample (=Participants).
fre var PD2.
*n=1923.
Compute NS=1923.
compute RR_NS=(NS/TP)*100.
fre var RR_NS.


*CALC regular participants (=reached final page).
fre var PD2.
compute Regular=1282.
compute RR_RS=(regular/TP)*100.
fre var RR_RS.


*------------------------------------------------------------------------------------------------------------------.
*3 Data and Methods.
*------------------------------------------------------------------------------------------------------------------.
*-----------------------------------------------------.
*3.1 Questionnaire and Data.
*-----------------------------------------------------.
*Note: Infomation about response time is provided by the online-survey-template. 
*Note: those who reacted to the invitation and therefore reached the welcome-page, but did not turn to the next page are not incuded;
            The related information is provided by the online-tamplate.
*Note: figures in the paper are partly rounded.


*xxxxxxxxxxx.
*TABLE 1. 
*xxxxxxxxxxx.
*Text p.34 + p.35.

*variables are computed above.
fre var TP GS RR_GS RR_NS RR_RS.


*compute variable break-off vs. regular - based on the dispcode.
fre var PD2.

recode PD2 (22=1) (31,32=0) into breakoff. 
recode PD2 (22=0) (31,32=1) into regular. 

fre var breakoff regular.


*Calc Dropout-Rates.
compute DOG = 2483-1923.
fre var dog.
compute DON = 1923-1282.
fre var don.


Compute DogRR=dog/2483*100.
Compute DonRR=don/2483*100.
fre var dogRR donRR.

compute DO=dog+don.
fre var do.

Compute DoRR=do/2483*100.
fre var doRR.


*xxxxxxxxxxx.
*Text below table 1, p35.

*sample charakteristics.
fre var D6 D7 .

*note.: mm excludes those who did not know if they are a multimedia student.
           *multim incluces those who did not know if they are a multimedia as "no".
fre var D3.
recode D3 (1,2=1) (3=0) (4=sysmis) (else=copy) into mm.
recode D3 (1,2=1) (3,4=0) (else=copy) into multim.
fre var mm multim.


*xxxxxxxxxxx.
*Footnoe 5 / TABLE A1. 
*xxxxxxxxxxx.
CROSSTABS PD1 by breakoff  /CELLS COUNT Row / STATISTICS = chi corr. 


*-----------------------------------------------------.
*3.2 Study Design.
*-----------------------------------------------------.

*xxxxxxxxxxx.
*Text, p35.

*PD3 in sec.
fre var PD3.
*PD3 in min.
compute dur1m=PD3/60.
des var dur1m.

*xx-excluding dropouts.
temp.
select if regular=1.
des var dur1m.


*xxxxxxxxxxx.
*TABLE A2. 
*xxxxxxxxxxx.

*compute place (home/not) AND smph (smartphone/not) .
fre var BK1 BK2.
recode BK1 (1=1) (2 thru high =0) into Home.
val lab Home 1 "yes" 0 "no".
recode BK2 (2=1) (1=0) (3=sysmis) into SMPH.
val lab SMPH 1 "yes" 0 "no".
CROSSTABS  home by smph / cells count row /statistics. 


*xxxxxxxxxxx.
*Footnote 6, p35. 
*xxxxxxxxxxx.

*compute mobility.
compute mobility=0.
if BK1=1 and BK2 =1 mobility=1.
if BK1=1 and BK2 =2 mobility=2.
if BK1>1 and BK2 =1 mobility=3.
if BK1>1 and BK2 =2 mobility=4.
val lab mobility 1 "Non-Mob" 2 "Mobile-Phone" 3 "Mobile-Place" 4 "Mobile".
recode mobility (0=sysmis).
fre var mobility.

sort cases by mobility.
split file by mobility.
temp.
select if regular=1.
des var dur1m.
split file off. 


*Testing influence of SMPH and Place on duration.
temp.
select if regular=1.
UNIANOVA dur1m  BY  home smph  
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN= home smph   smph*home.


*xxxxxxxxxxx.
*TABLE 2. 
*xxxxxxxxxxx.
CROSSTABS gruppetr by breakoff /CELLS COUNT Row / STATISTICS = chi corr.

*xxxxxxxxxxx.
*TABLE A3. 
*xxxxxxxxxxx.
SORT CASES by mobility.
SPLIT FILE by mobility.
CROSSTABS breakoff by gruppeTR / cells count row/ STATISTICS.
 
LOGISTIC REGRESSION VARIABLES breakoff
  /METHOD=ENTER   gruppeTR   
  /CONTRAST (gruppeTR)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5)
 /SAVE PRED  .

SPLIT FILE off. 

*ooooooooooo.
*Figure A1. 
*ooooooooooo. 

*Change order.
fre var mobility.
recode mobility (2=3) (3=2) (else=copy) into mob2.
val lab mob2  1 "Non-Mobile" 2 "Mobile-Place" 3 "Mobile-Phone" 4 "Mobile".
fre var mob2.

GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=mob2 MEAN(pre_1)[name="MEAN_pre_1"] gruppeTR 
    MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: mob2=col(source(s), name("mob2"), unit.category())
  DATA: MEAN_pre_1=col(source(s), name("MEAN_pre_1"))
  DATA: gruppeTR=col(source(s), name("gruppeTR"), unit.category())
  GUIDE: axis(dim(1), label("Digital Mobility"))
  GUIDE: axis(dim(2), label("Mean Predicted probability"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Trigger"))
  SCALE: cat(dim(1), include("1.00", "2.00", "3.00", "4.00"))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include(".00", "1.00", "2.00", "3.00"))
  ELEMENT: line(position(mob2*MEAN_pre_1), color.interior(gruppeTR), missing.wings())
END GPL.

*------------------------------------------------------------------------------------------------------------------.
*4 Results.
*------------------------------------------------------------------------------------------------------------------.
*-----------------------------------------------------.
*4.1 Context-related categorization of web survey respondents.
*-----------------------------------------------------.
*xxxxxxxxxxx.
*TABLE A2. 
*xxxxxxxxxxx.
fre var home smph.
CROSSTABS home by smph /CELLS COUNT Row / STATISTICS = chi corr.

*xxxxxxxxxxx.
*TABLE 3. 
*xxxxxxxxxxx.
CROSSTABS home by smph / cells count total/ STATISTICS.
 

*xxxxxxxxxxx.
*TABLE 4. 
*xxxxxxxxxxx.
fre var d1 d2 d3 d4 . 
recode D1 (1=0) (2=1) into male.
*note.: *multim incluces those who did not know if they are a multimedia as "no".

LOGISTIC REGRESSION VARIABLES home
  /METHOD=ENTER    multim   D6  D7 D5 
  /CONTRAST (gruppeTR)=Indicator(1)
  /CONTRAST (D6)=Indicator(1)
  /CONTRAST (D7)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5) .

LOGISTIC REGRESSION VARIABLES home
  /METHOD=ENTER    multim   D6  D7 D5 D2  male D4 
  /CONTRAST (gruppeTR)=Indicator(1)
  /CONTRAST (D6)=Indicator(1)
  /CONTRAST (D7)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5) .

LOGISTIC REGRESSION VARIABLES smph
  /METHOD=ENTER    multim   D6  D7 D5 
  /CONTRAST (gruppeTR)=Indicator(1)
  /CONTRAST (D6)=Indicator(1)
  /CONTRAST (D7)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5) .
 
LOGISTIC REGRESSION VARIABLES smph
  /METHOD=ENTER    multim  D6  D7 D5  D2 male D4
  /CONTRAST (gruppeTR)=Indicator(1)
  /CONTRAST (D6)=Indicator(1)
  /CONTRAST (D7)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5) .


*-----------------------------------------------------.
*4.2. Nonresponses as context-sensitive respnose behaviour of wegb survey respondents.
*-----------------------------------------------------.
*xxxxxxxxxxx.
*TABLE 5. 
*xxxxxxxxxxx.

fre var mobility. 
sort cases by breakoff. 
split file by breakoff. 
fre var mobility. 
split file off. 

*Testing: sign. of differences in the distribution.
CROSSTABS mobility by breakoff / cells count row/ STATISTICS.


*xxxxxxxxxxx.
*TABLE 6. 
*xxxxxxxxxxx.
CROSSTABS mobility by breakoff / cells count row/ STATISTICS.

LOGISTIC REGRESSION VARIABLES breakoff
  /METHOD=ENTER   home smph  home*smph  gruppeTR   
  /CONTRAST (gruppeTR)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5)
 /SAVE PRED  .


*ooooooooooo.
*Figure A2. 
*ooooooooooo. 
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=home MEAN(pre_1)[name="MEAN_pre_1"] smph 
    MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: home=col(source(s), name("home"), unit.category())
  DATA: MEAN_pre_1=col(source(s), name("MEAN_pre_1"))
  DATA: smph=col(source(s), name("smph"), unit.category())
  GUIDE: axis(dim(1), label("Home"))
  GUIDE: axis(dim(2), label("Mean Predicted probability"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Smph"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: line(position(home*MEAN_pre_1), color.interior(smph), missing.wings())
END GPL.

*xxxxxxxxxxx.
*TABLE 7. 
*xxxxxxxxxxx.
fre var PD5.
recode PD5 (1 thru 12=1) (13 thru high=0) into abbs12.
fre var abbs12. 

*total.
temp.
select if breakoff =1.
fre var abbs12.

temp.
select if breakoff =1.
des var pd5.

*per mobility-group.
SORT CASES by mobility.
SPLIT FILE by mobility.
temp.
select if breakoff =1.
fre var abbs12.

temp.
select if breakoff =1.
des var PD5 .
SPLIT FILE off. 

*compute trigger groups seperatly.
fre var gruppeTR.
recode gruppeTR (0=1) (1,2,3=0) into v0tr.
recode gruppeTR (1=1) (0,2,3=0) into v6tr.
recode gruppeTR (2=1) (0,1,3=0) into v99tr.
recode gruppeTR (3=1) (0,1,2=0) into v99u6tr.

*testing significant influences.
temp.
select if breakoff =1.
UNIANOVA pd5 BY  home smph  v6tr v99tr v99u6tr 
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN= home smph v6tr v99tr v99u6tr smph*home.

*xxxxxxxxxxx.
*TABLE 8. 
*xxxxxxxxxxx.

des var PD4  .

SORT CASES by mobility.
SPLIT FILE by mobility.
des var PD4  .
split file off.

UNIANOVA PD4  BY  home smph  v6tr v99tr v99u6tr 
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN= home smph v6tr v99tr v99u6tr smph*home.

*xx-include-xx->missing<50 items.
recode PD4 (0 thru 61=1) (62 thru high =0) into a50p.
fre var a50p.

fre var a50p.
filter by a50p.
des var pd4.
SORT CASES by mobility.
SPLIT FILE by mobility.
des var PD4  .
split file off.

UNIANOVA PD4  BY  home smph  v6tr v99tr v99u6tr 
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN= home smph v6tr v99tr v99u6tr smph*home.

filter off.


*xx-include-xx->regular participants.
fre var regular.
filter by regular.
des var pd4.
SORT CASES by mobility.
SPLIT FILE by mobility.
des var PD4  .
split file off.

UNIANOVA PD4  BY  home smph  v6tr v99tr v99u6tr 
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=OPOWER ETASQ HOMOGENEITY DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN= home smph v6tr v99tr v99u6tr smph*home.

filter off.
  
*-----------------------------------------------------.
*4.3. Consequences of context-sensitive response behaviour
*-----------------------------------------------------.
*ooooooooooo.
*Figure 3. 
*ooooooooooo. 
fre var D6  D7  D5 D3 mm .

temp.
select if breakoff =0.
fre var D6  D7  D5 mm .

*ooooooooooo.
*Figure 4. 
*ooooooooooo. 
*note: the figure was computed using excel.

fre var D6.
recode d6 (1=1) (2,3=0) into re1.
recode d6 (2=1) (1,3=0) into sowie1.
recode d6 (3=1) (1,2=0) into tnf1.

EXAMINE VARIABLES=   re1 sowie1 tnf1
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.


*Note: filter_fp cleanes the sample based on comon practices (non-response rate and duration).
filter by filter_fp.
EXAMINE VARIABLES=   re1 sowie1 tnf1
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*Note: wwwfpres weights the sample based on the proportion in the basic population.
weight by wwwfpRES.
EXAMINE VARIABLES=   re1 sowie1 tnf1
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*deactivate filter and weights.
filter off.
weight off. 

*ooooooooooo.
*Figure 5. 
*ooooooooooo. 

SORT CASES by mobility.
SPLIT FILE by mobility.

*n.
des var sowie1 re1 tnf1.
*n-regular.
temp. 
select if regular =1.
des var sowie1 re1 tnf1

EXAMINE VARIABLES=    sowie1 re1 tnf1
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

filter by filter_fp.
EXAMINE VARIABLES=   sowie1 re1  tnf1
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.
 
weight by wwwfpRES.
EXAMINE VARIABLES=   re1 sowie1 tnf1
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*xx-include-xx-> all participants.
SPLIT FILE off. 
filter off.
weight off. 

*xxxxxxxxxxx.
*TABLE 9. 
*xxxxxxxxxxx.
fre var CR1.
compute IAsmhs =smph*home.

*xx-include-xx->all participants.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT CR1 
  /METHOD=ENTER v6tr v99tr v99u6tr sowie1 tnf1 D5  smph home .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT CR1 
  /METHOD=ENTER v6tr v99tr v99u6tr  sowie1 tnf1 D5 smph home IAsmhs.

*xx-include-xx->regulär participants. 
filter by regular.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT CR1 
  /METHOD=ENTER v6tr v99tr v99u6tr sowie1 tnf1 D5 smph home .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT CR1 
  /METHOD=ENTER v6tr v99tr v99u6tr  sowie1 tnf1 D5 smph home IAsmhs.

*xx-include-xx->dorpouts. 
filter by breakoff.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT CR1 
  /METHOD=ENTER v6tr v99tr v99u6tr sowie1 tnf1  D5  smph home .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT CR1 
  /METHOD=ENTER v6tr v99tr v99u6tr  sowie1 tnf1 D5  smph home IAsmhs.

*xx-include-xx-> -samble cleaned and weight.
filter by filter_fp.
weight by wmob.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT CR1 
  /METHOD=ENTER v6tr v99tr v99u6tr sowie1 tnf1  D5  smph home .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT CR1 
  /METHOD=ENTER v6tr v99tr v99u6tr  sowie1 tnf1 D5 smph home IAsmhs.

*xx-include-xx-> all participants / unweihted.
weight off. 
filter off. 

*------------------------------------------------------------------------------------------------------------------.
*Conclusion.
*------------------------------------------------------------------------------------------------------------------.
fre var TP GS NS  RR_GS PD2 regular dogrr.
 
