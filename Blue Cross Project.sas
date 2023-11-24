/** SAS Project by Fahim Hoq **/



libname in 'C:\DATS7510\SAS';

/** 1 **/
/** Formatting Categorical Variables **/

Proc format;
	value fmtfemale 	0 = "No" 
					    1 = "Yes"; 
run;


Proc format;
	value  fmtindicator   0 = "No" 
					      1 = "Yes";
run;

/** Combining Data **/

data dempts;
  set in. dempts;
proc sort data=dempts;
 by studyid;
run;

data aprx;
  set in. aprx;
proc sort data=dempts;
 by studyid;
run;

data aprxdx;
  set in. aprxdx;
proc sort data=dempts;
 by studyid;
run;

data cci;
  set in. cci;
proc sort data=dempts;
 by studyid;
run;

data costutil;
  set in. costutil;
proc sort data=dempts;
 by studyid;
run;


proc contents data=dempts short varnum;
proc contents data=aprx short varnum;
proc contents data=aprxdx short varnum;
proc contents data=cci short varnum;
proc contents data=costutil short varnum;
run;


data complete;
merge dempts aprx aprxdx cci costutil;
  by studyid;
format female fmtfemale.;
format iaids ialtercon ianydx iapaltercon iapanydx iapconstipation iapdelirium iapdepress
iapdiab iapfalls iapfemur iaphip iapstroke iapsyncope iatypical ibenzo icancer iccidem ichf icnsrx
iconstipation iconven icpd icvd idelirium idem idepress idiab idiabc idiabnc ifalls ifemur ihip
ihpplega imcancer imi imliverd imsliver ipud ipvd irenald irhemz istroke isyncope fmtindicator. ;
run;

proc print data=complete;
run;

proc contents data=complete short varnum; 
run;


/** 2 **/
/** More Formatting and using else/if statements **/

Proc format;
	value fmttype 	0 = "neither conventional nor atypical" 
					1 = "conventional only"
					2 = "atypical only"
					3 = "both conventional and atypical"; 
run;


data complete_b;
merge dempts aprx aprxdx cci costutil;
  by studyid;
format female fmtfem.;
if iconven = 0 and iatypical = 0 then antipsychotictype = 0;
else if iconven = 1 and iatypical = 0 then antipsychotictype = 1;
else if iconven = 0 and iatypical = 1 then antipsychotictype = 2;
else if iconven = 1 and iatypical = 1 then antipsychotictype = 3;
format antipsychotictype fmttype.; 
run;

proc print data=complete_b;
var studyid iconven iatypical antipsychotictype;
run;


/** 3 **/


data complete_c;
merge dempts aprx aprxdx cci costutil;
  by studyid;

if srxtype = 1 then typesofprescriptions = "1";
else if 2 <= srxtype <= 3 then typesofprescriptions = "2-3";
else if 4 <= srxtype <= 5 then typesofprescriptions = "4-5";
else if srxtype >= 6 then typesofprescriptions = "6+";
run;

proc print data=complete_c;
var studyid srxtype typesofprescriptions;
run;

/** 4 **/

Proc format;
	value ihipifemur 	0 = "non fracture" 
					    1 = "any fracture"; 
run;

data complete_d;
merge dempts aprx aprxdx cci costutil;
  by studyid;
if ihip = 0 and ifemur = 0 then OverallFracture = 0;
else if ihip = 1 or ifemur = 1 then OverallFracture = 1;
format OverallFracture ihipifemur.; 
run;

proc print data=complete_d;
var studyid ihip ifemur OverallFracture;
run;

/** 5 **/

Proc format;
	value fmtsap 	    0 = "non fracture" 
					    1 = "any fracture"; 
run;

data complete_e;
merge dempts aprx aprxdx cci costutil;
  by studyid;

if iaphip = 0 and iapfemur = 0 then OverallAntipsy = 0;
else if iaphip = 1 or iapfemur = 1 then OverallAntipsy = 1;

format overallAntipsy fmtsap.;

Label  OverallAntipsy = "overall antipsychotic frac";
run;

proc print data=complete_e Label;
var studyid iaphip iapfemur OverallAntipsy;
run;

/** 6 **/
/** Descriptive Statistics **/

proc freq data = complete_b;
table antipsychotictype;
title "antipsychotictype";
run;

proc freq data = complete_c;
table typesofprescriptions;
title "Type of Prescriptions";
run;

proc freq data = complete_d;
table OverallFracture;
title "Overall Fracture";
run;

proc freq data = complete_e;
table OverallAntipsy;
title "Antipsychotic Fracture";
run;

