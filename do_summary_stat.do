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
la var obesity_rates "conunty obesity rates"
*combine wic and snap_auth_stores_17_x
gen food_stamp_fm=fm_accepts_snap+fm_accept_wic
gen  pct_fm_accepting_food_stamps= (food_stamp_fm/farmers_markets)*100
la var  pct_fm_accepting_food_stamps "percent farmer markets accepting food stamps"         



                    
