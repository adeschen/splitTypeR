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


#' @title Class Union for matrix or NULL
#' 
#' @description A virtual class that groups matrix and \code{NULL} 
#' together.
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' 
#' @name MatrixOrNULL-class
#' @rdname MatrixOrNULL-class
#' @exportClass MatrixOrNULL
setClassUnion("MatrixOrNULL", members = c("matrix", "NULL"))


#' @title An S4 class to represent the splitTypeR data
#'
#' @slot signatures \code{NULL} or a \code{list} of the genes   
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @slot gsvaResults \code{NULL} or a  \code{numeric} \code{matrix} with 
#' the sample GSVA results for each signature. The \code{matrix} should be 
#' have one row per signature. 
#' Default: \code{NULL}.
#' 
#' @slot permutations \code{NULL} or a \code{list} of the permutations results  
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @slot standardDeviation \code{NULL} or a \code{list} of the sample standard 
#' deviation for each signature. The \code{list} should be have one entry 
#' per signature. 
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
             gsvaResults="MatrixOrNULL",
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
setValidity("SplitTypeRdata", function(object) {
 
    if (!is.null(object@signatures)) {
        signTmp <- names(object@signatures)
        
        
    }
    
    TRUE
})


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
#' @examples
#' 
#' # Define a dummy class to show usage
#' setClass("MyClass", slots = list(signatures="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", signatures="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # signatures(obj)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
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
#' @examples
#' 
#' # Define a dummy class to show usage
#' setClass("MyClass", slots = list(gsvaResults="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", gsvaResults="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # gsvaResults(obj)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
setGeneric("gsvaResults", function(x) standardGeneric("gsvaResults"))


#' Getter for the signatures slot in a SplitTypeRdata class
#' 
#' @description A function for getting the gsvaResults slot in a 
#' \code{SplitTypeRdata} class. 
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @return \code{NULL} or a \code{matrix} of the GSVA results for each 
#' signature. The \code{matrix} should be have one entry per signature. 
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
#' @examples
#' 
#' # Define a dummy class to show usage
#' setClass("MyClass", slots = list(permutations="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", permutations="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # permutations(obj)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
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
#' @examples
#' 
#' # Define a dummy class to show usage
#' setClass("MyClass", slots = list(standardDeviation="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", standardDeviation="123")
#' 
# # Call the generic (assuming a method is implemented)
# # standardDeviation(obj)
#' 
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
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
#' @return \code{NULL} or a \code{list} of the sample standard deviation 
#' for each signature. The \code{list} should be have one entry per signature. 
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
#' @examples
#' 
#' # Define a dummy class to show usage
#' setClass("MyClass", slots = list(upscaling="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", upscaling="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # upscaling(obj)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
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
#' @return \code{NULL} or a \code{list} of the upscaling data for each 
#' signature. The \code{list} should be have one entry per signature. 
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
#' @export
setMethod("upscaling", "SplitTypeRdata", function(x) {
    return(x@upscaling)
})


#' Generic function for getting the model slot in a class
#' 
#' @description A generic function for getting the model slot in a 
#' class. The function is implemented for the \code{SplitTypeRdata} class.
#' 
#' @param x an object.
#' 
#' @return an object.
#' 
#' @examples
#' 
#' # Define a dummy class to show usage
#' setClass("MyClass", slots = list(model="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", model="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # model(obj)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
setGeneric("model", function(x) 
    standardGeneric("model"))


#' Getter for the model slot in a SplitTypeRdata class
#' 
#' @description A function for getting the model slot in a 
#' \code{SplitTypeRdata} class. 
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @return \code{NULL} or a \code{list} of the mixture models calculated  
#' for each signature. The \code{list} should be have one entry per signature. 
#' 
#' @examples
#' 
#' ## Create a SplitTypeRdata object
#' splitData <- SplitTypeRdata()
#' 
#' ## Extract the model slot for the object
#' model(splitData)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
setMethod("model", "SplitTypeRdata", function(x) {
    return(x@model)
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


#' Replacement of signatures slot in a \code{SplitTypeRdata} object
#' 
#' @description A function for replacement of the signatures slot in a 
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
#' signaDemo <- list("SignatureA"=c("KRAS", "AKT1", "MTOR"), 
#'     "SignatureB"=c("PIK3CB", "CTTN"))
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


#' Generic function for replacement of gsvaResults slot in a class
#' 
#' @description A generic function for replacement of gsvaResults slot in a 
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
#' setClass("MyClass", slots = list(gsvaResults="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", gsvaResults="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # gsvaResults(obj) <- "333"
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
setGeneric("gsvaResults<-", function(x, value) 
    standardGeneric("gsvaResults<-"))


#' Replacement of gsvaResults slot in a \code{SplitTypeRdata} object
#' 
#' @description A function for replacement of the gsvaResults slot in a 
#' \code{SplitTypeRdata} class.
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @param value \code{NULL} or a \code{matrix} of the GSVA results for each 
#' signature. The \code{matrix} should be have one row per signature. 
#' Default: \code{NULL}.
#' 
#' @return the modified \code{SplitTypeRdata} object when the new value is 
#' valid.
#' 
#' @examples
#' 
#' ## Two demo signatures
#' sign <- list("SignatureA"=c("EGFR", "CTTN", "ACTB"), 
#'     "SignatureB"=c("ACTR2", "AKT1"))
#'     
#' ## Create a SplitTypeRdata object with the signatures
#' demo <- new("SplitTypeRdata", signatures=sign)
#' 
#' ## Demo study data frame
#' signaDemo <- matrix(data=c(0.23772165, -0.71262458, 0.42328775, 
#'     -0.65149268, 0.18324268, 0.007158662), nrow=2, ncol=3, byrow=FALSE)
#' colnames(signaDemo) <- paste0("Patient_", 1:3)
#' rownames(signaDemo) <- c("SignatureA", "SignatureB")
#' 
#' gsvaResults(demo) <- signaDemo
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @importFrom methods validObject
#' @export
setMethod("gsvaResults<-", "SplitTypeRdata", function(x, value) {
    x@gsvaResults <- value
    
    # Validate and return the modified object
    validObject(x) 
    return(x)
})


#' Generic function for replacement of permutations slot in a class
#' 
#' @description A generic function for replacement of permutations slot in a 
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
#' setClass("MyClass", slots = list(permutations="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", permutations="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # permutations(obj) <- "333"
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
setGeneric("permutations<-", function(x, value) 
    standardGeneric("permutations<-"))


#' Replacement of permutations slot in a \code{SplitTypeRdata} object
#' 
#' @description A function for replacement of the permutations slot in a 
#' \code{SplitTypeRdata} class.
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @param value \code{NULL} or a \code{list} of the permutations results 
#' for each signature. The \code{list} should be have one entry per signature. 
#' 
#' @return the modified \code{SplitTypeRdata} object when the new value is 
#' valid.
#' 
#' @examples
#' 
#' ## Two demo signatures
#' sign <- list("SignatureA"=c("EGFR", "CTTN", "ACTB"), 
#'     "SignatureB"=c("ACTR2", "AKT1"))
#'     
#' ## Create a SplitTypeRdata object with the signatures
#' demo <- new("SplitTypeRdata", signatures=sign)
#' 
#' ## Demo study data frame
#' demoPerm1 <- matrix(data=c(0.23772165, -0.71262458, 0.42328775, 
#'         -0.65149268, 0.18324268, 0.007158662), nrow=2, ncol=3, byrow=FALSE)
#' rownames(demoPerm1) <- paste0("Patient_", 1:2)
#' 
#' demoPerm2 <- matrix(data=c(0.29772165, 0.21262458, 0.42218775, 
#'         0.65133268, 0.18324268, -0.017158662), nrow=2, ncol=4, byrow=FALSE)
#' rownames(demoPerm2) <- paste0("Patient_", 1:2)
#' demoPerm <- list()
#' demoPerm[[names(sign)[1]]] <- demoPerm1
#' demoPerm[[names(sign)[2]]] <- demoPerm2
#' 
#' 
#' permutations(demo) <- demoPerm
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @importFrom methods validObject
#' @export
setMethod("permutations<-", "SplitTypeRdata", function(x, value) {
    x@permutations <- value
    
    # Validate and return the modified object
    validObject(x) 
    return(x)
})


#' Generic function for replacement of model slot in a class
#' 
#' @description A generic function for replacement of model slot in a 
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
#' setClass("MyClass", slots = list(model="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", model="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # model(obj) <- "333"
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
setGeneric("model<-", function(x, value) 
    standardGeneric("model<-"))


#' Replacement of model slot in a \code{SplitTypeRdata} object
#' 
#' @description A function for replacement of the model slot in a 
#' \code{SplitTypeRdata} class.
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @param value \code{NULL} or a \code{list} of the mixture models calculated 
#' for each signature. The \code{list} should be have one entry per signature. 
#' 
#' @return the modified \code{SplitTypeRdata} object when the new value is 
#' valid.
#' 
#' @examples
#' 
#' ## Load required library
#' library(mixtools)
#' 
#' ## Two demo signatures
#' sign <- list("SignatureA"=c("EGFR", "CTTN", "ACTB"), 
#'     "SignatureB"=c("ACTR2", "AKT1"))
#'     
#' ## Create a SplitTypeRdata object with the signatures
#' demo <- new("SplitTypeRdata", signatures=sign)
#' 
#' ## Create demo model
#' set.seed(121)
#' modelExp <- normalmixEM(c(sample(1:25, size=12, replace=TRUE), 
#'                 sample(23:45, size=12, replace=TRUE)), k=2, verb=FALSE)
#'                 
#' ## Create demo models
#' demoModels <- list()
#' demoModels[[names(sign)[1]]] <- modelExp
#' demoModels[[names(sign)[2]]] <- modelExp
#' 
#' model(demo) <- demoModels
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @importFrom methods validObject
#' @export
setMethod("model<-", "SplitTypeRdata", function(x, value) {
    x@model <- value
    
    # Validate and return the modified object
    validObject(x) 
    return(x)
})


#' Generic function for replacement of standardDeviation slot in a class
#' 
#' @description A generic function for replacement of standardDeviation slot 
#' in a S4 object.
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
#' setClass("MyClass", slots = list(standardDeviation="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", standardDeviation="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # standardDeviation(obj) <- "333"
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
setGeneric("standardDeviation<-", function(x, value) 
    standardGeneric("standardDeviation<-"))


#' Replacement of the standardDeviation slot in a \code{SplitTypeRdata} object
#' 
#' @description A function for replacement of the standardDeviation slot in a 
#' \code{SplitTypeRdata} class.
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @param value \code{NULL} or a TODO 
#' 
#' @return the modified \code{SplitTypeRdata} object when the new value is 
#' valid.
#' 
#' @examples
#' 
#' ## Load required library
#' library(mixtools)
#' 
#' ## Two demo signatures
#' sign <- list("SignatureA"=c("EGFR", "CTTN", "ACTB"), 
#'     "SignatureB"=c("ACTR2", "AKT1"))
#'     
#' ## Create a SplitTypeRdata object with the signatures
#' demo <- new("SplitTypeRdata", signatures=sign)
#' 
#' ## Create standard deviations
#' demoSD <- list()
#' demoSD[[names(sign)[1]]] <- c(0.01748988, 0.08992500, 0.11781061, 0.0747440)
#' demoSD[[names(sign)[2]]] <- c(0.02058364, 0.08476766, 0.14783058, 0.1009961)
#' 
#' standardDeviation(demo) <- demoSD
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @importFrom methods validObject
#' @export
setMethod("standardDeviation<-", "SplitTypeRdata", function(x, value) {
    x@standardDeviation <- value
    
    # Validate and return the modified object
    validObject(x) 
    return(x)
})


#' Generic function for replacement of the upscaling slot in a class
#' 
#' @description A generic function for replacement of the upscaling slot 
#' in a S4 object.
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
#' setClass("MyClass", slots = list(upscaling="character"))
#' 
#' # Create an instance
#' obj <- new("MyClass", upscaling="123")
#' 
#' # Call the generic (assuming a method is implemented)
#' # upscaling(obj) <- "333"
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
setGeneric("upscaling<-", function(x, value) 
    standardGeneric("upscaling<-"))


#' Replacement of the upscaling slot in a \code{SplitTypeRdata} object
#' 
#' @description A function for replacement of the upscaling slot in a 
#' \code{SplitTypeRdata} class.
#' 
#' @param x a \code{SplitTypeRdata} object.
#' 
#' @param value \code{NULL} or a \code{list} of the upscaling data for 
#' each signature. The \code{list} should be have one entry per signature.
#' 
#' @return the modified \code{SplitTypeRdata} object when the new value is 
#' valid.
#' 
#' @examples
#' 
#' ## Load required library
#' library(mixtools)
#' 
#' ## Two demo signatures
#' sign <- list("SignatureA"=c("EGFR", "CTTN", "ACTB"), 
#'     "SignatureB"=c("ACTR2", "AKT1"))
#'     
#' ## Create a SplitTypeRdata object with the signatures
#' demo <- new("SplitTypeRdata", signatures=sign)
#' 
#'                 
#' ## Create demo standard devitaions
#' demoUp <- list()
#' demoUp[[names(sign)[1]]] <- matrix(data=c(0.0174988, 0.0892500, 0.1178101, 
#' 0.0744401, 0.0654692, 0.2546492), nrow=2, ncol=3, byrow=FALSE)
#' demoUp[[names(sign)[2]]] <- matrix(data=c(0.3749488, 0.4894500, 0.2118101, 
#' 0.4444401, 0.4154692, 0.8543392), nrow=2, ncol=3, byrow=FALSE)
#' 
#' upscaling(demo) <- demoUp
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @importFrom methods validObject
#' @export
setMethod("upscaling<-", "SplitTypeRdata", function(x, value) {
    x@upscaling <- value
    
    # Validate and return the modified object
    validObject(x) 
    return(x)
})


#' @title Create a SplitTypeRdata object 
#'
#' @description This function creates a SplitTypeRdata object using the values 
#' present in the parameters.
#' 
#' @param signatures \code{NULL} or a \code{list} of the genes   
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @param gsvaResults \code{NULL} or a \code{matrix} of the GSVA results  
#' for each signature. The \code{matrix} should be have one row per signature. 
#' Default: \code{NULL}.
#' 
#' @param permutations \code{NULL} or a \code{list} of the permutations results  
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @param standardDeviation \code{NULL} or a \code{list} of the standard 
#' deviation results  for each signature. The \code{list} should be have one 
#' entry per signature. 
#' Default: \code{NULL}.
#' 
#' @param upscaling \code{NULL} or a \code{list} of the upscaling data 
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @param model \code{NULL} or a \code{list} of the mixture models calculated 
#' for each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @param classification \code{NULL} or a \code{list} of the classification for 
#' each signature. The \code{list} should be have one entry per signature. 
#' Default: \code{NULL}.
#' 
#' @return an object of class \code{SplitTypeRdata} that contains all the 
#' required parameters needed by the RAIDS workflow.
#' 
#'
#' @examples
#' 
#' ## New object of class "SplitTypeRdata" with default parameters
#' newSplitData1 <- SplitTypeRdata()
#' 
#' ## New object of class "SplitTypeRdata" with non-default parameters
#' newSplitData2 <- SplitTypeRdata(signatures=list("Signature1"=c("ABL1", 
#'     "BLM", "BRCA1"), "Signature2"=c("COP1", "RAD50", "FANCD2", "TERF2")), 
#'     gsvaResults=NULL, permutations=NULL,   
#'     standardDeviation=NULL, upscaling=NULL, model=NULL, 
#'     classification=NULL)
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @importFrom methods new
#' @export
SplitTypeRdata <- function(signatures=NULL, gsvaResults=NULL, 
    permutations=NULL, standardDeviation=NULL, upscaling=NULL, model=NULL, 
    classification=NULL) {
    
    new("SplitTypeRdata", signatures=signatures, gsvaResults=gsvaResults, 
        permutations=permutations, standardDeviation=standardDeviation,
        upscaling=upscaling, model=model, classification=classification)
}