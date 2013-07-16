### Data file

* Retrieved from http://www.cde.ca.gov/ds/sd/sd/documents/frpm1213.xls on 2013-07-11.
* File structure details available at http://www.cde.ca.gov/ds/sd/sd/fssp1213.asp
* Notes about data available at http://www.cde.ca.gov/ds/sd/sd/filessp1213.asp
* Import based on data/CSV/ousd_free_reduced_meal_2012-2013.csv
* CSV is exported from data/XLS/frpm1213.xls where 1213 is the 2012-2013 school yer

### Fields

| Column Name                 | Description |
| --------------------------- | ----------- |
| date                        | Date of reduced lunch data - usually October of the given school year |
| school_year                 | School year of the given data, eg 2012-2013 |
| provision_two_three_school  | This indicates whether a school is on a National School Lunch Program (NSLP) provision 2 or 3 status. “Y” indicates the school is on a provisional status; “N” indicates the school is not. For more information on provision status, please refer to the United States Department of Agriculture (USDA) Provision Guidance Manual |
| data_source                 | This indicates the data source for Provision 2 or 3 school data. “NSD” indicates that the data are sourced from October 2012 claim data submitted to the CDE’s Nutrition Services Division (NSD); “CARS” indicates that the data are sourced from base percentages that LEAs certified in the Consolidated Application and Reporting System (CARS) in 2011–12. |
| low_grade                   | Lowest grade offered. |
| high_grade                  | Highest grade offered. |
| enrollment_k_12             | October school enrollment (primary or short-term) of students in grades kindergarten through twelve certified in CALPADS as part of the Fall 1 submission. |
| free_meal_count_k_12        | Of the students enrolled in the school, the unduplicated count of students in grades kindergarten through twelve who are eligible to receive free meals. Students may be eligible for free meals based on applying for the National School Lunch Program (NSLP), or who are determined to meet the same income eligibility criteria as the NSLP, through their local schools, their homeless, migrant, or foster status, or participation in California’s food stamp program. There are no counts provided for Provision 2 and 3 schools. |
| percent_eligible_free_k_12  | Percentage of students (K–12) eligible for free meals. (October 2012 Free Meal Count [K–12] divided by CALPADS October 2012 Enrollment [K–12].) |
| frpm_total_undup_count_k_12 | The total unduplicated count of students ages 5–17 enrolled in the school who are eligible to receive free or reduced price meals (FRPM). Students may be eligible for reduced price meals based on applying for the National School Lunch Program (NSLP), or who are determined to meet the same income eligibility criteria as the NSLP, through their local schools. |
| frpm_percent_eligible_k_12  | Percentage of students (K–12) eligible for free and reduced price meals (FRPM). (October 2012 FRPM Total Unduplicated Count [K–12] divided by CALPADS October 2012 Enrollment [K–12].) |
| enrollment_5_17             | CALPADS October school enrollment (primary or short-term) of students ages 5–17 certified in CALPADS as part of the Fall 1 data submission. |
| free_meal_count_5_17        | Of the students enrolled in the school, the unduplicated count of students ages 5–17 who are eligible to receive free meals. Students may be eligible for free meals based on applying for the National School Lunch Program (NSLP), or who are determined to meet the same income eligibility criteria as the NSLP, through their local schools, their homeless, migrant, or foster status, or participation in California’s food stamp program. There are no counts provided for Provision 2 and 3 schools. |
| percent_eligible_5_17       | Percentage of students (ages 5–17) eligible for free meals. (October 2012 Free Meal Count [ages 5–17] divided by CALPADS 2012 October Enrollment [ages 5–17].) |
| frpm_total_undup_count_5_17 | The total unduplicated count of students ages 5–17 enrolled in the school who are eligible to receive free and reduced price meals (FRPM). Students may be eligible for reduced price meals based on applying for the National School Lunch Program (NSLP), or who are determined to meet the same income eligibility criteria as the NSLP, through their local schools. |
| frpm_percent_eligible_5_17  | Percentage of students (ages 5–17) eligible for free and reduced price meals (FRPM). (October 2012 FRPM Total Unduplicated Count [ages 5–17] divided by CALPADS October 2012 Enrollment [ages 5–17].) |


### Other Fields

The following fields from this file were added to schools 

| Column Name                         | Description |
| ----------------------------------- | ----------- |
| school_code                         |             |
| direct_funded_charter_school        | Based on whether a charter school number was present or not |
| direct_funded_charter_school_number |             |
