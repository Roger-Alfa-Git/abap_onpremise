*&---------------------------------------------------------------------*
*& Report ZVIST_SUP_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvist_sup_alfa10.

DATA: ls_emple TYPE  zevs_empe_alfa10.

ls_emple-num_dir = 3.

ls_emple-nombre = 'Carlos'.

INSERT zevs_empe_alfa10 FROM ls_emple.

IF sy-subrc EQ 0.
  WRITE 'Registro insertado'.
ENDIF.
