addalpha <- function(colors, alpha) {
  r <- col2rgb(colors, alpha=T)
  # Apply alpha
  r[4,] <- alpha*255
  r <- r/255.0
  return(rgb(r[1,], r[2,], r[3,], r[4,]))
}

rescale <- function(x, x.min = NULL, x.max = NULL, new.min = 0, new.max = 1) {
  if(is.null(x.min)) x.min = min(x)
  if(is.null(x.max)) x.max = max(x)
  new.min + (x - x.min) * ((new.max - new.min) / (x.max - x.min))
}
# Sample raster with point using densities according to density
bgSample <- function(raster,
                     n = 1000,
                     prob = FALSE,
                     replace = FALSE,
                     spatial = TRUE)
  # sample N random pixels (not NA) from raster. If 'prob = TRUE' raster
  # is assumed to be a bias grid and points sampled accordingly. If 'sp = TRUE'
  # a SpatialPoints* object is returned, else a matrix of coordinates
{
  pixels <- notMissingIdx(raster)
  
  if (prob) {
    prob <- getValues(raster)[pixels]
  } else {
    prob <- NULL
  }
  
  # sample does stupid things if x is an integer, so sample an index to the
  # pixel numbers instead
  idx <- sample.int(n = length(pixels),
                    size = n,
                    replace = replace,
                    prob = prob)
  points <- pixels[idx]
  
  # get as coordinates
  points <- xyFromCell(raster, points)
  if (spatial) {
    return (SpatialPoints(points, proj4string = raster@crs))
  } else {
    return (points)
  }
}
# Fnuctions needed for previous function
notMissingIdx <- function(raster) {
  # return an index for the non-missing cells in raster
  which(!is.na(getValues(raster)))
}

missingIdx <- function(raster) {
  # return an index for the missing cells in raster
  which(is.na(getValues(raster)))
}
