FUNCTION z_mf_materiales_alfa10.
*"----------------------------------------------------------------------
*"*"Interfase local
*"  IMPORTING
*"     REFERENCE(DATE_FROM) TYPE  SYDATUM
*"     REFERENCE(DATE_TO) TYPE  SYDATUM
*"  TABLES
*"      TI_MATERIALES STRUCTURE  MARA OPTIONAL
*"  EXCEPTIONS
*"      EX_SIN_MATERIALES
*"----------------------------------------------------------------------
  DATA lwa_materiales TYPE mara.

  SELECT * FROM mara
    INTO TABLE ti_materiales
    WHERE ersda GT date_from AND ersda LE date_to.

  IF sy-subrc EQ 0.

    LOOP AT ti_materiales INTO lwa_materiales.
      WRITE / lwa_materiales-matnr.
    ENDLOOP.

  ELSEIF sy-subrc NE 0.
    RAISE ex_sin_materiales.
  ENDIF.

ENDFUNCTION.
