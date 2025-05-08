*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*---------------------------INITS--------------------------------------*
*-------------------------INSERT---------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form INIT_4015
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4015 .

  DD = 1.

  SELECT MAX( id_proveedor )
    FROM ztc_proveedores
    INTO ( gv_max ).
  MOVE gv_max TO res.
  res = res + 1.
  MOVE res TO gv_max.

  SELECT FROM ztc_proveedores
    FIELDS *
    INTO TABLE @DATA(ed)."Estoy creando una variable con el unico fin de leer
  READ TABLE ed TRANSPORTING NO FIELDS WITH KEY id_proveedor = res.

  ztc_proveedores-id_proveedor = gv_max.

  CHECK ok_code_4015 IS NOT INITIAL.

  CASE ok_code_4015.
    WHEN 'BTN_RP'.
      CLEAR ok_code_4015.
      PERFORM valid_insert_proveedores.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4016
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4016 .

  DD = 2.

  SELECT MAX( id_empleado )
    FROM ztc_empleados
    INTO ( gv_max ).
  MOVE gv_max TO res.
  res = res + 1.
  MOVE res TO gv_max.

  SELECT FROM ztc_empleados
    FIELDS *
    INTO TABLE @DATA(ed)."Estoy creando una variable con el unico fin de leer
  READ TABLE ed TRANSPORTING NO FIELDS WITH KEY id_empleado = res.

  ztc_empleados-id_empleado = gv_max.

  CHECK ok_code_4016 IS NOT INITIAL.

  CASE ok_code_4016.
    WHEN 'BTN_RP'.
      CLEAR ok_code_4016.
      PERFORM VALID_INSERT_EMPLEADOS.

  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form init_4017
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4017 .

  DD = 3.

  SELECT MAX( ID_CLIENTE )
    FROM ztc_clientes
    INTO ( gv_max ).
  MOVE gv_max TO res.
  res = res + 1.
  MOVE res TO gv_max.

  SELECT FROM ztc_clientes
    FIELDS *
    INTO TABLE @DATA(ed)."Estoy creando una variable con el unico fin de leer
  READ TABLE ed TRANSPORTING NO FIELDS WITH KEY ID_CLIENTE = res.

  ztc_clientes-id_cliente = gv_max.

  CHECK ok_code_4017 IS NOT INITIAL.

  CASE ok_code_4017.
    WHEN 'BTN_RP'.
      CLEAR ok_code_4017.
      PERFORM VALID_INSERT_CLIENTES.

  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form init_4018
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4018 .

  DD = 4.

  SELECT MAX( id_material )
    FROM ztc_materiales
    INTO ( gv_max ).
  MOVE gv_max TO res.
  res = res + 1.
  MOVE res TO gv_max.

  SELECT FROM ztc_materiales
    FIELDS *
    INTO TABLE @DATA(ed)."Estoy creando una variable con el unico fin de leer
  READ TABLE ed TRANSPORTING NO FIELDS WITH KEY id_material = res.

  ztc_materiales-id_material = gv_max.

  CHECK ok_code_4018 IS NOT INITIAL.

  CASE ok_code_4018.
    WHEN 'BTN_RP'.
      CLEAR ok_code_4018.
      PERFORM VALID_INSERT_MATERIALES.
  ENDCASE.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form init_4019
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4019 .

  DD = 5.

  SELECT MAX( id_producto )
    FROM ztc_productos
    INTO ( gv_max ).
  MOVE gv_max TO res.
  res = res + 1.
  MOVE res TO gv_max.

  SELECT FROM ztc_productos
    FIELDS *
    INTO TABLE @DATA(ed)."Estoy creando una variable con el unico fin de leer
  READ TABLE ed TRANSPORTING NO FIELDS WITH KEY id_producto = res.

  ztc_productos-id_producto = gv_max.

  CHECK ok_code_4019 IS NOT INITIAL.

  CASE ok_code_4019.
    WHEN 'BTN_RP'.
      CLEAR ok_code_4019.
      PERFORM VALID_INSERT_PRODUCTOS.

  ENDCASE.

ENDFORM.
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*---------------------------INITS--------------------------------------*
*-----------------------MODIFICACION-----------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form INIT_4030
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4030.

  DD = 6.

if ZTC_PROVEEDORES-nombre is NOT INITIAL.

 ELSE.
    ZTC_PROVEEDORES-id_proveedor = GS_PROVEEDOR_SELECCIONADO-id_proveedor.
    ZTC_PROVEEDORES-nombre = GS_PROVEEDOR_SELECCIONADO-nombre.
    ZTC_PROVEEDORES-apellido_paterno = GS_PROVEEDOR_SELECCIONADO-apellido_paterno.
    ZTC_PROVEEDORES-apellido_materno = GS_PROVEEDOR_SELECCIONADO-apellido_materno.
    ZTC_PROVEEDORES-tipo_persona = GS_PROVEEDOR_SELECCIONADO-tipo_persona.
    ZTC_PROVEEDORES-rfc = GS_PROVEEDOR_SELECCIONADO-rfc.
    ZTC_PROVEEDORES-razon_social = GS_PROVEEDOR_SELECCIONADO-razon_social.
    ZTC_PROVEEDORES-regimen_fiscal = GS_PROVEEDOR_SELECCIONADO-regimen_fiscal.
    ZTC_PROVEEDORES-calle = GS_PROVEEDOR_SELECCIONADO-calle.
    ZTC_PROVEEDORES-colonia = GS_PROVEEDOR_SELECCIONADO-colonia.
    ZTC_PROVEEDORES-municipio = GS_PROVEEDOR_SELECCIONADO-municipio.
    ZTC_PROVEEDORES-estado = GS_PROVEEDOR_SELECCIONADO-estado.
    ZTC_PROVEEDORES-no_exterior = GS_PROVEEDOR_SELECCIONADO-no_exterior.
    ZTC_PROVEEDORES-no_interior = GS_PROVEEDOR_SELECCIONADO-no_interior.
    ZTC_PROVEEDORES-cp = GS_PROVEEDOR_SELECCIONADO-cp.
    ZTC_PROVEEDORES-telefono1 = GS_PROVEEDOR_SELECCIONADO-telefono1.
    ZTC_PROVEEDORES-telefono2 = GS_PROVEEDOR_SELECCIONADO-telefono2.
    ZTC_PROVEEDORES-email = GS_PROVEEDOR_SELECCIONADO-email.
   ENDIF.

  CHECK ok_code_4030 is NOT INITIAL.

  CASE ok_code_4030.
    WHEN 'BTN_MOD'.
      PERFORM VALID_MODI_PROVEEDORES.
      CLEAR: OK_CODE_4030.
      IF ER GT 15.
          CALL SCREEN 4004.
        ELSE.
          PERFORM VALID_MODI_PROVEEDORES.
      ENDIF.
    WHEN 'BTN_DEL'.
      CLEAR: OK_CODE_4030.
      PERFORM ELIMINAR_CATALOGOS USING 'PROVEEDORES'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4031
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4031.

  DD = 7.

  IF ZTC_PRODUCTOS-descripcion IS NOT INITIAL.

  ELSE.

    ZTC_PRODUCTOS-id_producto = GS_PRODUCTO_SELECCIONADO-id_producto.
    ZTC_PRODUCTOS-descripcion = GS_PRODUCTO_SELECCIONADO-descripcion.
    ZTC_PRODUCTOS-color       = GS_PRODUCTO_SELECCIONADO-color.
    ZTC_PRODUCTOS-talla       = GS_PRODUCTO_SELECCIONADO-talla.
    ZTC_PRODUCTOS-existencia  = GS_PRODUCTO_SELECCIONADO-existencia.
    ZTC_PRODUCTOS-precio      = GS_PRODUCTO_SELECCIONADO-precio.

  ENDIF.

  CHECK OK_CODE_4031 IS NOT INITIAL.

  CASE OK_CODE_4031.
    WHEN 'BTN_MOD'.
      PERFORM VALID_MODI_PRODUCTOS.
      CLEAR: OK_CODE_4031.
       IF ER GT 3.
          CALL SCREEN 4002.
       ELSE.
         PERFORM VALID_MODI_PRODUCTOS.
       ENDIF.
    WHEN 'BTN_DEL'.
      CLEAR: OK_CODE_4031.
      PERFORM ELIMINAR_CATALOGOS USING 'PRODUCTO'.
    WHEN OTHERS.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4032
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4032 .

  DD = 8.

  IF ZTC_EMPLEADOS-NOMBRE IS NOT INITIAL.

  ELSE.

    ZTC_EMPLEADOS-id_empleado      = GS_MAQUILERO_SELECCIONADO-id_empleado.
    ZTC_EMPLEADOS-nombre           = GS_MAQUILERO_SELECCIONADO-nombre.
    ZTC_EMPLEADOS-apellido_paterno = GS_MAQUILERO_SELECCIONADO-apellido_paterno.
    ZTC_EMPLEADOS-apellido_materno = GS_MAQUILERO_SELECCIONADO-apellido_materno.
    ZTC_EMPLEADOS-genero           = GS_MAQUILERO_SELECCIONADO-genero.
    ZTC_EMPLEADOS-fecha_nacimiento = GS_MAQUILERO_SELECCIONADO-fecha_nacimiento.
    ZTC_EMPLEADOS-curp             = GS_MAQUILERO_SELECCIONADO-curp.
    ZTC_EMPLEADOS-rfc              = GS_MAQUILERO_SELECCIONADO-rfc.
    ZTC_EMPLEADOS-no_seguro        = GS_MAQUILERO_SELECCIONADO-no_seguro.
    ZTC_EMPLEADOS-estado_civil     = GS_MAQUILERO_SELECCIONADO-estado_civil.
    ZTC_EMPLEADOS-calle            = GS_MAQUILERO_SELECCIONADO-calle.
    ZTC_EMPLEADOS-colonia          = GS_MAQUILERO_SELECCIONADO-colonia.
    ZTC_EMPLEADOS-municipio        = GS_MAQUILERO_SELECCIONADO-municipio.
    ZTC_EMPLEADOS-estado           = GS_MAQUILERO_SELECCIONADO-estado.
    ZTC_EMPLEADOS-no_exterior      = GS_MAQUILERO_SELECCIONADO-no_exterior.
    ZTC_EMPLEADOS-no_interior      = GS_MAQUILERO_SELECCIONADO-no_interior.
    ZTC_EMPLEADOS-cp               = GS_MAQUILERO_SELECCIONADO-cp.
    ZTC_EMPLEADOS-telefono1        = GS_MAQUILERO_SELECCIONADO-telefono1.
    ZTC_EMPLEADOS-telefono2        = GS_MAQUILERO_SELECCIONADO-telefono2.
    ZTC_EMPLEADOS-email            = GS_MAQUILERO_SELECCIONADO-email.

  ENDIF.

  CHECK OK_CODE_4032 IS NOT INITIAL.

  CASE OK_CODE_4032.
    WHEN 'BTN_MOD'.
      PERFORM valid_modi_empleados.
      CLEAR: OK_CODE_4032.
      IF ER GT 15.
        CALL SCREEN 4005.
      ELSE.
       PERFORM valid_modi_empleados.
      ENDIF.
    WHEN 'BTN_DEL'.
      CLEAR: OK_CODE_4032.
      PERFORM ELIMINAR_CATALOGOS USING 'MAQUILERO'.
    WHEN OTHERS.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4033
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4033 .

  DD = 9.

  IF ZTC_CLIENTES-NOMBRE IS NOT INITIAL.

  ELSE.

    ZTC_CLIENTES-id_cliente       = GS_CLIENTE_SELECCIONADO-id_cliente.
    ZTC_CLIENTES-nombre           = GS_CLIENTE_SELECCIONADO-nombre.
    ZTC_CLIENTES-apellido_paterno = GS_CLIENTE_SELECCIONADO-apellido_paterno.
    ZTC_CLIENTES-apellido_materno = GS_CLIENTE_SELECCIONADO-apellido_materno.
    ZTC_CLIENTES-tipo_persona     = GS_CLIENTE_SELECCIONADO-tipo_persona.
    ZTC_CLIENTES-rfc              = GS_CLIENTE_SELECCIONADO-rfc.
    ZTC_CLIENTES-razon_social     = GS_CLIENTE_SELECCIONADO-razon_social.
    ZTC_CLIENTES-regimen_fiscal   = GS_CLIENTE_SELECCIONADO-regimen_fiscal.
    ZTC_CLIENTES-calle            = GS_CLIENTE_SELECCIONADO-calle.
    ZTC_CLIENTES-colonia          = GS_CLIENTE_SELECCIONADO-colonia.
    ZTC_CLIENTES-municipio        = GS_CLIENTE_SELECCIONADO-municipio.
    ZTC_CLIENTES-estado           = GS_CLIENTE_SELECCIONADO-estado.
    ZTC_CLIENTES-no_exterior      = GS_CLIENTE_SELECCIONADO-no_exterior.
    ZTC_CLIENTES-no_interior      = GS_CLIENTE_SELECCIONADO-no_interior.
    ZTC_CLIENTES-cp               = GS_CLIENTE_SELECCIONADO-cp.
    ZTC_CLIENTES-telefono1        = GS_CLIENTE_SELECCIONADO-telefono1.
    ZTC_CLIENTES-telefono2        = GS_CLIENTE_SELECCIONADO-telefono2.
    ZTC_CLIENTES-email            = GS_CLIENTE_SELECCIONADO-email.

  ENDIF.

  CHECK OK_CODE_4033 IS NOT INITIAL.

  CASE OK_CODE_4033.
    WHEN 'BTN_MOD'.
      PERFORM valid_modi_clientes.
      CLEAR: OK_CODE_4033.
      IF ER GT 14.
        CALL SCREEN 4006.
      ELSE.
       PERFORM valid_modi_clientes.
      ENDIF.
    WHEN 'BTN_DEL'.
      CLEAR: OK_CODE_4033.
      PERFORM ELIMINAR_CATALOGOS USING 'CLIENTE'.
    WHEN OTHERS.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4034
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4034 .

  DD = 10.

  IF ZTC_MATERIALES-descripcion IS NOT INITIAL.

  ELSE.

    ZTC_MATERIALES-id_material        = GS_MATERIAL_SELECCIONADO-id_material.
    ZTC_MATERIALES-descripcion        = GS_MATERIAL_SELECCIONADO-descripcion.
    ZTC_MATERIALES-color              = GS_MATERIAL_SELECCIONADO-color.
    ZTC_MATERIALES-rollos             = GS_MATERIAL_SELECCIONADO-rollos.
    ZTC_MATERIALES-rollos_incompletos = GS_MATERIAL_SELECCIONADO-rollos_incompletos.
    ZTC_MATERIALES-peso               = GS_MATERIAL_SELECCIONADO-peso.

  ENDIF.

  CHECK OK_CODE_4034 IS NOT INITIAL.

  CASE OK_CODE_4034.
    WHEN 'BTN_MOD'.
      PERFORM valid_modi_materiales.
      CLEAR: OK_CODE_4034.
      IF ER GT 4.
        CALL SCREEN 4001.
      ELSE.
       PERFORM valid_modi_materiales.
      ENDIF.
    WHEN 'BTN_DEL'.
      CLEAR: OK_CODE_4034.
      PERFORM ELIMINAR_CATALOGOS USING 'MATERIAL'.
    WHEN OTHERS.
  ENDCASE.

ENDFORM.
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*--------------------------INSERTS-------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form INSERT_MATERIALES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_materiales .

    gwa_mat-mandt = SY-UNAME.

    GWA_MAT-id_material = ZTC_MATERIALES-id_material.

    GWA_MAT-descripcion = ZTC_MATERIALES-DESCRIPCION.

    GWA_MAT-color = ZTC_MATERIALES-COLOR.

    GWA_MAT-rollos = ZTC_MATERIALES-ROLLOS.

    GWA_MAT-rollos_incompletos = ZTC_MATERIALES-ROLLOS_INCOMPLETOS.

    GWA_MAT-peso = ZTC_MATERIALES-PESO.

    INSERT INTO ZTC_MATERIALES VALUES GWA_MAT.

    IF sy-subrc EQ 0.
          MESSAGE 'Registro insertado correctamente' TYPE 'I'.
          CLEAR:ZTC_MATERIALES-ID_MATERIAL,
                ZTC_MATERIALES-DESCRIPCION,
                ZTC_MATERIALES-COLOR,
                ZTC_MATERIALES-ROLLOS,
                ZTC_MATERIALES-ROLLOS_INCOMPLETOS,
                ZTC_MATERIALES-PESO.

          LEAVE TO SCREEN 0.
        ELSE.
          MESSAGE 'El registro no se insertó' TYPE 'I'.
        ENDIF.

   SELECT MAX( id_material )
    FROM ztc_materiales
    INTO ( gv_max ).
  MOVE gv_max TO res.
  res = res + 1.
  MOVE res TO gv_max.

  SELECT FROM ztc_materiales
    FIELDS *
    INTO TABLE @DATA(ed)."Estoy creando una variable con el unico fin de leer
  READ TABLE ed TRANSPORTING NO FIELDS WITH KEY id_material = res.

  ztc_materiales-id_material = gv_max.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form INSERT_PRODUCTOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_productos .


  gwa_prod-mandt       = sy-uname.

  gwa_prod-id_producto = ztc_productos-id_producto.

  gwa_prod-descripcion = ztc_productos-descripcion.

  gwa_prod-color       = ztc_productos-color.

  gwa_prod-talla       = ztc_productos-talla.

  gwa_prod-existencia  = ztc_productos-existencia.

  gwa_prod-precio      = ztc_productos-precio.

  INSERT INTO ztc_productos VALUES gwa_prod.

   IF sy-subrc eq 0.
            MESSAGE 'Registro insertado correctamente' TYPE 'I'.
            CLEAR:ztc_productos-id_producto,
                  ztc_productos-descripcion,
                  ztc_productos-color,
                  ztc_productos-talla,
                  ztc_productos-existencia,
                  ztc_productos-precio.
              LEAVE TO SCREEN 0.
            ELSE.
            MESSAGE 'Registro no insertado' TYPE 'I'.

    ENDIF.

  SELECT MAX( id_producto )
    FROM ztc_productos
    INTO ( gv_max ).
  MOVE gv_max TO res.
  res = res + 1.
  MOVE res TO gv_max.

  SELECT FROM ztc_productos
    FIELDS *
    INTO TABLE @DATA(ed)."Estoy creando una variable con el unico fin de leer
  READ TABLE ed TRANSPORTING NO FIELDS WITH KEY id_producto = res.

  ztc_productos-id_producto = gv_max.


ENDFORM.



*&---------------------------------------------------------------------*
*& Form INSERT_PROVEEDORES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_proveedores .

  gwa_prov-mandt              = sy-uname.

  gwa_prov-id_proveedor       = ztc_proveedores-id_proveedor.

  gwa_prov-nombre             = ztc_proveedores-nombre.

  gwa_prov-apellido_paterno   = ztc_proveedores-apellido_paterno.

  gwa_prov-apellido_materno   = ztc_proveedores-apellido_materno.

  gwa_prov-tipo_persona       = ztc_proveedores-tipo_persona.

  gwa_prov-rfc                = ztc_proveedores-rfc.

  gwa_prov-razon_social       = ztc_proveedores-razon_social.

  gwa_prov-regimen_fiscal     = ztc_proveedores-regimen_fiscal.

  gwa_prov-calle              = ztc_proveedores-calle.

  gwa_prov-colonia            = ztc_proveedores-colonia.

  gwa_prov-municipio          = ztc_proveedores-municipio.

  gwa_prov-estado             = ztc_proveedores-estado.

  gwa_prov-no_exterior        = ztc_proveedores-no_exterior.

  gwa_prov-no_interior        = ztc_proveedores-no_interior.

  gwa_prov-cp                 = ztc_proveedores-cp.

  gwa_prov-telefono1          = ztc_proveedores-telefono1.

  gwa_prov-telefono2          = ztc_proveedores-telefono2.

  gwa_prov-email              = ztc_proveedores-email.

  INSERT INTO ztc_proveedores VALUES gwa_prov.

    IF sy-subrc eq 0.
            MESSAGE 'Registro insertado correctamente' TYPE 'I'.
            CLEAR: ztc_proveedores-nombre,
                   ztc_proveedores-apellido_paterno,
                   ztc_proveedores-apellido_materno,
                   ztc_proveedores-tipo_persona,
                   ztc_proveedores-rfc,
                   ztc_proveedores-razon_social,
                   ztc_proveedores-regimen_fiscal,
                   ztc_proveedores-calle,
                   ztc_proveedores-colonia,
                   ztc_proveedores-municipio,
                   ztc_proveedores-estado,
                   ztc_proveedores-no_exterior,
                   ztc_proveedores-no_interior,
                   ztc_proveedores-cp,
                   ztc_proveedores-telefono1,
                   ztc_proveedores-telefono2,
                   ztc_proveedores-email.
                    LEAVE TO SCREEN 0.
          ELSE.
            MESSAGE 'Registro no insertado' TYPE 'I'.

    ENDIF.

    SELECT MAX( id_proveedor )
        FROM ztc_proveedores
        INTO ( gv_max ).
      MOVE gv_max TO res.
      res = res + 1.
      MOVE res TO gv_max.

      SELECT FROM ztc_proveedores
        FIELDS *
        INTO TABLE @DATA(ed)."Estoy creando una variable con el unico fin de leer
      READ TABLE ed TRANSPORTING NO FIELDS WITH KEY id_proveedor = res.

      ztc_proveedores-id_proveedor = gv_max.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form INSERT_EMPLEADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_empleados .

      gwa_emp-mandt = sy-uname.

      gwa_emp-id_empleado =          ztc_empleados-id_empleado.

      gwa_emp-nombre =               ztc_empleados-nombre.

      gwa_emp-apellido_paterno =     ztc_empleados-apellido_paterno.

      gwa_emp-apellido_materno =     ztc_empleados-apellido_materno.

      gwa_emp-genero =               ztc_empleados-genero.

      gwa_emp-fecha_nacimiento =     ztc_empleados-fecha_nacimiento.

      gwa_emp-curp =                 ztc_empleados-curp.

      gwa_emp-rfc =                  ztc_empleados-rfc.

      gwa_emp-no_seguro =            ztc_empleados-no_seguro.

      gwa_emp-estado_civil =         ztc_empleados-estado_civil.

      gwa_emp-calle =                ztc_empleados-calle.

      gwa_emp-colonia =              ztc_empleados-colonia.

      gwa_emp-municipio =            ztc_empleados-municipio.

      gwa_emp-estado =               ztc_empleados-estado.

      gwa_emp-no_exterior =          ztc_empleados-no_exterior.

      gwa_emp-no_interior =          ztc_empleados-no_interior.

      gwa_emp-cp =                   ztc_empleados-cp.

      gwa_emp-telefono1 =            ztc_empleados-telefono1.

      gwa_emp-telefono2 =            ztc_empleados-telefono2.

      gwa_emp-email =                ztc_empleados-email.

      INSERT INTO ztc_empleados VALUES gwa_emp.

      IF sy-subrc eq 0.
            MESSAGE 'Registro insertado correctamente' TYPE 'I'.
            CLEAR:ztc_empleados-id_empleado,
                  ztc_empleados-nombre,
                  ztc_empleados-apellido_paterno,
                  ztc_empleados-apellido_materno,
                  ztc_empleados-genero,
                  ztc_empleados-fecha_nacimiento,
                  ztc_empleados-curp,
                  ztc_empleados-rfc,
                  ztc_empleados-no_seguro,
                  ztc_empleados-estado_civil,
                  ztc_empleados-calle,
                  ztc_empleados-colonia,
                  ztc_empleados-municipio,
                  ztc_empleados-estado,
                  ztc_empleados-no_exterior,
                  ztc_empleados-no_interior,
                  ztc_empleados-cp,
                  ztc_empleados-telefono1,
                  ztc_empleados-telefono2,
                  ztc_empleados-email.
            LEAVE TO SCREEN 0.
            ELSE.
            MESSAGE 'Registro no insertado' TYPE 'I'.
            ENDIF.

            SELECT MAX( id_empleado )
              FROM ztc_empleados
              INTO ( gv_max ).
            MOVE gv_max TO res.
            res = res + 1.
            MOVE res TO gv_max.

            SELECT FROM ztc_empleados
              FIELDS *
              INTO TABLE @DATA(ed)."Estoy creando una variable con el unico fin de leer
            READ TABLE ed TRANSPORTING NO FIELDS WITH KEY id_empleado = res.

            ztc_empleados-id_empleado = gv_max.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form INSERT_CLIENTES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_clientes .

  gwa_client-mandt            = SY-UNAME.

  gwa_client-id_cliente       = ztc_clientes-id_cliente.

  gwa_client-nombre           = ztc_clientes-nombre.

  gwa_client-apellido_paterno = ztc_clientes-apellido_paterno.

  gwa_client-apellido_materno = ztc_clientes-apellido_materno.

  gwa_client-tipo_persona     = ztc_clientes-tipo_persona.

  gwa_client-rfc              = ztc_clientes-rfc.

  gwa_client-razon_social     = ztc_clientes-razon_social.

  gwa_client-regimen_fiscal   = ztc_clientes-regimen_fiscal.

  gwa_client-calle            = ztc_clientes-calle.

  gwa_client-colonia          = ztc_clientes-colonia.

  gwa_client-municipio        = ztc_clientes-municipio.

  gwa_client-estado           = ztc_clientes-estado.

  gwa_client-no_exterior      = ztc_clientes-no_exterior.

  gwa_client-no_interior      = ztc_clientes-no_interior.

  gwa_client-cp               = ztc_clientes-cp.

  gwa_client-telefono1        = ztc_clientes-telefono1.

  gwa_client-telefono2        = ztc_clientes-telefono2.

  gwa_client-email            = ztc_clientes-email.

  INSERT INTO ztc_clientes VALUES gwa_client.

  IF sy-subrc eq 0.
            MESSAGE 'Registro insertado correctamente' TYPE 'I'.
            CLEAR:ztc_clientes-id_cliente,
                  ztc_clientes-nombre,
                  ztc_clientes-apellido_paterno,
                  ztc_clientes-apellido_materno,
                  ztc_clientes-tipo_persona,
                  ztc_clientes-rfc,
                  ztc_clientes-razon_social,
                  ztc_clientes-regimen_fiscal,
                  ztc_clientes-calle,
                  ztc_clientes-colonia,
                  ztc_clientes-municipio,
                  ztc_clientes-estado,
                  ztc_clientes-no_exterior,
                  ztc_clientes-no_interior,
                  ztc_clientes-cp,
                  ztc_clientes-telefono1,
                  ztc_clientes-telefono2,
                  ztc_clientes-email.
            LEAVE TO SCREEN 0.
            ELSE.
            MESSAGE 'Registro no insertado' TYPE 'I'.

    ENDIF.

    SELECT MAX( ID_CLIENTE )
      FROM ztc_clientes
      INTO ( gv_max ).
    MOVE gv_max TO res.
    res = res + 1.
    MOVE res TO gv_max.

    SELECT FROM ztc_clientes
      FIELDS *
      INTO TABLE @DATA(ed)."Estoy creando una variable con el unico fin de leer
    READ TABLE ed TRANSPORTING NO FIELDS WITH KEY ID_CLIENTE = res.

    ztc_clientes-id_cliente = gv_max.

ENDFORM.


*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*-----------------------MODIFICACION-----------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form MODIFICAR_CATALOGOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM  modificar_catalogos USING UC.

  IF UC EQ 'PROVEEDORES'.

    UPDATE ZTC_PROVEEDORES SET nombre            = ZTC_PROVEEDORES-nombre
                               apellido_paterno  = ZTC_PROVEEDORES-APELLIDO_PATERNO
                               apellido_materno  = ZTC_PROVEEDORES-APELLIDO_MATERNO
                               tipo_persona      = ZTC_PROVEEDORES-TIPO_PERSONA
                               rfc               = ZTC_PROVEEDORES-RFC
                               razon_social      = ZTC_PROVEEDORES-RAZON_SOCIAL
                               regimen_fiscal    = ZTC_PROVEEDORES-REGIMEN_FISCAL
                               calle             = ZTC_PROVEEDORES-CALLE
                               colonia           = ZTC_PROVEEDORES-COLONIA
                               municipio         = ZTC_PROVEEDORES-MUNICIPIO
                               estado            = ZTC_PROVEEDORES-ESTADO
                               no_exterior       = ZTC_PROVEEDORES-NO_EXTERIOR
                               no_interior       = ZTC_PROVEEDORES-NO_INTERIOR
                               cp                = ZTC_PROVEEDORES-CP
                               telefono1         = ZTC_PROVEEDORES-TELEFONO1
                               telefono2         = ZTC_PROVEEDORES-TELEFONO2
                               email             = ZTC_PROVEEDORES-EMAIL
    WHERE ID_PROVEEDOR EQ GS_PROVEEDOR_SELECCIONADO-id_proveedor.


          CLEAR: ZTC_PROVEEDORES-nombre,
             ZTC_PROVEEDORES-APELLIDO_PATERNO,
             ZTC_PROVEEDORES-APELLIDO_MATERNO,
             ZTC_PROVEEDORES-TIPO_PERSONA,
             ZTC_PROVEEDORES-RFC,
             ZTC_PROVEEDORES-RAZON_SOCIAL,
             ZTC_PROVEEDORES-REGIMEN_FISCAL,
             ZTC_PROVEEDORES-CALLE,
             ZTC_PROVEEDORES-COLONIA,
             ZTC_PROVEEDORES-MUNICIPIO,
             ZTC_PROVEEDORES-ESTADO,
             ZTC_PROVEEDORES-NO_EXTERIOR,
             ZTC_PROVEEDORES-NO_INTERIOR,
             ZTC_PROVEEDORES-CP,
             ZTC_PROVEEDORES-TELEFONO1,
             ZTC_PROVEEDORES-TELEFONO2,
             ZTC_PROVEEDORES-EMAIL.

  ELSEIF UC EQ 'PRODUCTO'.

    UPDATE ZTC_PRODUCTOS SET descripcion = ZTC_PRODUCTOS-descripcion
                             color       = ZTC_PRODUCTOS-color
                             talla       = ZTC_PRODUCTOS-talla
                             existencia  = ZTC_PRODUCTOS-existencia
                             precio      = ZTC_PRODUCTOS-precio
    WHERE ID_PRODUCTO EQ GS_PRODUCTO_SELECCIONADO-id_producto.

    CLEAR: ZTC_PRODUCTOS-descripcion,
           ZTC_PRODUCTOS-color,
           ZTC_PRODUCTOS-talla,
           ZTC_PRODUCTOS-existencia,
           ZTC_PRODUCTOS-precio.

  ELSEIF UC EQ 'MAQUILERO'.

    UPDATE ZTC_EMPLEADOS SET nombre           = ZTC_EMPLEADOS-nombre
                             apellido_paterno = ZTC_EMPLEADOS-apellido_paternO
                             apellido_materno = ZTC_EMPLEADOS-apellido_materno
                             genero           = ZTC_EMPLEADOS-genero
                             fecha_nacimiento = ZTC_EMPLEADOS-fecha_nacimiento
                             curp             = ZTC_EMPLEADOS-curp
                             rfc              = ZTC_EMPLEADOS-rfc
                             no_seguro        = ZTC_EMPLEADOS-no_seguro
                             estado_civil     = ZTC_EMPLEADOS-estado_civil
                             calle            = ZTC_EMPLEADOS-calle
                             colonia          = ZTC_EMPLEADOS-colonia
                             municipio        = ZTC_EMPLEADOS-municipio
                             estado           = ZTC_EMPLEADOS-estado
                             no_exterior      = ZTC_EMPLEADOS-no_exterior
                             no_interior      = ZTC_EMPLEADOS-no_interior
                             cp               = ZTC_EMPLEADOS-cp
                             telefono1        = ZTC_EMPLEADOS-telefono1
                             telefono2        = ZTC_EMPLEADOS-telefono2
                             email            = ZTC_EMPLEADOS-email
    WHERE ID_EMPLEADO EQ GS_MAQUILERO_SELECCIONADO-id_empleado.

    CLEAR: ZTC_EMPLEADOS-id_empleado,
           ZTC_EMPLEADOS-nombre,
           ZTC_EMPLEADOS-apellido_paternO,
           ZTC_EMPLEADOS-apellido_materno,
           ZTC_EMPLEADOS-genero,
           ZTC_EMPLEADOS-fecha_nacimiento,
           ZTC_EMPLEADOS-curp,
           ZTC_EMPLEADOS-rfc,
           ZTC_EMPLEADOS-no_seguro,
           ZTC_EMPLEADOS-estado_civil,
           ZTC_EMPLEADOS-calle,
           ZTC_EMPLEADOS-colonia,
           ZTC_EMPLEADOS-municipio,
           ZTC_EMPLEADOS-estado,
           ZTC_EMPLEADOS-no_exterior,
           ZTC_EMPLEADOS-no_interior,
           ZTC_EMPLEADOS-cp,
           ZTC_EMPLEADOS-telefono1,
           ZTC_EMPLEADOS-telefono2,
           ZTC_EMPLEADOS-email.

  ELSEIF UC EQ 'CLIENTE'.

    UPDATE ZTC_CLIENTES SET nombre            = ZTC_CLIENTES-nombre
                            apellido_paterno  = ZTC_CLIENTES-apellido_paterno
                            apellido_materno  = ZTC_CLIENTES-apellido_materno
                            tipo_persona      = ZTC_CLIENTES-tipo_persona
                            rfc               = ZTC_CLIENTES-rfc
                            razon_social      = ZTC_CLIENTES-razon_social
                            regimen_fiscal    = ZTC_CLIENTES-regimen_fiscal
                            calle             = ZTC_CLIENTES-calle
                            colonia           = ZTC_CLIENTES-colonia
                            municipio         = ZTC_CLIENTES-municipio
                            estado            = ZTC_CLIENTES-estado
                            no_exterior       = ZTC_CLIENTES-no_exterior
                            no_interior       = ZTC_CLIENTES-no_interior
                            cp                = ZTC_CLIENTES-cp
                            telefono1         = ZTC_CLIENTES-telefono1
                            telefono2         = ZTC_CLIENTES-telefono2
                            email             = ZTC_CLIENTES-email
    WHERE ID_CLIENTE EQ GS_CLIENTE_SELECCIONADO-id_cliente.

    CLEAR: ZTC_CLIENTES-id_cliente,
               ZTC_CLIENTES-nombre,
               ZTC_CLIENTES-apellido_paterno,
               ZTC_CLIENTES-apellido_materno,
               ZTC_CLIENTES-tipo_persona,
               ZTC_CLIENTES-rfc,
               ZTC_CLIENTES-razon_social,
               ZTC_CLIENTES-regimen_fiscal,
               ZTC_CLIENTES-calle,
               ZTC_CLIENTES-colonia,
               ZTC_CLIENTES-municipio,
               ZTC_CLIENTES-estado,
               ZTC_CLIENTES-no_exterior,
               ZTC_CLIENTES-no_interior,
               ZTC_CLIENTES-cp,
               ZTC_CLIENTES-telefono1,
               ZTC_CLIENTES-telefono2,
               ZTC_CLIENTES-email.

  ELSEIF UC EQ 'MATERIAL'.

    UPDATE ZTC_MATERIALES SET descripcion         = ZTC_MATERIALES-descripcion
                              color               = ZTC_MATERIALES-color
                              rollos              = ZTC_MATERIALES-rollos
                              rollos_incompletos  = ZTC_MATERIALES-rollos_incompletos
                              peso                = ZTC_MATERIALES-peso
    WHERE ID_MATERIAL EQ GS_MATERIAL_SELECCIONADO-id_material.

    CLEAR: ZTC_MATERIALES-descripcion,
           ZTC_MATERIALES-color,
           ZTC_MATERIALES-rollos,
           ZTC_MATERIALES-rollos_incompletos,
           ZTC_MATERIALES-peso.

  ENDIF.

 ENDFORM.
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*-----------------------ELIMINACIONES----------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form ELIMINAR_CATALOGOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM eliminar_catalogos USING DC.

  IF DC EQ 'PROVEEDORES'.

    DELETE FROM ZTC_PROVEEDORES WHERE id_proveedor EQ GS_PROVEEDOR_SELECCIONADO-id_proveedor.

    IF SY-SUBRC EQ 0.

      MESSAGE s005(zgi_cv_ms) WITH  tc DISPLAY LIKE 'S'.

      CLEAR: ZTC_PROVEEDORES-nombre,
             ZTC_PROVEEDORES-APELLIDO_PATERNO,
             ZTC_PROVEEDORES-APELLIDO_MATERNO,
             ZTC_PROVEEDORES-TIPO_PERSONA,
             ZTC_PROVEEDORES-RFC,
             ZTC_PROVEEDORES-RAZON_SOCIAL,
             ZTC_PROVEEDORES-REGIMEN_FISCAL,
             ZTC_PROVEEDORES-CALLE,
             ZTC_PROVEEDORES-COLONIA,
             ZTC_PROVEEDORES-MUNICIPIO,
             ZTC_PROVEEDORES-ESTADO,
             ZTC_PROVEEDORES-NO_EXTERIOR,
             ZTC_PROVEEDORES-NO_INTERIOR,
             ZTC_PROVEEDORES-CP,
             ZTC_PROVEEDORES-TELEFONO1,
             ZTC_PROVEEDORES-TELEFONO2,
             ZTC_PROVEEDORES-EMAIL.

      CALL SCREEN 4004.

    ELSE.

      MESSAGE s007(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.

    ENDIF.

  ELSEIF DC EQ 'PRODUCTO'.

    DELETE FROM ZTC_PRODUCTOS WHERE id_producto EQ GS_PRODUCTO_SELECCIONADO-id_producto.

    IF SY-SUBRC EQ 0.

      MESSAGE s005(zgi_cv_ms) WITH  tc DISPLAY LIKE 'S'.

      CLEAR: ZTC_PRODUCTOS-id_producto,
             ZTC_PRODUCTOS-descripcion,
             ZTC_PRODUCTOS-color,
             ZTC_PRODUCTOS-talla,
             ZTC_PRODUCTOS-existencia,
             ZTC_PRODUCTOS-precio.

      CALL SCREEN 4002.

    ELSE.

      MESSAGE s007(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.

    ENDIF.

  ELSEIF DC EQ 'MAQUILERO'.

    DELETE FROM ZTC_EMPLEADOS WHERE id_empleado EQ GS_MAQUILERO_SELECCIONADO-id_empleado.

    IF SY-SUBRC EQ 0.

      MESSAGE s005(zgi_cv_ms) WITH  tc DISPLAY LIKE 'S'.

      CLEAR: ZTC_EMPLEADOS-id_empleado,
             ZTC_EMPLEADOS-nombre,
             ZTC_EMPLEADOS-apellido_paternO,
             ZTC_EMPLEADOS-apellido_materno,
             ZTC_EMPLEADOS-genero,
             ZTC_EMPLEADOS-fecha_nacimiento,
             ZTC_EMPLEADOS-curp,
             ZTC_EMPLEADOS-rfc,
             ZTC_EMPLEADOS-no_seguro,
             ZTC_EMPLEADOS-estado_civil,
             ZTC_EMPLEADOS-calle,
             ZTC_EMPLEADOS-colonia,
             ZTC_EMPLEADOS-municipio,
             ZTC_EMPLEADOS-estado,
             ZTC_EMPLEADOS-no_exterior,
             ZTC_EMPLEADOS-no_interior,
             ZTC_EMPLEADOS-cp,
             ZTC_EMPLEADOS-telefono1,
             ZTC_EMPLEADOS-telefono2,
             ZTC_EMPLEADOS-email.

      CALL SCREEN 4005.

    ELSE.

      MESSAGE s007(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.

    ENDIF.

  ELSEIF DC EQ 'CLIENTE'.

      DELETE FROM ZTC_CLIENTES WHERE id_cliente EQ GS_CLIENTE_SELECCIONADO-id_cliente.

      IF SY-SUBRC EQ 0.

       MESSAGE s005(zgi_cv_ms) WITH  tc DISPLAY LIKE 'S'.

        CLEAR: ZTC_CLIENTES-id_cliente,
               ZTC_CLIENTES-nombre,
               ZTC_CLIENTES-apellido_paterno,
               ZTC_CLIENTES-apellido_materno,
               ZTC_CLIENTES-tipo_persona,
               ZTC_CLIENTES-rfc,
               ZTC_CLIENTES-razon_social,
               ZTC_CLIENTES-regimen_fiscal,
               ZTC_CLIENTES-calle,
               ZTC_CLIENTES-colonia,
               ZTC_CLIENTES-municipio,
               ZTC_CLIENTES-estado,
               ZTC_CLIENTES-no_exterior,
               ZTC_CLIENTES-no_interior,
               ZTC_CLIENTES-cp,
               ZTC_CLIENTES-telefono1,
               ZTC_CLIENTES-telefono2,
               ZTC_CLIENTES-email.

        CALL SCREEN 4006.

     ELSE.

      MESSAGE s007(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.

    ENDIF.

  ELSEIF DC EQ 'MATERIAL'.

    DELETE FROM ZTC_MATERIALES WHERE id_material EQ GS_MATERIAL_SELECCIONADO-id_material.

    IF SY-SUBRC EQ 0.

      MESSAGE s005(zgi_cv_ms) WITH  tc DISPLAY LIKE 'S'.

      CLEAR: ZTC_MATERIALES-descripcion,
             ZTC_MATERIALES-color,
             ZTC_MATERIALES-rollos,
             ZTC_MATERIALES-rollos_incompletos,
             ZTC_MATERIALES-peso.

      CALL SCREEN 4001.

    ELSE.

      MESSAGE s007(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.

    ENDIF.

  ENDIF.

ENDFORM.

*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*--------------------VALIDACION DE CAMPOS------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
**************************************************************************************
*                     SUBRUTINAS PARA LA MODIFICACION DE CATALOGOS                   *
**************************************************************************************

*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*-----------------------VALIDACION-------------------------------------*
*--------------------------PARA----------------------------------------*
*----------------------MODIFICACION------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form VALID_INSERT_MATERIALES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_modi_materiales .

  ER = 0.

*---------Validacion-------------
*----------MATERIALES-------------
*----------DESCRIPCION------------
tc = 'DESCRIPCION'.
l_string = ZTC_MATERIALES-DESCRIPCION.
IF ZTC_MATERIALES-descripcion IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*----------MATERIALES-------------
*----------COLOR------------
tc = 'COLOR'.
l_string = ZTC_MATERIALES-COLOR.
IF ZTC_MATERIALES-COLOR IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*----------MATERIALES-------------
*----------ROLLOS------------
tc = 'ROLLOS'.
l_string = ZTC_MATERIALES-ROLLOS.
IF ZTC_MATERIALES-ROLLOS ge 0 .
    er = er + 1.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*----------MATERIALES-------------
*----------ROLLOS_INCOMPLETOS------------
tc = 'ROLLOS_INCOMPLETOS'.
l_string = ZTC_MATERIALES-ROLLOS_INCOMPLETOS.
IF ZTC_MATERIALES-ROLLOS_INCOMPLETOS ge 0 .
    er = er + 1.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*----------MATERIALES-------------
*----------PESO------------
tc = 'PESO'.
l_string = ZTC_MATERIALES-PESO.
IF ZTC_MATERIALES-PESO ge 0 .
    er = er + 1.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

IF ER GT 4.
  PERFORM MODIFICAR_CATALOGOS USING 'MATERIAL'.
  MESSAGE s006(zgi_cv_ms) WITH  tc DISPLAY LIKE 'S'.
ELSE.
   ER = 0.
ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form VALID_MODI_PRODUCTOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_modi_productos .

  MESSAGE 'Llegua aqui 'TYPE 'I'.
  ER = 0.

*---------Validacion-------------
*--------Proveedores-------------
*----------DESCRIPCION----------------
tc = 'DESCRIPCION'.
l_string = ztc_productos-DESCRIPCION.
IF ztc_productos-descripcion IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*---------Validacion-------------
*--------Proveedores-------------
*----------COLOR----------------
tc = 'COLOR'.
l_string = ztc_productos-COLOR.
IF ztc_productos-COLOR IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*--------Proveedores-------------
*----------TALLA----------------
tc = 'TALLA'.
l_string = ztc_productos-TALLA.
IF ztc_productos-TALLA IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*------------Proveedores-------------------
*------------EXISTENCIA-------------------
tc = 'EXISTENCIA'.
l_string = ztc_productos-EXISTENCIA.
IF ztc_productos-EXISTENCIA ge 0 .
    er = er + 1.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*------------Proveedores-------------------
*------------PRECIO-------------------
tc = 'PRECIO'.
l_string = ztc_productos-PRECIO.
IF ztc_productos-precio ge 0 .
    er = er + 1.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

IF ER GT 4.
  PERFORM MODIFICAR_CATALOGOS USING 'PRODUCTO'.
  MESSAGE s006(zgi_cv_ms) WITH  tc DISPLAY LIKE 'S'.
ELSE.
   ER = 0.
ENDIF.


ENDFORM.



*&---------------------------------------------------------------------*
*& Form VALID_MODI_PROVEEDORES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_modi_proveedores .

ER = 0.

*---------Validacion-------------
*--------Proveedores-------------
*----------Nombre----------------
tc = 'NOMBRE'.
l_string = ztc_proveedores-nombre.
IF ztc_proveedores-nombre IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*-------------Proveedores------------------
*----------Apellido Paterno----------------
tc = 'APELLIDO PATERNO'.
l_string = ztc_proveedores-apellido_paterno.
IF ztc_proveedores-apellido_paterno IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------Apellido Materno----------------
tc = 'APELLIDO MATERNO'.
l_string = ztc_proveedores-apellido_materno.
IF ztc_proveedores-apellido_materno IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------Apellido Materno----------------
tc = 'APELLIDO MATERNO'.
l_string = ztc_proveedores-apellido_materno.
IF ztc_proveedores-apellido_materno IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------------RFC-----------------------
tc = 'RFC'.
l_string = ztc_proveedores-RFC.
IF ztc_proveedores-RFC IS NOT INITIAL.
    PERFORM valid_rfc_prov.
    IF reg_prod eq abap_true.
        PERFORM valid_palabras_ofensivas.
        IF reg_prod eq abap_true.
            er = er + 1.
          ELSE.
            MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------RAZON SOCIAL----------------
tc = 'RAZON SOCIAL'.
l_string = ztc_proveedores-RAZON_SOCIAL.
IF ztc_proveedores-RAZON_SOCIAL IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------CALLE----------------
tc = 'CALLE'.
l_string = ztc_proveedores-CALLE.
IF ztc_proveedores-CALLE IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------COLONIA----------------
tc = 'COLONIA'.
l_string = ztc_proveedores-COLONIA.
IF ztc_proveedores-COLONIA IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*-------------Proveedores------------------
*--------------MUNICIPIO-------------------
tc = 'MUNICIPIO'.
l_string = ztc_proveedores-MUNICIPIO.
IF ztc_proveedores-MUNICIPIO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*---------------ESTADO---------------------
tc = 'ESTADO'.
l_string = ztc_proveedores-ESTADO.
IF ztc_proveedores-ESTADO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*------------Proveedores-------------------
*------------NO_EXTERIOR-------------------
tc = 'NO_EXTERIOR'.
l_string = ztc_proveedores-NO_EXTERIOR.
IF ztc_proveedores-NO_EXTERIOR IS NOT INITIAL.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*------------Proveedores-------------------
*------------NO_INTERIOR-------------------
tc = 'NO_INTERIOR'.
l_string = ztc_proveedores-NO_INTERIOR.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.


*-------------Validacion-------------------
*------------Proveedores-------------------
*---------------CP-------------------------
tc = 'CP'.
l_string = ztc_proveedores-CP.
IF ztc_proveedores-CP IS NOT INITIAL.
    PERFORM valid_cp.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s008(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*------------Proveedores-------------------
*-------------TELEFONO1--------------------
tc = 'TELEFONO1'.
l_string = ztc_proveedores-TELEFONO1.
IF ztc_proveedores-TELEFONO1 IS NOT INITIAL.
    PERFORM valid_solo_nums.
      IF  reg_prod eq abap_true.
          PERFORM valid_telefono.
            IF  reg_prod eq abap_true.
                  er = er + 1.
                ELSE.
                  MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
            ENDIF.
      ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
      ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*------------Proveedores-------------------
*-------------TELEFONO2--------------------
tc = 'TELEFONO2'.
l_string = ztc_proveedores-TELEFONO2.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
      PERFORM valid_telefono.
           IF  reg_prod eq abap_true.
                 er = er + 1.
               ELSE.
                 MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
           ENDIF.
      ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.

*-------------Validacion-------------------
*------------Proveedores-------------------
*-------------EMAIL------------------------
tc = 'EMAIL'.
l_string = ztc_proveedores-EMAIL.
IF ztc_proveedores-EMAIL is NOT INITIAL.
    PERFORM valid_email.
    IF  reg_prod eq abap_true.
      PERFORM valid_palabras_ofensivas.
      IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       ENDIF.
       ELSE.
         MESSAGE s010(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.



*-------------Paso-------------------------
*--------------Al--------------------------
*------------Modificar------------------------
*
IF ER GT 15.
    PERFORM modificar_catalogos USING 'PROVEEDORES'.
    MESSAGE s006(zgi_cv_ms) WITH  tc DISPLAY LIKE 'S'.
  ELSE.
    ER = 0.
ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form VALID_MODI_EMPLEADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_modi_empleados .

*   MESSAGE 'Llegua aqui 'TYPE 'I'.

ER = 0.

*---------Validacion-------------
*--------EMPLEADOS-------------
*----------NOMBRE----------------
tc = 'NOMBRE'.
l_string = ztc_empleados-NOMBRE.
IF ztc_empleados-NOMBRE IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*--------EMPLEADOS-------------
*----------APELLIDO_PATERNO----------------
tc = 'APELLIDO_PATERNO'.
l_string = ztc_empleados-APELLIDO_PATERNO.
IF ztc_empleados-APELLIDO_PATERNO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*--------EMPLEADOS-------------
*----------APELLIDO_MATERNO----------------
tc = 'APELLIDO_MATERNO'.
l_string = ztc_empleados-APELLIDO_MATERNO.
IF ztc_empleados-APELLIDO_MATERNO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*----------------CURP-----------------------
tc = 'CURP'.
l_string = ztc_empleados-CURP.
IF ztc_empleados-CURP IS NOT INITIAL.
    PERFORM valid_curp.
    IF reg_prod eq abap_true.
        PERFORM valid_palabras_ofensivas.
        IF reg_prod eq abap_true.
            er = er + 1.
          ELSE.
            MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*----------------RFC-----------------------
tc = 'RFC'.
l_string = ztc_empleados-RFC.
IF ztc_empleados-RFC IS NOT INITIAL.
    PERFORM valid_rfc.
    IF reg_prod eq abap_true.
        PERFORM valid_palabras_ofensivas.
        IF reg_prod eq abap_true.
            er = er + 1.
          ELSE.
            MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*----------------NO_SEGURO-----------------------
tc = 'NO_SEGURO'.
l_string = ztc_empleados-NO_SEGURO.
IF ztc_empleados-NO_SEGURO IS NOT INITIAL.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------EMPLEADOS-------------
*----------CALLE----------------
tc = 'CALLE'.
l_string = ztc_empleados-CALLE.
IF ztc_empleados-CALLE IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------EMPLEADOS-------------
*----------COLONIA----------------
tc = 'COLONIA'.
l_string = ztc_empleados-COLONIA.
IF ztc_empleados-COLONIA IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS-------------
*--------------MUNICIPIO-------------------
tc = 'MUNICIPIO'.
l_string = ztc_empleados-MUNICIPIO.
IF ztc_empleados-MUNICIPIO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*---------------ESTADO---------------------
tc = 'ESTADO'.
l_string = ztc_empleados-ESTADO.
IF ztc_empleados-ESTADO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*------------NO_EXTERIOR-------------------
tc = 'NO_EXTERIOR'.
l_string = ztc_empleados-NO_EXTERIOR.
IF ztc_empleados-NO_EXTERIOR IS NOT INITIAL.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*------------NO_INTERIOR-------------------
tc = 'NO_INTERIOR'.
l_string = ztc_empleados-NO_INTERIOR.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*---------------CP-------------------------
tc = 'CP'.
l_string = ztc_empleados-CP.
IF ztc_empleados-CP IS NOT INITIAL.
    PERFORM valid_cp.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s008(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*-------------TELEFONO1--------------------
tc = 'TELEFONO1'.
l_string = ztc_empleados-TELEFONO1.
IF ztc_empleados-TELEFONO1 IS NOT INITIAL.
    PERFORM valid_solo_nums.
      IF  reg_prod eq abap_true.
          PERFORM valid_telefono.
            IF  reg_prod eq abap_true.
                  er = er + 1.
                ELSE.
                  MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
            ENDIF.
      ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
      ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*-------------TELEFONO2--------------------
tc = 'TELEFONO2'.
l_string = ztc_empleados-TELEFONO2.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
      PERFORM valid_telefono.
           IF  reg_prod eq abap_true.
                 er = er + 1.
               ELSE.
                 MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
           ENDIF.
      ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*-------------EMAIL------------------------
tc = 'EMAIL'.
l_string = ztc_empleados-EMAIL.
IF ztc_empleados-EMAIL IS NOT INITIAL.
    PERFORM valid_email.
    IF  reg_prod eq abap_true.
      PERFORM valid_palabras_ofensivas.
      IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       ENDIF.
       ELSE.
         MESSAGE s010(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

IF ER GT 15.
  PERFORM MODIFICAR_CATALOGOS USING 'MAQUILERO'.
  MESSAGE s006(zgi_cv_ms) WITH  tc DISPLAY LIKE 'S'.
ELSE.
   ER = 0.
ENDIF.


ENDFORM.


*&---------------------------------------------------------------------*
*& Form VALID_modi_CLIENTES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_modi_clientes .

*  MESSAGE 'Llega aqui' TYPE 'I'.
ER = 0.

*---------Validacion-------------
*--------CLIENTES-------------
*----------NOMBRE----------------
tc = 'NOMBRE'.
l_string = ztc_clientes-NOMBRE.
IF ztc_clientes-NOMBRE IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*--------CLIENTES-------------
*----------APELLIDO_PATERNO----------------
tc = 'APELLIDO_PATERNO'.
l_string = ztc_clientes-APELLIDO_PATERNO.
IF ztc_clientes-APELLIDO_PATERNO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*--------CLIENTES-------------
*----------APELLIDO_MATERNO----------------
tc = 'APELLIDO_MATERNO'.
l_string = ztc_clientes-APELLIDO_MATERNO.
IF ztc_clientes-APELLIDO_MATERNO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*----------------RFC-----------------------
tc = 'RFC'.
l_string = ztc_clientes-RFC.
IF ztc_clientes-RFC IS NOT INITIAL.
    PERFORM valid_rfc_clie.
    IF reg_prod eq abap_true.
        PERFORM valid_palabras_ofensivas.
        IF reg_prod eq abap_true.
            er = er + 1.
          ELSE.
            MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*----------RAZON SOCIAL----------------
tc = 'RAZON SOCIAL'.
l_string = ztc_clientes-RAZON_SOCIAL.
IF ztc_clientes-RAZON_SOCIAL IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*----------CALLE----------------
tc = 'CALLE'.
l_string = ztc_clientes-CALLE.
IF ztc_clientes-CALLE IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*----------COLONIA----------------
tc = 'COLONIA'.
l_string = ztc_clientes-COLONIA.
IF ztc_clientes-COLONIA IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*--------------MUNICIPIO-------------------
tc = 'MUNICIPIO'.
l_string = ztc_clientes-MUNICIPIO.
IF ztc_clientes-MUNICIPIO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*---------------ESTADO---------------------
tc = 'ESTADO'.
l_string = ztc_clientes-ESTADO.
IF ztc_clientes-ESTADO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s001(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*------------NO_EXTERIOR-------------------
tc = 'NO_EXTERIOR'.
l_string = ztc_clientes-NO_EXTERIOR.
IF ztc_clientes-NO_EXTERIOR IS NOT INITIAL.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*------------NO_INTERIOR-------------------
tc = 'NO_INTERIOR'.
l_string = ztc_clientes-NO_INTERIOR.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s002(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*---------------CP-------------------------
tc = 'CP'.
l_string = ztc_clientes-CP.
IF ztc_clientes-CP IS NOT INITIAL.
    PERFORM valid_cp.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s008(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*--------CLIENTES-------------
*-------------TELEFONO1--------------------
tc = 'TELEFONO1'.
l_string = ztc_clientes-TELEFONO1.
IF ztc_clientes-TELEFONO1 IS NOT INITIAL.
    PERFORM valid_solo_nums.
      IF  reg_prod eq abap_true.
          PERFORM valid_telefono.
            IF  reg_prod eq abap_true.
                  er = er + 1.
                ELSE.
                  MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
            ENDIF.
      ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
      ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*-------------TELEFONO2--------------------
tc = 'TELEFONO2'.
l_string = ztc_clientes-TELEFONO2.
    PERFORM valid_solo_nums.
      IF  reg_prod eq abap_true.
        PERFORM valid_telefono.
             IF  reg_prod eq abap_true.
                   er = er + 1.
                 ELSE.
                   MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
             ENDIF.
        ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
      ENDIF.


*-------------Validacion-------------------
*--------CLIENTES-------------
*-------------EMAIL------------------------
tc = 'EMAIL'.
l_string = ztc_clientes-EMAIL.
IF ztc_clientes-EMAIL IS NOT INITIAL.
    PERFORM valid_email.
    IF  reg_prod eq abap_true.
      PERFORM valid_palabras_ofensivas.
      IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s003(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       ENDIF.
       ELSE.
         MESSAGE s010(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s000(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Paso-------------------------
*--------------Al--------------------------
*------------MODIFICAR------------------------
*
IF ER GT 14.
  PERFORM MODIFICAR_CATALOGOS USING 'CLIENTE'.
  MESSAGE s006(zgi_cv_ms) WITH  tc DISPLAY LIKE 'S'.
ELSE.
    ER = 0.
ENDIF.

ENDFORM.


**************************************************************************************
*                     SUBRUTINAS PARA LA INSERCION DE CATALOGOS                   *
**************************************************************************************
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*-----------------------VALIDACION-------------------------------------*
*--------------------------PARA----------------------------------------*
*----------------------INSERCION------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form VALID_INSERT_MATERIALES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_materiales .

  ER = 0.

*---------Validacion-------------
*----------MATERIALES-------------
*----------DESCRIPCION------------
tc = 'DESCRIPCION'.
l_string = ZTC_MATERIALES-DESCRIPCION.
IF ZTC_MATERIALES-descripcion IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*----------MATERIALES-------------
*----------COLOR------------
tc = 'COLOR'.
l_string = ZTC_MATERIALES-COLOR.
IF ZTC_MATERIALES-COLOR IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*----------MATERIALES-------------
*----------ROLLOS------------
tc = 'ROLLOS'.
l_string = ZTC_MATERIALES-ROLLOS.
IF ZTC_MATERIALES-ROLLOS ge 0 .
    er = er + 1.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*----------MATERIALES-------------
*----------ROLLOS_INCOMPLETOS------------
tc = 'ROLLOS_INCOMPLETOS'.
l_string = ZTC_MATERIALES-ROLLOS_INCOMPLETOS.
IF ZTC_MATERIALES-ROLLOS_INCOMPLETOS ge 0 .
    er = er + 1.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*----------MATERIALES-------------
*----------PESO------------
tc = 'PESO'.
l_string = ZTC_MATERIALES-PESO.
IF ZTC_MATERIALES-PESO ge 0 .
    er = er + 1.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

IF ER GT 4.
  PERFORM INSERT_MATERIALES.
  ELSE.
   ER = 0.
ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form VALID_INSERT_PRODUCTOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_productos .

  MESSAGE 'Llegua aqui 'TYPE 'I'.
  ER = 0.

*---------Validacion-------------
*--------Proveedores-------------
*----------DESCRIPCION----------------
tc = 'DESCRIPCION'.
l_string = ztc_productos-DESCRIPCION.
IF ztc_productos-descripcion IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*---------Validacion-------------
*--------Proveedores-------------
*----------COLOR----------------
tc = 'COLOR'.
l_string = ztc_productos-COLOR.
IF ztc_productos-COLOR IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*--------Proveedores-------------
*----------TALLA----------------
tc = 'TALLA'.
l_string = ztc_productos-TALLA.
IF ztc_productos-TALLA IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*------------Proveedores-------------------
*------------EXISTENCIA-------------------
tc = 'EXISTENCIA'.
l_string = ztc_productos-EXISTENCIA.
IF ztc_productos-EXISTENCIA ge 0 .
    er = er + 1.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*------------Proveedores-------------------
*------------PRECIO-------------------
tc = 'PRECIO'.
l_string = ztc_productos-PRECIO.
IF ztc_productos-precio ge 0 .
    er = er + 1.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.
*-----------------------------------
*-----------------------------------
*-----------------------------------
IF ER GT 4.
  PERFORM INSERT_PRODUCTOS.
  ELSE.
   ER = 0.
ENDIF.


ENDFORM.


*&---------------------------------------------------------------------*
*& Form VALID_PROV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_proveedores .

ER = 0.

*---------Validacion-------------
*--------Proveedores-------------
*----------Nombre----------------
tc = 'NOMBRE'.
l_string = ztc_proveedores-nombre.
IF ztc_proveedores-nombre IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*-------------Proveedores------------------
*----------Apellido Paterno----------------
tc = 'APELLIDO PATERNO'.
l_string = ztc_proveedores-apellido_paterno.
IF ztc_proveedores-apellido_paterno IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------Apellido Materno----------------
tc = 'APELLIDO MATERNO'.
l_string = ztc_proveedores-apellido_materno.
IF ztc_proveedores-apellido_materno IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------Apellido Materno----------------
tc = 'APELLIDO MATERNO'.
l_string = ztc_proveedores-apellido_materno.
IF ztc_proveedores-apellido_materno IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------------RFC-----------------------
tc = 'RFC'.
l_string = ztc_proveedores-RFC.
IF ztc_proveedores-RFC IS NOT INITIAL.
    PERFORM valid_rfc_prov.
    IF reg_prod eq abap_true.
        PERFORM valid_palabras_ofensivas.
        IF reg_prod eq abap_true.
            er = er + 1.
          ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------RAZON SOCIAL----------------
tc = 'RAZON SOCIAL'.
l_string = ztc_proveedores-RAZON_SOCIAL.
IF ztc_proveedores-RAZON_SOCIAL IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------CALLE----------------
tc = 'CALLE'.
l_string = ztc_proveedores-CALLE.
IF ztc_proveedores-CALLE IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*----------COLONIA----------------
tc = 'COLONIA'.
l_string = ztc_proveedores-COLONIA.
IF ztc_proveedores-COLONIA IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*-------------Proveedores------------------
*--------------MUNICIPIO-------------------
tc = 'MUNICIPIO'.
l_string = ztc_proveedores-MUNICIPIO.
IF ztc_proveedores-MUNICIPIO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------Proveedores------------------
*---------------ESTADO---------------------
tc = 'ESTADO'.
l_string = ztc_proveedores-ESTADO.
IF ztc_proveedores-ESTADO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*------------Proveedores-------------------
*------------NO_EXTERIOR-------------------
tc = 'NO_EXTERIOR'.
l_string = ztc_proveedores-NO_EXTERIOR.
IF ztc_proveedores-NO_EXTERIOR IS NOT INITIAL.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*------------Proveedores-------------------
*------------NO_INTERIOR-------------------
tc = 'NO_INTERIOR'.
l_string = ztc_proveedores-NO_INTERIOR.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.


*-------------Validacion-------------------
*------------Proveedores-------------------
*---------------CP-------------------------
tc = 'CP'.
l_string = ztc_proveedores-CP.
IF ztc_proveedores-CP IS NOT INITIAL.
    PERFORM valid_cp.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*------------Proveedores-------------------
*-------------TELEFONO1--------------------
tc = 'TELEFONO1'.
l_string = ztc_proveedores-TELEFONO1.
IF ztc_proveedores-TELEFONO1 IS NOT INITIAL.
    PERFORM valid_solo_nums.
      IF  reg_prod eq abap_true.
          PERFORM valid_telefono.
            IF  reg_prod eq abap_true.
                  er = er + 1.
                ELSE.
                  MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
            ENDIF.
      ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
      ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*------------Proveedores-------------------
*-------------TELEFONO2--------------------
tc = 'TELEFONO2'.
l_string = ztc_proveedores-TELEFONO2.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
      PERFORM valid_telefono.
           IF  reg_prod eq abap_true.
                 er = er + 1.
               ELSE.
                 MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
           ENDIF.
      ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.

*-------------Validacion-------------------
*------------Proveedores-------------------
*-------------EMAIL------------------------
tc = 'EMAIL'.
l_string = ztc_proveedores-EMAIL.
IF ztc_proveedores-EMAIL is NOT INITIAL.
    PERFORM valid_email.
    IF  reg_prod eq abap_true.
      PERFORM valid_palabras_ofensivas.
      IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       ENDIF.
       ELSE.
         MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Paso-------------------------
*--------------Al--------------------------
*------------INSERT------------------------

IF ER GT 15.
  PERFORM INSERT_PROVEEDORES.
  ELSE.
   ER = 0.
ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_INSERT_EMPLEADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_empleados .

*   MESSAGE 'Llegua aqui 'TYPE 'I'.

ER = 0.

*---------Validacion-------------
*--------EMPLEADOS-------------
*----------NOMBRE----------------
tc = 'NOMBRE'.
l_string = ztc_empleados-NOMBRE.
IF ztc_empleados-NOMBRE IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*--------EMPLEADOS-------------
*----------APELLIDO_PATERNO----------------
tc = 'APELLIDO_PATERNO'.
l_string = ztc_empleados-APELLIDO_PATERNO.
IF ztc_empleados-APELLIDO_PATERNO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*--------EMPLEADOS-------------
*----------APELLIDO_MATERNO----------------
tc = 'APELLIDO_MATERNO'.
l_string = ztc_empleados-APELLIDO_MATERNO.
IF ztc_empleados-APELLIDO_MATERNO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*----------------CURP-----------------------
tc = 'CURP'.
l_string = ztc_empleados-CURP.
IF ztc_empleados-CURP IS NOT INITIAL.
    PERFORM valid_curp.
    IF reg_prod eq abap_true.
        PERFORM valid_palabras_ofensivas.
        IF reg_prod eq abap_true.
            er = er + 1.
          ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*----------------RFC-----------------------
tc = 'RFC'.
l_string = ztc_empleados-RFC.
IF ztc_empleados-RFC IS NOT INITIAL.
    PERFORM valid_rfc.
    IF reg_prod eq abap_true.
        PERFORM valid_palabras_ofensivas.
        IF reg_prod eq abap_true.
            er = er + 1.
          ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*----------------NO_SEGURO-----------------------
tc = 'NO_SEGURO'.
l_string = ztc_empleados-NO_SEGURO.
IF ztc_empleados-NO_SEGURO IS NOT INITIAL.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------EMPLEADOS-------------
*----------CALLE----------------
tc = 'CALLE'.
l_string = ztc_empleados-CALLE.
IF ztc_empleados-CALLE IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------EMPLEADOS-------------
*----------COLONIA----------------
tc = 'COLONIA'.
l_string = ztc_empleados-COLONIA.
IF ztc_empleados-COLONIA IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS-------------
*--------------MUNICIPIO-------------------
tc = 'MUNICIPIO'.
l_string = ztc_empleados-MUNICIPIO.
IF ztc_empleados-MUNICIPIO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*---------------ESTADO---------------------
tc = 'ESTADO'.
l_string = ztc_empleados-ESTADO.
IF ztc_empleados-ESTADO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*------------NO_EXTERIOR-------------------
tc = 'NO_EXTERIOR'.
l_string = ztc_empleados-NO_EXTERIOR.
IF ztc_empleados-NO_EXTERIOR IS NOT INITIAL.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*------------NO_INTERIOR-------------------
tc = 'NO_INTERIOR'.
l_string = ztc_empleados-NO_INTERIOR.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*---------------CP-------------------------
tc = 'CP'.
l_string = ztc_empleados-CP.
IF ztc_empleados-CP IS NOT INITIAL.
    PERFORM valid_cp.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*-------------TELEFONO1--------------------
tc = 'TELEFONO1'.
l_string = ztc_empleados-TELEFONO1.
IF ztc_empleados-TELEFONO1 IS NOT INITIAL.
    PERFORM valid_solo_nums.
      IF  reg_prod eq abap_true.
          PERFORM valid_telefono.
            IF  reg_prod eq abap_true.
                  er = er + 1.
                ELSE.
                  MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
            ENDIF.
      ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
      ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*-------------TELEFONO2--------------------
tc = 'TELEFONO2'.
l_string = ztc_empleados-TELEFONO2.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
      PERFORM valid_telefono.
           IF  reg_prod eq abap_true.
                 er = er + 1.
               ELSE.
                 MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
           ENDIF.
      ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.

*-------------Validacion-------------------
*-------------EMPLEADOS------------------
*-------------EMAIL------------------------
tc = 'EMAIL'.
l_string = ztc_empleados-EMAIL.
IF ztc_empleados-EMAIL IS NOT INITIAL.
    PERFORM valid_email.
    IF  reg_prod eq abap_true.
      PERFORM valid_palabras_ofensivas.
      IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       ENDIF.
       ELSE.
         MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

IF ER GT 15.
  PERFORM INSERT_EMPLEADOS.
  ELSE.
   ER = 0.
ENDIF.


ENDFORM.


*&---------------------------------------------------------------------*
*& Form VALID_INSERT_CLIENTES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_clientes .

*  MESSAGE 'Llega aqui' TYPE 'I'.
ER = 0.

*---------Validacion-------------
*--------CLIENTES-------------
*----------NOMBRE----------------
tc = 'NOMBRE'.
l_string = ztc_clientes-NOMBRE.
IF ztc_clientes-NOMBRE IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*--------CLIENTES-------------
*----------APELLIDO_PATERNO----------------
tc = 'APELLIDO_PATERNO'.
l_string = ztc_clientes-APELLIDO_PATERNO.
IF ztc_clientes-APELLIDO_PATERNO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*---------Validacion-------------
*--------CLIENTES-------------
*----------APELLIDO_MATERNO----------------
tc = 'APELLIDO_MATERNO'.
l_string = ztc_clientes-APELLIDO_MATERNO.
IF ztc_clientes-APELLIDO_MATERNO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*----------------RFC-----------------------
tc = 'RFC'.
l_string = ztc_clientes-RFC.
IF ztc_clientes-RFC IS NOT INITIAL.
    PERFORM valid_rfc_clie.
    IF reg_prod eq abap_true.
        PERFORM valid_palabras_ofensivas.
        IF reg_prod eq abap_true.
            er = er + 1.
          ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*----------RAZON SOCIAL----------------
tc = 'RAZON SOCIAL'.
l_string = ztc_clientes-RAZON_SOCIAL.
IF ztc_clientes-RAZON_SOCIAL IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*----------CALLE----------------
tc = 'CALLE'.
l_string = ztc_clientes-CALLE.
IF ztc_clientes-CALLE IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*----------COLONIA----------------
tc = 'COLONIA'.
l_string = ztc_clientes-COLONIA.
IF ztc_clientes-COLONIA IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_nums_lets.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*--------------MUNICIPIO-------------------
tc = 'MUNICIPIO'.
l_string = ztc_clientes-MUNICIPIO.
IF ztc_clientes-MUNICIPIO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*---------------ESTADO---------------------
tc = 'ESTADO'.
l_string = ztc_clientes-ESTADO.
IF ztc_clientes-ESTADO IS NOT INITIAL.
    PERFORM valid_espacios.
    IF  reg_prod eq abap_true.
        PERFORM valid_letras.
        IF  reg_prod eq abap_true.
              PERFORM valid_palabras_ofensivas.
                IF  reg_prod eq abap_true.
                    er = er + 1.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                  ENDIF.
            ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.
        ELSE.
        MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*------------NO_EXTERIOR-------------------
tc = 'NO_EXTERIOR'.
l_string = ztc_clientes-NO_EXTERIOR.
IF ztc_clientes-NO_EXTERIOR IS NOT INITIAL.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*------------NO_INTERIOR-------------------
tc = 'NO_INTERIOR'.
l_string = ztc_clientes-NO_INTERIOR.
    PERFORM valid_solo_nums.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*---------------CP-------------------------
tc = 'CP'.
l_string = ztc_clientes-CP.
IF ztc_clientes-CP IS NOT INITIAL.
    PERFORM valid_cp.
    IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.


*-------------Validacion-------------------
*--------CLIENTES-------------
*-------------TELEFONO1--------------------
tc = 'TELEFONO1'.
l_string = ztc_clientes-TELEFONO1.
IF ztc_clientes-TELEFONO1 IS NOT INITIAL.
    PERFORM valid_solo_nums.
      IF  reg_prod eq abap_true.
          PERFORM valid_telefono.
            IF  reg_prod eq abap_true.
                  er = er + 1.
                ELSE.
                  MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
            ENDIF.
      ELSE.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
      ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Validacion-------------------
*--------CLIENTES-------------
*-------------TELEFONO2--------------------
tc = 'TELEFONO2'.
l_string = ztc_clientes-TELEFONO2.
    PERFORM valid_solo_nums.
        IF  reg_prod eq abap_true.
          PERFORM valid_telefono.
               IF  reg_prod eq abap_true.
                     er = er + 1.
                   ELSE.
                     MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
               ENDIF.
          ELSE.
                MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
        ENDIF.


*-------------Validacion-------------------
*--------CLIENTES-------------
*-------------EMAIL------------------------
tc = 'EMAIL'.
l_string = ztc_clientes-EMAIL.
IF ztc_clientes-EMAIL IS NOT INITIAL.
    PERFORM valid_email.
    IF  reg_prod eq abap_true.
      PERFORM valid_palabras_ofensivas.
      IF  reg_prod eq abap_true.
          er = er + 1.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       ENDIF.
       ELSE.
         MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
ENDIF.

*-------------Paso-------------------------
*--------------Al--------------------------
*------------INSERT------------------------
*
IF ER GT 14.
  PERFORM INSERT_CLIENTES.
  ELSE.
    ER = 0.
ENDIF.

ENDFORM.




*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*--------------------------EXPRESIONES---------------------------------*
*------------------------------DE--------------------------------------*
*-------------------------VALIDACIONES---------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form VALID_ESPACIOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_espacios .

  l_regex = ' {2,5}'.                  " El ' {2,5}' define que si estan de 2 a 5 espacios seguidos se arrojara un aviso

  FIND ALL OCCURRENCES OF REGEX l_regex IN l_string "Aqui analizamos todas las veces que ocurre en el texto indicado
            IN CHARACTER MODE RESPECTING CASE
            MATCH COUNT l_matches RESULTS lt_match_result. "Aqui arrojamos la variable de repeticiones para saber que hacer dependiendo su valor

  IF l_matches LE 0. " Aqui es el if que decide si para al siguiete filtro o si este filtro si presento conidicencias.
    reg_prod = abap_true.
  ELSE.
*      MESSAGE 'Uno de los campos contiene mas de un espacio seguido' TYPE 'I'.
    reg_prod = abap_false.
*      return.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_LETRAS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_letras .

  l_regex = '[^A-Za-z Ññ]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

  FIND ALL OCCURRENCES OF REGEX l_regex IN l_string
            IN CHARACTER MODE RESPECTING CASE
            MATCH COUNT l_matches RESULTS lt_match_result.
  IF l_matches LE 0.
    reg_prod = abap_true.
  ELSE.
*            MESSAGE 'Uno de los campos contiene caracteres desconocidos' TYPE 'I'.
    reg_prod = abap_false.
*          return.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_PALABRAS_OFENSIVAS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_palabras_ofensivas .

    reg_prod = abap_true.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_SOLO_NUMS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_solo_nums .

  l_regex = '[^0-9]'. " El '[^0-9]' almacena todas las concidencias que sean numeros

  FIND ALL OCCURRENCES OF REGEX l_regex IN l_string
            IN CHARACTER MODE RESPECTING CASE
            MATCH COUNT l_matches RESULTS lt_match_result.
  IF l_matches LE 0.
    reg_prod = abap_true.
  ELSE.
*            MESSAGE 'Uno de los campos contiene caracteres desconocidos' TYPE 'I'.
    reg_prod = abap_false.
*          return.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form VALID_SOLO_rfc
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_rfc .

 DATA: str1 TYPE string,
       str2 TYPE string,
       str3 TYPE string.
  DATA cr TYPE I.
  DATA: var TYPE CHAR20,
        tam TYPE I.

    var = l_string.

    tam = STRLEN( var ).

  IF tam NE 13.

    reg_prod = abap_false.

    ELSE.

      str1 = l_string+0(4).

      str2 = l_string+4(6).

      str3 = l_string+10(3).

      l_regex = '[^A-ZÑ]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

      FIND ALL OCCURRENCES OF REGEX l_regex IN str1
                IN CHARACTER MODE RESPECTING CASE
                MATCH COUNT l_matches RESULTS lt_match_result.
      IF l_matches LE 0.
        cr = cr + 1.
*        reg_prod = abap_true.
      ELSE.
        cr = 0.
*        reg_prod = abap_false.
      ENDIF.

      l_regex = '[^0-9]'. " El '[^0-9]' almacena todas las concidencias que sean numeros

      FIND ALL OCCURRENCES OF REGEX l_regex IN str2
                IN CHARACTER MODE RESPECTING CASE
                MATCH COUNT l_matches RESULTS lt_match_result.

      IF l_matches LE 0.
        cr = cr + 1.
*        reg_prod = abap_true.
      ELSE.
        cr = 0.
*        reg_prod = abap_false.
      ENDIF.


      l_regex = '[^A-ZÑ0-9]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

            FIND ALL OCCURRENCES OF REGEX l_regex IN str3
                      IN CHARACTER MODE RESPECTING CASE
                      MATCH COUNT l_matches RESULTS lt_match_result.
            IF l_matches LE 0.
              cr = cr + 1.
*              reg_prod = abap_true.
            ELSE.
              cr = 0.
*              reg_prod = abap_false.
            ENDIF.


        IF cr le 2.
*            MESSAGE 'El CURP es incorrecto' TYPE 'I'.
            reg_prod = abap_false.
            ELSE.
*            MESSAGE 'El CURP es correcto' TYPE 'I'.
            reg_prod = abap_true.
          ENDIF.

  ENDIF.



ENDFORM.

*&---------------------------------------------------------------------*
*& Form VALID_SOLO_nums_lets
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_nums_lets .

  l_regex = '[^ A-ZÑ0-9]'. " El '[A-Z]' almacena todas las concidencias que sean numeros

  FIND ALL OCCURRENCES OF REGEX l_regex IN l_string
            IN CHARACTER MODE RESPECTING CASE
            MATCH COUNT l_matches RESULTS lt_match_result.
  IF l_matches LE 0.

    reg_prod = abap_true.
  ELSE.
*            MESSAGE 'Uno de los campos contiene caracteres desconocidos' TYPE 'I'.
    reg_prod = abap_false.
*          return.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form VALID_SOLO_nums_lets
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_email .

DATA: matcher TYPE REF TO cl_abap_matcher.

matcher = cl_abap_matcher=>create(
  pattern = '^[^<>()\[\]\\,;:\s@"`]+@([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}$'
  text    = l_string ).

IF matcher->match( ) IS INITIAL.
  "No se reconocio como email
  reg_prod = abap_false.
*  MESSAGE 'Debe ingresar un email valido' TYPE 'W'.
ELSE.
  reg_prod = abap_true.
*  MESSAGE 'Es un email valido' TYPE 'S'.

ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form valid_cp
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_cp .

DATA: var TYPE CHAR10,
      tam TYPE N.

var = l_string.

CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
  EXPORTING
    input  = var
  IMPORTING
    output = var
  .

tam = STRLEN( var ).

IF tam le 4.
    reg_prod = abap_false.
  ELSE.
    reg_prod = abap_true.
ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form valid_curp
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_curp .

  DATA: str1 TYPE string,
        str2 TYPE string,
        str3 TYPE string.
  DATA  cr TYPE I.
  DATA: var TYPE CHAR20,
        tam TYPE I.

    var = l_string.

    tam = STRLEN( var ).

    IF tam NE 18.
        reg_prod = abap_false.
      ELSE.
        str1 = l_string+0(4).

        str2 = l_string+4(6).

        str3 = l_string+10(8).

        l_regex = '[^A-ZÑ]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

        FIND ALL OCCURRENCES OF REGEX l_regex IN str1
                  IN CHARACTER MODE RESPECTING CASE
                  MATCH COUNT l_matches RESULTS lt_match_result.
        IF l_matches LE 0.
          cr = cr + 1.
*          reg_prod = abap_true.
        ELSE.
          cr = 0.
*          reg_prod = abap_false.
        ENDIF.



        l_regex = '[^0-9]'. " El '[^0-9]' almacena todas las concidencias que sean numeros

        FIND ALL OCCURRENCES OF REGEX l_regex IN str2
                  IN CHARACTER MODE RESPECTING CASE
                  MATCH COUNT l_matches RESULTS lt_match_result.

        IF l_matches LE 0.
          cr = cr + 1.
*          reg_prod = abap_true.
        ELSE.
          cr = 0.
*          reg_prod = abap_false.
        ENDIF.

         l_regex = '[^A-ZÑ0-9]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

        FIND ALL OCCURRENCES OF REGEX l_regex IN str3
                  IN CHARACTER MODE RESPECTING CASE
                  MATCH COUNT l_matches RESULTS lt_match_result.
        IF l_matches LE 0.
          cr = cr + 1.
*          reg_prod = abap_true.
        ELSE.
          cr = 0.
*          reg_prod = abap_false.
        ENDIF.

        IF cr le 2.
*          MESSAGE 'El CURP es incorrecto' TYPE 'I'.
          reg_prod = abap_false.
          ELSE.
*          MESSAGE 'El CURP es correcto' TYPE 'I'.
          reg_prod = abap_true.
        ENDIF.
    ENDIF.





ENDFORM.
*&---------------------------------------------------------------------*
*& Form valid_telefono
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_telefono .

  DATA: var TYPE CHAR10,
        tam TYPE I.

  var = l_string.

CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
  EXPORTING
    input  = var
  IMPORTING
    output = var
  .

tam = STRLEN( var ).

IF tc eq 'TELEFONO2' and l_string IS INITIAL.
    reg_prod = abap_true.
  ELSE.
    IF tam NE 10.
        reg_prod = abap_false.
      ELSE.
        reg_prod = abap_true.
    ENDIF.
ENDIF.



ENDFORM.
*&---------------------------------------------------------------------*
*& Form valid_rfc_prov
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_rfc_prov .

  DATA: str1 TYPE string,
        str2 TYPE string,
        str3 TYPE string.
  DATA  cr TYPE I.
  DATA: var TYPE CHAR20,
        tam TYPE I.
  DATA  tp TYPE CHAR10.

  IF ztc_proveedores-tipo_persona EQ 'MORAL'.

          var = l_string.

          tam = STRLEN( var ).

        IF tam NE 12.

          reg_prod = abap_false.

          ELSE.

            str1 = l_string+0(3).

            str2 = l_string+3(6).

            str3 = l_string+9(3).

            l_regex = '[^A-ZÑ]'. " El '[^A-ZÑ]' almacena todas las concidencias que no sean de letras o un espacio

            FIND ALL OCCURRENCES OF REGEX l_regex IN str1
                      IN CHARACTER MODE RESPECTING CASE
                      MATCH COUNT l_matches RESULTS lt_match_result.
            IF l_matches LE 0.
              cr = cr + 1.
*              reg_prod = abap_true.
            ELSE.
              cr = 0.
*              reg_prod = abap_false.
            ENDIF.



            l_regex = '[^0-9]'. " El '[^0-9]' almacena todas las concidencias que sean numeros

            FIND ALL OCCURRENCES OF REGEX l_regex IN str2
                      IN CHARACTER MODE RESPECTING CASE
                      MATCH COUNT l_matches RESULTS lt_match_result.

            IF l_matches LE 0.
              cr = cr + 1.
*              reg_prod = abap_true.
            ELSE.
              cr = 0.
*              reg_prod = abap_false.
            ENDIF.


            l_regex = '[^A-ZÑ0-9]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

                  FIND ALL OCCURRENCES OF REGEX l_regex IN str3
                            IN CHARACTER MODE RESPECTING CASE
                            MATCH COUNT l_matches RESULTS lt_match_result.
                  IF l_matches LE 0.
                    cr = cr + 1.
*                    reg_prod = abap_true.
                  ELSE.
                    cr = 0.
*                    reg_prod = abap_false.
                  ENDIF.


              IF cr le 2.
*                  MESSAGE 'El CURP es incorrecto' TYPE 'I'.
                  reg_prod = abap_false.
                  ELSE.
*                  MESSAGE 'El CURP es correcto' TYPE 'I'.
                  reg_prod = abap_true.
                ENDIF.

            ENDIF.

    ELSEIF ztc_proveedores-tipo_persona EQ 'FISICA'.

          var = l_string.

          tam = STRLEN( var ).

        IF tam NE 13.

          reg_prod = abap_false.

          ELSE.

            str1 = l_string+0(4).

            str2 = l_string+4(6).

            str3 = l_string+10(3).

            l_regex = '[^A-ZÑ]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

            FIND ALL OCCURRENCES OF REGEX l_regex IN str1
                      IN CHARACTER MODE RESPECTING CASE
                      MATCH COUNT l_matches RESULTS lt_match_result.
            IF l_matches LE 0.
              cr = cr + 1.
*              reg_prod = abap_true.
            ELSE.
              cr = 0.
*              reg_prod = abap_false.
            ENDIF.

            l_regex = '[^0-9]'. " El '[^0-9]' almacena todas las concidencias que sean numeros

            FIND ALL OCCURRENCES OF REGEX l_regex IN str2
                      IN CHARACTER MODE RESPECTING CASE
                      MATCH COUNT l_matches RESULTS lt_match_result.

            IF l_matches LE 0.
              cr = cr + 1.
*              reg_prod = abap_true.
            ELSE.
              cr = 0.
*              reg_prod = abap_false.
            ENDIF.


            l_regex = '[^A-ZÑ0-9]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

                  FIND ALL OCCURRENCES OF REGEX l_regex IN str3
                            IN CHARACTER MODE RESPECTING CASE
                            MATCH COUNT l_matches RESULTS lt_match_result.
                  IF l_matches LE 0.
                    cr = cr + 1.
*                    reg_prod = abap_true.
                  ELSE.
                    cr = 0.
*                    reg_prod = abap_false.
                  ENDIF.


              IF cr le 2.
*                  MESSAGE 'El CURP es incorrecto' TYPE 'I'.
                  reg_prod = abap_false.
                  ELSE.
*                  MESSAGE 'El CURP es correcto' TYPE 'I'.
                  reg_prod = abap_true.
                ENDIF.

          ENDIF.

    ELSE.
      MESSAGE s012(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
  ENDIF.



ENDFORM.
*&---------------------------------------------------------------------*
*& Form valid_rfc_clie
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_rfc_clie .

  DATA: str1 TYPE string,
        str2 TYPE string,
        str3 TYPE string.
  DATA  cr TYPE I.
  DATA: var TYPE CHAR20,
        tam TYPE I.
  DATA  tp TYPE CHAR10.

  IF ztc_clientes-tipo_persona EQ 'MORAL'.

          var = l_string.

          tam = STRLEN( var ).

        IF tam NE 12.

          reg_prod = abap_false.

          ELSE.

            str1 = l_string+0(3).

            str2 = l_string+3(6).

            str3 = l_string+9(3).

            l_regex = '[^A-ZÑ]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

            FIND ALL OCCURRENCES OF REGEX l_regex IN str1
                      IN CHARACTER MODE RESPECTING CASE
                      MATCH COUNT l_matches RESULTS lt_match_result.
            IF l_matches LE 0.
              cr = cr + 1.
*              reg_prod = abap_true.
            ELSE.
              cr = 0.
*              reg_prod = abap_false.
            ENDIF.

            l_regex = '[^0-9]'. " El '[^0-9]' almacena todas las concidencias que sean numeros

            FIND ALL OCCURRENCES OF REGEX l_regex IN str2
                      IN CHARACTER MODE RESPECTING CASE
                      MATCH COUNT l_matches RESULTS lt_match_result.

            IF l_matches LE 0.
              cr = cr + 1.
*              reg_prod = abap_true.
            ELSE.
              cr = 0.
*              reg_prod = abap_false.
            ENDIF.


            l_regex = '[^A-ZÑ0-9]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

                  FIND ALL OCCURRENCES OF REGEX l_regex IN str3
                            IN CHARACTER MODE RESPECTING CASE
                            MATCH COUNT l_matches RESULTS lt_match_result.
                  IF l_matches LE 0.
                    cr = cr + 1.
*                    reg_prod = abap_true.
                  ELSE.
                    cr = 0.
*                    reg_prod = abap_false.
                  ENDIF.


              IF cr le 2.
*                  MESSAGE 'El CURP es incorrecto' TYPE 'I'.
                  reg_prod = abap_false.
                  ELSE.
*                  MESSAGE 'El CURP es correcto' TYPE 'I'.
                  reg_prod = abap_true.
                ENDIF.

            ENDIF.

    ELSEIF ztc_clientes-tipo_persona EQ 'FISICA'.

          var = l_string.

          tam = STRLEN( var ).

        IF tam NE 13.

          reg_prod = abap_false.

          ELSE.

            str1 = l_string+0(4).

            str2 = l_string+4(6).

            str3 = l_string+10(3).

            l_regex = '[^A-ZÑ]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

            FIND ALL OCCURRENCES OF REGEX l_regex IN str1
                      IN CHARACTER MODE RESPECTING CASE
                      MATCH COUNT l_matches RESULTS lt_match_result.
            IF l_matches LE 0.
              cr = cr + 1.
*              reg_prod = abap_true.
            ELSE.
              cr = 0.
*              reg_prod = abap_false.
            ENDIF.

            l_regex = '[^0-9]'. " El '[^0-9]' almacena todas las concidencias que sean numeros

            FIND ALL OCCURRENCES OF REGEX l_regex IN str2
                      IN CHARACTER MODE RESPECTING CASE
                      MATCH COUNT l_matches RESULTS lt_match_result.

            IF l_matches LE 0.
              cr = cr + 1.
*              reg_prod = abap_true.
            ELSE.
              cr = 0.
*              reg_prod = abap_false.
            ENDIF.


            l_regex = '[^A-ZÑ0-9]'. " El '[^A-Z ]' almacena todas las concidencias que no sean de letras o un espacio

                  FIND ALL OCCURRENCES OF REGEX l_regex IN str3
                            IN CHARACTER MODE RESPECTING CASE
                            MATCH COUNT l_matches RESULTS lt_match_result.
                  IF l_matches LE 0.
                    cr = cr + 1.
*                    reg_prod = abap_true.
                  ELSE.
                    cr = 0.
*                    reg_prod = abap_false.
                  ENDIF.


              IF cr le 2.
*                  MESSAGE 'El CURP es incorrecto' TYPE 'I'.
                  reg_prod = abap_false.
                  ELSE.
*                  MESSAGE 'El CURP es correcto' TYPE 'I'.
                  reg_prod = abap_true.
                ENDIF.

          ENDIF.

    ELSE.
      MESSAGE s012(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form borrar_campos
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM borrar_campos.

  IF DD EQ 1.
    CLEAR: ZTC_PROVEEDORES-nombre,
           ZTC_PROVEEDORES-APELLIDO_PATERNO,
           ZTC_PROVEEDORES-APELLIDO_MATERNO,
           ZTC_PROVEEDORES-TIPO_PERSONA,
           ZTC_PROVEEDORES-RFC,
           ZTC_PROVEEDORES-RAZON_SOCIAL,
           ZTC_PROVEEDORES-REGIMEN_FISCAL,
           ZTC_PROVEEDORES-CALLE,
           ZTC_PROVEEDORES-COLONIA,
           ZTC_PROVEEDORES-MUNICIPIO,
           ZTC_PROVEEDORES-ESTADO,
           ZTC_PROVEEDORES-NO_EXTERIOR,
           ZTC_PROVEEDORES-NO_INTERIOR,
           ZTC_PROVEEDORES-CP,
           ZTC_PROVEEDORES-TELEFONO1,
           ZTC_PROVEEDORES-TELEFONO2,
           ZTC_PROVEEDORES-EMAIL.
  ELSEIF DD EQ 2.
    CLEAR: ZTC_EMPLEADOS-id_empleado,
           ZTC_EMPLEADOS-nombre,
           ZTC_EMPLEADOS-apellido_paterno,
           ZTC_EMPLEADOS-apellido_materno,
           ZTC_EMPLEADOS-genero,
           ZTC_EMPLEADOS-fecha_nacimiento,
           ZTC_EMPLEADOS-curp,
           ZTC_EMPLEADOS-rfc,
           ZTC_EMPLEADOS-no_seguro,
           ZTC_EMPLEADOS-estado_civil,
           ZTC_EMPLEADOS-calle,
           ZTC_EMPLEADOS-colonia,
           ZTC_EMPLEADOS-municipio,
           ZTC_EMPLEADOS-estado,
           ZTC_EMPLEADOS-no_exterior,
           ZTC_EMPLEADOS-no_interior,
           ZTC_EMPLEADOS-cp,
           ZTC_EMPLEADOS-telefono1,
           ZTC_EMPLEADOS-telefono2,
           ZTC_EMPLEADOS-email.
  ELSEIF DD EQ 3.
    CLEAR: ZTC_CLIENTES-id_cliente,
           ZTC_CLIENTES-nombre,
           ZTC_CLIENTES-apellido_paterno,
           ZTC_CLIENTES-apellido_materno,
           ZTC_CLIENTES-tipo_persona,
           ZTC_CLIENTES-rfc,
           ZTC_CLIENTES-razon_social,
           ZTC_CLIENTES-regimen_fiscal,
           ZTC_CLIENTES-calle,
           ZTC_CLIENTES-colonia,
           ZTC_CLIENTES-municipio,
           ZTC_CLIENTES-estado,
           ZTC_CLIENTES-no_exterior,
           ZTC_CLIENTES-no_interior,
           ZTC_CLIENTES-cp,
           ZTC_CLIENTES-telefono1,
           ZTC_CLIENTES-telefono2,
           ZTC_CLIENTES-email.
  ELSEIF DD EQ 4.
    CLEAR: ZTC_MATERIALES-id_material,
           ZTC_MATERIALES-descripcion,
           ZTC_MATERIALES-color,
           ZTC_MATERIALES-rollos,
           ZTC_MATERIALES-rollos_incompletos,
           ZTC_MATERIALES-peso.
  ELSEIF DD EQ 5.
    CLEAR: ZTC_PRODUCTOS-ID_PRODUCTO,
           ZTC_PRODUCTOS-DESCRIPCION,
           ZTC_PRODUCTOS-COLOR,
           ZTC_PRODUCTOS-TALLA,
           ZTC_PRODUCTOS-EXISTENCIA,
           ZTC_PRODUCTOS-PRECIO.
  ELSEIF DD EQ 6.
    CLEAR: ZTC_PROVEEDORES-nombre,
           ZTC_PROVEEDORES-APELLIDO_PATERNO,
           ZTC_PROVEEDORES-APELLIDO_MATERNO,
           ZTC_PROVEEDORES-TIPO_PERSONA,
           ZTC_PROVEEDORES-RFC,
           ZTC_PROVEEDORES-RAZON_SOCIAL,
           ZTC_PROVEEDORES-REGIMEN_FISCAL,
           ZTC_PROVEEDORES-CALLE,
           ZTC_PROVEEDORES-COLONIA,
           ZTC_PROVEEDORES-MUNICIPIO,
           ZTC_PROVEEDORES-ESTADO,
           ZTC_PROVEEDORES-NO_EXTERIOR,
           ZTC_PROVEEDORES-NO_INTERIOR,
           ZTC_PROVEEDORES-CP,
           ZTC_PROVEEDORES-TELEFONO1,
           ZTC_PROVEEDORES-TELEFONO2,
           ZTC_PROVEEDORES-EMAIL.
  ELSEIF DD EQ 7.
    CLEAR: ZTC_PRODUCTOS-ID_PRODUCTO,
           ZTC_PRODUCTOS-DESCRIPCION,
           ZTC_PRODUCTOS-COLOR,
           ZTC_PRODUCTOS-TALLA,
           ZTC_PRODUCTOS-EXISTENCIA,
           ZTC_PRODUCTOS-PRECIO.
  ELSEIF DD EQ 8.
    CLEAR: ZTC_EMPLEADOS-id_empleado,
           ZTC_EMPLEADOS-nombre,
           ZTC_EMPLEADOS-apellido_paterno,
           ZTC_EMPLEADOS-apellido_materno,
           ZTC_EMPLEADOS-genero,
           ZTC_EMPLEADOS-fecha_nacimiento,
           ZTC_EMPLEADOS-curp,
           ZTC_EMPLEADOS-rfc,
           ZTC_EMPLEADOS-no_seguro,
           ZTC_EMPLEADOS-estado_civil,
           ZTC_EMPLEADOS-calle,
           ZTC_EMPLEADOS-colonia,
           ZTC_EMPLEADOS-municipio,
           ZTC_EMPLEADOS-estado,
           ZTC_EMPLEADOS-no_exterior,
           ZTC_EMPLEADOS-no_interior,
           ZTC_EMPLEADOS-cp,
           ZTC_EMPLEADOS-telefono1,
           ZTC_EMPLEADOS-telefono2,
           ZTC_EMPLEADOS-email.
  ELSEIF DD EQ 9.
    CLEAR: ZTC_CLIENTES-id_cliente,
           ZTC_CLIENTES-nombre,
           ZTC_CLIENTES-apellido_paterno,
           ZTC_CLIENTES-apellido_materno,
           ZTC_CLIENTES-tipo_persona,
           ZTC_CLIENTES-rfc,
           ZTC_CLIENTES-razon_social,
           ZTC_CLIENTES-regimen_fiscal,
           ZTC_CLIENTES-calle,
           ZTC_CLIENTES-colonia,
           ZTC_CLIENTES-municipio,
           ZTC_CLIENTES-estado,
           ZTC_CLIENTES-no_exterior,
           ZTC_CLIENTES-no_interior,
           ZTC_CLIENTES-cp,
           ZTC_CLIENTES-telefono1,
           ZTC_CLIENTES-telefono2,
           ZTC_CLIENTES-email.
  ELSEIF DD EQ 10.
    CLEAR: ZTC_MATERIALES-id_material,
           ZTC_MATERIALES-descripcion,
           ZTC_MATERIALES-color,
           ZTC_MATERIALES-rollos,
           ZTC_MATERIALES-rollos_incompletos,
           ZTC_MATERIALES-peso.
  ENDIF.

ENDFORM.
















" no tocar :v
*&---------------------------------------------------------------------*
*& Form INSERT_MATERIALS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM insert_materials .
*
*  TYPES: BEGIN OF GTY_VALORES1,
*         FOLIO_ENT_MAT TYPE ZFOLIO_ENT_MAT,
*         ID_PROVEEDOR TYPE ZID_PROVEEDOR,
*         FECHA_ENTRADA TYPE ZFECHAENTRADA,
*         ALMACENISTA TYPE ZALMACENISTA,
*         END OF GTY_VALORES1.
*  TYPES: BEGIN OF GTY_VALORES2,
*         FOLIO_ENT_MAT TYPE ZFOLIO_ENT_MAT,
*         ID_MATERIAL TYPE ZID_MATERIAL,
*         ROLLOS TYPE ZROLLOS_TELA,
*         METROS TYPE ZMETROS_TELA,
*         PESO TYPE ZPESO_TELA,
*         END OF GTY_VALORES2.
*
*  DATA: GT_VALORES1 TYPE STANDARD TABLE OF GTY_VALORES1,
*        GT_VALORES2 TYPE STANDARD TABLE OF GTY_VALORES2.
*
*  SELECT * FROM ZTT_ENT_MAT
*    INTO CORRESPONDING FIELDS OF TABLE GT_VALORES1.
*    IF SY-SUBRC EQ 0.
*      INSERT ZTC_ENT_MATERIAL FROM TABLE GT_VALORES1.
*    ENDIF.
*  SELECT * FROM ZTT_ENT_MAT
*    INTO CORRESPONDING FIELDS OF TABLE GT_VALORES2.
*    IF SY-SUBRC EQ 0.
*      INSERT ZTC_ENT_MAT_DETA FROM TABLE GT_VALORES2.
*    ENDIF.
*
*
*ENDFORM.
*&---------------------------------------------------------------------*
*& Form LIMPIAR_MOVIMIENTOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM limpiar_movimientos .

  IF dyn_mov EQ 'ENT_MAT'.
      PERFORM delet_alv_ent_mat.
      CLEAR:ZTT_ENT_MAT-folio_ent_mat,
            ZTT_ENT_MAT-ID_PROVEEDOR,
            ztc_proveedores-NOMBRE,
            ZTT_ENT_MAT-ALMACENISTA,
            ZTT_ENT_MAT-FECHA_ENTRADA.
  ENDIF.

  IF dyn_mov EQ 'SAL_MAT'.
      PERFORM DELETE_SAL_MAT.
      CLEAR: ztt_sal_mat-folio_sal_mat,
             ZTC_EMPLEADOS-NOMBRE,
             ztt_sal_mat-id_empleado,
             ztt_sal_mat-fecha_salida,
             ztt_sal_mat-almacenista,
             ztt_sal_mat-peso_total,
             ztt_sal_mat-peso_restante.
  ENDIF.

ENDFORM.
