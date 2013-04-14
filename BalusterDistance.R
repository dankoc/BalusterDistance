##
##  BalusterDistance.R -- R script for computing optimal distance between balusters.
##
##  Prints: 
##   (1) The number of balusters required to span a given distance, subject 
##       to the maximum distance between each baluster; and 
##
##   (2) The position of the center of each baluster relative to the start 
##       of the span (rounded to the nearest 1/16th inch).
##
##  Supports angles.  All units in inches ('').
##
##  totDist  --> Total distance covered by the railing (in inches).
##  minDist  --> Maximum distance between each baluster permitted by local codes (default= 4''). 
##  balWidth --> Width of the baluster (default= 1'').
##  offs     --> Optional offset; if specified, shifts baluster centers relative to the start.
##  angle    --> Use if the span is at an angle, and you want angular measurements from the bottom
##               to the top of the stair case.  Units= radians.  Useful for runs up stairs.
##

bd <- function(totDist, minDist= 4, balWidth= 1, offs= 0, angle= 0) { ## angle is in radians...
  ## If at an angle, adjust totDist, assiming the hypotus is the input...
  totDist <- totDist*cos(angle)

  ## Calculate the minimum number of balusters.
  numBal <- ceiling(totDist/ (minDist+balWidth))
  print(paste("number of balusters: ",numBal))
  
  ## Calculate the distance between balusters.
  ## NOTE: There's 1 extra empty space than there are balusters, so add 1...
  distApart <- (totDist-(balWidth*numBal))/(numBal+1) 
  print(paste("distance apart",distApart))
  
  ## Calculate the position of the center of each baluster.
  dOnCenter <- c(1:numBal)*distApart + (c(1:numBal)-1)*balWidth + balWidth/2 - offs
  
  ## If an angle...
  dOnCenter <- dOnCenter/ cos(angle)
  
  ## Now make it print the nearest 1/16''.
  decimal <- dOnCenter-floor(dOnCenter)
  nearest16th <- c(0:16)/16
  ## NOTE: using which.min with 0:16, have to subtract 1 to get nearest 16th...
  n16ths <- (unlist(lapply(decimal, function(x) (which.min(abs(x-nearest16th)))))-1)
  
  ## print... 
  print(data.frame(inches= floor(dOnCenter), sixteenths= n16ths))
}

## Examples ... used in my house.

## Left side of open area...
## Top is ~63 3/16; bottom is ~63
bd(mean(63+3/16, 63))

## Center of open area...
## Top is ~62.5; bottom is ~62 13/16
bd(mean(62.5, 62+3/4+1/16))

## Left of open area...
## Top is ~63 5/16; bottom is ~63 1/8
bd(mean(63+1/8, 63+5/16))

## Top, long run over stairs.
bd((8*12)+1/8)

## Top, long run by laundary room.
bd((93)+3/16)

## Top, short run over landing.
bd((37)+1/2) ## Floor.
  
## Center ... angled...
bd(75, angle= atan(0.735501))

## Lower section...
## measurements from hole to newel post.
l <- c(2.25, 7+5/8, 12+7/8, 17+13/16, 23+3/16, 28+3/8, 33+9/16, 38+13/16, 44+1/16, 44+1/16+4+1/16+1, 44+1/16+9+1/4+1/16+1, 44+1/16+9+1/4+1/16+1+4+1)
r <- l+1
cnt <- (l+r)/2
cnt <- cnt/ cos(atan(0.735501)) ## Convert to measurement along rail.
decimal <- cnt-floor(cnt)## Now make it print the nearest 1/16''.
nearest16th <- c(0:16)/16
n16ths <- (unlist(lapply(decimal, function(x) (which.min(abs(x-nearest16th)))))-1)
print(data.frame(inches= floor(cnt), sixteenths= n16ths))

unlist(lapply(c(2:11), function(i) {cnt[i]-cnt[i-1]}))*cos(atan(0.735501))-1-4.25 ## sanity check... Should all be ~4.25
## 3-rd to 4th off 1/4''
