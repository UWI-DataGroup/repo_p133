** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			    ncdrisc_obesity_001.do
    //  project:				    Food Sovereignty and Obesity in SIDS
    //  analysts:				    Ian HAMBLETON
    // 	date last modified	        04-JUN-2019
    //  algorithm task			    Preparing the Obesity datasets from NCD-RisC Collaboration

    ** General algorithm set-up
    version 15
    clear all
    macro drop _all
    set more 1
    set linesize 80

    ** Set working directories: this is for DATASET and LOGFILE import and export
    ** DATASETS to encrypted SharePoint folder
    local datapath "X:/The University of the West Indies/DataGroup - repo_data/data_p133"
    ** LOGFILES to unencrypted OneDrive folder (.gitignore set to IGNORE log files on PUSH to GitHub)
    local logpath X:/OneDrive - The University of the West Indies/repo_datagroup/repo_p133

    ** Close any open log file and open a new log file
    capture log close
    log using "`logpath'\ncdrisc_obesity_001", replace
** HEADER -----------------------------------------------------

** THERE are three files downloaded from the NCD-RisC Collaboration
** Age-standardised adult obesity - global
** Age-standardised adult obesity - regional 
** Age-standardised adult obesity - country-level

** ------------------------------------------------------------
** FILE 1 - GLOBAL OBESITY
** Used for general comparisons
** ------------------------------------------------------------
insheet using "`datapath'/version01/1-input/NCD_RisC_Lancet_2017_BMI_age_standardised_world.txt", names comma

** Preparing the variables (mainly to create shorter variable names)

** Country ID 
rename countryregionworld cid
label var cid "Country, Region, World ID"

** Country ISO Codes
** ISO codes are 3-digit alphanumeric codes unique to a country - there are no codes for world or region 
label var iso "ISO-3166 country codes"

** Body Mass Index Sex
rename sex temp1
gen sex = 1 if temp1=="Women"
replace sex =2 if temp1 == "Men"
label define sex_ 1 "women" 2 "men", modify 
label values sex sex_
label var sex "Sex for the estimated BMI"
drop temp1 
order sex, after(iso)

** Body Mass Index Year
label var year "Year for the estimated BMI (1975-2016)"

** Mean BMI (with 95% CI)
rename meanbmi bmim
rename meanbmilower95uncertaintyinterva bmim_lo
rename meanbmiupper95uncertaintyinterva bmim_hi
label var bmim "Mean BMI (kg/m-squared)"
label var bmim_lo "Mean BMI, lower 95% UI"
label var bmim_hi "Mean BMI, upper 95% UI"

** Prevalence of Obesity (>= 30 kg/m-sq)
rename prevalenceofbmi30kgmobesity bmi30
rename prevalenceofbmi30kgmlower95uncer bmi30_lo
rename prevalenceofbmi30kgmupper95uncer bmi30_hi 
label var bmi30 "Prevalence >=30 (%)"
label var bmi30_lo "Prevalence >=30, lower 95% UI"
label var bmi30_hi "Prevalence >=30, upper 95% UI"

** Prevalence of Severe Obesity (>= 35 kg/m-sq)
rename prevalenceofbmi35kgmsevereobesit bmi35
rename prevalenceofbmi35kgmlower95uncer bmi35_lo
rename prevalenceofbmi35kgmupper95uncer bmi35_hi
label var bmi35 "Prevalence >=35 (%)"
label var bmi35_lo "Prevalence >=35, lower 95% UI"
label var bmi35_hi "Prevalence >=35, upper 95% UI"

** Prevalence of Underweight (< 18.5 kg/m-sq)
rename prevalenceofbmi185kgmunderweight bmi185 
rename prevalenceofbmi185kgmlower95unce bmi185_lo
rename prevalenceofbmi185kgmupper95unce bmi185_hi 
label var bmi185 "Prevalence <18.5 (%)"
label var bmi185_lo "Prevalence <18.5, lower 95% UI"
label var bmi185_hi "Prevalence <18.5, upper 95% UI"


** Prevalence of Underweight (18.5 to <20 kg/m-sq)
rename prevalenceofbmi185kgmto20kgm bmi185_20
rename prevalenceofbmi185kgmto20kgmlowe bmi185_20_lo
rename prevalenceofbmi185kgmto20kgmuppe bmi185_20_hi
label var bmi185_20 "Prevalence 18.5 to <20 (%)"
label var bmi185_20_lo "Prevalence 18.5 to <20, lower 95% UI"
label var bmi185_20_hi "Prevalence 18.5 to <20, upper 95% UI"


** Prevalence of Normal Weight (20 to <25 kg/m-sq)
rename prevalenceofbmi20kgmto25kgm bmi20_25
rename prevalenceofbmi20kgmto25kgmlower bmi20_25_lo
rename prevalenceofbmi20kgmto25kgmupper bmi20_25_hi
label var bmi20_25 "Prevalence 20 to <25 (%)"
label var bmi20_25_lo "Prevalence 20 to <25, lower 95% UI"
label var bmi20_25_hi "Prevalence 20 to <25, upper 95% UI"


** Prevalence of Overweight (25 to <30 kg/m-sq)
rename prevalenceofbmi25kgmto30kgm bmi25_30
rename prevalenceofbmi25kgmto30kgmlower bmi25_30_lo 
rename prevalenceofbmi25kgmto30kgmupper bmi25_30_hi 
label var bmi25_30 "Prevalence 25 to <30 (%)"
label var bmi25_30_lo "Prevalence 25 to <30, lower 95% UI"
label var bmi25_30_hi "Prevalence 25 to <30, upper 95% UI"


** Prevalence of Obesity (30 to <35 kg/m-sq)
rename prevalenceofbmi30kgmto35kgm bmi30_35
rename prevalenceofbmi30kgmto35kgmlower bmi30_35_lo
rename prevalenceofbmi30kgmto35kgmupper bmi30_35_hi
label var bmi30_35 "Prevalence 30 to <35 (%)"
label var bmi30_35_lo "Prevalence 30 to <35, lower 95% UI"
label var bmi30_35_hi "Prevalence 30 to <35, upper 95% UI"

** Prevalence of Morbid Obesity (35 to <40 kg/m-sq)
rename prevalenceofbmi35kgmto40kgm bmi35_40
rename prevalenceofbmi35kgmto40kgmlower bmi35_40_lo
rename prevalenceofbmi35kgmto40kgmupper  bmi35_40_hi
label var bmi35_40 "Prevalence 35 to <40 (%)"
label var bmi35_40_lo "Prevalence 35 to <40, lower 95% UI"
label var bmi35_40_hi "Prevalence 35 to <40, upper 95% UI"

** Prevalence of Morbid Obesity (>= 40 kg/m-sq)
rename prevalenceofbmi40kgmmorbidobesit bmi40
rename prevalenceofbmi40kgmlower95uncer bmi40_lo
rename prevalenceofbmi40kgmupper95uncer bmi40_hi
label var bmi40 "Prevalence >=40 (%)"
label var bmi40_lo "Prevalence >=40, lower 95% UI"
label var bmi40_hi "Prevalence >=40, upper 95% UI"

** Save the GLOBAL dataset
tempfile world 
save "`datapath'/version01/2-working/bmi_world", replace



** ------------------------------------------------------------
** FILE 2 - REGIONAL OBESITY
** Used for general comparisons
** Caribbean and South Pacific not separated from Latin America / Oceania in this file, 
** so we must build the Caribbean region ourselves from the country-level file
** ------------------------------------------------------------
insheet using "`datapath'/version01/1-input/NCD_RisC_Lancet_2017_BMI_age_standardised_region.txt", clear names comma

** Preparing the variables (mainly to create shorter variable names)

** Country ID 
rename countryregionworld cid
label var cid "Country, Region, World ID"

** Country ISO Codes
** ISO codes are 3-digit alphanumeric codes unique to a country - there are no codes for world or region 
label var iso "ISO-3166 country codes"

** Body Mass Index Sex
rename sex temp1
gen sex = 1 if temp1=="Women"
replace sex =2 if temp1 == "Men"
label values sex sex_
label var sex "Sex for the estimated BMI"
drop temp1 
order sex, after(iso)

** Body Mass Index Year
label var year "Year for the estimated BMI (1975-2016)"

** Mean BMI (with 95% CI)
rename meanbmi bmim
rename meanbmilower95uncertaintyinterva bmim_lo
rename meanbmiupper95uncertaintyinterva bmim_hi
label var bmim "Mean BMI (kg/m-squared)"
label var bmim_lo "Mean BMI, lower 95% UI"
label var bmim_hi "Mean BMI, upper 95% UI"

** Prevalence of Obesity (>= 30 kg/m-sq)
rename prevalenceofbmi30kgmobesity bmi30
rename prevalenceofbmi30kgmlower95uncer bmi30_lo
rename prevalenceofbmi30kgmupper95uncer bmi30_hi 
label var bmi30 "Prevalence >=30 (%)"
label var bmi30_lo "Prevalence >=30, lower 95% UI"
label var bmi30_hi "Prevalence >=30, upper 95% UI"

** Prevalence of Severe Obesity (>= 35 kg/m-sq)
rename prevalenceofbmi35kgmsevereobesit bmi35
rename prevalenceofbmi35kgmlower95uncer bmi35_lo
rename prevalenceofbmi35kgmupper95uncer bmi35_hi
label var bmi35 "Prevalence >=35 (%)"
label var bmi35_lo "Prevalence >=35, lower 95% UI"
label var bmi35_hi "Prevalence >=35, upper 95% UI"

** Prevalence of Underweight (< 18.5 kg/m-sq)
rename prevalenceofbmi185kgmunderweight bmi185 
rename prevalenceofbmi185kgmlower95unce bmi185_lo
rename prevalenceofbmi185kgmupper95unce bmi185_hi 
label var bmi185 "Prevalence <18.5 (%)"
label var bmi185_lo "Prevalence <18.5, lower 95% UI"
label var bmi185_hi "Prevalence <18.5, upper 95% UI"


** Prevalence of Underweight (18.5 to <20 kg/m-sq)
rename prevalenceofbmi185kgmto20kgm bmi185_20
rename prevalenceofbmi185kgmto20kgmlowe bmi185_20_lo
rename prevalenceofbmi185kgmto20kgmuppe bmi185_20_hi
label var bmi185_20 "Prevalence 18.5 to <20 (%)"
label var bmi185_20_lo "Prevalence 18.5 to <20, lower 95% UI"
label var bmi185_20_hi "Prevalence 18.5 to <20, upper 95% UI"


** Prevalence of Normal Weight (20 to <25 kg/m-sq)
rename prevalenceofbmi20kgmto25kgm bmi20_25
rename prevalenceofbmi20kgmto25kgmlower bmi20_25_lo
rename prevalenceofbmi20kgmto25kgmupper bmi20_25_hi
label var bmi20_25 "Prevalence 20 to <25 (%)"
label var bmi20_25_lo "Prevalence 20 to <25, lower 95% UI"
label var bmi20_25_hi "Prevalence 20 to <25, upper 95% UI"


** Prevalence of Overweight (25 to <30 kg/m-sq)
rename prevalenceofbmi25kgmto30kgm bmi25_30
rename prevalenceofbmi25kgmto30kgmlower bmi25_30_lo 
rename prevalenceofbmi25kgmto30kgmupper bmi25_30_hi 
label var bmi25_30 "Prevalence 25 to <30 (%)"
label var bmi25_30_lo "Prevalence 25 to <30, lower 95% UI"
label var bmi25_30_hi "Prevalence 25 to <30, upper 95% UI"


** Prevalence of Obesity (30 to <35 kg/m-sq)
rename prevalenceofbmi30kgmto35kgm bmi30_35
rename prevalenceofbmi30kgmto35kgmlower bmi30_35_lo
rename prevalenceofbmi30kgmto35kgmupper bmi30_35_hi
label var bmi30_35 "Prevalence 30 to <35 (%)"
label var bmi30_35_lo "Prevalence 30 to <35, lower 95% UI"
label var bmi30_35_hi "Prevalence 30 to <35, upper 95% UI"

** Prevalence of Morbid Obesity (35 to <40 kg/m-sq)
rename prevalenceofbmi35kgmto40kgm bmi35_40
rename prevalenceofbmi35kgmto40kgmlower bmi35_40_lo
rename prevalenceofbmi35kgmto40kgmupper  bmi35_40_hi
label var bmi35_40 "Prevalence 35 to <40 (%)"
label var bmi35_40_lo "Prevalence 35 to <40, lower 95% UI"
label var bmi35_40_hi "Prevalence 35 to <40, upper 95% UI"

** Prevalence of Morbid Obesity (>= 40 kg/m-sq)
rename prevalenceofbmi40kgmmorbidobesit bmi40
rename prevalenceofbmi40kgmlower95uncer bmi40_lo
rename prevalenceofbmi40kgmupper95uncer bmi40_hi
label var bmi40 "Prevalence >=40 (%)"
label var bmi40_lo "Prevalence >=40, lower 95% UI"
label var bmi40_hi "Prevalence >=40, upper 95% UI"

** Save the REGIONAL dataset
tempfile region 
save "`datapath'/version01/2-working/bmi_region", replace





** ------------------------------------------------------------
** FILE 3 - COUNTRY OBESITY
** Caribbean and South Pacific not separated from Latin America / Oceania in this file, 
** so we must build the Caribbean region ourselves from this country-level file
** ------------------------------------------------------------
insheet using "`datapath'/version01/1-input/NCD_RisC_Lancet_2017_BMI_age_standardised_country.txt", clear names comma

** Preparing the variables (mainly to create shorter variable names)

** Country ID 
rename countryregionworld cid
label var cid "Country, Region, World ID"

** Country ISO Codes
** ISO codes are 3-digit alphanumeric codes unique to a country - there are no codes for world or region 
label var iso "ISO-3166 country codes"

** Body Mass Index Sex
rename sex temp1
gen sex = 1 if temp1=="Women"
replace sex =2 if temp1 == "Men"
label values sex sex_
label var sex "Sex for the estimated BMI"
drop temp1 
order sex, after(iso)

** Body Mass Index Year
label var year "Year for the estimated BMI (1975-2016)"

** Mean BMI (with 95% CI)
rename meanbmi bmim
rename meanbmilower95uncertaintyinterva bmim_lo
rename meanbmiupper95uncertaintyinterva bmim_hi
label var bmim "Mean BMI (kg/m-squared)"
label var bmim_lo "Mean BMI, lower 95% UI"
label var bmim_hi "Mean BMI, upper 95% UI"

** Prevalence of Obesity (>= 30 kg/m-sq)
rename prevalenceofbmi30kgmobesity bmi30
rename prevalenceofbmi30kgmlower95uncer bmi30_lo
rename prevalenceofbmi30kgmupper95uncer bmi30_hi 
label var bmi30 "Prevalence >=30 (%)"
label var bmi30_lo "Prevalence >=30, lower 95% UI"
label var bmi30_hi "Prevalence >=30, upper 95% UI"

** Prevalence of Severe Obesity (>= 35 kg/m-sq)
rename prevalenceofbmi35kgmsevereobesit bmi35
rename prevalenceofbmi35kgmlower95uncer bmi35_lo
rename prevalenceofbmi35kgmupper95uncer bmi35_hi
label var bmi35 "Prevalence >=35 (%)"
label var bmi35_lo "Prevalence >=35, lower 95% UI"
label var bmi35_hi "Prevalence >=35, upper 95% UI"

** Prevalence of Underweight (< 18.5 kg/m-sq)
rename prevalenceofbmi185kgmunderweight bmi185 
rename prevalenceofbmi185kgmlower95unce bmi185_lo
rename prevalenceofbmi185kgmupper95unce bmi185_hi 
label var bmi185 "Prevalence <18.5 (%)"
label var bmi185_lo "Prevalence <18.5, lower 95% UI"
label var bmi185_hi "Prevalence <18.5, upper 95% UI"


** Prevalence of Underweight (18.5 to <20 kg/m-sq)
rename prevalenceofbmi185kgmto20kgm bmi185_20
rename prevalenceofbmi185kgmto20kgmlowe bmi185_20_lo
rename prevalenceofbmi185kgmto20kgmuppe bmi185_20_hi
label var bmi185_20 "Prevalence 18.5 to <20 (%)"
label var bmi185_20_lo "Prevalence 18.5 to <20, lower 95% UI"
label var bmi185_20_hi "Prevalence 18.5 to <20, upper 95% UI"


** Prevalence of Normal Weight (20 to <25 kg/m-sq)
rename prevalenceofbmi20kgmto25kgm bmi20_25
rename prevalenceofbmi20kgmto25kgmlower bmi20_25_lo
rename prevalenceofbmi20kgmto25kgmupper bmi20_25_hi
label var bmi20_25 "Prevalence 20 to <25 (%)"
label var bmi20_25_lo "Prevalence 20 to <25, lower 95% UI"
label var bmi20_25_hi "Prevalence 20 to <25, upper 95% UI"


** Prevalence of Overweight (25 to <30 kg/m-sq)
rename prevalenceofbmi25kgmto30kgm bmi25_30
rename prevalenceofbmi25kgmto30kgmlower bmi25_30_lo 
rename prevalenceofbmi25kgmto30kgmupper bmi25_30_hi 
label var bmi25_30 "Prevalence 25 to <30 (%)"
label var bmi25_30_lo "Prevalence 25 to <30, lower 95% UI"
label var bmi25_30_hi "Prevalence 25 to <30, upper 95% UI"


** Prevalence of Obesity (30 to <35 kg/m-sq)
rename prevalenceofbmi30kgmto35kgm bmi30_35
rename prevalenceofbmi30kgmto35kgmlower bmi30_35_lo
rename prevalenceofbmi30kgmto35kgmupper bmi30_35_hi
label var bmi30_35 "Prevalence 30 to <35 (%)"
label var bmi30_35_lo "Prevalence 30 to <35, lower 95% UI"
label var bmi30_35_hi "Prevalence 30 to <35, upper 95% UI"

** Prevalence of Morbid Obesity (35 to <40 kg/m-sq)
rename prevalenceofbmi35kgmto40kgm bmi35_40
rename prevalenceofbmi35kgmto40kgmlower bmi35_40_lo
rename prevalenceofbmi35kgmto40kgmupper  bmi35_40_hi
label var bmi35_40 "Prevalence 35 to <40 (%)"
label var bmi35_40_lo "Prevalence 35 to <40, lower 95% UI"
label var bmi35_40_hi "Prevalence 35 to <40, upper 95% UI"

** Prevalence of Morbid Obesity (>= 40 kg/m-sq)
rename prevalenceofbmi40kgmmorbidobesit bmi40
rename prevalenceofbmi40kgmlower95uncer bmi40_lo
rename prevalenceofbmi40kgmupper95uncer bmi40_hi
label var bmi40 "Prevalence >=40 (%)"
label var bmi40_lo "Prevalence >=40, lower 95% UI"
label var bmi40_hi "Prevalence >=40, upper 95% UI"

** Caribbean SIDS
** 16 FULL SIDS 
** 2 NON-UN MEMBERS / ASSOCIATE MEMBER SIDS (Bermuda and Puerto Rico)
** 5206	Caribbean	---	Anguilla (UK, BOT)
** 5206	Caribbean	ATG	Antigua and Barbuda
** 5206	Caribbean	---	Aruba (Netherlands, constituent country)
** 5206	Caribbean	BHS	Bahamas
** 5206	Caribbean	BRB	Barbados
** 5206 Caribbean   BLZ Belize
** 5206 Caribbean   BMU Bermuda (UK, BOT) (Associate member SID)
** 5206	Caribbean	---	British Virgin Islands (UK, BOT)
** 5206	Caribbean	---	Cayman Islands (UK, BOT)
** 5206	Caribbean	CUB	Cuba
** 5206	Caribbean	---	Curacao (Netherlands, constituent country)
** 5206	Caribbean	DMA	Dominica
** 5206	Caribbean	DOM	Dominican Republic
** 5206	Caribbean	GRD	Grenada
** 5206	Caribbean	---	Guadeloupe (France, overseas region)
** 5206 Caribbean   GUY Guyana
** 5206	Caribbean	HTI	Haiti
** 5206	Caribbean	JAM	Jamaica
** 5206	Caribbean	---	Martinique (France, overseas region)
** 5206	Caribbean	---	Montserrat (UK, BOT)
** 5206	Caribbean	---	Netherlands Antilles (Netherlands, former, dissolved 2010)
** 5206	Caribbean	PRI	Puerto Rico (US, commonwealth) (Associate member SID)
** 5206	Caribbean	KNA	Saint Kitts and Nevis
** 5206	Caribbean	LCA	Saint Lucia
** 5206	Caribbean	VCT	Saint Vincent and the Grenadines
** 5206	Caribbean	---	Saint-Martin (France, overseas collectivity)
** 5206	Caribbean	---	Sint Maarten (Netherlands, constituent country)
** 5206 Caribbean   SUR Suriname
** 5206	Caribbean	TTO	Trinidad and Tobago
** 5206	Caribbean	---	Turks and Caicos Islands (UK, BOT)
** 5206	Caribbean	---	United States Virgin Islands (US, unincorporated and organised territory)
gen rid = .
#delimit ;
    replace rid = 1 if  iso=="ATG" | iso=="BHS" |
                        iso=="BRB" | iso=="BLZ" |
                        iso=="BMU" | iso=="CUB" |
                        iso=="DMA" | iso=="DOM" |
                        iso=="GRD" | iso=="GUY" |
                        iso=="HTI" | iso=="JAM" |
                        iso=="PRI" | iso=="KNA" |
                        iso=="LCA" | iso=="VCT" |
                        iso=="SUR" | iso=="TTO" ;
#delimit cr
order rid, after(cid)


** MELANESIA (5502)
** 5502	Melanesia	FJI	Fiji
** 5502	Melanesia	---	New Caledonia (France, special collectivity)
** 5502	Melanesia	PNG	Papua New Guinea
** 5502	Melanesia	SLB	Solomon Islands
** 5502	Melanesia	VUT	Vanuatu
#delimit ;
    replace rid = 2 if  iso=="FJI"  | iso=="PNG"|
                        iso=="SLB"  | iso=="VUT";
#delimit cr

** MICRONESIA (5503)
** 5503	Micronesia	---	Guam (US, unincorporated organized territory)
** 5503	Micronesia	KIR	Kiribati
** 5503	Micronesia	MHL	Marshall Islands (US, COFA)
** 5503	Micronesia	FSM	Micronesia (Federated States of) (US, COFA)
** 5503	Micronesia	NRU	Nauru
** 5503	Micronesia	---	Northern Mariana Islands (US, commonwealth)
** 5503	Micronesia	---	Pacific Islands Trust Territory (Historical Territory)
** 5503	Micronesia	PLW	Palau (US, COFA)
#delimit ;
    replace rid = 3 if  iso=="KIR"  | iso=="MHL" |
                        iso=="FSM" | iso=="NRU"|
                        iso=="PLW" ;
#delimit cr

** POLYNESIA (5504)
** 5504	Polynesia	ASM	American Samoa (US, unincorporated territory)	
** 5504	Polynesia	COK	Cook Islands (Free association with NZ)
** 5504	Polynesia	PYF	French Polynesia (France, overseas collectivity / overseas country)
** 5504	Polynesia	NIU	Niue	
** 5504	Polynesia	---	Pitcairn Islands (UK, BOT)
** 5504	Polynesia	WSM	Samoa
** 5504	Polynesia	TKL	Tokelau
** 5504	Polynesia	TON	Tonga
** 5504	Polynesia	TUV Tuvalu
** 5504	Polynesia	---	Wake Island (US, unincorporated unorganized territory)
** 5504	Polynesia	---	Wallis and Futuna Islands (France, collectivity)
#delimit ;
    replace rid = 4 if  iso=="ASM" | iso=="COK" |
                        iso=="PYF" | iso=="NIU" |
                        iso=="WSM" | iso=="TKL" |
                        iso=="TON" | iso=="TUV";
#delimit cr

** Atlantic, Indian Ocean, Mediterranean, South China Seas (AIMS)
** AIMS     BHR     Bahrain
** AIMS     CPV     Cabo Verde
** AIMS     COM     Comoros
** AIMS     GNB     Guinea Bissau
** AIMS     MDV     Maldives
** AIMS     MUS     Mauritius
** AIMS     STP     Sao Tome and Principe
** AIMS     SYC     Seychelles
** AIMS     SGP     Singapore 
#delimit ;
    replace rid = 5 if  iso=="BHR" | iso=="CPV" |
                        iso=="COM" | iso=="GNB" |
                        iso=="MDV" | iso=="MUS" |
                        iso=="STP" | iso=="SYC" |
                        iso=="SGP";
#delimit cr

label var rid "Region ID"
order rid, after(cid)
label define rid_ 1 "caribbean" 2 "melanesia" 3 "micronesia" 4 "polynesia" 5 "aims"
label values rid rid_

** Save the COUNTRY dataset
tempfile country
save "`datapath'/version01/2-working/bmi_country", replace
