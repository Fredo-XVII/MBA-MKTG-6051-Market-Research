
data CSOM_1 ; set csom ;
    male = 0 ; female = 0 ; 
    if gender = 1 then male = 1 ; 
    if gender = 0 then female = 1 ; 
run ; 

proc freq data = csom ; table gender ; run ; 
proc means data = csom_1 n sum median mean std min max range ; run; 

proc logistic data = csom_1 descending ;
    model awarecsom = female hoursTV DetergentPur Income ; 
run ; 
