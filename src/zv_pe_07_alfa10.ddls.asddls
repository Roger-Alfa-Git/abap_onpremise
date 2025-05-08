@AbapCatalog.sqlViewName: 'ZV_PE01_ALFA10'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Path Expressions'
@Metadata.ignorePropagatedAnnotations: true
define view ZV_PE_07_ALFA10
  as select from scarr
  association to ZV_PE_06_ALFA10 as _flights on scarr.carrid = _flights.carrid
{
  _flights,
  scarr.carrid,
  scarr.carrname
}
