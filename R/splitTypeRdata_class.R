#' @title Class Union for list or NULL
#' 
#' @description A virtual class that groups list and \code{NULL} 
#' together.
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @name ListOrNULL-class
#' @rdname ListOrNULL-class
#' @exportClass ListOrNULL
setClassUnion("ListOrNULL", members = c("list", "NULL"))


#' @title An S4 class to represent the splitTypeR data
#'
#' @slot signatures \code{NULL} or a \code{list} of the genes   
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @slot gsvaResults \code{NULL} or a \code{list} of the GSVA results  
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @slot permutations \code{NULL} or a \code{list} of the permutations results  
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @slot standardDeviation \code{NULL} or a \code{list} of the standard 
#' deviation results  for each signature. The \code{list} should be have one 
#' entry per signature. 
#' Default: \code{NULL}.
#' 
#' @slot upscaling \code{NULL} or a \code{list} of the upscaling data 
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @slot upscaling \code{NULL} or a \code{list} of the upscaling data 
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @slot model \code{NULL} or a \code{list} of the mixture models calculated 
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @slot classification \code{NULL} or a \code{list} of the classification for 
#' each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @aliases SplitTypeRdata-class
#' @name SplitTypeRdata-class
#' @rdname SplitTypeRdata-class
#' 
#' @keywords classes
#' @exportClass SplitTypeRdata
#' @export
setClass("SplitTypeRdata",
         slots = c(
             signatures="ListOrNULL",
             gsvaResults="ListOrNULL",
             permutations="ListOrNULL",
             standardDeviation="ListOrNULL",
             upscaling="ListOrNULL",
             model="ListOrNULL",
             classification="ListOrNULL"
         ),
         prototype = list(
             signatures=NULL,
             gsvaResults=NULL,
             permutations=NULL,
             standardDeviation=NULL,
             upscaling=NULL,
             model=NULL,
             classification=NULL
         )
)

## Validation
setValidity("SplitTypeRdata",
            function(object)
            {
                TRUE
            }
)


###########################################################################
## All the getter functions for the SplitTypeRdata class
###########################################################################

#' Generic function for getting the signatures slot in a class
#' 
#' @description A generic function for getting the signatures slot in a 
#' class. The function is implemented for the \code{SplitTypeRdata} class.
#' 
#' @param x an object.
#' 
#' @return an object.
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @export
setGeneric("signatures", function(x) standardGeneric("signatures"))


#' Getter for the signatures slot in a SplitTypeRdata class
#' 
#' @description A function for getting the signatures slot in a 
#' \code{SplitTypeRdata} class. 
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @return a \code{list}.
#' 
#' @examples
#' 
#' ## Create a SplitTypeRdata object
#' splitData <- SplitTypeRdata()
#' 
#' ## Extract the signature slot for the object
#' signatures(splitData)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @export
setMethod("signatures", "SplitTypeRdata", function(x) {
    return(x@signatures)
})


#' Generic function for getting the gsvaResults slot in a class
#' 
#' @description A generic function for getting the gsvaResults slot in a 
#' class. The function is implemented for the \code{SplitTypeRdata} class.
#' 
#' @param x an object.
#' 
#' @return an object.
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @export
setGeneric("gsvaResults", function(x) standardGeneric("gsvaResults"))


#' Getter for the signatures slot in a SplitTypeRdata class
#' 
#' @description A function for getting the gsvaResults slot in a 
#' \code{SplitTypeRdata} class. 
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @return a \code{list}.
#' 
#' @examples
#' 
#' ## Create a SplitTypeRdata object
#' splitData <- SplitTypeRdata()
#' 
#' ## Extract the gsvaResults slot for the object
#' gsvaResults(splitData)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @export
setMethod("gsvaResults", "SplitTypeRdata", function(x) {
    return(x@gsvaResults)
})


#' Generic function for getting the permutations slot in a class
#' 
#' @description A generic function for getting the permutations slot in a 
#' class. The function is implemented for the \code{SplitTypeRdata} class.
#' 
#' @param x an object.
#' 
#' @return an object.
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @export
setGeneric("permutations", function(x) standardGeneric("permutations"))


#' Getter for the signatures slot in a SplitTypeRdata class
#' 
#' @description A function for getting the permutations slot in a 
#' \code{SplitTypeRdata} class. 
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @return a \code{list}.
#' 
#' @examples
#' 
#' ## Create a SplitTypeRdata object
#' splitData <- SplitTypeRdata()
#' 
#' ## Extract the permutations slot for the object
#' permutations(splitData)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @export
setMethod("permutations", "SplitTypeRdata", function(x) {
    return(x@permutations)
})


#' Generic function for getting the standardDeviation slot in a class
#' 
#' @description A generic function for getting the standardDeviation slot in a 
#' class. The function is implemented for the \code{SplitTypeRdata} class.
#' 
#' @param x an object.
#' 
#' @return an object.
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @export
setGeneric("standardDeviation", function(x) 
        standardGeneric("standardDeviation"))


#' Getter for the standardDeviation slot in a SplitTypeRdata class
#' 
#' @description A function for getting the standardDeviation slot in a 
#' \code{SplitTypeRdata} class. 
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @return a \code{list}.
#' 
#' @examples
#' 
#' ## Create a SplitTypeRdata object
#' splitData <- SplitTypeRdata()
#' 
#' ## Extract the sd slot for the object
#' standardDeviation(splitData)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @export
setMethod("standardDeviation", "SplitTypeRdata", function(x) {
    return(x@standardDeviation)
})


#' Generic function for getting the upscaling slot in a class
#' 
#' @description A generic function for getting the upscaling slot in a 
#' class. The function is implemented for the \code{SplitTypeRdata} class.
#' 
#' @param x an object.
#' 
#' @return an object.
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @export
setGeneric("upscaling", function(x) 
    standardGeneric("upscaling"))


#' Getter for the upscaling slot in a SplitTypeRdata class
#' 
#' @description A function for getting the upscaling slot in a 
#' \code{SplitTypeRdata} class. 
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @return a \code{list}.
#' 
#' @examples
#' 
#' ## Create a SplitTypeRdata object
#' splitData <- SplitTypeRdata()
#' 
#' ## Extract the upscaling slot for the object
#' upscaling(splitData)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @export
setMethod("upscaling", "SplitTypeRdata", function(x) {
    return(x@upscaling)
})


###########################################################################
## All the setter functions for the SplitTypeRdata class
###########################################################################


#' Generic function for replacement of signatures slot in a class
#' 
#' @description A generic function for replacement of signatures slot in a 
#' S4 object.
#' 
#' @param x a S4 object.
#' 
#' @param value the new value to assign or update.
#' 
#' @return the modified S4 object when the new value is valid.
#' 
#' @examples
#'  
#' # Define a dummy class to show usage
#' setClass("MyClass", slots = list(signatures="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", signatures="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # signatures(obj) <- "333"
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
setGeneric("signatures<-", function(x, value) standardGeneric("signatures<-"))


#' Replacement of studyDF slot in a \code{SplitTypeRdata} object
#' 
#' @description A function for replacement of the studyDF slot in a 
#' \code{SplitTypeRdata} class.
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @param value \code{NULL} or a \code{list} of the genes   
#' for each signature. The \code{list} should be have one entry per signature. 
#' 
#' @return the modified \code{SplitTypeRdata} object when the new value is 
#' valid.
#' 
#' @examples
#' 
#' ## Create a SplitTypeRdata object
#' paramDemo <- new("SplitTypeRdata")
#' 
#' ## Demo study data frame
#' signaDemo <- list("SignatureA"=c("Gene1", "Gene2", "Gene3"), 
#'     "SignatureB"=c("Gene10", "Gene12"))
#' 
#' ## Assign the new list to the signatures slot in the object
#' signatures(paramDemo) <- signaDemo
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @importFrom methods validObject
#' @export
setMethod("signatures<-", "SplitTypeRdata", function(x, value) {
    x@signatures <- value
    
    # Validate and return the modified object
    validObject(x) 
    return(x)
})
