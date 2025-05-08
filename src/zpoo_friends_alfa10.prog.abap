*&---------------------------------------------------------------------*
*& Report ZPOO_FRIENDS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_friends_alfa10.

CLASS centro_ventas DEFINITION.
  PUBLIC SECTION.
    METHODS: ver_producto_almacen,
      generar_pedido IMPORTING producto TYPE string.

ENDCLASS.

CLASS almacen DEFINITION FRIENDS centro_ventas.

  PRIVATE SECTION.
    CLASS-DATA: producto TYPE string VALUE 'Monitor DELL 27" LED'.

    METHODS: crear_pedido IMPORTING producto TYPE string.
ENDCLASS.


CLASS centro_ventas IMPLEMENTATION.

  METHOD ver_producto_almacen.
    WRITE almacen=>producto.
  ENDMETHOD.

  METHOD generar_pedido.
    DATA: lr_almacen TYPE REF TO almacen.

    CREATE OBJECT lr_almacen.

    lr_almacen->crear_pedido( producto = producto ).
  ENDMETHOD.

ENDCLASS.

CLASS almacen IMPLEMENTATION.
  METHOD crear_pedido.
    WRITE: / 'Se ha creado el pedido ',producto.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_centro_ventas TYPE REF TO centro_ventas.

  CREATE OBJECT gr_centro_ventas.

  gr_centro_ventas->ver_producto_almacen( ).

  gr_centro_ventas->generar_pedido( producto = 'Monitor HP 22 FULL-HD' ).
