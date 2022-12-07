//MPRTSQL JOB 'MASTER',
//            'MAC',
//            CLASS=A,
//            MSGCLASS=X,
//            NOTIFY=&SYSUID
//*=========================================
//STEP001 EXEC PGM=IKJEFT01
//STEPLIB   DD DSN=DSN910.DB9G.RUNLIB.LOAD,DISP=SHR
//SYSTSPRT  DD SYSOUT=*
//SYSTSIN   DD *
 DSN SYSTEM(DB9G)
 RUN PROGRAM(DSNTEP2) PLAN(DSNTEP91)
/*
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
    DROP DATABASE DBCOMPTE;
    DROP TABLE TBDEVISE;
    COMMIT;

    CREATE DATABASE DBCOMPTE;
    CREATE TABLESPACE TBDEVISE IN DBCOMPTE;

    CREATE TABLE TBDEVISE (
        CDEV    CHAR(03)     NOT NULL,
        MTACHAT DECIMAL(6,3) NOT NULL,
        MTVENTE DECIMAL(6,3) NOT NULL,
        DDMAJ   DATE         NOT NULL,
        HDMAJ   TIME         NOT NULL
    );

    CREATE ALIAS TBDEVISE                                        
       FOR TBDEVISE;                                     

    GRANT DBADM                                                     
       ON DATABASE DBCOMPTE                                       
       TO PUBLIC;                                                          

    GRANT USE                                                       
       OF TABLESPACE DBCOMPTE.TBDEVISE                             
       TO PUBLIC;                                                   

    GRANT DELETE, INSERT, SELECT, UPDATE                            
       ON TABLE TBDEVISE                                
       TO PUBLIC;  

    INSERT INTO TBDEVISE VALUES
    ('USD', 1.054,   11.095 ,CURRENT DATE, CURRENT TIME);
    INSERT INTO TBDEVISE VALUES
    ('CAD', 1.414,   1.485  ,CURRENT DATE, CURRENT TIME);
    INSERT INTO TBDEVISE VALUES
    ('JPY', 134.234, 138.525,CURRENT DATE, CURRENT TIME);
    INSERT INTO TBDEVISE VALUES
    ('GBP', 0.854,   0.905  ,CURRENT DATE, CURRENT TIME);
    INSERT INTO TBDEVISE VALUES
    ('CHF', 0.985,   0.991  ,CURRENT DATE, CURRENT TIME);
/*
