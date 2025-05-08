TYPE-POOL zfa10 .

CONSTANTS: zfa10_tarifa_tecnico       TYPE i VALUE 80,
           zfa10_tarifa_programador   TYPE i VALUE 100,
           zfa10_tarifa_analista      TYPE i VALUE 150,
           zfa10_tarifa_jefe_proyecto TYPE i VALUE 200.

TYPES: BEGIN OF zfa10_tipo_cntr,
         tipo_cntr TYPE ztipo_cntr_alfa10,
         horas_sem TYPE i,
         dias_vac  TYPE i,
       END OF zfa10_tipo_cntr.
