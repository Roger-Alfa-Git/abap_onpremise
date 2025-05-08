@AbapCatalog.sqlViewName: 'ZVB_04_01_ALFA10'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Path Expressions'
@Metadata.ignorePropagatedAnnotations: true
define view ZB_04_01_ALFA10
  as select from sflight
  association to saplane on sflight.planetype = saplane.planetype
{
  carrid,
  connid,
  planetype,
  saplane
}
