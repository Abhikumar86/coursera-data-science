## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {       # This function creates a special "matrix" object that can cache its inverse
    inv <- NULL
    set <- function(y) { # set the value of matrix
      x <<- y
      inv <<- NULL
    }
    get <- function() x                           # get the vaue of matrix
    setInv <- function(inverse) inv <<- inverse   # set the value of inverse of the matrix
    getInv <- function() inv                      # get the inverse of matrix
    list(set = set, get = get,
         setInv = setInv,
         getInv = getInv)                         # return the output as list
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {          # This function computes the inverse of the special "matrix"
    inv <- x$getInv()
    if(!is.null(inv)) {                   # If the inverse has already been calculated
      message("getting cached data")
      return(inv)
    }
    data <- x$get()
    inv <- solve(data, ...)              # Computing the inverse of a square matrix
    x$setInv(inv)
    inv
}
