// AppVeL - Christoph Thewes (thewes@b-tu.de)

// Publication data for Thewes, C. (2024). Asking Volunteers: Pitfalls and Solutions 
// for Surveying Voluntary Organisations in Germany. Survey Methods: Insights from 
// the Field. Retrieved from https://surveyinsights.org/?p=18408

graph set window fontface "segoe ui"
set scheme cblind1  

set more off
clear all
version 18

 
// READ REGISTER-DATA
*use "..\..\01-sample\data\register.dta"					// based on date from Open Knowledge Foundation: CC by OpenCorporates (https://offeneregister.de)

*gen pc_reg = 1
*collapse (percent) pc_reg=pc_reg (count) n_reg=pc_reg, by(state)

*save pc_reg, replace


use "appvel_v2_0_public", clear								// based on https://doi.org/10.7802/2577

// ----------
//  FIGURE 1
// ----------

gen pc_svy = 1

collapse (percent) pc_svy if !rel [pw=dweight], by(state)

merge 1:1 state using pc_reg, nogen keepus(pc_reg)

gen brutto = .												// based on sample frame; Not publicly available for data protection reasons
replace brutto = 18.83 if state == "Baden-Württemberg"
replace brutto = 15.26 if state == "Bayern"
replace brutto = 4.67 if state == "Berlin"
replace brutto = 2.53 if state == "Brandenburg"
replace brutto = 0.56 if state == "Bremen"
replace brutto = 1.93 if state == "Hamburg"
replace brutto = 6.87 if state == "Hessen"
replace brutto = 0.70 if state == "Mecklenburg Vorpommern"
replace brutto = 8.59 if state == "Niedersachsen"
replace brutto = 19.48 if state == "Nordrhein-Westfalen"
replace brutto = 5.88 if state == "Rheinland-Pfalz"
replace brutto = 1.80 if state == "Saarland"
replace brutto = 4.27 if state == "Sachsen"
replace brutto = 2.19 if state == "Sachsen-Anhalt"
replace brutto = 3.75 if state == "Schleswig-Holstein"
replace brutto = 2.03 if state == "Thüringen"

gen ziviz = .												// based on https://www.ziviz.de/sites/ziv/files/ziviz-survey_2023_methodenbericht.pdf p.20
replace ziviz = 1428 if state == "Baden-Württemberg"
replace ziviz = 1546 if state == "Bayern"
replace ziviz = 366 if state == "Berlin"
replace ziviz = 523 if state == "Brandenburg"
replace ziviz = 340 if state == "Bremen"
replace ziviz = 488 if state == "Hamburg"
replace ziviz = 1424 if state == "Hessen"
replace ziviz = 455 if state == "Mecklenburg Vorpommern"
replace ziviz = 1342 if state == "Niedersachsen"
replace ziviz = 1204 if state == "Nordrhein-Westfalen"
replace ziviz = 935 if state == "Rheinland-Pfalz"
replace ziviz = 478 if state == "Saarland"
replace ziviz = 668 if state == "Sachsen"
replace ziviz = 417 if state == "Sachsen-Anhalt"
replace ziviz = 654 if state == "Schleswig-Holstein"
replace ziviz = 524 if state == "Thüringen"
replace ziviz = ziviz/12792*100

replace state = "Baden-Württemberg" if state == "Baden-Württemberg"
replace state = "Bavaria" if state == "Bayern"
replace state = "Berlin" if state == "Berlin"
replace state = "Brandenburg" if state == "Brandenburg"
replace state = "Bremen" if state == "Bremen"
replace state = "Hamburg" if state == "Hamburg"
replace state = "Hesse" if state == "Hessen"
replace state = "Mecklenburg-West Pomerania" if state == "Mecklenburg Vorpommern"
replace state = "Lower Saxony" if state == "Niedersachsen"
replace state = "North Rhine-Westphalia" if state == "Nordrhein-Westfalen"
replace state = "Rhineland-Palatinate" if state == "Rheinland-Pfalz"
replace state = "Saarland" if state == "Saarland"
replace state = "Saxony" if state == "Sachsen"
replace state = "Saxony-Anhalt" if state == "Sachsen-Anhalt"
replace state = "Schleswig-Holstein" if state == "Schleswig-Holstein"
replace state = "Thuringia" if state == "Thüringen"


gen diff = abs(pc_svy - pc_reg)
gen diff2 = abs(brutto - pc_svy)

graph dot pc_reg brutto pc_svy, marker(1,msymbol(|) mc(black) msize(*1.5)) marker(3, mc("0 150 0")) over(state, sort(pc_reg))  ///
	title("") ytitle("in per cent") ///
	legend(order(1 "Register data" 2 "AppVeL Gross sample" 3 "AppVeL Net sample")  row(1))
graph export "stout/state_register.pdf", replace
graph export "stout/state_register.png", replace width(1600)



// ----------
//  FIGURE 2
// ----------

use "../../02-survey-results/output/appvel_v2_0_public", clear
gen pc_svy = 1

replace v1 = 4 if v1 == 3
replace v1 = 14 if v1 == 15
replace pweight = pweight*dweight

collapse (percent) pc_svy [pw=pweight], by(v1)

gen ziviz_v1 = .
replace ziviz_v1 = 22 if v1 == 1
replace ziviz_v1 = 17 if v1 == 2
replace ziviz_v1 = 19 if v1 == 4
replace ziviz_v1 = 9 if v1 == 5
replace ziviz_v1 = 6 if v1 == 6
replace ziviz_v1 = 5 if v1 == 9
replace ziviz_v1 = 4 if v1 == 10
replace ziviz_v1 = 4 if v1 == 7
replace ziviz_v1 = 3 if v1 == 8
replace ziviz_v1 = 2 if v1 == 13
replace ziviz_v1 = 2 if v1 == 11
replace ziviz_v1 = 2 if v1 == 12
replace ziviz_v1 = 4 if v1 == 15
drop if ziviz_v1 == .

lab def v1 ///
	1 "Sport" ///
	2 "Education" ///
	3 "Music" ///
	4 "Culture/Music" ///
	5 "Conviviality" ///
	6 "Social service" ///
	7 "Religious groups" ///
	8 "Healthcare" ///
	9 "Environmental protection" ///
	10 "Civil Protection" ///
	11 "International solidarity" ///
	12 "Consumer interests" ///
	13 "Science" ///
	14 "Regional Development" ///
	15 "Other" ///
	16 "Politics (gen.)", replace 


graph dot pc_svy ziviz_v1, marker(1, mc("0 150 0")) over(v1, sort(pc_svy) des)  ///
	title("") ytitle("in per cent") ///
	legend(order(1 "AppVeL 2022 (N = 2,771)" 2 "ZiviZ 2023 (N = 12,702)")  row(1))
graph export "stout/v1_ziviz.pdf", replace
graph export "stout/v1_ziviz.png", replace width(1600)




// ---------
//  TABLE 2
// ---------

replace kontakt = 1 if kontakt == 2

gen v15a_d = inrange(v15a,4,5) if !mi(v15a)	// (1 = mehrmals die Woche)

sum intern extern komp
sum komp
replace komp = komp-r(min)
sum komp
replace komp = komp/r(max)*10

tab kontakt
drop if sample == 2

foreach var of varlist intern extern komp v5 v8 v15a_d {
	reg `var' i.kontakt [pw=pweigh],
	margins i.kontakt
}


exit
