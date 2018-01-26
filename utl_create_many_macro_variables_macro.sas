%macro utl_usrDelMac;

 * hidden user macro variables with prefix SYS created by SAS but not you cannot be deleted;

 %put ***** BEFORE DELETE ******;
 %put _user_;

 data _null_;
     length macvar $16000;
     retain macvar;
     if _n_=0 then do;
        rc=%sysfunc(dosubl('
           %utlfkil(d:/txt/mac.txt);
           filename tmp "d:/txt/mac.txt";
           proc printto log=tmp;run;quit;
             %put _user_;
           proc printto;run;quit;
           filename tmp clear;
        '));
     end;

     infile "d:/txt/mac.txt" end=dne;
     input;

     if index(_infile_,"GLOBAL")>0 then do;
        mac=scan(_infile_,2," ");
        if substr(mac,1,3) ne "SYS" then macvar = catx(" ",macvar,mac);
     end;

        * cannot use DOSUBL - also tricky to create an additional macro variable;
     if dne then
        call execute (catx(" ",'%symdel',macvar,';'));

 run;quit;

 %put ***** AFTER DELETE ******;
 %put _user_;

%mend utl_usrDelMac;
