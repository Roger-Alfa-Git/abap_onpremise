*&---------------------------------------------------------------------*
*& Report ZPOO_07_CLASS_TYPES_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_07_class_types_alfa10.

CLASS cl_html DEFINITION.

  PUBLIC SECTION.

    TYPES: BEGIN OF types_extension,
             address TYPE string,
             block   TYPE string,
             center  TYPE string,
             div     TYPE string,
           END OF types_extension.

    DATA: home_index TYPE types_extension.

    METHODS establecer_home_index IMPORTING iv_home_index TYPE types_extension.

ENDCLASS.

CLASS cl_html IMPLEMENTATION.

  METHOD establecer_home_index.
    home_index = iv_home_index.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  "TYPES: BEGIN OF gb_types_extension,
   "        address TYPE string,
    "       block   TYPE string,
     "      center  TYPE string,
      "     div     TYPE string,
       "  END OF gb_types_extension.

  DATA: gr_html TYPE REF TO cl_html,
        gs_html TYPE cl_html=>types_extension.

  gs_html-address = 'http://logalisap.com'.
  gs_html-block = 'cursos'.
  gs_html-center = 'elementos'.
  gs_html-div = 'objetos'.

  CREATE OBJECT gr_html.

  gr_html->establecer_home_index( iv_home_index = gs_html ).

  WRITE: / gr_html->home_index-address,
         / gr_html->home_index-block,
         / gr_html->home_index-center,
         / gr_html->home_index-div.
