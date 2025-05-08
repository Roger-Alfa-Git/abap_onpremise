class ZCL_ASSIT_MATERIAL_ALFA10 definition
  public
  inheriting from CL_WD_COMPONENT_ASSISTANCE
  create public .

public section.

  constants CTEXT_BUTTON_NEXT type STRING value 'NEXT' ##NO_TEXT.
  constants CTEXT_BUTTON_FINISH type STRING value 'FINISH' ##NO_TEXT.

  methods GET_COMPANY_DETAILS
    returning
      value(RS_COMPANY_DETAILS) type ZST_MATE_HEADER .
  methods GET_MATERIAL_REPORT
    returning
      value(RT_MATERIAL_REPORT) type ZTT_MATERIAL_DATA_FA10 .
  methods GET_ROAD_INFO
    returning
      value(RS_ROADMAP_INFO) type ZST_ROADMAP_FA10 .
  methods GET_MATERIAL_PANEL_LIST
    returning
      value(RT_MATERIAL_PANEL_LIST) type ZTT_MATERIAL_HEADER .
  methods DELETE_MATERIAL
    importing
      !IV_MATERIAL_ID type ZDE_MATERIAL_ID_FA10
    returning
      value(RV_PROCESS_OK) type ABAP_BOOL .
  methods INSERT_MATERIAL
    changing
      !CS_MATERIAL type ZST_MATERIAL_DATA_FA10
    returning
      value(RV_PROCESS_OK) type ABAP_BOOL .
  methods UPDATE_MATERIAL
    importing
      !CS_MATERIAL type ZST_MATERIAL_DATA_FA10
    returning
      value(RV_PROCESS_OK) type ABAP_BOOL .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ASSIT_MATERIAL_ALFA10 IMPLEMENTATION.


  METHOD delete_material.
    DELETE FROM zwarehousemate10 WHERE material_id EQ iv_material_id.
    IF sy-subrc EQ 0.
      DELETE FROM zwarehousedata10 WHERE material_id EQ iv_material_id.
      IF sy-subrc EQ 0.
        rv_process_ok = abap_true.
      ELSE.
        rv_process_ok = abap_false.
      ENDIF.
    ELSE.
      rv_process_ok = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD get_company_details.
    SELECT SINGLE * FROM zwarehousecomp10
      INTO @DATA(ls_company_details)
      WHERE comp_code EQ 'BUKR'.

    IF sy-subrc EQ 0.
      MOVE-CORRESPONDING ls_company_details TO rs_company_details.
    ENDIF.
  ENDMETHOD.


  METHOD get_material_panel_list.
    SELECT FROM zwarehousemate10
      FIELDS material_id, description
      WHERE material_id NE @space
      ORDER BY material_id DESCENDING
      INTO TABLE @rt_material_panel_list.
  ENDMETHOD.


  METHOD get_material_report.
    SELECT * FROM zwarehousedata10 AS data
          INNER JOIN zwarehousemate10 AS mate
      ON data~material_id EQ mate~material_id
      ORDER BY data~material_id DESCENDING
      INTO CORRESPONDING FIELDS OF TABLE @rt_material_report.
  ENDMETHOD.


  METHOD get_road_info.
    SELECT * FROM zwarehouseroad10
      INTO TABLE @DATA(lt_roadmap_info)
      WHERE language EQ @sy-langu
      ORDER BY step_id ASCENDING.

    IF sy-subrc EQ 0.
      LOOP AT lt_roadmap_info ASSIGNING FIELD-SYMBOL(<ls_roadmap_info>).
        CASE sy-tabix.
          WHEN 1.
            rs_roadmap_info-step_1_id = <ls_roadmap_info>-step_id.
            rs_roadmap_info-step_1_desc = <ls_roadmap_info>-step_desc.
            rs_roadmap_info-step_1_name = <ls_roadmap_info>-step_name.
            rs_roadmap_info-step_1_enabled = <ls_roadmap_info>-enabled.
            rs_roadmap_info-step_1_tooltip = <ls_roadmap_info>-tooltip.
            rs_roadmap_info-step_1_visibility = <ls_roadmap_info>-visibility.

          WHEN 2.
            rs_roadmap_info-step_2_id = <ls_roadmap_info>-step_id.
            rs_roadmap_info-step_2_desc = <ls_roadmap_info>-step_desc.
            rs_roadmap_info-step_2_name = <ls_roadmap_info>-step_name.
            rs_roadmap_info-step_2_enabled = <ls_roadmap_info>-enabled.
            rs_roadmap_info-step_2_tooltip = <ls_roadmap_info>-tooltip.
            rs_roadmap_info-step_2_visibility = <ls_roadmap_info>-visibility.

          WHEN 3.
            rs_roadmap_info-step_3_id = <ls_roadmap_info>-step_id.
            rs_roadmap_info-step_3_desc = <ls_roadmap_info>-step_desc.
            rs_roadmap_info-step_3_name = <ls_roadmap_info>-step_name.
            rs_roadmap_info-step_3_enabled = <ls_roadmap_info>-enabled.
            rs_roadmap_info-step_3_tooltip = <ls_roadmap_info>-tooltip.
            rs_roadmap_info-step_3_visibility = <ls_roadmap_info>-visibility.

        ENDCASE.
      ENDLOOP.
      rs_roadmap_info-visibility = '02'.
      rs_roadmap_info-current_step_id = rs_roadmap_info-step_1_id.
      rs_roadmap_info-next_but_text = ctext_button_next.
    ENDIF.
  ENDMETHOD.


  METHOD insert_material.

    DATA: ls_wh_data TYPE  zwarehousedata10,
          ls_wh_mate TYPE  zwarehousemate10.

    SELECT SINGLE FROM zwarehousedata10
      FIELDS MAX( material_id )
      INTO @DATA(lv_max_mate_id).

    ADD 1 TO lv_max_mate_id.

    MOVE-CORRESPONDING cs_material TO ls_wh_data.

    INSERT zwarehousedata10 FROM ls_wh_data.

    IF sy-subrc EQ 0.

      MOVE-CORRESPONDING cs_material TO ls_wh_mate.

      ls_wh_mate-language = sy-langu.

      INSERT zwarehousemate10 FROM ls_wh_mate.

      IF sy-subrc EQ 0.
        rv_process_ok = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD update_material.

    DATA: ls_matdata TYPE zwarehousedata10,
          ls_mate    TYPE zwarehousemate10.

    MOVE-CORRESPONDING cs_material TO ls_matdata.
    MOVE-CORRESPONDING cs_material TO ls_mate.

    UPDATE zwarehousedata10 FROM ls_matdata.
    IF sy-subrc EQ 0.
      UPDATE zwarehousemate10 FROM ls_mate.
      rv_process_ok = abap_true.
      IF sy-subrc EQ 0.
        rv_process_ok = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
