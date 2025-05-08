*&---------------------------------------------------------------------*
*& Report ZPOO_05_METODOS_FUNC_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_05_metodos_func_alfa10.


CLASS verificar DEFINITION.

  PUBLIC SECTION.

    METHODS sociedad IMPORTING i_sociedad    TYPE bukrs
                     RETURNING VALUE(existe) TYPE abap_bool.


ENDCLASS.

CLASS verificar IMPLEMENTATION.
  METHOD sociedad.
    DATA: lv_soc TYPE bukrs.

    SELECT SINGLE bukrs FROM t001
      INTO lv_soc
      WHERE bukrs EQ i_sociedad.

    IF sy-subrc EQ 0.
      existe = abap_true.
    ELSE.
      existe = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS formula DEFINITION.
  PUBLIC SECTION.

    CLASS-METHODS media_aritmetica IMPORTING numero_1     TYPE i
                                             numero_2     TYPE i
                                             numero_3     TYPE i
                                   RETURNING VALUE(media) TYPE i.
ENDCLASS.

CLASS formula IMPLEMENTATION.

  METHOD media_aritmetica.
    media = ( numero_1 + numero_2 + numero_3 ) / 3.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_verificar TYPE REF TO verificar,
        gv_existe    TYPE abap_bool.

  CREATE OBJECT gr_verificar.

  "  CALL METHOD gr_verificar->sociedad
  "   EXPORTING
  "    i_sociedad = '1000'
  " RECEIVING
  "  existe     = gv_existe.

  IF gr_verificar->sociedad( i_sociedad = '1000' ) EQ abap_true.
    MESSAGE 'La sociedad existe' TYPE 'I'.
  ELSE.
    MESSAGE 'La sociedad No existe' TYPE 'I'.
  ENDIF.

  WRITE: 'La media aritmetica es de: ', formula=>media_aritmetica(
          numero_1 = 3
          numero_2 = 4
          numero_3 = 5
        ).
