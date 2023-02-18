#!/bin/awk -f

BEGIN { 
    Min = 999999; 
    MAX = 0; 
}

/BDEV_IO_START/ {
    if ($8 == 4) {
        exists[$6] = 1;
    }
}

/BDEV_IO_DONE/ {
    if(exists[$6] == 1) {
        if($8 < Min && $8 > 0) {
            Min = $8
        }

        if($8 > MAX) {
            MAX = $8
        } 
        
        count++; 
        mean_diff = ($8 - mean) / count; 
        new_mean = mean + mean_diff; 
        d_sq_inc = ($8 - new_mean) * ($8 - mean); 
        mean = new_mean; 
        d_sq = d_sq + d_sq_inc; 
    }
}

/nvme_cmd_write/ { 
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
    printf "min %f\n", Min; 
    printf "max %f\n", MAX; 
}
