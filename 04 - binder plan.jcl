//BNDPLAN JOB 'MASTER',
//            'MAC',
//            CLASS=A,
//            MSGCLASS=X,
//            NOTIFY=&SYSUID
//*=========================================
// SET DBRMLIB=MASTER.SQL.DBRM
// SET RUNLIB=DSN910.DB9G.RUNLIB.LOAD
//*=========================================
//STEP001 EXEC PGM=IKJEFT01
//STEPLIB   DD DISP=SHR,DSN=&RUNLIB
//DBRMLIB   DD DISP=SHR,DSN=&DBRMLIB
//SYSTSPRT  DD SYSOUT=*
//SYSPRINT  DD SYSOUT=*
//SYSTSIN   DD  *
 DSN SYSTEM(DB9G)
    BIND - 
        PLAN      (PLANCOB) -
        OWNER     (IBMUSER) -
        PKLIST    (COL1.*)     
    END 
 END
/*