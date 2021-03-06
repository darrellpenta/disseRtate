#' Helper functions for creating factor_summary_data
#'
#' @inheritParams summary_stats
#' @param ... ignored arguments to other functions
#' @rdname factor_summary_helpers
#' @include combine_factor_levels-function.R
#' @include sweet_dots-function.R
#' @include standard_error-function.R

#' Summarize with subsets
#' @rdname factor_summary_helpers
#' @export

summary_subset <- function(.data, .ind_var, .dep_var, ...) {
  sub_set_out <-
    combine_factor_levels(
      tibble::tibble("data" = .ind_var),
      m = length(.ind_var):1,
      simplify = FALSE,
      byrow = TRUE
    ) %>%
    unlist(recursive = FALSE,
           use.names = FALSE) %>%
    lapply(function(ind_var_,
                    dat = .data,
                    dep_var_ = .dep_var) {
      summary_stats(.data = dplyr::ungroup(dat),
                    .dep_var = dep_var_,
                    .ind_var = ind_var_)

    })
  sub_set_out
}

#' Combine summaries
#' @rdname factor_summary_helpers
#' @export
#'

summary_combine <- function(.data, ...) {
  combine_out <-
    plyr::ldply(.data, function(x) {
      x_out_vector <-
        names(x)[grepl("[^N|M|SD|SE]", names(x), ignore.case = FALSE)]

      if (ncol(x) != 1) {
        x_out <-
          tidyr::unite_(
            x,
            col = "data",
            from = x_out_vector,
            sep = ":",
            remove = TRUE
          )
        x_out
      } else {
        x_out <-
          tidyr::unite_(
            x,
            col = "data",
            from = x_out_vector,
            sep = "",
            remove = TRUE
          )
        x_out
      }
      x_out

    })
  combine_out
}
