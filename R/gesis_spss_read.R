#' Read in a GESIS SPSS file.
#'
#' @param path An object to be converted to character
#' @param zacat_id Default to \code{NULL}. Not used in this instance
#' of the method.
#' @param conversion Defaults to \code{'factor'}.
#' @importFrom purrr possibly
#' @importFrom haven read_spss is.labelled
#' @importFrom dplyr mutate_if
#' @examples
#' \dontrun{
#' ##use your own file:
#' gesis_spss_read(    path = file.path ( 'not_included', 'example.sav'),
#'                     zacat_id = NULL )
#' }
#' @export

gesis_spss_read <- function ( path = NULL,
                              zacat_id = NULL,
                              conversion = 'factor') {

  if ( ! is.null(path) ) {

    possibly_read_spss <-  purrr::possibly( haven::read_spss,
                                            otherwise = NULL)
    try_read <- possibly_read_spss
    read_df <- try_read ( path )

    if ( is.null(read_df) ) {
      stop ( "File could not be found or read.")
    }

  } else if ( ! is.null(zacat_id) ) {

    message ( "this is not yeat written")

  } else {
    stop ('No path or zacat_id given.')
  }

  if ( is.null ( conversion ) ) {
    return(read_df)
  }

  message ( "Read ", path, '\n', "Continue to change labelled variables to ", conversion )

  read_df_relevelled <- dplyr::mutate_if ( read_df,
                                           haven::is.labelled,
                                           haven::as_factor )

  if ( conversion == 'factor' ) {
    return ( read_df_relevelled )
  } else if ( conversion == 'character' )  {
    read_df_relevelled <- dplyr::mutate_if ( read_df_relevelled,
                                             is.factor,
                                             as.character )
    return( read_df_relevelled )

  } else {

    warning ( conversion, 'is not meaningful, returning values as factors')
    return ( read_df_relevelled )
  }

}
