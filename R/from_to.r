#' Get the starting position 'from' and the ending position 'to' of the 
#' elements contained in a vector (or a list of vectors)
#'
#' @param x a numeric vector or a list of vectors
#' @param ... further arguments are ignored
#' @return A list with two vectors: '$from' and '$to'.
#' '$from' contains the indices with starting positions.
#' '$to' contains the indices with ending positions.
#' @author Gaston Sanchez
#' @seealso \code{\link{lengths}}, \code{\link{listsize}}
#' @export
#' @examples
#' # let's say you have a numeric vector like this
#' num_vec = c(2, 3, 1, 4)
#' 
#' # get 'from' and 'to' indices
#' start_end = from_to(num_vec)
#' from = start_end$from
#' to = start_end$to
#' 
#' #' let's say you have a list like this
#' str_list = list(c("a","b","c"), c("d", "e"), c("f","g","h"))
#' 
#' # get 'from' and 'to' indices
#' start_end = from_to(str_list)
#' from = start_end$from
#' to = start_end$to
from_to <- function(x, ...) {
  UseMethod("from_to", x)  
}


#' @S3method from_to numeric
from_to.numeric <- function(x, ...)
{
  if (!is.vector(x) || !is.numeric(x))
    stop("\nA numeric vector is required")
  
  to = cumsum(x)
  from = to - x + 1
  list(from=from, to=to)
}


#' @S3method from_to list
from_to.list <- function(x, ...)
{
  all_vectors = unlist(lapply(x, is.vector))
  if (length(x) != sum(all_vectors))
    stop("\nA list of vectors is required")
  
  aux = unlist(lapply(x, length))
  to = cumsum(aux)
  from = to - aux + 1
  list(from=from, to=to)
}
