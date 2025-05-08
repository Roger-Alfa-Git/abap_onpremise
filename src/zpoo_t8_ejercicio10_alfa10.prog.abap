*&---------------------------------------------------------------------*
*& Report ZPOO_T8_EJERCICIO10_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t8_ejercicio10_alfa10.

CLASS lcx_no_date DEFINITION INHERITING FROM cx_static_check.

ENDCLASS.

CLASS lcx_format_unknown DEFINITION INHERITING FROM cx_static_check.

ENDCLASS.

CLASS lcl_date_analyze DEFINITION.
  PUBLIC SECTION.
    METHODS: analyze_date   IMPORTING previous TYPE REF TO cx_root OPTIONAL RAISING lcx_no_date,
      analyze_format IMPORTING previous TYPE REF TO cx_root RAISING lcx_format_unknown.
ENDCLASS.

CLASS lcl_date_analyze IMPLEMENTATION.
  METHOD analyze_date.
    RAISE EXCEPTION TYPE lcx_no_date
      EXPORTING
*       textid   =
        previous = previous.
  ENDMETHOD.

  METHOD analyze_format.
    RAISE EXCEPTION TYPE lcx_format_unknown
      EXPORTING
*       textid   =
        previous = previous.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: go_date_analyze    TYPE REF TO lcl_date_analyze,
        gcx_no_date        TYPE REF TO lcx_no_date,
        gcx_format_unknown TYPE REF TO lcx_format_unknown.

  CREATE OBJECT go_date_analyze.
  TRY.
      TRY.
          go_date_analyze->analyze_date(  ).
        CATCH lcx_no_date INTO gcx_no_date.
          go_date_analyze->analyze_format( previous = gcx_no_date ).
      ENDTRY.
    CATCH lcx_format_unknown INTO gcx_format_unknown.
      gcx_format_unknown->get_text( ).
  ENDTRY.
