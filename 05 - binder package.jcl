//BNDPAKG JOB 'MASTER',
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
        PACKAGE   (COL1)    -
        MEMBER    (PROGRAM) -
        OWNER     (IBMUSER) -
        QUALIFIER (IBMUSER) -
        ACTION    (REPLACE) -
        VALIDATE  (BIND)    -
        ENCODING  (EBCDIC)  -
        ISOLATION (CS)
    END 
 END
/*