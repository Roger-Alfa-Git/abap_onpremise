*&---------------------------------------------------------------------*
*& Report Z33_MIN_MAX_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z33_min_max_alfa10.

DATA: gv_reserva_min TYPE s_sum,
      gv_reserva_max TYPE s_sum.

SELECT MIN( paymentsum ) FROM zsflight_alfa10
  INTO gv_reserva_min.

SELECT MAX( paymentsum ) FROM zsflight_alfa10
  INTO gv_reserva_max.

WRITE: / 'Numero Minimo: ', gv_reserva_min,
       / 'Numero Maximo: ', gv_reserva_max.

*////////////Ejercicio del video/////////////////////////////////////////////////////////
*DATA: gv_weight_max TYPE s_plan_wei,
*      gv_weight_min TYPE s_plan_wei.
*
*SELECT MAX( weight ) FROM zsaplane_alfa10
*  INTO gv_weight_max.
*
*IF sy-subrc EQ 0.
*  WRITE: / gv_weight_max.
*ENDIF.
*
*SELECT MIN( weight ) FROM zsaplane_alfa10
*  INTO gv_weight_min.
*
*IF sy-subrc EQ 0.
*  WRITE: / gv_weight_min.
*ENDIF.
