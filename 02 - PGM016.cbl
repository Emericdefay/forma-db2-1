      *****************************************************************
      * Program name:    PGM016                               
      * Original author: DEFAY E.                                
      *
      * Maintenence Log                                              
      * Date      Author        Maintenance Requirement               
      * --------- ------------  --------------------------------------- 
      * 07/12/22  IBMUSER       Created for COBOL class         
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM016.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  07/12/22. 
       DATE-COMPILED. 07/12/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL. 
           SELECT FILEIN ASSIGN TO FILEIN
           FILE STATUS IS FS-FILEIN.
      *****************************************************************
       DATA DIVISION.
      *****************************************************************
       FILE SECTION.
       FD  FILEIN RECORDING MODE F
           RECORD CONTAINS 80 CHARACTERS.
       01  ENREG-FMDEVISE. 
           10 FM-CDEV        PIC X(03).
           10 FM-MTACHAT     PIC S9(03)V9(03) USAGE COMP-3. 
           10 FM-MTVENTE     PIC S9(03)V9(03) USAGE COMP-3.
           10 FILLER         PIC X(65).

      *****************************************************************
       WORKING-STORAGE SECTION.
      / FILES STATUS
       01 FS-FILEIN PIC X(2).
           88 END-FILEIN VALUE '10'.
       
       01 FILLER.
           10 WS-CDEV        PIC X(03).
           10 WS-MTACHAT     PIC S9(03)V9(03) USAGE COMP-3. 
           10 WS-MTVENTE     PIC S9(03)V9(03) USAGE COMP-3.

      / IMPORT SQLCA
           EXEC SQL INCLUDE SQLCA 
           END-EXEC.

      / DECLARATIONS DCLGEN(PGM016)
           EXEC SQL INCLUDE DBCTBD
           END-EXEC.

      /
      *****************************************************************
      *  Program : Setup, run main routine and exit.
      *    
      *    Main purpose
      *    - 0xx : Input/Output section
      *    - 1xx : Main element
      *    - 2xx : Verifications   
      *    - 5xx : SQL Handling
      *    - 9xx : Close files
      *
      *    Input/Output managment
      *    - x1x : Perform a READ
      *    - x2x : Perform a WRITE
      *    - x3x : Perform a FETCH
      *    - x5x : Perform Comparisons
      *    - x7x : Perform a UPDATE
      *    - x9x : Perform a CLOSE
      *
      *    Specials
      *    -  xxx : OTHERS
      *    - Dxxx : Displays
      *****************************************************************
       
       PROCEDURE DIVISION.
           PERFORM 000-OFILES.
           PERFORM 100-Main.
           PERFORM 999-CFILES.
           GOBACK.

       000-OFILES.
           OPEN INPUT FILEIN
           .

       100-Main.
      **********************************************************
      *  Main routine, getting values from filein
      *  Then fetch SQL
      *  Then update value
           PERFORM 210-Read-File
           PERFORM UNTIL (END-FILEIN)
      *        PERFORM 500-Cursor-Open-Rtn
               PERFORM 570-Update-Table
      *        PERFORM 590-Cursor-Close-Rtn
               PERFORM 210-Read-File
           END-PERFORM
           .

       210-Read-File.
      **********************************************************
      *  This routine should read file line by line
           READ FILEIN
           .
      
       570-Update-Table.
      **********************************************************
      *  This routine should update mtachat, mtvente of cursor
           DISPLAY FM-CDEV    ' - '
                   FM-MTACHAT ' - '
                   FM-MTVENTE  
      * DON'T FORGET TO MOVE FILE VALUES TO WS VALUES
           MOVE FM-MTACHAT TO WS-MTACHAT
           MOVE FM-MTVENTE TO WS-MTVENTE
           MOVE FM-CDEV    TO WS-CDEV

           EXEC SQL
              UPDATE TBDEVISE 
              SET CDEV=:WS-CDEV,
                  MTACHAT=:WS-MTACHAT,
                  MTVENTE=:WS-MTVENTE,
                  DDMAJ=CURRENT DATE,
                  HDMAJ=CURRENT TIME
              WHERE CDEV=:WS-CDEV
           END-EXEC
           PERFORM D550-CHECKSQL
           .

       999-CFILES.
      **********************************************************
      *  This routine should close file(s)
           CLOSE FILEIN
           .

       D550-CHECKSQL.
      **********************************************************
      *  Check SQLCODE
           EVALUATE SQLCODE
              WHEN ZERO
                 CONTINUE
              WHEN +100
                 DISPLAY 'END QUERY'
              WHEN OTHER
                 PERFORM D520-DBERROR
           END-EVALUATE
           .
   
       D520-DBERROR.
      **********************************************************
      *  DB2 Error Handling Routine
           DISPLAY '*************************************************'
           DISPLAY '**** E R R O R M E S S A G E S               ****'
           DISPLAY '*************************************************'
           DISPLAY '* Problem in paragraph: ' SQLERRML 
           DISPLAY '* Problem-msg: ' SQLERRMC 
           DISPLAY '*'
           DISPLAY '* SQLCODE: ' SQLCODE
           DISPLAY '*************************************************'
           STOP RUN
           .