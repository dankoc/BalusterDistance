BalusterDistance
================

BalusterDistance -- R script for computing optimal distance between balusters.

  Prints: 
  
   (1) The number of balusters required to span a given distance, subject 
       to the maximum distance between each baluster; and 

   (2) The position of the center of each baluster relative to the start 
       of the span (rounded to the nearest 1/16th inch).

  Arguments: 
   totDist  --> Total distance covered by the railing (in inches).
   minDist  --> Maximum distance between each baluster permitted by local codes (default= 4''). 
   balWidth --> Width of the baluster (default= 1'').
   offs     --> Optional offset; if specified, shifts baluster centers relative to the start.
   angle    --> Use if the span is at an angle, and you want angular measurements from the bottom
                to the top of the stair case.  Units= radians.  Useful for runs up stairs.
