@AbapCatalog.sqlViewName: 'ZALFA10_V_AIRL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airline'
@VDM.viewType: #BASIC
@Analytics:{
    dataCategory: #DIMENSION
    }
define view ZALFA10_CDS_AIRL as select from scarr
{
    key carrid as AirlineID,
    carrname as AirlineName,
    @Semantics.currencyCode: true
    currcode as AirlineLocalCurrency,
    @Semantics.url: {
        mimeType: 'AirlineUrl'
    }
    url as AirlineUrl
}
