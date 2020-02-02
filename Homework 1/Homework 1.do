clear all

use ptot_r a_hga age1 using cpsmar2017.dta

// dropping "not in universe", meaning no data, not that it is 0
drop if ptot_r == 0 

// combining the two associate degrees together
replace a_hga = 41 if a_hga == 42 

// transform income
gen income = (ptot_r - 1) * 2500

hist income, width(9999) xtitle("Total Person Income (USD)") ytitle("Percent of Respondents")  ylabel(0.00001 "10" 0.00002 "20" 0.00003 "30", angle(0)) title("Total Personal Income") xlabel(0(10000)100000, angle(45)) lcolor(black) color(bluishgray) lwidth(vthin) plotregion(color(white)) graphregion(color(white)) 


hist ptot_r if ptot_r != 1 & ptot_r != 41, title("Histogram of income") ytitle("Income level") 


// graph export hist1.png

label define a_hga 31 "< Grade 1" 32 "Grade 1/2/3/4" 33 "Grade 5/6" 34 "Grade 7/8" 35 "Grade 9" 36 "Grade 10" 37 "Grade 11" 38 "Grade 12" 39 "HS Graduate" 40 "Some college" 41 "Associate" 42 "Associate" 43 "Bachelor's" 44 "Master's" 45 "Professional" 46 "Doctorate", modify

splitvallabels a_hga 

graph hbar, over(a_hga, label(labsize(small)) relabel(`r(relabel)')) ytitle("Percent of Respondents", size(small)) title("Educational Attainment") blabel(bar, format(%4.1f))  intensity(25) aspect(0.65) scale(1) plotregion(fcolor(white)) graphregion(color(white)) 

// tables of both together
tab ptot_r a_hga

// hist ptot_r, title("Histogram of income") ytitle("Income level") xtitle(none) horizontal discrete bcolor(navy) ylabel(1/41, valuelabel angle(0)) 

// hist a_hga, title("Histogram of Educational Attainment")  horizontal discrete bcolor(navy) ylabel(31/46, valuelabel angle(0)) 



// graph export hist2.png


gen incomesegment = .
replace incomesegment = 0 if ptot_r == 01 | ptot_r == 02 | ptot_r == 03 | ptot_r == 04
replace incomesegment = 1 if ptot_r == 05 | ptot_r == 06 | ptot_r == 07 | ptot_r == 08
replace incomesegment = 2 if ptot_r == 09 | ptot_r == 10 | ptot_r == 11 | ptot_r == 12
replace incomesegment = 3 if ptot_r == 13 | ptot_r == 14 | ptot_r == 15 | ptot_r == 16
replace incomesegment = 4 if ptot_r == 17 | ptot_r == 18 | ptot_r == 19 | ptot_r == 20
replace incomesegment = 5 if ptot_r == 21 | ptot_r == 22 | ptot_r == 23 | ptot_r == 24
replace incomesegment = 6 if ptot_r == 25 | ptot_r == 26 | ptot_r == 27 | ptot_r == 28
replace incomesegment = 7 if ptot_r == 29 | ptot_r == 30 | ptot_r == 31 | ptot_r == 32
replace incomesegment = 8 if ptot_r == 33 | ptot_r == 34 | ptot_r == 35 | ptot_r == 36
replace incomesegment = 9 if ptot_r == 37 | ptot_r == 38 | ptot_r == 39 | ptot_r == 40
replace incomesegment = 10 if ptot_r == 41

label define incomesegmentl 0 "$0 to $9,999" 1 "$10,000 to $19,999" 2 "$20,000 to $29,999" 3 "$30,000 to $39,999" 4 "$40,000 to $49,999" 5 "$50,000 to $59,999" 6 "$60,000 to $69,999" 7 "$70,000 to $79,999" 8 "$80,000 to $89,999" 9 "$90,000 to $99,999" 10 "$100,000 and up"
label values incomesegment incomesegmentl


tab incomesegment

tab incomesegment a_hga


regress income i.a_hga

gen age = age1
replace age = 15 if age1 == 01
replace age = 16.5 if age1 == 02
replace age = 18.5 if age1 == 03
replace age = 20.5 if age1 == 04
replace age = 23 if age1 == 05
replace age = 27 if age1 == 06
replace age = 32 if age1 == 07
replace age = 37 if age1 == 08
replace age = 42 if age1 == 09
replace age = 47 if age1 == 10
replace age = 52 if age1 == 11
replace age = 57 if age1 == 12
replace age = 60.5 if age1 == 13
replace age = 63 if age1 == 14
replace age = 67 if age1 == 15
replace age = 72 if age1 == 16
replace age = 75 if age1 == 17

tab age


regress income i.a_hga age1

regress income i.a_hga age

gen years_educated = 0
replace years_educated = 1 if a_hga == 31
replace years_educated = 2.5 if a_hga == 32
replace years_educated = 5.5 if a_hga == 33
replace years_educated = 7.5 if a_hga == 34
replace years_educated = 9 if a_hga == 35
replace years_educated = 10 if a_hga == 36
replace years_educated = 11 if a_hga == 37
replace years_educated = 12 if a_hga == 38
replace years_educated = 13 if a_hga == 39
replace years_educated = 14 if a_hga == 40
replace years_educated = 16 if a_hga == 41
replace years_educated = 16 if a_hga == 42
replace years_educated = 17 if a_hga == 43
replace years_educated = 19 if a_hga == 44
replace years_educated = 19 if a_hga == 45
replace years_educated = 20 if a_hga == 46
tab years_educated


regress income years_educated

regress income years_educated age



ttest income == 0 if a_hga == 31 | a_hga == 32

// getting 1st, 2nd, 3rd, 4th grade
ttest income if a_hga == 31| a_hga == 32, by(a_hga)

// getting 5th or 6th grade
ttest income if a_hga == 32| a_hga == 33, by(a_hga)

// getting 7th or 8th grade
ttest income if a_hga == 33| a_hga == 34, by(a_hga)

// getting 9th grade
ttest income if a_hga == 34| a_hga == 35, by(a_hga)

// getting 10th grade
ttest income if a_hga == 35| a_hga == 36, by(a_hga)

// getting 11th grade
ttest income if a_hga == 36| a_hga == 37, by(a_hga)

// getting 12th grade (not graduating)
ttest income if a_hga == 37| a_hga == 38, by(a_hga)

// getting 12th grade (graduating vs not graduating)
ttest income if a_hga == 38| a_hga == 39, by(a_hga) unequal

// getting 12th grade (graduating vs 11th grade)
ttest income if a_hga == 37| a_hga == 39, by(a_hga)

// getting 12th grade (graduating vs some college)
ttest income if a_hga == 39| a_hga == 40, by(a_hga)

// getting 12th grade (graduating hs vs graduating college)
ttest income if a_hga == 39| a_hga == 43, by(a_hga)
