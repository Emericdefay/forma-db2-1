//MPRTSQL JOB 'MASTER',
//            'MAC',
//            CLASS=A,
//            MSGCLASS=X,
//            NOTIFY=&SYSUID
//*=================PROGRAM==================
//      SET PROGM=PGM016
//      SET PGMPATH=MASTER.PROG.CBL
//      SET COPYPATH=MASTER.PROG.COPY
//      SET LOADPATH=MASTER.PROG.LOAD
//*==============DCLGEN PATH=================
//      SET DCLGENPT=MASTER.SQL.DCLGEN
//*==============DBRM PATH===================
//      SET DBRMPTH=MASTER.SQL.DBRM
//*===========IGY SPECIFICATION==============
//      SET IGYSPE=IGY410.SIGYCOMP
//*==========================================
//*
//* Precompilation
//*
//PRECOMPL EXEC DSNHICOB,MEM=&PROGM
//PC.SYSIN   DD DISP=SHR,DSN=&PGMPATH(&MEM)
//PC.SYSLIB  DD DISP=SHR,DSN=&DCLGENPT
//PC.DBRMLIB DD DISP=SHR,DSN=&DBRMPTH(&MEM)
//*
//* Compilation
//*
//COB.STEPLIB  DD DISP=SHR,DSN=&IGYSPE
//COB.SYSLIB   DD DISP=SHR,DSN=&COPYPATH
//LKED.SYSLMOD DD DISP=SHR,DSN=&LOADPATH(&MEM)
//*
//* Binding
//*
//*