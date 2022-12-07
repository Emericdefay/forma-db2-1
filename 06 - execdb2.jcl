//EXEPLAN JOB 'MASTER',                         
//            'MAC',                            
//            CLASS=A,                          
//            MSGCLASS=X,                       
//            NOTIFY=&SYSUID                    
//*=========================================    
// SET RUNLIB=DSN910.DB9G.RUNLIB.LOAD           
// SET LIBLOAD=MASTER.PROG.LOAD        
// SET FILE=FILE016       
// SET FOLDER=MASTER.FILES          
//*=========================================    
//STEP001 EXEC PGM=IKJEFT01                     
//STEPLIB   DD DISP=SHR,DSN=&RUNLIB             
//          DD DISP=SHR,DSN=&LIBLOAD            
//FILEIN    DD DISP=SHR,DSN=&FOLDER(&FILE016)
//SYSTSPRT  DD SYSOUT=*                         
//SYSPRINT  DD SYSOUT=*                         
//SYSTSIN   DD  *                               
 DSN SYSTEM(DB9G)                               
     RUN -                    
        PROGRAM   (PGM016) - 
        PLAN      (PLANCOB)  
     END                      
 END                         
/*                           