#!/bin/awk -f

BEGIN { 
    Min = 999999; 
    MAX = 0; 
}

{ 
    if($1 < Min && $1 > 0) {
        Min = $1
    }

    if($1 > MAX) {
        MAX = $1
    } 
    
    count++; 
    mean_diff = ($1 - mean) / count; 
    new_mean = mean + mean_diff; 
    d_sq_inc = ($1 - new_mean) * ($1 - mean); 
    mean = new_mean; 
    d_sq = d_sq + d_sq_inc; 
}

END {
    print mean; 
    print sqrt(d_sq / count); 
    print Min; 
    print MAX; 
}
