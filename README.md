# utl_create_many_macro_variables.
Create many macro variables. Keywords: sas sql join merge big data analytics macros oracle teradata mysql sas communities stackoverflow statistics artificial inteligence AI Python R Java Javascript WPS Matlab SPSS Scala Perl C C# Excel MS Access JSON graphics maps NLP natural language processing machine learning igraph DOSUBL DOW loop stackoverflow SAS community.
    Create many macro variables

    github
    https://github.com/rogerjdeangelis/utl_create_many_macro_variables

    Macro to delete "_user_" macro variable on the end

    ARRAY and DO_OVER MACRO
    https://goo.gl/CVFQVW
    https://github.com/rogerjdeangelis/utl_sql_looping_or_using_arrays_in_sql_do_over_macro/blob/master/utl_sql_looping_or_using_arrays_in_sql_do_over.sas

    see
    https://goo.gl/GKjTGu
    https://communities.sas.com/t5/Base-SAS-Programming/create-a-macro-variable/m-p/431247

       Eight techniques

            1. %input
            2. %SYSCALL SET(DSID);
            3. ARRAY macro (see DO_OVER)
            4. DATASTEP DO_OVER
            5. SQL DO_OVER
            6. Datastep and 60 macro variables

           Concatenating many variables into on macro strings

            7. Datstep Concatenating into 3 macro variable strings
            8. SQL Concatenating into 3 macro variable strings

          Other methods (not included)
               call symputx
               %let


    INPUTS
    ======

    Macros  utl_usrDelmac(in end), ARRAY and DO_OVER MACRO

    * You might want to put these macro statements in your autoexec file;

    %let lettersq=
     "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z";
    %let letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;


    %let numbersq=%str("1","2","3","4","5","6","7","8","9","0");
    %let numbers=0 1 2 3 4 5 6 7 8 9;


    Empty sas/wps dataset in your sasuser folder

      data sasuser.empty;
         empty="";
       run;quit;

    For a null dataset

     data sasuser.null;
        set sasuser.empty(obs=0)
     run;quit;

    *_            _           _
    | |_ ___  ___| |__  _ __ (_) __ _ _   _  ___  ___
    | __/ _ \/ __| '_ \| '_ \| |/ _` | | | |/ _ \/ __|
    | ||  __/ (__| | | | | | | | (_| | |_| |  __/\__ \
     \__\___|\___|_| |_|_| |_|_|\__, |\__,_|\___||___/
                                   |_|
    ;

    1. %INPUT

       %utl_usrDelMac;

       %input n01 n02 n03 n04 n05 n06 n07 n08 n09;
       10 20 30 40 50 60 70 80 90;

       %put _user_;

           N01 10
           N02 20
           N03 30
           N04 40
           N05 50
           N06 60
           N07 70
           N08 80
           N09 90;

    5. %SYSCALL SET(DSID);

        %utl_usrDelMac;  * delete all user defined macro variables;

        data _null_;
          %let dsid = %sysfunc(open(sashelp.class(where=(name='Alice')),i));
          %syscall set(dsid);
          %let rc=%sysfunc(fetchobs(&dsid,1));
          %let rc=%sysfunc(close(&dsid));
        run;quit;

       %put _user_;

           NAME   Alice
           SEX        F
           AGE       13
           HEIGHT  56.5
           WEIGHT    84


    2. ARRAY macro

        %utl_usrDelMac;  * delete all user defined macro variables;

        * set in autoexec but I deleted them above so I need to recreate;
        %let numbers=0 1 2 3 4 5 6 7 8 9;
        %let letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;

        %array(ltr,values=&letters);        * note macro variable letters is in my autoexec iw a b c d ..;
        %array(num,values=&numbers);        * note macro variable numbers is in my autoexec ie 0 1 2 3...;

        %array(abc,values=1-20);
        %array(qrs,values=100-120);
        %array(xyz,values=51-70);


        %put _user_;

            LTR1  A
            LTR10 J
            LTR11 K
            LTR12 L
            LTR13 M
            LTR14 N
            LTR15 O
            LTR16 P
            LTR17 Q
            LTR18 R
            LTR19 S
            LTR2  B
            LTR20 T
            LTR21 U
            LTR22 V
            LTR23 W
            LTR24 X
            LTR25 Y
            LTR26 Z
            LTR3  C
            LTR4  D
            LTR5  E
            LTR6  F
            LTR7  G
            LTR8  H
            LTR9  I

            LTRN 26

    3. DO_OVER  (squares of 0 to 10)

        %utl_usrDelMac;  * delete all user defined macro variables;

        %let numbers=1 2 3 4 5 6 7 8 9 0;

        %array(nums,values=&numbers);
        %do_over(nums,phrase=%nrstr(data; nums? = ?*?;call symputx("nums?",nums?);run;quit;));

        %put _user_; * squares;

             NUMS1 1
             NUMS2 4
             NUMS3 9
             NUMS4 16
             NUMS5 25
             NUMS6 36
             NUMS7 49
             NUMS8 64
             NUMS9 81
             NUMS10 0

             NUMSN 10
             SYSRANDOM 1234

    4. SQL with a empty table

      %utl_usrDelMac;  * delete all user defined macro variables;

        %let lettersq=
         "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z";

        %let letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;

        %put &=lettersq;

        proc sql;
         %array(ltrs,values=&letters)
         select
            &lettersq
         into
            %do_over(ltrs,phrase=%str(:???),between=comma)
         from
           sasuser.empty /* you can use sashelp.class(obs=1) */
       ;quit;

      %put _user_;

          A   AAA
          B   BBB
          C   CCC
          D   DDD
          E   EEE
          F   FFF
          G   GGG
          H   HHH
          I   III
          J   JJJ
          K   KKK
          L   LLL
          M   MMM
          N   NNN
          O   OOO
          P   PPP
          Q   QQQ
          R   RRR
          S   SSS
          T   TTT
          U   UUU
          V   VVV
          W   WWW
          X   XXX
          Y   YYY
          Z   ZZZ


    5. %SYSCALL SET(DSID); * you can loop and radd all data but you will need sufices on macro vars;

        %utl_usrDelMac;  * delete all user defined macro variables;

        data _null_;
          %let dsid = %sysfunc(open(sashelp.class(where=(name='Alice')),i));
          %syscall set(dsid);
          %let rc=%sysfunc(fetchobs(&dsid,1));
          %let rc=%sysfunc(close(&dsid));
        run;quit;

       %put _user_;

           NAME   Alice
           SEX        F
           AGE       13
           HEIGHT  56.5
           WEIGHT    84


    6. Datastep and 60 macro variables

         data _null_;

             call streaminit(1234);

             do i=1 to 20;

               abc=put(int(100*rand('uniform')),z2.);
               qrs=put(int(100*rand('uniform')),z2.);
               xyz=put(int(100*rand('uniform')),z2.);

               call symputx('abc'!!put(i,2. -l),abc);
               call symputx('qrs'!!put(i,2. -l),qrs);
               call symputx('xyz'!!put(i,2. -l),xyz);

            end;

         run;quit;

       %put _user_;

        ABC1 75    QRS1 74    XYZ1 29
        ABC10 71   QRS10 05   XYZ10 56
        ABC11 22   QRS11 07   XYZ11 90
        ABC12 07   QRS12 99   XYZ12 47
        ABC13 05   QRS13 26   XYZ13 68
        ABC14 91   QRS14 52   XYZ14 58
        ABC15 66   QRS15 95   XYZ15 22
        ABC16 91   QRS16 19   XYZ16 04
        ABC17 05   QRS17 05   XYZ17 47
        ABC18 17   QRS18 05   XYZ18 21
        ABC19 02   QRS19 43   XYZ19 56
        ABC2 29    QRS2 99    XYZ2 21
        ABC20 71   QRS20 48   XYZ20 95
        ABC3 29    QRS3 56    XYZ3 21
        ABC4 55    QRS4 13    XYZ4 73
        ABC5 49    QRS5 28    XYZ5 94
        ABC6 79    QRS6 42    XYZ6 96
        ABC7 09    QRS7 30    XYZ7 94
        ABC8 95    QRS8 71    XYZ8 89
        ABC9 81    QRS9 31    XYZ9 23



    7. Datstep Concatenating into 3 macro variable strings

         %utl_usrDelMac;  * delete all user defined macro variables;

         data _null_;
             length abc qrs xyz $100;
             retain abc qrs xyz;

             call streaminit(1234);

             do i=1 to 20;

               xabc=put(int(100*rand('uniform')),z2.);
               xqrs=put(int(100*rand('uniform')),z2.);
               xxyz=put(int(100*rand('uniform')),z2.);

               abc=catx("|",abc,xabc);
               qrs=catx("|",qrs,xqrs);
               xyz=catx("|",xyz,xxyz);
            end;

            call symputx('abc',abc);
            call symputx('qrs',qrs);
            call symputx('xyz',xyz);

         run;quit;

        %put _user_;

        ABC 75|29|29|55|49|79|09|95|81|71|22|07|05|91|66|91|05|17|02|71
        QRS 74|99|56|13|28|42|30|71|31|05|07|99|26|52|95|19|05|05|43|48
        XYZ 29|21|21|73|94|96|94|89|23|56|90|47|68|58|22|04|47|21|56|95
        SYSRANDOM 1234


    8. Proc sql Concatenating into 3 macro variable strings

       %utl_usrDelMac;  * delete all user defined macro variables;

       data _null_;
         if _n_=0 then do;
           %let rc=%sysfunc(dosubl('
            data have;
               call streaminit(1234);
               do i=1 to 20;
                 abc=put(int(100*rand("uniform")),z2.);
                 qrs=put(int(100*rand("uniform")),z2.);
                 xyz=put(int(100*rand("uniform")),z2.);
                 output;
              end;
            run;quit;
           '));
         end;

         rc=dosubl('
           proc sql;
              select
                 abc
                ,qrs
                ,xyz
              into
                :abc separated by " "
               ,:qrs separated by " "
               ,:xyz separated by " "
              from
                have
           ;quit;
        ');
        stop;
       run;quit;

       %put _user_;


       ABC 75 29 29 55 49 79 09 95 81 71 22 07 05 91 66 91 05 17 02 71
       QRS 74 99 56 13 28 42 30 71 31 05 07 99 26 52 95 19 05 05 43 48
       XYZ 29 21 21 73 94 96 94 89 23 56 90 47 68 58 22 04 47 21 56 95

       SYSRANDOM 1234

    *    _      _      _
      __| | ___| | ___| |_ ___   _ __ ___   __ _  ___
     / _` |/ _ \ |/ _ \ __/ _ \ | '_ ` _ \ / _` |/ __|
    | (_| |  __/ |  __/ ||  __/ | | | | | | (_| | (__
     \__,_|\___|_|\___|\__\___| |_| |_| |_|\__,_|\___|

    ;

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

    %utl_usrDelMac;
