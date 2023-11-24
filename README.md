# SAS-project-Blue-Cross-Blue-Shield-data

Data sets is from Blue Cross/Blue Shield data regarding dementia patients and their use of antipsychotic medications was done. There are 5 permanent SAS data sets dempts (5 variables), aprx (12 variables), aprxdx (47 variables), cci (36 variables), and costutil (24 variables). Each of them has hundred observations.

Tasks done

1. Merge the 5 data sets together by the variable studyid. Format all categorical variables that have been using numbers ( 1=’Yes’ and 0=’No’).
2. Create a 4 level variable antipsychotic type from the variables iconven (having a prescription for a conventional antipsychotic) and iatypical (having a prescription for an atypical antipsychotic) that has values 0=neither conventional nor atypical, 1=conventional only, 2=atypical only, 3=both conventional and atypical.
3. Create a variable from the number of types of prescriptions (srxtype) that has categories of 1, 2-3, 4-5, 6+.
4. Create an overall fracture variable (any fracture=1, non fracture=0) from ihip and ifemur.
5. Create an overall antipsychotic related fracture variable (any fracture=1, non fracture=0) from iaphip and iapfemur.
6. Descriptive statistics on all variables I created in earlier parts.
