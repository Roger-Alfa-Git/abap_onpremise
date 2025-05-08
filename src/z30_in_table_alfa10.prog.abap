*&---------------------------------------------------------------------*
*& Report Z30_IN_TABLE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30_in_table_alfa10.

DATA: gt_flight    TYPE STANDARD TABLE OF zsflight_alfa10,
      gr_currency  TYPE RANGE OF s_currcode,
      gwa_currency LIKE LINE OF gr_currency.

TYPES: BEGIN OF ty_range_s_price,
         sign   TYPE c LENGTH 1,
         option TYPE c LENGTH 2,
         p_low  TYPE s_price,
         p_high TYPE s_price,
       END OF ty_range_s_price.

DATA: gr_price  TYPE TABLE OF ty_range_s_price,
      gwa_price TYPE ty_range_s_price.

gwa_price-sign = 'I'.
gwa_price-option = 'BT'.
gwa_price-p_low = '500'.
gwa_price-p_high = '1500'.
APPEND gwa_price TO gr_price.

gwa_currency-sign = 'E'.
gwa_currency-option = 'NE'.
gwa_currency-low = 'EUR'.
APPEND gwa_currency TO gr_currency.

SELECT * FROM zsflight_alfa10
  INTO TABLE gt_flight
  WHERE price IN gr_price
  AND currency IN gr_currency.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_flight ).
ENDIF.

*//////Codigo del video//////////////////////////////////////////////////////
*DATA: gt_plane   TYPE STANDARD TABLE OF zsaplane_alfa10,
*      gr_weight  TYPE RANGE OF s_plan_wei,
*      gwa_weight LIKE LINE OF gr_weight.
*
*TYPES: BEGIN OF ty_range_s_seatsmax,
*         sign   TYPE c LENGTH 1,
*         option TYPE c LENGTH 2,
*         low    TYPE s_seatsmax,
*         high   TYPE s_seatsmax,
*       END OF ty_range_s_seatsmax.
*
*DATA: gr_seatsmax  TYPE TABLE OF ty_range_s_seatsmax,
*      gwa_seatsmax TYPE ty_range_s_seatsmax.
*
*gwa_seatsmax-sign = 'I'.
*gwa_seatsmax-option = 'BT'.
*gwa_seatsmax-low = '100'.
*gwa_seatsmax-high = '200'.
*APPEND gwa_seatsmax TO gr_seatsmax.
*
*gwa_weight-sign = 'E'.
*gwa_weight-option = 'EQ'.
*gwa_weight-low = '25458'.
*APPEND gwa_weight TO gr_weight.
*
*SELECT * FROM zsaplane_alfa10
*  INTO TABLE gt_plane
*  WHERE seatsmax IN gr_seatsmax
*  AND weight IN gr_weight.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_plane ).
*ENDIF.


*DATA: gt_plane TYPE STANDARD TABLE OF saplane,
*      gt_t     TYPE standard TABLE OF zsaplane_alfa10.
*
*SELECT * FROM saplane
*  INTO TABLE gt_plane.
*
*MOVE-CORRESPONDING gt_plane TO gt_t.
*
*INSERT zsaplane_alfa10 from TABLE gt_t.
*
*IF sy-subrc EQ 0.
*  WRITE: / 'GGS' .
*ENDIF.
