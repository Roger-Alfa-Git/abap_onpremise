*&---------------------------------------------------------------------*
*& Report ZPOO_09_CLASS_CONST_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_09_class_const_alfa10.

CLASS cl_foto DEFINITION.

  PUBLIC SECTION.

    CONSTANTS: png TYPE char3 VALUE 'PNG',
               jpg TYPE char3 VALUE 'JPG',
               bmp TYPE char3 VALUE 'BMP'.

ENDCLASS.

START-OF-SELECTION.

  DATA: gv_formato_foto TYPE char3.

  gv_formato_foto = cl_foto=>bmp.

  WRITE: / gv_formato_foto,
         / cl_foto=>jpg.
