* ============================================================================ *
* PROJECT:		ICCP
* OBJECTIVE: 	recodes dataset to harmonize with other countries
/* Linking Austrian ICCP Data to other countries' ICCP datasets at the individual level 
DK-answer on issue credibility sets respondents on this particular issue as missing
*/
* ============================================================================ *

*open AUSSDA ICCP file 


clear all

use "10079_da_en_v1_0.dta"


*only variables from pre wave
drop post*


*rename pre_citizenship
rename pre_id respid_num
rename pre_sex gender
rename pre_yearborn yearborn
rename pre_geosub geosub
rename pre_townsize townsize
rename pre_polint polint
rename pre_ecoretro ecoretro
rename pre_ecoprosp ecoprosp
rename pre_ptv_SPO ptv_at_spo
rename pre_ptv_KURZ ptv_at_kurz
rename pre_ptv_FPO ptv_at_fpo
rename pre_ptv_GRUNE ptv_at_grune
rename pre_ptv_NEOS ptv_at_neos
rename pre_ptv_PILZ ptv_at_pilz

rename pre_self_pos_issue_2 pos_at_p2
rename pre_SPO_pos_issue_2 cred_at_p2_spo
rename pre_newOVP_pos_issue_2 cred_at_p2_kurz
rename pre_FPO_pos_issue_2 cred_at_p2_fpo
rename pre_GRUNE_pos_issue_2 cred_at_p2_grune
rename pre_NEOS_pos_issue_2 cred_at_p2_neos
rename pre_PILZ_pos_issue_2 cred_at_p2_pilz
rename pre_98_pos_issue_2 cred_at_p2_noparty
rename pre_priority_pos_issue_2 priority_at_p2

rename pre_self_pos_issue_3 pos_at_p3
rename pre_SPO_pos_issue_3 cred_at_p3_spo
rename pre_newOVP_pos_issue_3 cred_at_p3_kurz
rename pre_FPO_pos_issue_3 cred_at_p3_fpo
rename pre_GRUNE_pos_issue_3 cred_at_p3_grune
rename pre_NEOS_pos_issue_3 cred_at_p3_neos
rename pre_PILZ_pos_issue_3 cred_at_p3_pilz
rename pre_98_pos_issue_3 cred_at_p3_noparty
rename pre_priority_pos_issue_3 priority_at_p3

rename pre_self_pos_issue_4 pos_at_p4
rename pre_SPO_pos_issue_4 cred_at_p4_spo
rename pre_newOVP_pos_issue_4 cred_at_p4_kurz
rename pre_FPO_pos_issue_4 cred_at_p4_fpo
rename pre_GRUNE_pos_issue_4 cred_at_p4_grune
rename pre_NEOS_pos_issue_4 cred_at_p4_neos
rename pre_PILZ_pos_issue_4 cred_at_p4_pilz
rename pre_98_pos_issue_4 cred_at_p4_noparty
rename pre_priority_pos_issue_4 priority_at_p4

rename pre_self_pos_issue_6 pos_at_p6
rename pre_SPO_pos_issue_6 cred_at_p6_spo
rename pre_newOVP_pos_issue_6 cred_at_p6_kurz
rename pre_FPO_pos_issue_6 cred_at_p6_fpo
rename pre_GRUNE_pos_issue_6 cred_at_p6_grune
rename pre_NEOS_pos_issue_6 cred_at_p6_neos
rename pre_PILZ_pos_issue_6 cred_at_p6_pilz
rename pre_98_pos_issue_6 cred_at_p6_noparty
rename pre_priority_pos_issue_6 priority_at_p6

rename pre_self_pos_issue_13 pos_at_p13
rename pre_SPO_pos_issue_13 cred_at_p13_spo
rename pre_newOVP_pos_issue_13 cred_at_p13_kurz
rename pre_FPO_pos_issue_13 cred_at_p13_fpo
rename pre_GRUNE_pos_issue_13 cred_at_p13_grune
rename pre_NEOS_pos_issue_13 cred_at_p13_neos
rename pre_PILZ_pos_issue_13 cred_at_p13_pilz
rename pre_98_pos_issue_13 cred_at_p13_noparty
rename pre_priority_pos_issue_13 priority_at_p13

rename pre_self_pos_issue_20 pos_at_p20
rename pre_SPO_pos_issue_20 cred_at_p20_spo
rename pre_newOVP_pos_issue_20 cred_at_p20_kurz
rename pre_FPO_pos_issue_20 cred_at_p20_fpo
rename pre_GRUNE_pos_issue_20 cred_at_p20_grune
rename pre_NEOS_pos_issue_20 cred_at_p20_neos
rename pre_PILZ_pos_issue_20 cred_at_p20_pilz
rename pre_98_pos_issue_20 cred_at_p20_noparty
rename pre_priority_pos_issue_20 priority_at_p20

rename pre_self_pos_issue_21 pos_at_p21
rename pre_SPO_pos_issue_21 cred_at_p21_spo
rename pre_newOVP_pos_issue_21 cred_at_p21_kurz
rename pre_FPO_pos_issue_21 cred_at_p21_fpo
rename pre_GRUNE_pos_issue_21 cred_at_p21_grune
rename pre_NEOS_pos_issue_21 cred_at_p21_neos
rename pre_PILZ_pos_issue_21 cred_at_p21_pilz
rename pre_98_pos_issue_21 cred_at_p21_noparty
rename pre_priority_pos_issue_21 priority_at_p21

rename pre_self_pos_issue_11 pos_at_p11
rename pre_SPO_pos_issue_11 cred_at_p11_spo
rename pre_newOVP_pos_issue_11 cred_at_p11_kurz
rename pre_FPO_pos_issue_11 cred_at_p11_fpo
rename pre_GRUNE_pos_issue_11 cred_at_p11_grune
rename pre_NEOS_pos_issue_11 cred_at_p11_neos
rename pre_PILZ_pos_issue_11 cred_at_p11_pilz
rename pre_98_pos_issue_11 cred_at_p11_noparty
rename pre_priority_pos_issue_11 priority_at_p11

rename pre_self_pos_issue_12 pos_at_p12
rename pre_SPO_pos_issue_12 cred_at_p12_spo
rename pre_newOVP_pos_issue_12 cred_at_p12_kurz
rename pre_FPO_pos_issue_12 cred_at_p12_fpo
rename pre_GRUNE_pos_issue_12 cred_at_p12_grune
rename pre_NEOS_pos_issue_12 cred_at_p12_neos
rename pre_PILZ_pos_issue_12 cred_at_p12_pilz
rename pre_98_pos_issue_12 cred_at_p12_noparty
rename pre_priority_pos_issue_12 priority_at_p12

rename pre_self_pos_issue_14 pos_at_p14
rename pre_SPO_pos_issue_14 cred_at_p14_spo
rename pre_newOVP_pos_issue_14 cred_at_p14_kurz    
rename pre_FPO_pos_issue_14 cred_at_p14_fpo
rename pre_GRUNE_pos_issue_14 cred_at_p14_grune
rename pre_NEOS_pos_issue_14 cred_at_p14_neos
rename pre_PILZ_pos_issue_14 cred_at_p14_pilz
rename pre_98_pos_issue_14 cred_at_p14_noparty
rename pre_priority_pos_issue_14 priority_at_p14

rename pre_self_pos_issue_10 pos_at_p10
rename pre_SPO_pos_issue_10 cred_at_p10_spo
rename pre_newOVP_pos_issue_10 cred_at_p10_kurz
rename pre_FPO_pos_issue_10 cred_at_p10_fpo
rename pre_GRUNE_pos_issue_10 cred_at_p10_grune
rename pre_NEOS_pos_issue_10 cred_at_p10_neos
rename pre_PILZ_pos_issue_10 cred_at_p10_pilz
rename pre_98_pos_issue_10 cred_at_p10_noparty
rename pre_priority_pos_issue_10 priority_at_p10

rename pre_self_pos_issue_15 pos_at_p15
rename pre_SPO_pos_issue_15 cred_at_p15_spo
rename pre_newOVP_pos_issue_15 cred_at_p15_kurz
rename pre_FPO_pos_issue_15 cred_at_p15_fpo
rename pre_GRUNE_pos_issue_15 cred_at_p15_grune
rename pre_NEOS_pos_issue_15 cred_at_p15_neos
rename pre_PILZ_pos_issue_15 cred_at_p15_pilz
rename pre_98_pos_issue_15 cred_at_p15_noparty
rename pre_priority_pos_issue_15 priority_at_p15

rename pre_self_pos_issue_18 pos_at_p18
rename pre_SPO_pos_issue_18 cred_at_p18_spo
rename pre_newOVP_pos_issue_18 cred_at_p18_kurz
rename pre_FPO_pos_issue_18 cred_at_p18_fpo
rename pre_GRUNE_pos_issue_18 cred_at_p18_grune
rename pre_NEOS_pos_issue_18 cred_at_p18_neos
rename pre_PILZ_pos_issue_18 cred_at_p18_pilz
rename pre_98_pos_issue_18 cred_at_p18_noparty
rename pre_priority_pos_issue_18 priority_at_p18

rename pre_self_pos_issue_1 pos_at_p1
rename pre_SPO_pos_issue_1 cred_at_p1_spo
rename pre_newOVP_pos_issue_1 cred_at_p1_kurz
rename pre_FPO_pos_issue_1 cred_at_p1_fpo
rename pre_GRUNE_pos_issue_1 cred_at_p1_grune
rename pre_NEOS_pos_issue_1 cred_at_p1_neos
rename pre_PILZ_pos_issue_1 cred_at_p1_pilz
rename pre_98_pos_issue_1 cred_at_p1_noparty
rename pre_priority_pos_issue_1 priority_at_p1

rename pre_self_pos_issue_7 pos_at_p7
rename pre_SPO_pos_issue_7 cred_at_p7_spo
rename pre_newOVP_pos_issue_7 cred_at_p7_kurz
rename pre_FPO_pos_issue_7 cred_at_p7_fpo
rename pre_GRUNE_pos_issue_7 cred_at_p7_grune
rename pre_NEOS_pos_issue_7 cred_at_p7_neos
rename pre_PILZ_pos_issue_7 cred_at_p7_pilz
rename pre_98_pos_issue_7 cred_at_p7_noparty
rename pre_priority_pos_issue_7 priority_at_p7

rename pre_self_pos_issue_8 pos_at_p8
rename pre_SPO_pos_issue_8 cred_at_p8_spo
rename pre_newOVP_pos_issue_8 cred_at_p8_kurz
rename pre_FPO_pos_issue_8 cred_at_p8_fpo
rename pre_GRUNE_pos_issue_8 cred_at_p8_grune
rename pre_NEOS_pos_issue_8 cred_at_p8_neos
rename pre_PILZ_pos_issue_8 cred_at_p8_pilz
rename pre_98_pos_issue_8 cred_at_p8_noparty
rename pre_priority_pos_issue_8 priority_at_p8

rename pre_self_pos_issue_16 pos_at_p16
rename pre_SPO_pos_issue_16 cred_at_p16_spo
rename pre_newOVP_pos_issue_16 cred_at_p16_kurz
rename pre_FPO_pos_issue_16 cred_at_p16_fpo
rename pre_GRUNE_pos_issue_16 cred_at_p16_grune
rename pre_NEOS_pos_issue_16 cred_at_p16_neos
rename pre_PILZ_pos_issue_16 cred_at_p16_pilz
rename pre_98_pos_issue_16 cred_at_p16_noparty
rename pre_priority_pos_issue_16 priority_at_p16

rename pre_self_pos_issue_17 pos_at_p17
rename pre_SPO_pos_issue_17 cred_at_p17_spo
rename pre_newOVP_pos_issue_17 cred_at_p17_kurz
rename pre_FPO_pos_issue_17 cred_at_p17_fpo
rename pre_GRUNE_pos_issue_17 cred_at_p17_grune
rename pre_NEOS_pos_issue_17 cred_at_p17_neos
rename pre_PILZ_pos_issue_17 cred_at_p17_pilz
rename pre_98_pos_issue_17 cred_at_p17_noparty
rename pre_priority_pos_issue_17 priority_at_p17

rename pre_self_pos_issue_5 pos_at_p5
rename pre_SPO_pos_issue_5 cred_at_p5_spo
rename pre_newOVP_pos_issue_5 cred_at_p5_kurz
rename pre_FPO_pos_issue_5 cred_at_p5_fpo
rename pre_GRUNE_pos_issue_5 cred_at_p5_grune
rename pre_NEOS_pos_issue_5 cred_at_p5_neos
rename pre_PILZ_pos_issue_5 cred_at_p5_pilz
rename pre_98_pos_issue_5 cred_at_p5_noparty
rename pre_priority_pos_issue_5 priority_at_p5

rename pre_self_pos_issue_9 pos_at_p9
rename pre_SPO_pos_issue_9 cred_at_p9_spo 
rename pre_newOVP_pos_issue_9 cred_at_p9_kurz
rename pre_FPO_pos_issue_9 cred_at_p9_fpo
rename pre_GRUNE_pos_issue_9 cred_at_p9_grune
rename pre_NEOS_pos_issue_9 cred_at_p9_neos
rename pre_PILZ_pos_issue_9 cred_at_p9_pilz
rename pre_98_pos_issue_9 cred_at_p9_noparty
rename pre_priority_pos_issue_9 priority_at_p9

rename pre_self_pos_issue_19 pos_at_p19
rename pre_SPO_pos_issue_19 cred_at_p19_spo
rename pre_newOVP_pos_issue_19 cred_at_p19_kurz
rename pre_FPO_pos_issue_19 cred_at_p19_fpo
rename pre_GRUNE_pos_issue_19 cred_at_p19_grune
rename pre_NEOS_pos_issue_19 cred_at_p19_neos
rename pre_PILZ_pos_issue_19 cred_at_p19_pilz
rename pre_98_pos_issue_19 cred_at_p19_noparty
rename pre_priority_pos_issue_19 priority_at_p19
 
rename pre_SPO_val_issue_1 cred_at_v1_spo
rename pre_newOVP_val_issue_1 cred_at_v1_kurz
rename pre_FPO_val_issue_1 cred_at_v1_fpo
rename pre_GRUNE_val_issue_1 cred_at_v1_grune
rename pre_NEOS_val_issue_1 cred_at_v1_neos
rename pre_PILZ_val_issue_1 cred_at_v1_pilz
rename pre_98_val_issue_1 cred_at_v1_noparty
rename pre_priority_val_issue_1 priority_at_v1

rename pre_SPO_val_issue_2 cred_at_v2_spo
rename pre_newOVP_val_issue_2 cred_at_v2_kurz
rename pre_FPO_val_issue_2 cred_at_v2_fpo
rename pre_GRUNE_val_issue_2 cred_at_v2_grune
rename pre_NEOS_val_issue_2 cred_at_v2_neos
rename pre_PILZ_val_issue_2 cred_at_v2_pilz
rename pre_98_val_issue_2 cred_at_v2_noparty
rename pre_priority_val_issue_2 priority_at_v2

rename pre_SPO_val_issue_3 cred_at_v3_spo
rename pre_newOVP_val_issue_3 cred_at_v3_kurz
rename pre_FPO_val_issue_3 cred_at_v3_fpo
rename pre_GRUNE_val_issue_3 cred_at_v3_grune
rename pre_NEOS_val_issue_3 cred_at_v3_neos
rename pre_PILZ_val_issue_3 cred_at_v3_pilz
rename pre_98_val_issue_3 cred_at_v3_noparty
rename pre_priority_val_issue_3 priority_at_v3

rename pre_SPO_val_issue_4 cred_at_v4_spo
rename pre_newOVP_val_issue_4 cred_at_v4_kurz
rename pre_FPO_val_issue_4 cred_at_v4_fpo
rename pre_GRUNE_val_issue_4 cred_at_v4_grune
rename pre_NEOS_val_issue_4 cred_at_v4_neos
rename pre_PILZ_val_issue_4 cred_at_v4_pilz
rename pre_98_val_issue_4 cred_at_v4_noparty
rename pre_priority_val_issue_4 priority_at_v4

rename pre_SPO_val_issue_5 cred_at_v5_spo
rename pre_newOVP_val_issue_5  cred_at_v5_kurz
rename pre_FPO_val_issue_5 cred_at_v5_fpo
rename pre_GRUNE_val_issue_5 cred_at_v5_grune
rename pre_NEOS_val_issue_5 cred_at_v5_neos
rename pre_PILZ_val_issue_5 cred_at_v5_pilz
rename pre_98_val_issue_5 cred_at_v5_noparty
rename pre_priority_val_issue_5 priority_at_v5

rename pre_SPO_val_issue_6 cred_at_v6_spo
rename pre_newOVP_val_issue_6 cred_at_v6_kurz
rename pre_FPO_val_issue_6 cred_at_v6_fpo
rename pre_GRUNE_val_issue_6 cred_at_v6_grune
rename pre_NEOS_val_issue_6 cred_at_v6_neos
rename pre_PILZ_val_issue_6 cred_at_v6_pilz
rename pre_98_val_issue_6 cred_at_v6_noparty
rename pre_priority_val_issue_6 priority_at_v6

rename pre_SPO_val_issue_7 cred_at_v7_spo
rename pre_newOVP_val_issue_7 cred_at_v7_kurz
rename pre_FPO_val_issue_7 cred_at_v7_fpo
rename pre_GRUNE_val_issue_7 cred_at_v7_grune
rename pre_NEOS_val_issue_7 cred_at_v7_neos
rename pre_PILZ_val_issue_7 cred_at_v7_pilz
rename pre_98_val_issue_7 cred_at_v7_noparty
rename pre_priority_val_issue_7 priority_at_v7

rename pre_SPO_val_issue_8 cred_at_v8_spo
rename pre_newOVP_val_issue_8 cred_at_v8_kurz
rename pre_FPO_val_issue_8 cred_at_v8_fpo
rename pre_GRUNE_val_issue_8 cred_at_v8_grune
rename pre_NEOS_val_issue_8 cred_at_v8_neos
rename pre_PILZ_val_issue_8 cred_at_v8_pilz
rename pre_98_val_issue_8 cred_at_v8_noparty
rename pre_priority_val_issue_8 priority_at_v8

rename pre_SPO_val_issue_9 cred_at_v9_spo
rename pre_newOVP_val_issue_9 cred_at_v9_kurz
rename pre_FPO_val_issue_9 cred_at_v9_fpo
rename pre_GRUNE_val_issue_9 cred_at_v9_grune
rename pre_NEOS_val_issue_9 cred_at_v9_neos
rename pre_PILZ_val_issue_9 cred_at_v9_pilz
rename pre_98_val_issue_9 cred_at_v9_noparty
rename pre_priority_val_issue_9 priority_at_v9

rename pre_SPO_val_issue_10 cred_at_v10_spo
rename pre_newOVP_val_issue_10 cred_at_v10_kurz 
rename pre_FPO_val_issue_10 cred_at_v10_fpo
rename pre_GRUNE_val_issue_10 cred_at_v10_grune
rename pre_NEOS_val_issue_10 cred_at_v10_neos
rename pre_PILZ_val_issue_10 cred_at_v10_pilz
rename pre_98_val_issue_10 cred_at_v10_noparty
rename pre_priority_val_issue_10 priority_at_v10

rename pre_leaderSPO_comp lead_at_spo_knowl
rename pre_leaderSPO_stron lead_at_spo_stron
rename pre_leaderSPO_hones lead_at_spo_hones
rename pre_leaderSPO_cares lead_at_spo_cares
rename pre_leaderKURZ_comp lead_at_kurz_knowl
rename pre_leaderKURZ_stron lead_at_kurz_stron
rename pre_leaderKURZ_hones lead_at_kurz_hones
rename pre_leaderKURZ_cares lead_at_kurz_cares
rename pre_leaderFPO_comp lead_at_fpo_knowl
rename pre_leaderFPO_stron lead_at_fpo_stron
rename pre_leaderFPO_hones lead_at_fpo_hones
rename pre_leaderFPO_cares lead_at_fpo_cares
rename pre_leaderGRUNE_comp lead_at_grune_knowl
rename pre_leaderGRUNE_stron lead_at_grune_stron
rename pre_leaderGRUNE_hones lead_at_grune_hones
rename pre_leaderGRUNE_cares lead_at_grune_cares
rename pre_leaderNEOS_comp lead_at_neos_knowl
rename pre_leaderNEOS_stron lead_at_neos_stron
rename pre_leaderNEOS_hones lead_at_neos_hones
rename pre_leaderNEOS_cares lead_at_neos_cares
rename pre_leaderPILZ_comp lead_at_pilz_knowl
rename pre_leaderPILZ_stron lead_at_pilz_stron
rename pre_leaderPILZ_hones  lead_at_pilz_hones
rename pre_leaderPILZ_cares lead_at_pilz_cares


rename pre_voteint voteint
rename pre_ISCED edu3 
rename pre_church church
rename pre_govsat govsat
rename pre_lrself_0 lrself_10
rename pre_pidstre pidstre
rename pre_profcond profcond
rename pre_pidpartI pidhas
rename pre_profsect profsect
rename pre_clasself clasself
rename pre_livstand_1 livstand
rename prewave_weight wdempol

* drop open string variables
drop pre_edu_other
drop pre_voteintII_other
drop pre_votepast_other
drop pre_voteint_other
drop pre_pidpartII_other



**************************************
*** recoded variables ****************

*goal variable
forval x = 1/21 {
	recode pos_at_p`x' (4/6=0) (1/3=1), gen(goal_at_p`x')
	}

* pid dummy (GER has them e.g.)
recode pre_pidpartII (20/88=.)
rename pre_pidpartII pidpart
tab pidpart, gen(pidpart)
rename pidpart1 pid_at_spo
rename pidpart2 pid_at_kurz
rename pidpart3 pid_at_fpo
rename pidpart4 pid_at_grune
rename pidpart5 pid_at_neos
rename pidpart6 pid_at_pilz

* voteint_party
gen voteint_party = voteint
recode voteint_party (9/99=.)
lab define voteint_party_lab 1 "at_kurz" 2 "at_spo" 3 "at_fpo" 4 "at_grune" 5 "at_neos" 6 "at_pilz"
lab val voteint_party voteint_party_lab

*LR self
egen lrself_6 = cut(lrself_10), at(0 3 5 6 8 11)


*govsat
rename govsat govsat_at
recode govsat_at (1 2=1)(3 4=2), gen(govsat)

*church
rename church church_at
recode church_at (1 2=1)(3=2)(4=3)(5=4)(6=5)(7=6), gen (church)

*townsize
rename townsize townsize_at
recode townsize_at (2 3=2)(4=3)(5=4), gen(townsize)

*profsect
rename profsect profsect_at
recode profsect_at (2 3=2)(4=3)(5=4)(6=5), gen(profsect)






***************************************
*** order variables *******************

* numerical order
order ptv* pid* cred_at_v* priority_at_v* pos* goal* cred_at_p* ///
		priority_at_p*, seq

*order of other datasets
order respid_num token yearborn gender church edu3 geosub ///
		townsize profcond profsect clasself livstand polint voteint ///
		ecoretro ecoprosp ptv* pid* cred_at_v* priority_at_v* pos* goal* cred_at_p* ///
		priority_at_p* lead* lrself_10 lrself_6 govsat wdempol voteint_party

***************************************
*** drop counry specific variables ****		
		
* drop variables that only apear in the Austrian questionnaire
drop pre_monthborn pre_SD2 pre_livtstand2 pre_agegroup ///
		pre_ptvast_1 pre_votepast pre_voteintII pre_startdate pre_citizenship ///
		pre_edu pre_region pidpart panel_weight	

*** drop obsv that are missing the ID
drop if respid_num==.
	
	
	
***************************************************************
***************************************************************

  
label language multi, rename
label language en, new copy

tab profcond
label val profcond profcond_en
label define profcond_en 1"Working (part-time, full-time, etc" 2"Retired" 3"In school" 4"In University" 5"Other training" 6"Leave (Parental/Education/etc." 7"working in the household" 8"in military service" 9"unable to work" 10"unemployed" 11"other"
tab profcond

recode clasself (.=88)
label define clasself 88 "DK/Refuse to be classified", modify
tab clasself

recode voteint (.=88)
label define vfix 88 "I will not vote/Blank ballot/Null", modify
tab voteint, m

tab pidhas
label val pidhas pidhas_en
label define pidhas_en 1"No" 2"Yes"
tab pidhas

foreach party in spo kurz fpo grune neos pilz { 

label var cred_at_p1_`party' "*`party'* credible to *Keep current asylum rules* or *make them more restrictive*"
label var cred_at_p2_`party' "*`party'* credible to *Keep current pension age* or *increase it*"
label var cred_at_p3_`party' "*`party'* credible to *Reduce income differences* or *not"
label var cred_at_p4_`party' "*`party'* credible to *Raise taxes and spend more on health and social services* or *Cut taxes and spend less on health and social services*"
label var cred_at_p5_`party' "*`party'* credible to *Politics should implement gender quota* or *not*"
label var cred_at_p6_`party' "*`party'* credible to *Increase the minimum wage* or *not*"
label var cred_at_p7_`party' "*`party'* credible to *Restrict access to welfare benefits for immigrants* or *not*"
label var cred_at_p8_`party' "*`party'* credible to *Foreigners should fully adapt to Austrian culture* or *not*"
label var cred_at_p9_`party' "*`party'* credible to *Allow gay marriages* or *not*"
label var cred_at_p10_`party' "*`party'* credible to *Promoting sustainable energy* or *not"
label var cred_at_p11_`party' "*`party'* credible to *Extend surveillance measures* or *not*"
label var cred_at_p12_`party' "*`party'* credible to *Austria should have a property tax on inheritance* or *not*"
label var cred_at_p13_`party' "*`party'* credible to *Deregulate the job market* or *not*"
label var cred_at_p14_`party' "*`party'* credible to *Introduce stronger direct democracy measures* or *not*"
label var cred_at_p15_`party' "*`party'* credible to *Diesel cars should be banned* or *not*"
label var cred_at_p16_`party' "*`party'* credible to *The EU has to enforce refugee quotas* or *each country should decide by its own*"
label var cred_at_p17_`party' "*`party'* credible to *End* or *allow freedom of movement from the EU*"
label var cred_at_p18_`party' "*`party'* credible to *Stay in the EU* or *leave it*"
label var cred_at_p19_`party' "*`party'* credible to *Introduce a comprehensive school for all children until 14* or *not*"
label var cred_at_p20_`party' "*`party'* credible to *Abolish the obligatory membership in trade associations* or *not*"
label var cred_at_p21_`party' "*`party'* credible to *Decrease unemployment at the expense of high national debt* or *not*"

/*label var cred_at_p1_`party' "cred_`party' Make asylum rules more restrictive or Keep current asylum rules"
label var cred_at_p2_`party' "cred_`party' Keep current pension age or Increase pension age"
label var cred_at_p3_`party'"cred_`party' Reduce income differences or Don't reduce income differences"
label var cred_at_p4_`party'"cred_`party' Raise taxes and spend more on health and social services or Cut taxes and spend less on health and social services"
label var cred_at_p5_`party'"cred_`party' Politics should implement gender quotas or Politics should not enforce gender quotas"
label var cred_at_p6_`party'"cred_`party' Increase the minimum wage above 1500 euros or Do not increase the minimum wage above 1500 euros"
label var cred_at_p7_`party'"cred_`party' Restrict access to welfare benefits for immigrants or Mantain current levels of access to welfare benefits for immigrants"
label var cred_at_p8_`party'"cred_`party' Require foreigners in Austria to fully adapt to Austrian culture or Allow foreigners in Austria to preserve their own culture"
label var cred_at_p9_`party'"cred_`party' Allow gay marriages or Do not allow gay marriages"
label var cred_at_p10_`party'"cred_`party' Promoting the production of sustainable energy or Maintaining the current mix of sustainable and fossil energy"
label var cred_at_p11_`party'"cred_`party' Surveillance measures should be extended or Surveillance measures should not be extended"
label var cred_at_p12_`party'"cred_`party' Austria should have a property tax on inheritance or Austria should not have a property tax on inheritance"
label var cred_at_p13_`party'"cred_`party' Deregulate the job market or Keep current regulations in the job market"
label var cred_at_p14_`party'"cred_`party' Introduce stronger direct democracy measures or Keep current level of direct democracy measures"
label var cred_at_p15_`party'"cred_`party' Diesel cars should be banned  or No cars should be banned"
label var cred_at_p16_`party'"cred_`party' The EU has to enforce refugee quotas in all member states  or Each member state of the EU should decide by its own on refugee quotas"
label var cred_at_p17_`party'"cred_`party' End freedom of movement of people from the EU into Austria or Allow freedom of movement of people from the EU into Austria"
label var cred_at_p18_`party'"cred_`party' Stay in the EU or Leave the EU"
label var cred_at_p19_`party'"cred_`party' Austria should introduce a comprehensive school for all children until 14 or Austria should not introduce a comprehensive school for all children until 14"
label var cred_at_p20_`party'"cred_`party' Austria should abolish the obligatory membership in trade associations	or Austria should not abolish the obligatory membership in trade associations"
label var cred_at_p21_`party'"cred_`party' Decrease unemployment at the expense of high national debt or Do not decrease unemployment at the expense of high national debt"

  */
  
 label var cred_at_v1_`party' "*`party'* credible to *Providing affordable homes*"
 label var cred_at_v2_`party' "*`party'* credible to *Fighting poverty of elderly*"
 label var cred_at_v3_`party' "*`party'* credible to *Maintaining infrastructure*"
 label var cred_at_v4_`party' "*`party'* credible to *Protect from terrorism*"
 label var cred_at_v5_`party' "*`party'* credible to *Fight unemployment*"
 label var cred_at_v6_`party' "*`party'* credible to *Support the economic growth*"
 label var cred_at_v7_`party' "*`party'* credible to *Protect the environment*"
 label var cred_at_v8_`party' "*`party'* credible to *Support for families and children*"
 label var cred_at_v9_`party' "*`party'* credible to *Fighting crime*"
 label var cred_at_v10_`party' "*`party'* credible to *Providing social justice*"
 
 
} 

foreach v of numlist 1/21  { 
label var cred_at_p`v'_noparty "No party is credible"
 } 


 foreach var in pos_at_p goal_at_p /*priority_at_p*/{
 
label var `var'1 "Keep current asylum rules or make them more restrictive"
label var `var'2 "Keep current pension age or increase it"
label var `var'3 "Reduce income differences or not"
label var `var'4 "Taxes or social services"
label var `var'5 "Politics should implement gender quota or not"
label var `var'6 "Increase the minimum wage or not"
label var `var'7 "Restrict access to welfare benefits for immigrants or not"
label var `var'8 "Foreigners should fully adapt to Austrian culture or not"
label var `var'9 "Allow gay marriages or not"
label var `var'10 "Promoting sustainable energy or not"
label var `var'11 "Extend surveillance measures or not"
label var `var'12 "Austria should have a property tax on inheritance or not"
label var `var'13 "Deregulate the job market or not"
label var `var'14 "Introduce stronger direct democracy measures or not"
label var `var'15 "Diesel cars should be banned or not"
label var `var'16 "The EU has to enforce refugee quotas or each country should decide by its own"
label var `var'17 "End or allow freedom of movement from the EU"
label var `var'18 "Stay in the EU or leave it"
label var `var'19 "Introduce a comprehensive school for all children until 14 or not"
label var `var'20 "Abolish the obligatory membership in trade associations or not"
label var `var'21 "Decrease unemployment at the expense of high national debt or not"


/*label var `var'1 "Make asylum rules more restrictive or Keep current asylum rules"
label var `var'2 "Keep current pension age or Increase pension age"
label var `var'3 "Reduce income differences or Don't reduce income differences"
label var `var'4 "Raise taxes and spend more on health and social services or Cut taxes and spend less on health and social services"
label var `var'5 "Politics should implement gender quotas or Politics should not enforce gender quotas"
label var `var'6 "Increase the minimum wage above 1500 euros or Do not increase the minimum wage above 1500 euros"
label var `var'7 "Restrict access to welfare benefits for immigrants or Mantain current levels of access to welfare benefits for immigrants"
label var `var'8 "Require foreigners in Austria to fully adapt to Austrian culture or Allow foreigners in Austria to preserve their own culture"
label var `var'9 "Allow gay marriages or Do not allow gay marriages"
label var `var'10 "Promoting the production of sustainable energy or Maintaining the current mix of sustainable and fossil energy"
label var `var'11 "Surveillance measures should be extended or Surveillance measures should not be extended"
label var `var'12 "Austria should have a property tax on inheritance or Austria should not have a property tax on inheritance"
label var `var'13 "Deregulate the job market or Keep current regulations in the job market"
label var `var'14 "Introduce stronger direct democracy measures or Keep current level of direct democracy measures"
label var `var'15 "Diesel cars should be banned or No cars should be banned"
label var `var'16 "The EU has to enforce refugee quotas in all member states or Each member state of the EU should decide by its own on refugee quotas"
label var `var'17 "End freedom of movement of people from the EU into Austria or Allow freedom of movement of people from the EU into Austria"
label var `var'18 "Stay in the EU or Leave the EU"
label var `var'19 "Austria should introduce a comprehensive school for all children until 14 or Austria should not introduce a comprehensive school for all children until 14"
label var `var'20 "Austria should abolish the obligatory membership in trade associations or Austria should not abolish the obligatory membership in trade associations"
label var `var'21 "Decrease unemployment at the expense of high national debt or Do not decrease unemployment at the expense of high national debt"

1 Keep current asylum rules or make them more restrictive
2 Keep current pension age or increase it
3 Reduce income differences or not
4 Taxes or social services
5 Politics should implement gender quota or not
6 Increase the minimum wage or not
7 Restrict access to welfare benefits for immigrants or not
8 Foreigners should fully adapt to Austrian culture or not
9 Allow gay marriages or not
10 Promoting sustainable energy or not
11 Extend surveillance measures or not
12 Austria should have a property tax on inheritance or not
13 Deregulate the job market or not
14 Introduce stronger direct democracy measures or not
15 Diesel cars should be banned or not
16 The EU has to enforce refugee quotas or each country should decide by its own
17 End or allow freedom of movement from the EU
18 Stay in the EU or leave it
19 Introduce a comprehensive school for all children until 14 or not
20 Abolish the obligatory membership in trade associations or not
21 Decrease unemployment at the expense of high national debt or not
*/
} 
 
foreach var in priority_at_p {
 
label var `var'1 "R Priority: *Keep current asylum rules* or *make them more restrictive*"
label var `var'2 "R Priority: *Keep current pension age* or *increase it*"
label var `var'3 "R Priority: *Reduce income differences* or *not*"
label var `var'4 "R Priority: *Taxes* or *social services*"
label var `var'5 "R Priority: *Politics should implement gender quota* or *not*"
label var `var'6 "R Priority: *Increase the minimum wage* or *not*"
label var `var'7 "R Priority: *Restrict access to welfare benefits for immigrants* or *not*"
label var `var'8 "R Priority: *Foreigners should fully adapt to Austrian culture* or *not*"
label var `var'9 "R Priority: *Allow gay marriages* or *not*"
label var `var'10 "R Priority: *Promoting sustainable energy* or *not*"
label var `var'11 "R Priority: *Extend surveillance measures *or *not*"
label var `var'12 "R Priority: *Austria should have a property tax on inheritance* or *not*"
label var `var'13 "R Priority: *Deregulate the job market* or *not*"
label var `var'14 "R Priority: *Introduce stronger direct democracy measures* or *not*"
label var `var'15 "R Priority: *Diesel cars should be banned* or *not*"
label var `var'16 "R Priority: *The EU has to enforce refugee quotas* or *each country should decide by its own*"
label var `var'17 "R Priority: *End* or *allow freedom of movement from the EU*"
label var `var'18 "R Priority: *Stay in the EU* or *leave it*"
label var `var'19 "R Priority: *Introduce a comprehensive school for all children until 14* or *not*"
label var `var'20 "R Priority: *Abolish the obligatory membership in trade associations* or *not*"
label var `var'21 "R Priority: *Decrease unemployment at the expense of high national debt* or *not*"
} 

foreach var in priority_at_v {

label var `var'1 "R Priority: *Providing affordable homes*"
label var `var'2 "R Priority: *Fighting poverty of elderly*"
label var `var'3 "R Priority: *Maintaining infrastructure*"
label var `var'4 "R Priority: *Protect from terrorism*"
label var `var'5 "R Priority: *Fight unemployment*"
label var `var'6 "R Priority: *Support the economic growth*"
label var `var'7 "R Priority: *Protect the environment*"
label var `var'8 "R Priority: *Support for families and children*"
label var `var'9 "R Priority: *Fighting crime*"
label var `var'10 "R Priority: *Providing social justice*"

}
 
*** SECTION II: ADD VALUE LABELS FOR ISSUES***
*** Positional issues
label val pos_at_p1 pos_at_p1
label define pos_at_p1 1"[RC] Make asylum rules more restrictive" 6 "[LC] Keep current asylum rules"
tab pos_at_p1

label val pos_at_p2 pos_at_p2
label define pos_at_p2 1"[LE] Keep current pension age" 6"[RE] Increase pension age"
tab pos_at_p2

label val pos_at_p3 pos_at_p3
label define pos_at_p3 1"[LE] Reduce income differences"	6"[RE] Don't reduce income differences"
tab pos_at_p3

label val pos_at_p4 pos_at_p4
label define pos_at_p4 1"[LE] Raise taxes and spend more on health and social services"	6"[RE] Cut taxes and spend less on health and social services"
tab pos_at_p4

label val pos_at_p5 pos_at_p5
label define pos_at_p5 1"[LC] Politics should implement gender quotas"	6"[RC] Politics should not enforce gender quotas"
tab pos_at_p5

label val pos_at_p6 pos_at_p6
label define pos_at_p6 1"[LE] Increase the minimum wage above 1500 euros"	6"[RE] Do not increase the minimum wage above 1500 euros"
tab pos_at_p6

label val pos_at_p7 pos_at_p7
label define pos_at_p7 1"[RC] Restrict access to welfare benefits for immigrants"	6"[LC] Mantain current levels of access to welfare benefits for immigrants"
tab pos_at_p7

label val pos_at_p8 pos_at_p8
label define pos_at_p8 1"[RC] Require foreigners in COUNTRY to fully adapt to COUNTRY culture"	6"[LC] Allow foreigners in COUNTRY to preserve their own culture"
tab pos_at_p8

label val pos_at_p9 pos_at_p9
label define pos_at_p9 1"[LC] Allow gay marriages"	6"[RC] Do not allow gay marriages"
tab pos_at_p9

label val pos_at_p10 pos_at_p10
label define pos_at_p10 1"[LC] Promoting the production of sustainable energy"	6"[RC] Maintaining the current mix of sustainable and fossil energy"
tab pos_at_p10

label val pos_at_p11 pos_at_p11
label define pos_at_p11 1"[RC] Surveillance measures should be extended"	6"[LC] Surveillance measures should not be extended"
tab pos_at_p11

label val pos_at_p12 pos_at_p12
label define pos_at_p12 1"[LE] COUNTRY should have a property tax on inheritance"	6"[RE] COUNTRY should not have a property tax on inheritance"
tab pos_at_p12

label val pos_at_p13 pos_at_p13
label define pos_at_p13 1"[RE] Deregulate the job market"	6"[LE] Keep current regulations in the job market"
tab pos_at_p13

label val pos_at_p14 pos_at_p14
label define pos_at_p14 1"[LC] Introduce stronger direct democracy measures"	6"[RC] Keep current level of direct democracy measures"
tab pos_at_p14

label val pos_at_p15 pos_at_p15
label define pos_at_p15 1"[LC] Diesel cars should be banned" 6"[RC] No cars should be banned"
tab pos_at_p15

label val pos_at_p16 pos_at_p16
label define pos_at_p16 1"[LC] The EU has to enforce refugee quotas in all member states" 6"[RC] Each member state of the EU should decide by its own on refugee quotas"
tab pos_at_p16

label val pos_at_p17 pos_at_p17
label define pos_at_p17 1"[RC] End freedom of movement of people from the EU into COUNTRY" 6"[LC] Allow freedom of movement of people from the EU into COUNTRY"
tab pos_at_p17

label val pos_at_p18 pos_at_p18
label define pos_at_p18 1"[LC] Stay in the EU" 6"[RC] Leave the EU"
tab pos_at_p18

label val pos_at_p19 pos_at_p19
label define pos_at_p19 1"[LC] Country should introduce a comprehensive school for all children until 14"	6"[RC] Country should not introduce a comprehensive school for all children until 14"
tab pos_at_p19

label val pos_at_p20 pos_at_p20
label define pos_at_p20 1"[RE] COUNTRY should abolish the obligatory membership in trade associations"	6"[LE] COUNTRY should not abolish the obligatory membership in trade associations"
tab pos_at_p20

label val pos_at_p21 pos_at_p21
label define pos_at_p21 1"[LE] Decrease unemployment at the expense of high national debt"	6"[RE] Do not decrease unemployment at the expense of high national debt"
tab pos_at_p21


***
*** SECTION II BIS (GOALS)
***
label val goal_at_p1 goal_at_p1_en
label define goal_at_p1_en 0"[RC] Make asylum rules more restrictive" 1 "[LC] Keep current asylum rules"
tab goal_at_p1

label val goal_at_p2 goal_at_p2_en
label define goal_at_p2_en 0"[LE] Keep current pension age" 1"[RE] Increase pension age"
tab goal_at_p2

label val goal_at_p3 goal_at_p3_en
label define goal_at_p3_en 0"[LE] Reduce income differences"	1"[RE] Don't reduce income differences"
tab goal_at_p3

label val goal_at_p4 goal_at_p4_en
label define goal_at_p4_en 0"[LE] Raise taxes and spend more on health and social services"	1"[RE] Cut taxes and spend less on health and social services"
tab goal_at_p4

label val goal_at_p5 goal_at_p5_en
label define goal_at_p5_en 0"[LC] Politics should implement gender quotas"	1"[RC] Politics should not enforce gender quotas"
tab goal_at_p5

label val goal_at_p6 goal_at_p6_en
label define goal_at_p6_en 0"[LE] Increase the minimum wage above 1500 euros"	1"[RE] Do not increase the minimum wage above 1500 euros"
tab goal_at_p6

label val goal_at_p7 goal_at_p7_en
label define goal_at_p7_en 0"[RC] Restrict access to welfare benefits for immigrants"	1"[LC] Mantain current levels of access to welfare benefits for immigrants"
tab goal_at_p7

label val goal_at_p8 goal_at_p8_en
label define goal_at_p8_en 0"[RC] Require foreigners in COUNTRY to fully adapt to COUNTRY culture"	1"[LC] Allow foreigners in COUNTRY to preserve their own culture"
tab goal_at_p8

label val goal_at_p9 goal_at_p9_en
label define goal_at_p9_en 0"[LC] Allow gay marriages"	1"[RC] Do not allow gay marriages"
tab goal_at_p9

label val goal_at_p10 goal_at_p10_en
label define goal_at_p10_en 0"[LC] Promoting the production of sustainable energy"	1"[RC] Maintaining the current mix of sustainable and fossil energy"
tab goal_at_p10

label val goal_at_p11 goal_at_p11_en
label define goal_at_p11_en 0"[RC] Surveillance measures should be extended"	1"[LC] Surveillance measures should not be extended"
tab goal_at_p11

label val goal_at_p12 goal_at_p12_en
label define goal_at_p12_en 0"[LE] COUNTRY should have a property tax on inheritance"	1"[RE] COUNTRY should not have a property tax on inheritance"
tab goal_at_p12

label val goal_at_p13 goal_at_p13_en
label define goal_at_p13_en 0"[RE] Deregulate the job market"	1"[LE] Keep current regulations in the job market"
tab goal_at_p13

label val goal_at_p14 goal_at_p14_en
label define goal_at_p14_en 0"[LC] Introduce stronger direct democracy measures"	1"[RC] Keep current level of direct democracy measures"
tab goal_at_p14

label val goal_at_p15 goal_at_p15_en
label define goal_at_p15_en 0 "[LC] Diesel cars should be banned" 1"[RC] No cars should be banned"
tab goal_at_p15

label val goal_at_p16 goal_at_p16_en
label define goal_at_p16_en 0 "[LC] The EU has to enforce refugee quotas in all member states" 1"[RC] Each member state of the EU should decide by its own on refugee quotas"
tab goal_at_p16

label val goal_at_p17 goal_at_p17_en
label define goal_at_p17_en 0 "[RC] End freedom of movement of people from the EU into COUNTRY" 1"[LC] Allow freedom of movement of people from the EU into COUNTRY"
tab goal_at_p17

label val goal_at_p18 goal_at_p18_en
label define goal_at_p18_en 0 "[LC] Stay in the EU" 1"[RC] Leave the EU"
tab goal_at_p18

label val goal_at_p19 goal_at_p19_en
label define goal_at_p19_en 0"[LC] Country should introduce a comprehensive school for all children until 14"	1"[RC] Country should not introduce a comprehensive school for all children until 14"
tab goal_at_p19

label val goal_at_p20 goal_at_p20_en
label define goal_at_p20_en 0"[RE] COUNTRY should abolish the obligatory membership in trade associations"	1"[LE] COUNTRY should not abolish the obligatory membership in trade associations"
tab goal_at_p20

label val goal_at_p21 goal_at_p21_en
label define goal_at_p21_en 0"[LE] Decrease unemployment at the expense of high national debt"	1"[RE] Do not decrease unemployment at the expense of high national debt"
tab goal_at_p21 pos_at_p21

*** SECTION II TER CREDIBILITY POSITION
label language multi
foreach v of varlist cred_at_p* { 
label val `v' `v'
label define `v' 0"Nicht Gewählt" 1"Ja"
} 
tab1 cred_at_p*

label language en
foreach v of varlist cred_at_p* {
label val `v' `v'_en
label define `v'_en 0 "Not Selected" 1 "Credible" 
} 
tab1 cred_at_p*

*** SECTION III CREDIBILITY VALENCE

foreach v of numlist 1/10  { 
label var cred_at_v`v'_noparty "No party is credible"
 } 

label language multi
foreach v of varlist cred_at_v* { 
label val `v' `v'
label define `v' 0"Nicht Gewählt" 1"Ja"
} 

label language en
foreach v of varlist cred_at_v* { 
label val `v' `v'_en
label define `v'_en 0"Not selected" 1"Credible"
} 
tab1 cred_at_v*
*** SECTION IV: PRIORITIES
foreach v of varlist priority* { 
label val `v' `v'
label define `v' 1"High priority" 2"Average priority" 3"Low priority"
} 

*** SECTION V: ASSIGN LABELS TO PTV VARIABLES
foreach party in spo kurz fpo grune neos pilz { 
label var ptv_at_`party' propensity_to_vote_`party'
} 
foreach v of varlist ptv* { 
label val `v' `v'
label define `v' 0"Not at all probable" 10"Very probable"
} 

tab1 ptv*

*** SECTION VI: LEADER TRAITS
foreach v in lead_at_spo  {
foreach t in knowl stron hones cares {
label var `v'_`t' "[`t'] Christian Kern (spo)"
 } 
} 
foreach v in lead_at_kurz  {
foreach t in knowl stron hones cares {
label var `v'_`t' "[`t'] Sebastian Kurz (kurz)"
 } 
} 
 
foreach v in lead_at_fpo  {
foreach t in knowl stron hones cares {
label var `v'_`t' "[`t'] Heinz-Christian Strache (fpo)"
 } 
} 
foreach v in lead_at_grune  {
foreach t in knowl stron hones cares {
label var `v'_`t' "[`t'] Ulrike Lunacek (grune)"
 } 
} 
foreach v in lead_at_neos {
foreach t in knowl stron hones cares {
label var `v'_`t' "[`t'] Matthias Strolz (neos)"
 } 
} 
foreach v in lead_at_pilz {
foreach t in knowl stron hones cares {
label var `v'_`t' "[`t'] Peter Pilz (pilz)"
 } 
} 

*** Assign value labels 
foreach v of varlist lead_at* {
label val `v' `v'
label define `v' 1 "Yes" 2 "No" 3 "I don't know"
} 
tab1 lead*

*** SECTION VII: REMAINING VARIABLES
label var govsat "Do you approve or disapprove of the government’s record to date?"
label val govsat govsat_
label define govsat_ 1"Approve" 2"Disapprove" 88"I don't know"

label var govsat_at "COUNTRY SPECIFIC Do you approve or disapprove of the government’s record to date?"
label var lrself_10 "Left-Right scale"
label var pidhas "Party identification"
label var pidstre "Do you feel yourself to be very close to this party, fairly close or merely a sympathiser?"
label var profsect_at "COUNTRY SPECIFIC Are (were) you working in..."
label var lrself_6 "Left-Right scale (6-points)"

label var geosub "In which region do you live?"
label var townsize "Would you say you live in..."
label var townsize_at "COUNTRY SPECIFIC Would you say you live in..."
label var gender "Gender"
label var church "Church attendance"
label var church_at "COUNTRY SPECIFIC Church attendance"
label var edu3 "Education"
label var profcond "What is your current work situation?"
label var profsect "Are (were) you working in..."
label var clasself "Self-assessed social class"
label var livstand "Living standards"
label var polint "To what extent would you say you are interested in politics?"
label var voteint "Vote intention"
label var yearborn "Year of birth" 
label var ecoretro "Current economic situation"
label var ecoprosp "Economic situation in 12 months"
label var token Token
label var respid_num Respid

*** SECTION VIII: code taken from 00_setup_DA.do
*label drop govsat
label val govsat govsat
label define govsat 1"approve" 2"disapprove" 88"I don't know"

*label drop church
label val church church
label define church 1"several times a week" 2"once a week" 3"at least once a month" 4"a few times a year" 5"once a year or less" 6"never"

*label drop profsect
label val profsect profsect
label define profsect 1"agriculture" 2"industry" 3"public services" 4"private services" 5"other" 66"never worked"

*label drop townsize
label val townsize townsize
label define townsize 1"rural area or village" 2"a small or middle sized town" 3"The suburbs of a large town or city" 4"A large town or city" 

/*label drop profsect_at*/
label val profsect_at profsect_at
label define profsect_at 1"agriculture" 2"public industry" 3"private industry" 4"public services" 5"private services" 6"other" 66"never worked"

/*label drop govsat_at*/
label val govsat_at govsat_at
label define govsat_at 1"strongly approve" 2"approve" 3"disapprove" 4"strongly disapprove" 88"I don't know"

/*label drop church_at*/
label val church_at church_at
label define church_at 1"everyday" 2"several times a week" 3"once a week" 4"at least once a month" 5"a few times a year" 6"once a year or less" 7"never"

/*label drop townsize_at*/
label val townsize_at townsize_at
label define townsize_at 1"rural area" 2"small size town" 3"middle size town" 4"suburbs of a large town" 5"center of a large town"


*** SECTION IX: recode DK to missing

foreach party in spo kurz fpo grune pilz noparty neos {

foreach v of numlist 1/21  { 

replace cred_at_p`v'_`party'=. if pre_99_pos_issue_`v'==1
}

foreach v of numlist 1/10  { 

replace cred_at_v`v'_`party'=. if pre_99_val_issue_`v'==1
}

}

drop pre_99*



*** SECTION X: order variables
order respid_num token yearborn gender church_at church edu3 geosub townsize_at townsize ///
     profcond profsect_at profsect clasself livstand polint voteint  ecoretro ///
	 ecoprosp ptv* pidhas pidstre pid* cred_at_v* priority_at_v* pos_at_p* goal* ///
	 cred_at_p* priority_at_p* lead* govsat govsat_at lrself_10 lrself_6


numlabel, add force
labvalch3 * , strfcn(proper(`"@"'))

save "10079_da_en_v1_0_pre_individual", replace
