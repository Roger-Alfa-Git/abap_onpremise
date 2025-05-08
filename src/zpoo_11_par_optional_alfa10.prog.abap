*&---------------------------------------------------------------------*
*& Report ZPOO_11_PAR_OPTIONAL_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_11_par_optional_alfa10.

CLASS acceso_empresa DEFINITION.

  PUBLIC SECTION.

    METHODS crear_autorizacion IMPORTING entrada_principal TYPE string OPTIONAL
                                         edificio_sur      TYPE string OPTIONAL
                                         edificio_norte    TYPE string OPTIONAL.

ENDCLASS.


CLASS acceso_empresa IMPLEMENTATION.

  METHOD crear_autorizacion.

    WRITE: / 'Accesos: ',
           / entrada_principal,
           / edificio_sur,
           / edificio_norte.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_acceso TYPE REF TO acceso_empresa.

  CREATE OBJECT gr_acceso.

  IF gr_acceso IS BOUND.
    gr_acceso->crear_autorizacion(
      EXPORTING
        entrada_principal = 'Entrada Principal Acceso Permitido'
        edificio_sur      = 'Edificio Sur Acceso Permitido'
        edificio_norte    = 'Edificio Norte Acceso permitido'
    ).
  ENDIF.
