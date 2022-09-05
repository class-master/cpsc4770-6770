# Introduction to OpenMP


## 1. Target hardware
```{dropdown}
- Single computing node, multiple sockets, multiple cores.  
- Dell PowerEdge M600 Blade Server. 

:::{image} ../fig/intro-openmp/01.jpg
:alt: multi-socket motherboard
:class: bg-primary mb-1
:height: 400px
:align: center
:::

- Intel Sandy Bridge CPU. 

:::{image} ../fig/intro-openmp/02.jpg
:alt: Intel Sandy Bridge CPU
:class: bg-primary mb-1
:height: 400px
:align: center
:::

- In summary
  - Node with up to four sockets.
  - Each socker has up to 60 cores. 
  - Each core is an independent CPU. 
  - Each core has access to all the memory on the node. 
```

## 2. Thread 

```{dropdown} An abstraction for running multiple processes

- A normal process is a running program with a single point of execution, i.e, a 
single PC (program counter).
- A multi-threaded program has multiple points of execution, i.e., multiple PCs.
- Each thread is very much like a separate process, except for one difference:
  - All threads of the same process share the same address space and thus can access the same data.

:::{image} ../fig/intro-openmp/threads.png
:alt: Threads model
:class: bg-primary mb-1
:height: 400px
:align: center
:::

```

```{dropdown} POXIS threads (pthreads)

- Standardized C language thread programming API.
- `pthreads` specifies the interface of using threads, but not how threads are implemented in OS.
- Different implementations include:
  - kernel-level threads,
  - user-level threads, or
  - hybrid
- [pthread_create](http://man7.org/linux/man-pages/man3/pthread_create.3.html)
- [pthread_join](http://man7.org/linux/man-pages/man3/pthread_join.3.html)

```

```{dropdown} Say hello to my little threads ...

- Launch a Code Server on Palmetto 
- Open the Terminal
- Create a directory called `openmp`, and change into that directory

~~~bash
$ cd
$ mkdir openmp
$ cd openmp
~~~

- Create `thread_hello.c` with the following contents:

<script src="https://gist.github.com/linhbngo/d2f3a0b28b73a3f48c751410c6c91fd6.js?file=thread_hello.c"></script>

- Compile and run `thread_hello.c`:

~~~bash
$ gcc -o thread_hello thread_hello.c -lpthread
$ ./thread_hello 1
$ ./thread_hello 2 
$ ./thread_hello 4
~~~ 

```


## 3. Target software

```{dropdown}
- Provide wrappers for `threads` and `fork/join` model of parallelism.   
  - Program originally runs in sequential mode. 
  - When parallelism is activated, multiple `threads` are `forked` from the 
  original proces/thread (`master` thread). 
  - Once the parallel tasks are done, `threads` are `joined` back to the original 
  process and return to sequential execution.  

:::{image} ../fig/intro-openmp/fork-join.jpeg
:alt: threads/fork-join models
:class: bg-primary mb-1
:height: 400px
:align: center
:::

- The threads have access to all data in the `master` thread. This is `shared` data. 
- The threads also have their own private memory stack. 
```


## 4. Write, compile, and run an OpenMP program

```{dropdown} Basic requirements

- Source code (C) needs to include `#include <omp.h>`   
- Compiling task need to have `-fopenmp` flag.  
- Specify the environment variable **OMP_NUM_THREADS**.   

```

```{dropdown} OMP directives

- OpenMP must be told when to parallelize.    
- For C/C++, `pragma` is used to annotate

~~~c
#pragma omp somedirective clause(value, othervalue)
  parallel statement;
~~~


- or

~~~c
#pragma omp somedirective clause(value, othervalue)
{
  parallel statement 1;
  parallel statement 2;
  ...
}
~~~

```

```{dropdown} Hands-on 1: create hello_omp.c

- In the **EXPLORER** window, right-click on `openmp` and select `New File`.
- Type `hello_omp.c` as the file name and hits Enter. 
- Enter the following source code in the editor windows:
- Save the file when you are done: 
  - `Ctrl-S` for Windows/Linux
  - `Command-S` for Macs
- **Memorize your key-combos!**.

~~~c

#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
  /* Fork a team of threads giving them their own copies of variables */
  #pragma omp parallel 
  {
    /* Obtain thread number */
    int tid = omp_get_thread_num();
    printf("Hello World from thread = %d\n", tid);

    /* Only master thread does this */
    if (tid == 0) {
      int nthreads = omp_get_num_threads();
      printf("Number of threads = %d\n", nthreads);
    }
  } /* All threads join master thread and disband */
}

~~~

- Line 1: Include `omp.h` to have libraries that support OpenMP. 
- Line 7: Declare the beginning of the `parallel` region. **Pay attention to how the curly bracket
is setup, comparing to the other curly  brackets.**
- Line 10: `omp_get_thread_num` gets the ID assigned to the thread and then assign
it to a variable named `tid` of type `int`.
- Line 15: `omp_get_num_threads` gets the value assigned to `OMP_NUM_THREADS` and return it to 
a variable named `nthreads` of type `int`. 

```

```{dropdown} What's important?
- `tid` and `nthreads`.    
- They allow us to coordinate the parallel workloads.   
- Specify the environment variable **OMP_NUM_THREADS**. 

~~~bash
$ export OMP_NUM_THREADS=4
~~~
{: .language-bash}  
```

```{dropdown} Trapezoidal
- Problem: estimate the integral of $y=x^2$ on $[2,8]$ using trapezoidal rule. 
four threads.     
- With 4 threads: `nthreads=4`. 
  - How to decide which thread will handle which segment?
  - How to get all results back together?    

:::{image} ../fig/intro-openmp/06.png
:alt: Trapezoidal
:class: bg-primary mb-1
:height: 400px
:align: center
:::

```


## 5. Trapezoid implementation

```{dropdown}
- In the **EXPLORER** window, right-click on `openmp` and select `New File`.
- Type `trapezoid.c` as the file name and hits Enter. 
- Enter the following source code in the editor windows:

~~~c
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
  //init parameters and evaluators
  double a = atof(argv[1]);
  double b = atof(argv[2]);
  int N = atoi(argv[3]);
  int nthreads = atoi(argv[4]);
  double partial_sum[nthreads];
  double h = ((b - a) / nthreads);    

  omp_set_num_threads(nthreads);
  #pragma omp parallel 
  {
    int tid = omp_get_thread_num();
    /* number of trapezoids per thread */
    int partial_n = N / nthreads;
    double delta = (b - a)/N;
    double local_a = a + h * tid;
    double local_b = local_a + delta;
    for (int i = 0; i < partial_n; i++) {
      partial_sum[tid] += (local_a * local_a + local_b * local_b) * delta / 2;
      local_a = local_b;
      local_b += delta;
    }
  } 
  double sum = 0;
  for (int i = 0; i < nthreads; i++) {
    sum += partial_sum[i];
  }
  printf("The integral is: %.4f\n", sum);
  return 0;
}
~~~

- Compile and run `trapezoid.c`. 

```


## 6. A bit more detailed

```{dropdown}

- Modify the `trapezoid.c` so that it looks like below. 

~~~c
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
  //init parameters and evaluators
  double a = atof(argv[1]);
  double b = atof(argv[2]);
  int N = atoi(argv[3]);
  int nthreads = atoi(argv[4]);
  double partial_sum[nthreads];
  double h = ((b - a) / nthreads);    

  omp_set_num_threads(nthreads);
  #pragma omp parallel 
  {
    int tid = omp_get_thread_num();
    /* number of trapezoids per thread */
    int partial_n = N / nthreads;
    double delta = (b - a)/N;
    double local_a = a + h * tid;
    double local_b = local_a + delta;
    for (int i = 0; i < partial_n; i++) {
      partial_sum[tid] += (local_a * local_a + local_b * local_b) * delta / 2;
      local_a = local_b;
      local_b += delta;
    }
    printf("Thread %d calculate a partial sum of %.4f from %.4f to %.4f\n", tid, partial_sum[tid], a + h*tid, local_a);
  } 
  double sum = 0;
  for (int i = 0; i < nthreads; i++) {
    sum += partial_sum[i];
  }
  printf("The integral is: %.4f\n", sum);
  return 0;
}
~~~

```


## 7. Challenges 

```{dropdown} Part 1
Alternate the `trapezoid.c` code so that the parallel region will 
invokes a function to calculate the partial sum. 
 
:::{dropdown} Solution
~~~
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

double trap(double a, double b, int N, int nthreads, int tid) {
  double h = ((b - a) / nthreads);  
  int partial_n = N / nthreads;
  double delta = (b - a)/N;
  double local_a = a + h * tid;
  double local_b = local_a + delta;
  double p_sum = 0;
  for (int i = 0; i < partial_n; i++) {
    p_sum += (local_a * local_a + local_b * local_b) * delta / 2;
    local_a = local_b;
    local_b += delta;
  }
  return p_sum;
}

int main (int argc, char *argv[]) {
   //init parameters and evaluators
  double a = atof(argv[1]);
  double b = atof(argv[2]);
  int N = atoi(argv[3]);
  int nthreads = atoi(argv[4]);
  double partial_sum[nthreads];

  omp_set_num_threads(nthreads);
  #pragma omp parallel 
  {
    int tid = omp_get_thread_num();
    partial_sum[tid] = trap(a, b, N, nthreads, tid) ;
  } 
  double sum = 0;
  for (int i = 0; i < nthreads; i++) {
    sum += partial_sum[i];
  }
  printf("The integral is: %.4f\n", sum);
  return 0;
} 
~~~

:::

```



```{dropdown} Part 2:
- Write a program called `sum_series.c` that takes a single integer `N` as a command
line argument and calculate the sum of the first `N` non-negative integers.  
- Speed up the summation portion by using OpenMP.  
- Assume N is divisible by the number of threads. 
 
:::{dropdown} Solution

~~~c
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int sum(int N, int nthreads, int tid) {
  int count = N / nthreads;  
  int start = count * tid + 1;
  int p_sum = 0;
  for (int i = start; i < start + count; i++) {
    p_sum += i;
  }
  return p_sum;
}

int main (int argc, char *argv[]) {
  int N = atoi(argv[1]);
  int nthreads = atoi(argv[2]);
  int partial_sum[nthreads];
   
  omp_set_num_threads(nthreads);
  #pragma omp parallel 
  {
    int tid = omp_get_thread_num();
    partial_sum[tid] = sum(N, nthreads, tid) ;
  } 
  int sum = 0;
  for (int i = 0; i < nthreads; i++) {
    sum += partial_sum[i];
  }
  printf("The sum of series is: %.4f\n", sum);
  return 0;
} 
~~~

:::

```

```{dropdown} Part 3:

- Write a program called `sum_series_2.c` that takes a single integer `N` as a command
line argument and calculate the sum of the first `N` non-negative integers.  
- Speed up the summation portion by using OpenMP.  
- There is no assumtion that N is divisible by the number of threads. 
 
:::{dropdown} Solution

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=sum_series_3.c"></script> 

~~~
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int sum(int N, int nthreads, int tid) {
  int count = N / nthreads;  
  int start = count * tid;
  int end = start + count;
  int p_sum = 0;

  for (int i = start; i < end; i++) {
    p_sum += i;
  } 
  if (tid < remainder) {
    p_sum += count * remainder + tid + 1;
  }

  return p_sum;
}

int main (int argc, char *argv[]) {
  int N = atoi(argv[1]);
  int nthreads = atoi(argv[2]);
  int partial_sum[nthreads];
   
  omp_set_num_threads(nthreads);
  #pragma omp parallel 
  {
    int tid = omp_get_thread_num();
    partial_sum[tid] = sum(N, nthreads, tid) ;
  } 
  int sum = 0;
  for (int i = 0; i < nthreads; i++) {
    sum += partial_sum[i];
  }
  printf("The sum of series is: %.4f\n", sum);
  return 0;
} 
~~~

:::

```


## 8. With timing

```{dropdown}
- In the **EXPLORER** window, right-click on `openmp` and select `New File`.
- Type `trapezoid_time.c` as the file name and hits Enter. 
- Enter the following source code in the editor windows (You can copy the contents of `trapezoid.c` with function from **Challenge 1** as a starting point):
- Save the file when you are done: 

~~~c
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main (int argc, char *argv[]) {
  //init parameters and evaluators
  double a = atof(argv[1]);
  double b = atof(argv[2]);
  int N = atoi(argv[3]);
  int nthreads = atoi(argv[4]);
  double partial_sum[nthreads];
  double h = ((b - a) / nthreads);  
  clock_t start, end;  

  omp_set_num_threads(nthreads);
  start = clock();
  #pragma omp parallel 
  {
    int tid = omp_get_thread_num();
    /* number of trapezoids per thread */
    int partial_n = N / nthreads;
    double delta = (b - a)/N;
    double local_a = a + h * tid;
    double local_b = local_a + delta;
    for (int i = 0; i < partial_n; i++) {
      partial_sum[tid] += (local_a * local_a + local_b * local_b) * delta / 2;
      local_a = local_b;
      local_b += delta;
    }
  } 
  end = clock();
  double sum = 0;
  for (int i = 0; i < nthreads; i++) {
    sum += partial_sum[i];
  }
  printf("The integral is: %.4f\n", sum);
  printf("The run time is: %.4f\n", ((double) (end - start)) / CLOCKS_PER_SEC);
  return 0;
}
~~~

- How's the run time?
```




