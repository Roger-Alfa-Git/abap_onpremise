*&---------------------------------------------------------------------*
*& Report ZPOO_STATIC_EVENTS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_static_events_alfa10.

CLASS cl_mail DEFINITION.
  PUBLIC SECTION.
    CLASS-EVENTS new_mail EXPORTING VALUE(subject) TYPE string.
    CLASS-METHODS check_mails.
ENDCLASS.

CLASS cl_mail IMPLEMENTATION.
  METHOD check_mails.
    WRITE / 'Aviso nuevo correo electronico - evento levantado'.
    RAISE EVENT new_mail EXPORTING subject = 'Oferta de trabajo programador abap'.
  ENDMETHOD.
ENDCLASS.

CLASS cl_smtp_alfa10 DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS on_new_mail FOR EVENT new_mail OF cl_mail IMPORTING subject.
ENDCLASS.

CLASS cl_smtp_alfa10 IMPLEMENTATION.
  METHOD on_new_mail.
    WRITE: / 'Nuevo correo electronico....',subject.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  SET HANDLER cl_smtp_alfa10=>on_new_mail.

  cl_mail=>check_mails( ).

  DATA: gr_mail_1 TYPE REF TO cl_mail,
        gr_mail_2 TYPE REF TO cl_mail.

  CREATE OBJECT: gr_mail_1,gr_mail_2.

  gr_mail_1->check_mails( ).

  gr_mail_2->check_mails( ).
