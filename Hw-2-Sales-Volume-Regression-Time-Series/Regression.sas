/* Hw#2 Create a demand function from the base csv file.
Q - is volume, Price, and Ad Expense is an extra variable that seems interesting
*/

; /* NOTE: The data set WORK.DATA_1 has 40 observations and 45 variables. */
 data Data_1 ; set WORK.Assignment___indiv_assign2___dat ; 
    /*differences*/
    dif_vol_1 = dif(Sales_Vol_k) ;  
    dif_price_1 = dif(price) ; 
    dif_Adsp_1 = dif(Ad_spending) ; 
    /* lags*/
    lag_vol = lag(sales_vol_k) ; 
    lag_price = lag(price) ; 
    lag_adsp = lag(Ad_spending) ;
    lag_adsp2 = lag2(Ad_spending) ;
    lag_adsp3 = lag3(Ad_spending) ;
    /* lagged differences */
    lag_1_dif_vol = lag(dif_vol_1) ; 
    lag_1_dif_price = lag(dif_price_1) ; 
    lag_1_dif_adsp = lag(dif_Adsp_1) ; 

    lag_2_dif_vol = lag2(dif_vol_1) ; 
    lag_2_dif_price = lag2(dif_price_1) ; 
    lag_2_dif_adsp = lag2(dif_Adsp_1) ;

    lag_3_dif_vol = lag3(dif_vol_1) ; 
    lag_3_dif_price = lag3(dif_price_1) ; 
    lag_3_dif_adsp = lag3(dif_Adsp_1) ;  

    /* Ln */
    ln_vol = log(sales_vol_k) ;
        lag_1_ln_vol = lag(ln_vol) ;  
                lag_2_ln_vol = lag2(ln_vol) ;  
                        lag_3_ln_vol = lag3(ln_vol) ;  
    ln_price = log(price) ; 
        lag_1_ln_price = lag(ln_price) ;
        lag_2_ln_price = lag2(ln_price) ;
        lag_3_ln_price = lag3(ln_price) ;
        
    ln_ad = log(ad_spending) ;
        lag_1_ln_ad = lag(ln_ad) ;
        lag_2_ln_ad = lag2(ln_ad) ;
        lag_3_ln_ad = lag3(ln_ad) ;

    dif_ln_vol = dif(ln_vol);
        lag_1_dif_ln_vol = lag(dif_ln_vol) ; 
                lag_2_dif_ln_vol = lag2(dif_ln_vol) ; 
                        lag_3_dif_ln_vol = lag3(dif_ln_vol) ; 
    dif_ln_price = dif(ln_price) ;
        lag_1_dif_ln_price = lag(dif_ln_price) ; 
                lag_2_dif_ln_price = lag2(dif_ln_price) ; 
                        lag_3_dif_ln_price = lag3(dif_ln_price) ; 
    dif_ln_ad = dif(ln_ad) ;
        lag_1_dif_ln_ad = lag(dif_ln_ad) ; 
                lag_2_dif_ln_ad = lag2(dif_ln_ad) ; 
                        lag_3_dif_ln_ad = lag3(dif_ln_ad) ; 

 run ; 


 proc corr data = Data_1 RANK  ; var dif_ln_vol lag_vol lag_1_ln_vol	lag_2_ln_price	lag_3_ln_price	lag_2_ln_ad	dif_ln_price lag_1_dif_ln_price ;
run ; 

proc reg data = Data_1 ; 
    model dif_vol_1 =  lag_vol  / r ; /* lag_1_dif_vol */
run ; 

proc reg data = Data_1 ; 
    model dif_price_1 = days lag_price lag_1_dif_price/ r ; 
run ; 

proc reg data = Data_1 ; 
    model dif_Adsp_1 = days lag_adsp lag_1_dif_adsp / r ; 
run ; 

proc reg data = Data_1 ;
/*    model dif_vol_1 = days lag_vol lag_1_dif_vol lag_2_dif_vol lag_3_dif_vol  / r ;      */
/*    model sales_vol_k = days lag_vol  lag_adsp lag_adsp2 lag_adsp3 / dw r ;  /* lag_price is exogenous * /*/
/*    model dif_vol_1 = days lag_vol lag_1_dif_price lag_1_dif_adsp / aic bic r ;*/
/*    model dif_vol_1 = days lag_vol lag_price lag_adsp   / aic bic r ;*/
/*    model dif_vol_1 = lag_vol dif_price_1 dif_Adsp_1                 / aic bic r ; */                   
/*                lag_1_dif_price lag_2_dif_price lag_3_dif_price not significant */
/*                lag_1_dif_adsp lag_2_dif_adsp lag_3_dif_adsp not significant */
/*model dif_ln_vol =   days lag_1_ln_vol lag_1_dif_ln_vol lag_2_dif_ln_vol lag_3_dif_ln_vol*/
/*                                        lag_1_ln_price lag_2_ln_price lag_3_ln_price */
/*                                        lag_1_ln_ad lag_2_ln_ad lag_3_ln_ad / dw r ; /* first model ;*/*/
model dif_ln_vol =   days lag_1_ln_vol   
                                        lag_1_ln_price lag_2_ln_price lag_3_ln_price 
                                         lag_2_ln_ad  / dw r; /* first model ; */
/*model dif_ln_vol =   lag_1_ln_vol   */
/*                                        lag_1_ln_price lag_2_ln_price lag_3_ln_price */
/*                                         lag_2_ln_ad  / dw r; /* first model ; * /*/
model dif_ln_vol =   lag_1_ln_vol  dif_ln_price    /* Highest Rsq = .70 */ 
                                       lag_1_dif_ln_price lag_2_ln_price lag_3_ln_price 
                                         lag_2_ln_ad  / dw r; /* first model ; */
model dif_ln_vol =  days lag_1_ln_vol lag_1_ln_price lag_2_ln_price lag_3_ln_price lag_1_ln_ad lag_2_ln_ad lag_3_ln_ad / dw r;  * first model ;
model dif_ln_vol =  lag_1_ln_vol lag_1_ln_price lag_2_ln_price lag_3_ln_price lag_1_ln_ad lag_2_ln_ad lag_3_ln_ad / dw r;  *first model without days; 
/*    model dif_ln_vol =  days lag_1_ln_vol lag_3_ln_price lag_1_ln_ad lag_2_ln_ad lag_3_ln_ad / dw r; second model     */
       model dif_ln_vol =  days lag_1_ln_vol lag_3_ln_price lag_1_ln_ad lag_2_ln_ad  / dw r ;
              model dif_ln_vol =  lag_1_ln_vol lag_3_ln_price lag_1_ln_ad lag_2_ln_ad  / dw r ;
 model dif_ln_vol =  days lag_1_ln_vol dif_ln_price lag_1_ln_ad lag_2_ln_ad lag_3_ln_ad / dw r; 
  model dif_ln_vol =  days lag_1_ln_vol dif_ln_price lag_1_ln_ad lag_2_ln_ad / dw r; /* Best Model */
   model dif_ln_vol =  lag_1_ln_vol dif_ln_price lag_1_ln_ad lag_2_ln_ad / dw r; 
 model dif_ln_vol =  dif_ln_price dif_ln_ad / dw  r;  
 model dif_ln_vol =  lag_1_ln_vol dif_ln_price /dw r;  
    model dif_vol_1 = days lag_vol dif_price_1 dif_Adsp_1  / dw r ;
model dif_vol_1 =  dif_price_1 / dw r; 
run ; 


proc arima data = Data_1 ; 
    identify var = Sales_Vol_k(0) stationarity = (adf=(1,1))   ;
run ; 
proc arima data = Data_1 ; 
    identify var = Price(0) stationarity = (adf=(1,1))  ; 
run ; 
proc arima data = Data_1 ; 
    identify var = Ad_spend(6) stationarity = (adf=(1,1))  ;
run ; 




