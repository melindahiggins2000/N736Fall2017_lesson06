* ======================================;
* load dataA;
* ======================================;
proc import datafile='C:\MyGithub\N736Fall2017_lesson05\dataA.csv'
  out=dataA dbms=csv;
run;

* ======================================;
* load dataB;  
* ======================================;
proc import datafile='C:\MyGithub\N736Fall2017_lesson05\dataB.csv'
  out=dataB dbms=csv;
run;

* ======================================;
* load dataC;  
* ======================================;
proc import datafile='C:\MyGithub\N736Fall2017_lesson05\dataC.csv'
  out=dataC dbms=csv;
run;

* create some formats for likert scale variables
* and for the gender character variable;

proc format;
  value likert  
    1='strongly disagree'
    2='disagree'
	3='neutral'
	4='agree'
	5='strongly agree';
  value $gender  
    'm'='male'
    'f'='female';
run;

* see what it looks like without the format applied;

proc print data=dataA; run;

* apply the format to a new dataset dataA2;

data dataA2;
  set dataA;
  format var1 likert.;
run;

* the format comes with var1 in dataA2;

proc print data=dataA2; run;

* but we can also apply a format
* like gender to dataB;

proc print data=dataB;
  format var2 $gender.;
  run;

* run a frequency table without formatting;

proc freq data=dataB;
  tables var2;
  run;

* add the formatting for the table;

proc freq data=dataB;
  format var2 $gender.;
  tables var2;
  run;

* add a title to the ODS output;

proc freq data=dataB;
  title "Frequency Table of Gender";
  format var2 $gender.;
  tables var2;
  run;

* notice the title remains in the next output also;

proc print data=dataB; run;

* set the title to blank;

title;

proc print data=dataB; run;

* but now the title is empty;

* It is a good idea to ALWAYS include a title for each section of output;

 * you can add a comment about a dataset in SAS;

data dataA3 (label="a comment on dataset a3");
  set dataA;
run;

proc contents data=dataA3; run;

proc freq data=dataA3;
  tables var1;
  run;

proc univariate data=dataA2;
  var var1;
  run;

title "Univariate Report for var 1 in dataA2";
title2 "Report by Melinda Higgins";
title3 "dated 09/15/2017";
footnote "this is footnote 1";
footnote2 "this is footnote 2";
footnote3 "this is footnote 3";

proc univariate data=dataA2 plots;
  var var1;
  histogram var1/normal;
  run;

proc options; run;

* plots without the proc format applied;

proc freq data=dataA;
 tables var1/plots=freqplot;
 run;

* plots with the proc format applied;

proc freq data=dataA2;
 tables var1/plots=freqplot;
 run;

* ======================================;
* concatenate dataA and dataB
  add rows and keep columns in both;
* ======================================;
  
data dataAB;
  set dataA dataB;
run;
  
proc print data=dataAB noobs; run;

* recoding;

* define the formats first;

proc format;
  value splitYN
    0 = 'NO var1 <= 3'
    1 = 'YES var1 > 3';
run;

* create new dataset with recoded variables;
* apply new format labels;

data dataAB_new;
  set dataAB;
  if var1 > 3 then var1split3 = 1;
  else             var1split3 = 0;
  format var1split3 splitYN.;
run;

* create table and plot of new variable;

proc freq data=dataAB_new;
 tables var1split3/plots=freqplot;
 run;

* manipulating data types;
* see more at http://support.sas.com/kb/24/590.html;
* creating new variables;

data dataAB_new2;
   set dataAB;
   newvar12 = var1 || var2;
   newvar1str = put(var1, 6.);
   newvar1num = input(newvar1str, 6.);
run;

proc contents data=dataAB_new2; run;


