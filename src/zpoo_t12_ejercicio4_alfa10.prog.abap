*&---------------------------------------------------------------------*
*& Report ZPOO_T12_EJERCICIO4_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t12_ejercicio4_alfa10.

CLASS lcl_blog DEFINITION.
  PUBLIC SECTION.
    METHODS: enviar_notificacion IMPORTING notifiacion TYPE string.
    EVENTS: notificacion EXPORTING VALUE(aviso) TYPE string.
  PRIVATE SECTION.
    DATA: notificacion_aviso TYPE string.
ENDCLASS.

CLASS lcl_blog IMPLEMENTATION.
  METHOD enviar_notificacion.
    notificacion_aviso = notifiacion.
    SKIP 1.
    WRITE: / 'Notificacion en proceso...............', notificacion_aviso.
    RAISE EVENT notificacion
      EXPORTING
        aviso  = notificacion_aviso.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_observador DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: on_notificacion ABSTRACT FOR EVENT notificacion OF lcl_blog IMPORTING aviso.
ENDCLASS.

CLASS lcl_administrador DEFINITION INHERITING FROM lcl_observador.
  PUBLIC SECTION.
    METHODS: on_notificacion REDEFINITION.
ENDCLASS.

CLASS lcl_administrador IMPLEMENTATION.
  METHOD on_notificacion.
    WRITE: / 'Notificacion al Administrador.........', aviso.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_usuarios DEFINITION INHERITING FROM lcl_administrador.
  PUBLIC SECTION.
    METHODS: on_notificacion REDEFINITION.
ENDCLASS.

CLASS lcl_usuarios IMPLEMENTATION.
  METHOD on_notificacion.
    WRITE: / 'Notificacion a todos los usuarios.....', aviso.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_blog         TYPE REF TO lcl_blog,
        gr_admnistrador TYPE REF TO lcl_administrador,
        gr_usuarios     TYPE REF TO lcl_usuarios,
        gv_aviso        TYPE string.

  CREATE OBJECT: gr_blog,
                 gr_admnistrador,
                 gr_usuarios.

  SET HANDLER: gr_admnistrador->on_notificacion FOR gr_blog,
               gr_usuarios->on_notificacion FOR gr_blog.

  gv_aviso = 'Nuevo aviso: Hoy evento a las 2 de la tarde en Tenancingo centro'.

  gr_blog->enviar_notificacion( notifiacion = gv_aviso ).
