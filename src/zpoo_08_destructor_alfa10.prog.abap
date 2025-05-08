*&---------------------------------------------------------------------*
*& Report ZPOO_07_DESTRUCTOR_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_08_destructor_alfa10.

CLASS lcl_writer DEFINITION.
  PUBLIC SECTION.
    METHODS destructor NOT AT END OF MODE.

  PRIVATE SECTION.
    DATA pointer TYPE %_c_pointer.
ENDCLASS.

CLASS lcl_writer IMPLEMENTATION.
  METHOD destructor.
    SYSTEM-CALL C-DESTRUCTOR 'fxkmswrt_CDestr_destroy' USING pointer.
  ENDMETHOD.
ENDCLASS.
