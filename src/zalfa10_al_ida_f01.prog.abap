*&---------------------------------------------------------------------*
*& Include          ZALFA10_AL_IDA_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form init_2000
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_2000 .

  DATA(lo_collector) = NEW cl_salv_range_tab_collector( ).


  IF go_cust_cont IS NOT BOUND.

    go_cust_cont = NEW #( 'ALV_CONT' ).

    go_alv_display = cl_salv_gui_table_ida=>create( iv_table_name = 'SFLIGHT'
                                                    io_gui_container      = go_cust_cont ).

    lo_collector->add_ranges_for_name( iv_name = 'CARRID'
                                        it_ranges = so_carid[] ).

    lo_collector->add_ranges_for_name( iv_name = 'CONNID'
                                        it_ranges = so_conid[] ).

    lo_collector->add_ranges_for_name( iv_name = 'FLDATE'
                                        it_ranges = so_date[] ).

    lo_collector->get_collected_ranges( importing et_named_ranges = data(lt_name_ranges) ).

    go_alv_display->set_select_options( lt_name_ranges ).


  ENDIF.

ENDFORM.
