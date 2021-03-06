#' Shortcut for specifying paths relative to root
#'
#' \code{root_dir} is a wrapper around \code{getwd} that appends the path-part to the location specified by the user-supplied argument.
#'
#' @param pathpart A string to the path
#' @return A character vector with the path to the root directory appended to the path-part specified.
#' @examples
#'
#' # Supply path-part without preceding forward slash
#'
#' my_path <-
#'  root_dir("myfolder/test.txt")
#'
#'  my_path
#' @export

root_dir <-
  function(pathpart) {paste0(as.character(getwd()),"/",pathpart, collapse = "")}

