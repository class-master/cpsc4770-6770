# OpenMP: parallel regions and loop parallelism

## Loop parallelism
```{dropdown}
- Very common type of parallelism in scientific code     
- In previous trapezoid example, we calculate the division of iteration manually.  
- An alternative is to use `parallel for` pragma 
```


## Hands-on 1: Sum series implementation
```{dropdown}
- In the **EXPLORER** window, right-click on `csc466/openmp` and select `New File`.
- Type `sum_series_for.c` as the file name and hits Enter. 

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=sum_series_openmp_for.c"></script> 

```

## Hands-on 2: Improving sum series implementation
```{dropdown}
- In the **EXPLORER** window, right-click on `csc466/openmp` and select `New File`.
- Type `sum_series_for_2.c` as the file name and hits Enter. 

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=sum_series_openmp_for_2.c"></script> 

```





