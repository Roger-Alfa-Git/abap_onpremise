*&---------------------------------------------------------------------*
*& Include z_practica_alv_2_alfa10_sel
*&---------------------------------------------------------------------*

TABLES: sflight,spfli,scarr,t005,t005t,sairport.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_carri FOR scarr-carrid NO INTERVALS NO-EXTENSION,
                  so_conni FOR spfli-connid NO INTERVALS NO-EXTENSION,
                  so_coufr FOR spfli-countryfr NO INTERVALS NO-EXTENSION,
                  so_couto FOR spfli-countryto NO INTERVALS NO-EXTENSION.


SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN ON: so_coufr, so_couto, so_carri, so_conni.
  DATA: lt_match_result TYPE match_result_tab.
  DATA: l_matches TYPE i.
  DATA: str TYPE string.

  IF so_coufr IS NOT INITIAL .
    str = so_coufr-low.
    FIND ALL OCCURRENCES OF REGEX '^[A-Za-z]+$' IN str
            IN CHARACTER MODE RESPECTING CASE
            MATCH COUNT l_matches RESULTS lt_match_result.

    IF l_matches LE 0.
      MESSAGE i000(0k) WITH 'Solo letras en este campo' DISPLAY LIKE 'A'.
      REFRESH so_coufr.
      avanzar1 = abap_false.
    ELSE.
      avanzar1 = abap_true.
    ENDIF.
  ELSE.
    avanzar1 = abap_true.
  ENDIF.

  IF so_couto IS NOT INITIAL .
    str = so_couto-low.
    FIND ALL OCCURRENCES OF REGEX '^[A-Za-z]+$' IN str
          IN CHARACTER MODE RESPECTING CASE
          MATCH COUNT l_matches RESULTS lt_match_result.
    IF l_matches LE 0.
      MESSAGE i000(0k) WITH 'Solo letras en este campo' DISPLAY LIKE 'I'.
      REFRESH so_couto.
      avanzar2 = abap_false.
    ELSE.
      avanzar2 = abap_true.
    ENDIF.
  ELSE.
    avanzar2 = abap_true.
  ENDIF.

  IF so_carri IS NOT INITIAL.
    str = so_carri-low.
    FIND ALL OCCURRENCES OF REGEX '^[A-Za-z]+$' IN str
        IN CHARACTER MODE RESPECTING CASE
        MATCH COUNT l_matches RESULTS lt_match_result.
    IF l_matches LE 0.
      MESSAGE i000(0k) WITH 'Solo letras en este campo' DISPLAY LIKE 'I'.
      REFRESH so_carri.
      avanzar3 = abap_false.
    ELSE.
      avanzar3 = abap_true.
    ENDIF.
  ELSE.
    avanzar3 = abap_true.
  ENDIF.

  IF so_conni-low IS NOT INITIAL.
    str = so_conni-low.
    FIND ALL OCCURRENCES OF REGEX '^[0-9]+$' IN str
        IN CHARACTER MODE RESPECTING CASE
        MATCH COUNT l_matches RESULTS lt_match_result.
    IF l_matches LE 0.
      MESSAGE i000(0k) WITH 'Solo numeros en este campo' DISPLAY LIKE 'I'.
      REFRESH so_carri.
      avanzar4 = abap_false.
    ELSE.
      avanzar4 = abap_true.
    ENDIF.
  ELSE.
    avanzar4 = abap_true.
  ENDIF.
