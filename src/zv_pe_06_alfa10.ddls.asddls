@AbapCatalog.sqlViewName: 'ZV_PE_ALFA10'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Path Expressions'
@Metadata.ignorePropagatedAnnotations: true
define view ZV_PE_06_ALFA10
  as select from spfli
  association        to sflight  as _flights  on  spfli.carrid = _flights.carrid
                                              and spfli.connid = _flights.connid

  association [1..1] to sairport as _airports on  spfli.airpfrom = _airports.id
{
  _flights,
  _airports,
  spfli.carrid,
  spfli.connid,
  spfli.airpfrom
}
