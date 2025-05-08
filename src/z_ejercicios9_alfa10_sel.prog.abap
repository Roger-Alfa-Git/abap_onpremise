*&---------------------------------------------------------------------*
*& Include          Z_EJERCICIOS9_ALFA10_SEL
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK block4 WITH FRAME TITLE TEXT-b04.

  SELECTION-SCREEN BEGIN OF BLOCK block5 WITH FRAME TITLE TEXT-b05.

    PARAMETERS: p_create RADIOBUTTON GROUP bbdd , "Create
                p_read   RADIOBUTTON GROUP bbdd, "Read
                p_update RADIOBUTTON GROUP bbdd DEFAULT 'X', "Update
                p_delete RADIOBUTTON GROUP bbdd, "Delete
                p_modify RADIOBUTTON GROUP bbdd. "Modify
  SELECTION-SCREEN END OF BLOCK block5.

  SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-b01.
    PARAMETERS: p_soc    TYPE bukrs OBLIGATORY,
                p_ejer   TYPE n LENGTH 4 OBLIGATORY,
                p_perio  TYPE n LENGTH 2 OBLIGATORY,
                p_usario TYPE c LENGTH 12.
  SELECTION-SCREEN END OF BLOCK block1.
  SELECTION-SCREEN SKIP.
*&---------------------------------------------------------------------*
*& EJERCICIO 9.5
*&---------------------------------------------------------------------*

  SELECTION-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE TEXT-b02.

    PARAMETERS: p_acre RADIOBUTTON GROUP bupa,
                p_deud RADIOBUTTON GROUP bupa.

    SELECTION-SCREEN BEGIN OF LINE.

      PARAMETERS p_test  AS CHECKBOX.
      SELECTION-SCREEN COMMENT (22) c_test.

      PARAMETERS p_notif AS CHECKBOX DEFAULT 'X'.
      SELECTION-SCREEN COMMENT (22) c_notif.

    SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN END OF BLOCK block2.

  SELECTION-SCREEN SKIP.
*&---------------------------------------------------------------------*
*& EJERCICIO 9.7
*&---------------------------------------------------------------------*

  SELECTION-SCREEN BEGIN OF BLOCK block3 WITH FRAME TITLE TEXT-b03.

    SELECT-OPTIONS: s_cuenta FOR bsik-lifnr,
                    s_clase FOR bsik-umsks,
                    s_fecha FOR bsik-augdt,
                    s_doc FOR bsik-belnr.
    SELECTION-SCREEN SKIP.

  SELECTION-SCREEN END OF BLOCK block3.

SELECTION-SCREEN END OF BLOCK block4.
