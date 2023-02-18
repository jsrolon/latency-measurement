#!/bin/awk -f

BEGIN { 
    Min = 999999; 
    MAX = 0; 
}

/nvme_cmd_flush/ { 
    if($2 < Min && $2 > 0) {
        Min = $2
    }

    if($2 > MAX) {
        MAX = $2
    } 
    
    count++; 
    mean_diff = ($2 - mean) / count; 
    new_mean = mean + mean_diff; 
    d_sq_inc = ($2 - new_mean) * ($2 - mean); 
    mean = new_mean; 
    d_sq = d_sq + d_sq_inc; 
}

END {
    printf "mean %f\n", mean; 
    printf "stdev %f\n", sqrt(d_sq / count); 
    printf "min %d\n", Min; 
    printf "max %d\n", MAX; 
}
