*&---------------------------------------------------------------------*
*& Report Z23_SEL_PACKAGE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z23_sel_package_alfa10.
DATA: gt_company  TYPE SORTED TABLE OF zscarr_alfa10
      WITH NON-UNIQUE KEY carrid,
      gwa_company TYPE zscarr_alfa10.

SELECT * FROM zscarr_alfa10 INTO TABLE gt_company
   PACKAGE SIZE 2.

  LOOP AT gt_company INTO gwa_company.
    WRITE: / gwa_company-carrid,gwa_company-carrname.
  ENDLOOP.
  SKIP 1.

ENDSELECT.

**////////Ejercicio del video/////////////////////////////////////////////////////////
*DATA: gt_flight  TYPE SORTED TABLE OF zspfli_alfa10
*      WITH NON-UNIQUE KEY carrid connid,
*      gwa_flight TYPE zspfli_alfa10.
*
*SELECT * FROM zspfli_alfa10 INTO TABLE gt_flight
*   PACKAGE SIZE 3.
*
*  LOOP AT gt_flight INTO gwa_flight.
*    WRITE: / gwa_flight-connid,gwa_flight-carrid.
*  ENDLOOP.
*  SKIP 1.
*
*ENDSELECT.
