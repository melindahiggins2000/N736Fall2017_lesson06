* ======================================;
* N736 Lesson 06 SAS Code
* 09/13/2017
*
* Melinda Higgins, PhD
* ======================================;

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
* add a comment to dataset dataA;
* ======================================;

data dataAcomment (label="This is a comment on dataA");
  set dataA;
run;

* ======================================;
* see the dataset comment using PROC CONTENTS;
* ======================================;

proc contents data=dataAcomment; run;

* ======================================;
* define some formats;
* ======================================;

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

* ======================================;
* view dataA without formats applied;
* ======================================;

proc print data=dataA; run;

* ======================================;
* create dataA2 with formats for var1;
* ======================================;

data dataA2;
  set dataA;
  format var1 likert.;
run;

* ======================================;
* view dataA2 with formats for var1 applied;
* ======================================;

proc print data=dataA2; run;

* ======================================;
* can also use the formats on the fly;
* ======================================;

proc print data=dataB;
  format var2 $gender.;
  run;

* ======================================;
* run a frequency table without formatting;
* ======================================;

proc freq data=dataB;
  tables var2;
  run;

* ======================================;
* add the formatting for the table;
* ======================================;

proc freq data=dataB;
  format var2 $gender.;
  tables var2;
  run;

* ======================================;
* see frequency table without formatting
* ======================================;
  
proc freq data=dataA;
 tables var1;
 run;
 
* ======================================;
* see frequency table with formatting
* ======================================;

proc freq data=dataA2;
 tables var1;
 run;
 
* ======================================;
* see frequency table with formatting on the fly;
* and add a title - note global change;
* ======================================;
 
proc freq data=dataB;
  title "Frequency Table of Gender";
  format var2 $gender.;
  tables var2;
  run;
  
* ======================================;
* the title remains - need to reset;
* ======================================;
  
proc print data=dataB; run;

* ======================================;
* set title to blank;
* ======================================;

title;

* ======================================;
* no title is shown;
* ======================================;

proc print data=dataB; run;

* ======================================;
* can create up to 3 custom titles
* and custom footnotes;
* ======================================;

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
  
* ======================================;
* set all titles and footnotes back to empty;
* ======================================;

title;
title2;
title3;
footnote;
footnote2;
footnote3;

* ======================================;
* concatenate/stack dataA and dataB together
* ======================================;

data dataAB;
  set dataA dataB;
run;

proc print data=dataAB noobs; run;

* ======================================;
* define a new format;
* ======================================;

proc format;
  value splitYN
    0 = 'NO var1 <= 3'
    1 = 'YES var1 > 3';
run;

* ======================================;
* create new dataset with a new recoded
* variable and with formatting applied;
* ======================================;

data dataAB_new;
  set dataAB;
  if var1 > 3 then var1split3 = 1;
  else             var1split3 = 0;
  format var1split3 splitYN.;
run;

* ======================================;
* view all of these changes and the new variable
* with the new formatting and
* add plots using PROC FREQ;
* ======================================;

proc freq data=dataAB_new;
 tables var1split3/plots=freqplot;
 run;
 
 