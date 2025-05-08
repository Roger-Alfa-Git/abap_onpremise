*&---------------------------------------------------------------------*
*& Include z_practica_alv_2_alfa10_top
*&---------------------------------------------------------------------*

TYPE-POOLS slis.

DATA: gt_table    TYPE STANDARD TABLE OF zdataflightalfa10,
      gt_table2   TYPE STANDARD TABLE OF zdataflighttablealfa10,
      gt_fieldcat TYPE TABLE OF slis_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv,
      gs_table    TYPE zdataflightalfa10,
      gs_table2   TYPE zdataflighttablealfa10.
DATA: go_salv_table TYPE REF TO cl_salv_table,
      avanzar1      TYPE abap_bool,
      avanzar2      TYPE abap_bool,
      avanzar3      TYPE abap_bool,
      avanzar4      TYPE abap_bool.
DATA: gv_confirm TYPE abap_bool.
