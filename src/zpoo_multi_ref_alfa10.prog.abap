*&---------------------------------------------------------------------*
*& Report ZPOO_MULTI_REF_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_multi_ref_alfa10.

CLASS cl_calculo_iva DEFINITION.

  PUBLIC SECTION.

    DATA: iva TYPE decfloat16.
ENDCLASS.


DATA: gr_1 TYPE REF TO cl_calculo_iva,
      gr_2 TYPE REF TO cl_calculo_iva,
      gr_3 TYPE REF TO cl_calculo_iva.

*CREATE OBJECT: gr_1,gr_2,gr_3.

*gr_1->iva = '14.05'.
*gr_2->iva = '24.00'.
*gr_3->iva = '10.00'.

*WRITE: / gr_1->iva,
"      / gr_2->iva,
"     / gr_3->iva.

CREATE OBJECT gr_1.

gr_2 = gr_1.
gr_3 = gr_1.

gr_1->iva = '14.05'.
gr_2->iva = '24.00'.
gr_3->iva = '10.00'.

WRITE: / 'Asignacion sobre la misma referencia',
       / gr_1->iva,
       / gr_2->iva,
       / gr_3->iva.
