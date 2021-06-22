use "C:\Users\anneg\Documents\Correlation1\Data Analysis\Obesity.dta", clear
*drop duplicate
drop snap_auth_stores_chg_12_17_y-food_banks_18_y region_y
**I rename the variables for clarity
ren state_x state
ren county_x county
ren region_x region
ren grocery_16 grocery
ren grocery_per1kpop_16 grocery_conc
ren super_16 supercenters
ren super_per1kpop_16 supercenter_conc
ren convenience_16 convenience_stores
ren convenience_per1kpop_16 convenience_conc
ren specialty_16 speciality_stores
ren specialty_per1kpop_16 speciality_conc
ren snap_available_17 snap_stores 
ren snap_available_per1kpop_17 snap_conc
ren wic_available_16 wic_stores
ren wic_available_per1kpop_16 wic_conc

*I delete the absolute numbers and use percentages instead
drop pop_low_access_15 low_income_low_access_15 no_car_low_access_15 snap_low_access_15 child_low_access_15 senior_low_access_15 white_low_access_15 black_low_access_15 hispanic_low_access_15 asian_low_access_15 nhna_low_access_15 nhpi_low_access_15 multiracial_low_access_15
*I delete percentage changes between years
drop snap_auth_stores_chg_12_17_x snap_bens_per_cap_chg_12_17_x school_lunch_prog_chg_12_17_x school_bfast_prog_chg_12_17_x smr_food_prog_12_17_x wic_parts_pop_12_17_x
* I am not sure what this variables are
*fi_rate total_fi_people child_fi_rate num_fi_children
*rename
ren percent_pop_low_access_15 percent_low_access
ren percent_low_income_low_access_15 percent_low_income_low_access
ren percent_no_car_low_access_15 percent_nocar_low_access
ren percent_snap_low_access_15 percent_snap_low_access 
ren percent_child_low_access_15 percent_child_low_access
ren percent_senior_low_access_15 percent_senior_low_access
ren percent_white_low_access_15 percent_white_low_access
ren percent_black_low_access_15 percent_black_low_access
ren percent_hispanic_low_access_15 percent_hispanic_low_access
ren percent_asian_low_access_15 percent_asian_low_access
ren percent_nhna_low_access_15 percent_nhna_low_access
ren percent_multiracial_low_access_1 percent_multiracial_low_access

*rename restraunts
ren fast_food_16 number_fast_foods
ren fast_food_1000_16 fast_food_conc
ren full_service_16 full_service_count
ren full_service_1000_16 full_service_conc
ren fast_food_exp_percap_12 fast_food_percapita
ren full_service_exp_percap_12 full_service_percapita
ren popestimate17 total_population

*food_banks_18_y farmers_markets obesity_rates snap_auth_stores_17_x school_lunch_prog_17_x

*I label variables
la var fips "County FIPS code"
la var state "State name"
la var county "County name"
la var grocery "Number of grocery stores in county"
la var grocery_conc "Grocery stores concentration in county"
la var supercenters "Number of supercenter stores in county"
la var supercenter_conc "Supercenter stores concentration in county"
la var convenience_stores "Convenience stores concentration in county"
la var convenience_conc "Convenience stores concentration in county"
la var speciality_stores "Speciality stores concentration in county"
la var speciality_conc "Speciality stores concentration in county"
la var snap_stores "SNAP stores concentration in county"
la var snap_conc "SNAP stores concentration in county"
la var wic_stores "WIC stores concentration in county"
la var wic_conc "WIC stores concentration in county"
la var percent_low_access "Grocery stores concentration in county"
la var percent_low_income_low_access "percent low income low access to stores"
la var percent_nocar_low_access "percent no car no access"
*combine snap with wic and find tha average

la var percent_snap_low_access "percent snap with low access"
la var percent_child_low_access "percent children with low access"
la var percent_senior_low_access "percent seniors low access"
la var percent_white_low_access "percent white low access"
la var percent_black_low_access "percent blacks low access"
la var percent_hispanic_low_access "percent hispanic with low access"
la var percent_asian_low_access "percent asian with low access"
la var percent_nhna_low_access "percent north pacific? with low access"
la var percent_nhpi_low_access_15 "percent indians? with low access"
la var percent_multiracial_low_access "percent multiracial with low access"
la var number_fast_foods "number of fast food restaurants"
la var fast_food_conc "fast food conc"
la var full_service_count "number of full service restaurants"
la var full_service_conc "number of full service restaurants"
la var fast_food_percapita "number of fast food rest. per capita"
la var full_service_percapita "mumber of full service per capita"
la var total_population "total population"
la var region "region"
la var snap_auth_stores_17_x ""
*combine the school feeding program, I use average
gen school_feeding=(school_lunch_prog_17_x + school_bfast_prog_17_x)/2
la var school_feeding "school feeding program"
la var food_banks_18_x "number of food banks in the county"
la var farmers_markets "number of farmers markets in the county"
la var farmers_markets_per_1000 "farmers market concentration in county"
la var pct_fm_credit "percent accepting credit"
la var pct_fm_sell_frveg "percent selling fresh fruits and vegs"
la var obesity_rates "county obesity rates"
la var est_annual_food_budget_shortfall "Annual budget shortfall"
*combine wic and snap_auth_stores_17_x
gen food_stamp_fm=fm_accepts_snap+fm_accept_wic

*remove string //I guess its the NAN variable for python that came as string
drop if food_stamp_fm=="<module 'numpy' from 'C:\\Users\"
drop if farmers_markets=="<module 'numpy' from 'C:\\Users\"
destring food_stamp_fm, replace
destring farmers_markets, replace

*i drop for obesity because it will be a misreprensatation replacing by zero
drop if strpos(obesity_rates,"<module 'numpy' from 'C:\\Users\")>0
drop if strpos(region,"<module 'numpy' from 'C:\\Users\")>0

*For the other variable, I replace with zero, to avoid running out of obsevations

//I realized it is a serious problem, i create a loop to deal with the variables
foreach x in snap_stores snap_conc wic_stores wic_conc percent_low_access percent_low_income_low_access percent_nocar_low_access percent_snap_low_access percent_child_low_access percent_senior_low_access percent_white_low_access percent_black_low_access percent_hispanic_low_access percent_asian_low_access percent_nhna_low_access percent_nhpi_low_access_15 percent_multiracial_low_access state county total_population fi_rate total_fi_people child_fi_rate num_fi_children cost_per_meal est_annual_food_budget_shortfall region farmers_markets_per_1000 pct_fm_credit pct_fm_sell_frveg percent_multiracial_low_access num_fi_children snap_auth_stores_17_x  {
    replace `x'="0" if `x'=="<module 'numpy' from 'C:\\Users\"
}

*i convert the variable to integer and float
destring snap_stores-percent_nhpi_low_access_15 obesity_rates total_population fi_rate total_fi_people child_fi_rate num_fi_children cost_per_meal est_annual_food_budget_shortfall region farmers_markets_per_1000 pct_fm_credit pct_fm_sell_frveg percent_multiracial_low_access num_fi_children snap_auth_stores_17_x, replace

la var food_stamp_fm "farmers markets accepting food stamps"
gen  pct_fm_accepting_food_stamps= (food_stamp_fm/farmers_markets)*100
replace pct_fm_accepting_food_stamps=0 if pct_fm_accepting_food_stamps==.

la var  pct_fm_accepting_food_stamps "percent farmer markets accepting food stamps"     
*drop the redundant food stamp variables    
drop fm_accepts_snap pct_fm_accepting_snap fm_accept_wic pct_fm_accept_wic fm_accept_credit fm_sell_frveg
*drop the redundant food stamp variables    
drop snap_bens_per_cap_17_x school_lunch_prog_17_x school_bfast_prog_17_x wic_parts_pop_17_x snap_auth_stores_17_y
*i combine food stamp stores, I generate the average between snap and wic
gen food_stamp_stores=(snap_stores+ wic_stores)/2
gen food_stamp_stores_conc=(snap_conc+wic_conc)/2
la var food_stamp_stores "Number of food stamp store in the county"
la var food_stamp_stores_conc "Concentration of food stamp store in the county"
*drop redudant variables
drop snap_stores snap_conc wic_stores wic_conc
*I change the order
order fips state county region obesity_rates grocery grocery_conc supercenters supercenter_conc convenience_stores convenience_conc speciality_stores speciality_conc food_stamp_stores food_stamp_stores_conc number_fast_foods fast_food_conc full_service_count full_service_conc fast_food_percapita full_service_percapita total_population food_banks_18_x farmers_markets farmers_markets_per_1000 pct_fm_credit pct_fm_sell_frveg  school_feeding food_stamp_fm pct_fm_accepting_food_stamps est_annual_food_budget_shortfall
codebook, compact
save "C:\Users\anneg\Documents\Correlation1\Data Analysis\Obesity_inter.dta", replace

*i import the domographic data
insheet using "C:\Users\anneg\Documents\Correlation1\Data\socio_economic.csv", clear
ren FIPS fips
ren pct_nhwhite10 prop_white
ren pct_nhblack10 prop_black
ren pct_hisp10 prop_hisp
ren pct_nhasian10 prop_asian
ren pct_nhna10 prop_nhna
ren pct_nhpi10 prop_nhpi
ren pct_65older10 prop_older
ren pct_18younger10 prop_younger
ren medhhinc15 median_income 
ren povrate15 poverty_rates 
ren childpovrate15 child_poverty
drop perpov10 perchldpov10 metro13 poploss10
la var prop_white "proportion of Whites in the county"
la var prop_hisp "proportion of Hispanic in the county"
la var prop_black  "proportion of African Americans in the county"
la var prop_asian "proportion of Asiana in the county"
la var prop_nhna "proportion of nhna? in the county"
la var prop_nhpi "proportion of Hawaian pacific islanders in the county"
la var prop_older "proportion of older people in the county"
la var prop_younger "proportion of younger in the county"
la var median_income "County median income"
la var poverty_rates "County poverty rates"
la var child_poverty "County child poverty"
rename state States
rename county counties
joinby fips using "C:\Users\anneg\Documents\Correlation1\Data Analysis\Obesity_inter.dta", unmatched(both) update

*i check for duplicates, 2 counties duplicated
duplicates report
/*

--------------------------------------
   copies | observations       surplus
----------+---------------------------
        1 |         3148             0
        2 |            2             1
--------------------------------------
*/
*i force drop duplicates
duplicates drop
order fips States counties state county region obesity_rates
drop _merge States counties
la var fips "FIPS code"
ren farmers_markets_per_1000 farmer_mkt_conc
save "C:\Users\anneg\Documents\Correlation1\Data Analysis\Obesity_combined.dta", replace
