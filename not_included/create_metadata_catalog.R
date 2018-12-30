library(dplyr)

sav_directory <- 'C:/Users/Daniel Antal/OneDrive - Visegrad Investments/_data/data-raw/gesis'
directory_items <- dir ( sav_directory)
sav_files <- directory_items[ which( stringr::str_sub(directory_items, -3, -1) == 'sav') ]
length(sav_files)
successfully_read <- 0
start_read <- 1
end_read <- length(sav_files)
for ( i in start_read:end_read) {
  possibly_read_file <- purrr::possibly ( file_read, otherwise = NULL )

  message ( 'Trying to read ', file.path ( sav_directory, sav_files[i])  )
  tmp <- possibly_read_file ( file.path ( sav_directory, sav_files[i]) )

  if ( is.null(tmp)) {
    warning ( 'Failed to read ', file.path ( sav_directory, sav_files[i]) )
    next
  }

  possibly_names_get <- purrr::possibly (zacat_names_get, NULL)

  tmp_names_df <- possibly_names_get(tmp)

  if ( is.null(tmp_names_df)) {
    warning ( 'Failed to get the names of ', file.path ( sav_directory, sav_files[i]) )
    next
  }

  tmp_names_df$file_name <- sav_files[i]

  successfully_read <-  successfully_read + 1

  if ( successfully_read == 1 ) {
    names_df <- tmp_names_df
  } else {
    names_df <- rbind ( names_df, tmp_names_df)
    saveRDS(names_df, file.path('not_included', 'variable_names.rds'))
  }

} #end of loop in .sav files


names_df_2  <- names_df %>%
  mutate ( canonical_names = canonical_name_create( suggested_name ))
