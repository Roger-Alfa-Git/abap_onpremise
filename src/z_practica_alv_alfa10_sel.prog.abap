*&---------------------------------------------------------------------*
*& Include          Z_PRACTICA_ALV_ALFA10_SEL
*&---------------------------------------------------------------------*

TABLES sflight.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: basicbtn RADIOBUTTON GROUP btn USER-COMMAND test DEFAULT 'X',
              advanbtn RADIOBUTTON GROUP btn.

  SELECT-OPTIONS: so_carri FOR sflight-carrid,
                  so_conni FOR sflight-connid,
                  so_fldat FOR sflight-fldate.
  SELECT-OPTIONS: so_price FOR sflight-price MODIF ID b3,
                  so_curre FOR sflight-currency MODIF ID b3,
                  so_plant FOR sflight-planetype MODIF ID b3.
SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN OUTPUT.

  IF basicbtn = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'B3'.
        screen-active = '0'.
        REFRESH: so_price, so_curre, so_plant.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ELSEIF advanbtn = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'B3'.
        screen-active = '1'.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.
