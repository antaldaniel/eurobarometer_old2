#' Create a canonical variable name for the R objects
#'
#' @param x A vector of the GESIS variable names
#' @importFrom stringr str_sub
#' @examples
#' canonical_name_create ( c("UPPER CASE VAR", "VAR NAME WITH % SYMBOL") )
#' @export


canonical_name_create <- function(x) {
  x <- trimws(tolower(as.character(x)))

  ##do the abbreviations first that may have a . sign
  x <- gsub( '\\ss\\.a\\.', '_sa', x)

  x <- gsub( '\\&', '_and_', x)
  x <- gsub( '\\+', '_plus_', x)
  x <- gsub( '\\%', '_pct_', x)

  x <- gsub('\\.|-|\\:|\\;|\\/|\\(|\\)|\\!', '_', x)
  x <- gsub('\\s\\s', '\\s', x)

  x <- ifelse ( test = stringr::str_sub ( x, -1, -1 ) == '_',
                yes  = stringr::str_sub ( x,  1, -2 ),
                no   = x  )

  x <- gsub( '^q[abc]\\d{1,2}', '', x )  #remove QA1, QB25 etc
  x <- gsub( '^d\\d{1,2}', '', x )  #remove QA1, QB25 etc

  x <- gsub( '\\s', '_', x)
  x <- gsub( '___', '_', x)
  x <- gsub( '__', '_', x)

  x <- gsub( 'á', 'a', x)
  x <- gsub( 'ü', 'u', x)
  x <- gsub( 'é', 'e', x)

  x <- ifelse ( test = stringr::str_sub ( x, 1, 1 ) == '_',
                yes  = stringr::str_sub ( x,  2, -1 ),
                no   = x  )
  x
}
