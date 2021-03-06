
# Validation function ----

.valid.Colormap <- function(object){
  # To avoid later checking inside the app, this object should be stored in a
  # slot of its parent SummarizedExperiment that would check its validity
  # (e.g. all assay color maps should be present in the parent, etc.)
  # Note that default color maps will be provided for elements
  # of the parent that do not have a defined colormap.

  errors <- c()
  
  # Different types of checks
  free_lists <- c("assays")
  named_lists <- c("colData","rowData")
  controlled_lists <- c("all_discrete","all_continuous")
  function_slots <- c("global_discrete","global_continuous")
  
  controlled_names <- c("assays","colData","rowData")
  
  # Check that all color maps are functions
  # and that they return non-empty vectors (character or color)
  for (slotname in c(free_lists, named_lists, controlled_lists)){
    slotmaps <- slot(object, slotname)
    check_function <- vapply(slotmaps, "is.function", logical(1))
    if (!all(check_function)){
      errors <- c(errors, sprintf(
        "Color map `%s` in slot `%s` is not a function",
        names(slotmaps)[!check_function],
        slotname
      ))
      return(errors)
    }
  }
  ## No need to test those ##
  ## they are picked up by the automatic slot type-checking
  # if (!is.function(object@global_discrete)){
  #   errors <- c(errors, "Color map `global_discrete` is not a function")
  # }
  # if (!is.function(object@global_continuous)){
  #   errors <- c(errors, "Color map `global_continuous` is not a function")
  # }
  
  for (slotname in named_lists){
    slotmaps <- slot(object, slotname)
    # Check that all color maps are named
    check_named <- names(slotmaps) != ""
    if (!all(check_named)){
      errors <- c(errors, sprintf(
        "Color map #%s in slot `%s` must be named",
        which(!check_named),
        slotname
      ))
    }
  }
  
  for (slotname in controlled_lists){
    slotmaps <- slot(object, slotname)
    # Check that all color maps have the appropriate names
    if (!identical(names(slotmaps), controlled_names)){
      errors <- c(errors, sprintf(
        "Color map in slot `%s` must be named %s",
        slotname,
        paste(deparse(controlled_names), collapse = "")
      ))
    }
  }

  if (length(errors > 0)){
    return(errors)
  }

  return(TRUE)
}

# ExperimentColorMap definition ----

.nullColorMap <- function(n){
  return(NULL)
}

setClass("ExperimentColorMap",
    contains="Vector",
    representation(
      # each slot has a list of closures
      assays="list",
      colData="list",
      rowData="list",
      all_discrete="list",
      all_continuous="list",
      global_discrete="function",
      global_continuous="function"
    ),
    prototype(
      assays=list(),
      colData=list(),
      rowData=list(),
      all_discrete=list(
        assays=.nullColorMap,
        colData=.nullColorMap,
        rowData=.nullColorMap
      ),
      all_continuous=list(
        assays=.nullColorMap,
        colData=.nullColorMap,
        rowData=.nullColorMap
      ),
      global_discrete=.nullColorMap,
      global_continuous=.nullColorMap
    ),
  validity = .valid.Colormap
)

# Constructor ----

#' \code{ExperimentColorMap} objects
#'
#' @name ExperimentColorMap
#'
#' @param assays List of color maps for \code{assays}.
#' @param colData List of color maps for \code{colData}.
#' @param rowData List of color maps for \code{rowData}.
#' @param all_discrete Discrete color maps applied to all undefined
#' \code{assays}, \code{colData}, and \code{rowData}, respectively.
#' @param all_continuous Continuous color maps applied to all undefined
#' \code{assays}, \code{colData}, and \code{rowData}, respectively.
#' @param global_discrete Discrete color maps applied to all undefined discrete
#' covariates.
#' @param global_continuous Continuous color maps applied to all undefined
#' discrete covariates.
#' @param ... additional arguments passed on to the \code{ExperimentColorMap}
#' constructor
#' 
#' @details 
#' Color maps must all be functions that take at least one argument: the number
#' of (named) colours to return as a \code{character} vector.
#' This argument may be ignored in the body of the color map function
#' to produce constant color maps. 
#'
#' @section Accessors:
#'
#' In the following code snippets, \code{x} is an
#' \code{ExperimentColorMap} object. If the color map can not immediately
#' be found in the appropriate slot, \code{discrete} is a \code{logical(1)}
#' that indicates whether the default color map returned should be discrete
#' \code{TRUE} or continuous (\code{FALSE}, default).
#' 
#' \describe{
#'   \item{\code{assayColorMap(x, i, ..., discrete=FALSE)}:}{
#'   Get an \code{assays} colormap.}
#'   
#'   \item{\code{colDataColorMap(x, i, ..., discrete=FALSE)}:}{
#'   Get a \code{colData} colormap.}
#'   
#'   \item{\code{rowDataColorMap(x, i, ..., discrete=FALSE)}:}{
#'   Get a \code{rowData} colormap.}
#' }
#'
#' @export ExperimentColorMap
#' @exportClass ExperimentColorMap
#' @export assayColorMap
#' @exportMethod assayColorMap
#' @export colDataColorMap
#' @export rowDataColorMap
#' @aliases class:ExperimentColorMap ExperimentColorMap-class
#' assayColorMap colDataColorMap rowDataColorMap
#' assayColorMap,ExperimentColorMap,character-method
#' assayColorMap,ExperimentColorMap,numeric-method
#' colDataColorMap,ExperimentColorMap,character-method
#' rowDataColorMap,ExperimentColorMap,character-method
#'
#' @examples
#'
#' # Example color maps ----
#'
#' count_colors <- function(n){
#'   c("black","brown","red","orange","yellow")
#' }
#' fpkm_colors <- viridis::inferno
#' tpm_colors <- viridis::plasma
#'
#' qc_color_fun <- function(n){
#'   qc_colors <- c("forestgreen", "firebrick1")
#'   names(qc_colors) <- c("Y", "N")
#'   return(qc_colors)
#' }
#' 
#' # Constructor ----
#'
#' ecm <- ExperimentColorMap(
#'     assays = list(
#'         counts = count_colors,
#'         tophat_counts = count_colors,
#'         cufflinks_fpkm = fpkm_colors,
#'         cufflinks_fpkm = fpkm_colors,
#'         rsem_tpm = tpm_colors
#'     ),
#'     colData = list(
#'         passes_qc_checks_s = qc_color_fun
#'     )
#' )
#'
#' # Accessors ----
#'
#' assayColorMap(ecm, "logcounts") # [undefined --> default]
#' assayColorMap(ecm, "counts")
#' assayColorMap(ecm, "cufflinks_fpkm")
#'
#' colDataColorMap(ecm, "passes_qc_checks_s")
#' colDataColorMap(ecm, "undefined")
#'
#' rowDataColorMap(ecm, "undefined")
#'
ExperimentColorMap <- function(
  assays = list(), colData = list(), rowData = list(),
  all_discrete = list(assays=NULL, colData=NULL, rowData=NULL),
  all_continuous = list(assays=NULL, colData=NULL, rowData=NULL),
  global_discrete = NULL, global_continuous = NULL,
  ...){

  if (is.null(names(all_discrete))){
    stop("`all_discrete` must be a named list")
  }
  if (is.null(names(all_continuous))){
    stop("`all_continuous` must be a named list")
  }
  
  all_discrete <- .sanitize_controlled_colormaps(usr = all_discrete)
  all_continuous <- .sanitize_controlled_colormaps(usr = all_continuous)
  
  return(new(
    "ExperimentColorMap",
    assays=assays, colData=colData, rowData=rowData,
    all_discrete = all_discrete, all_continuous = all_continuous,
    global_discrete = ifelse(is.null(global_discrete), .nullColorMap, global_discrete),
    global_continuous = ifelse(is.null(global_continuous), .nullColorMap, global_continuous),
    ...))
}

# replace NULL values by the .nullColorMap
.substituteNullColorMap <- function(x){ifelse(
  is.null(x),
  .nullColorMap,
  x
)}

# set missing names to .nullColorMap 
.sanitize_controlled_colormaps <- function(
  usr,
  def = list(
    assays = .nullColorMap,
    colData = .nullColorMap,
    rowData = .nullColorMap)
  ){
  if (is.null(names(usr))){
    stop("User-defined color map must be a named list")
  }
  usr <- sapply(usr, .substituteNullColorMap)
  # set the color maps given by the user
  # note that invalid ones will be picked up by the class validity check later
  def[names(usr)] <- usr
  return(def)
}

# .default color maps ----

# default continuous colormap
.defaultContinuousColorMap <- viridis # function(n)
# default discrete colormap
.defaultDiscreteColorMap <- function(n) {
  # Credit: https://stackoverflow.com/questions/8197559/emulate-ggplot2-default-color-palette
  hues = seq(15, 375, length = n + 1)
  hcl(h = hues, l = 65, c = 100)[1:n]
}

.defaultColorMap <- function(discrete){
  # message(".defaultColorMap")
  if (discrete){
    .defaultDiscreteColorMap
  } else {
    .defaultContinuousColorMap
  }
}

# Accessors ----

# assayColorMap ----

setGeneric(
  "assayColorMap",
  function(x, i, ..., discrete = FALSE) standardGeneric("assayColorMap")
)

setMethod("assayColorMap", c("ExperimentColorMap", "character"),
    function(x, i, ..., discrete = FALSE)
{
    .assayColorMap(x, i, ..., discrete = discrete)
})

setMethod("assayColorMap", c("ExperimentColorMap", "numeric"),
    function(x, i, ..., discrete = FALSE)
{
    .assayColorMap(x, i, ..., discrete = discrete)
})

.assayColorMap <- function(x, i, ..., discrete){
  # message(".assayColorMap")
  # print(discrete)
  assay_map <- tryCatch({
        x@assays[[i]]
    }, error=function(err) {
        .nullColorMap
    })
  if (is.null(assay_map)){
    assay_map <- .nullColorMap
  }
  if (.activeColormap(assay_map)){
    return(assay_map)
  }
  return(.assayAllColorMap(x, discrete))
}

.assayAllColorMap <- function(x, discrete){
  # message(".assayAllColorMap")
  # print(discrete)
  if (discrete){
    all_assays_map <- x@all_discrete$assays
  } else {
    all_assays_map <- x@all_continuous$assays
  }
  if (is.null(all_assays_map)){
    all_assays_map <- .nullColorMap
  }
  if (.activeColormap(all_assays_map)){
    return(all_assays_map)
  }
  return(.globalColorMap(x, discrete))
}

# colDataColorMap ----

setGeneric(
  "colDataColorMap",
  function(x, i, ..., discrete = FALSE) standardGeneric("colDataColorMap"))

setMethod("colDataColorMap", c("ExperimentColorMap", "character"),
    function(x, i, ..., discrete = FALSE)
{
      .colDataColorMap(x, i, ..., discrete = discrete)
})

.colDataColorMap <- function(x, i, ..., discrete){
  # message(".colDataColorMap")
  # print(discrete)
  coldata_map <- x@colData[[i]]
  if (is.null(coldata_map)){
    coldata_map <- .nullColorMap
  }
  if (.activeColormap(coldata_map)){
    return(coldata_map)
  }
  return(.colDataAllColorMap(x, discrete))
}

.colDataAllColorMap <- function(x, discrete){
  # message(".colDataAllColorMap")
  # print(discrete)
  if (discrete){
    all_coldata_map <- x@all_discrete$colData
  } else {
    all_coldata_map <- x@all_continuous$colData
  }
  if (is.null(all_coldata_map)){
    all_coldata_map <- .nullColorMap
  }
  if (.activeColormap(all_coldata_map)){
    return(all_coldata_map)
  }
  return(.globalColorMap(x, discrete))
}

# rowDataColorMap ----

setGeneric(
  "rowDataColorMap",
  function(x, i, ..., discrete = FALSE) standardGeneric("rowDataColorMap"))

setMethod("rowDataColorMap", c("ExperimentColorMap", "character"),
    function(x, i, ..., discrete = FALSE)
{
      .rowDataColorMap(x, i, ..., discrete = discrete)
})

.rowDataColorMap <- function(x, i, ..., discrete){
  # message(".rowDataColorMap")
  # print(discrete)
  rowdata_map <- x@rowData[[i]]
  if (is.null(rowdata_map)){
    rowdata_map <- .nullColorMap
  }
  if (.activeColormap(rowdata_map)){
    return(rowdata_map)
  }
  return(.rowDataAllColorMap(x, discrete))
}

.rowDataAllColorMap <- function(x, discrete){
  # message(".rowDataAllColorMap")
  # print(discrete)
  if (discrete){
    all_rowdata_map <- x@all_discrete$rowData
  } else {
    all_rowdata_map <- x@all_continuous$rowData
  }
  if (is.null(all_rowdata_map)){
    all_rowdata_map <- .nullColorMap
  }
  if (.activeColormap(all_rowdata_map)){
    return(all_rowdata_map)
  }
  return(.globalColorMap(x, discrete))
}

# global color map ----

.globalColorMap <- function(x, discrete){
  # message(".globalColorMap")
  # print(discrete)
  if (discrete){
    global_map <- x@global_discrete
  } else {
    global_map <- x@global_continuous
  }
  if (.activeColormap(global_map)){
    return(global_map)
  }
  return(.defaultColorMap(discrete))
}

# show ----

.activeColormap <- function(x){
  # Return TRUE if the color map does not return NULL for an arbitrary
  # number of colors
  stopifnot(is.function(x))
  return(!is.null(x(21L)))
}

setMethod(
  "show", "ExperimentColorMap",
  function(object){
    scat <- function(fmt, vals=character(), exdent=2, ...)
    {
        vals <- ifelse(nzchar(vals), vals, "''")
        lbls <- paste(S4Vectors:::selectSome(vals), collapse=" ")
        txt <- sprintf(fmt, length(vals), lbls)
        cat(strwrap(txt, exdent=exdent, ...), sep="\n")
    }

    cat("Class: ExperimentColorMap\n")

    ## assays
    scat("assays(%d): %s\n", names(object@assays))

    ## colData
    scat("colData(%d): %s\n", names(object@colData))

    ## rowData
    scat("rowData(%d): %s\n", names(object@rowData))
    
    ## all_discrete
    which_valid <- sapply(object@all_discrete, .activeColormap)
    scat("all_discrete(%d): %s\n", names(object@all_discrete)[which_valid])
    
    ## all_continuous
    which_valid <- sapply(object@all_continuous, .activeColormap)
    scat("all_continuous(%d): %s\n", names(object@all_continuous)[which_valid])
    
    ## global_discrete
    if (.activeColormap(object@global_discrete)){
      cat("global_discrete(1)\n")
    }
    
    ## global_continuous
    if (.activeColormap(object@global_continuous)){
      cat("global_continuous(1)\n")
    }

    return(NULL)
  }
)
