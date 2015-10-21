
DATA WORK.Assignment___indiv_assign2___dat;
    LENGTH
        Days               8
        Sales_Vol_k        8
        Price              8
        Ad_spending        8 ;
    FORMAT
        Days             BEST2.
        Sales_Vol_k      BEST4.
        Price            BEST5.
        Ad_spending      BEST5. ;
    INFORMAT
        Days             BEST2.
        Sales_Vol_k      BEST4.
        Price            BEST5.
        Ad_spending      BEST5. ;
    INFILE 'xxx/xxx/'
        LRECL=19
        ENCODING="LATIN1"
        TERMSTR=CRLF
        DLM='7F'x
        MISSOVER
        DSD ;
    INPUT
        Days             : ?? BEST2.
        Sales_Vol_k      : ?? BEST4.
        Price            : ?? COMMA5.
        Ad_spending      : ?? COMMA5. ;
RUN;
