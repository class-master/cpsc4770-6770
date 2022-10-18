# OpenMP: Work sharing and controlling thread data


## 1. Work sharing constructs

- OpenMP utilizes **work sharing constructs** to facilitate dividing 
parallelizable work among a number of threads. 
- The work sharing constructs are:
  - **for**: divide loop iterations among threads. 
  - **sections**: divide sections of codes among themselves. 
  - **single**: the section is executed by a single thread. 


## 2. Work sharing constructs: sections

```{dropdown} Definition
- Used when parallelize predetermined number of independent work units. 
- Within a primary `sections` construct, there can be multiple `section`
construct. 
- A `section` can be executed by any available thread in the current 
team, including having multiple sections done by the same thread. 
```

```{dropdown} Hands-on
- In the **EXPLORER** window, double-click on `openmp` and select 
`New Dir` to create a new directory in `openmp` called `sections`. 
- Inside `sections`, create a file named `hello_sections.c` with the
following contents:

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=hello_sections.c"></script>

:::{image} ../fig/work-sharing/work_01.png
:alt: compile and run hello_sections.c
:class: bg-primary mb-1
:height: 400px
:align: center
:::

```

```{dropdown} Challenge

Given the following functions: y=x<sup>4</sup> + 15x<sup>3</sup> + 10x<sup>2</sup> + 2x  
develop an OpenMP program called `poly_openmp.c` with `sections`/`section` directives. Each
section should handle the calculations for one term of the polynomial. 
 
 :::{dropdown} Solution
 
 <script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=poly_openmp.c"></script>

:::
```

## 3. Work sharing construct: single

```{dropdown} Definition
- Limits the execution of a block to a single thread. 
- All other threads will skip the execution of this block **but** wait until the block is finished
before moving on. 
- To enable proceed without waiting, a **nowait** clause can be added. 
```

```{dropdown} Hands on: single
- Inside `sections`, create the following files: 

`hello_sections_nosingle.c`: 

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=hello_sections_nosingle.c"></script>

`hello_sections_single.c`: 

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=hello_sections_single.c"></script>

`hello_sections_single_nowait.c`: 

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=hello_sections_single_nowait.c"></script>

Compile and run the above files:

:::{image} ../fig/work-sharing/work_02.png
:alt: compile and run singles
:class: bg-primary mb-1
:height: 500px
:align: center
:::

```

## 4. Shared and private data

```{dropdown} Definition
- Data declared outside of a parallel region will be shared among all threads.  
- Data declared inside of a parallel region will be private to individual thread. 
```

```{dropdown} Hands-on: potential problems with shared data
- Inside `sections`, create a file named `counter_openmp.c` with the
following contents:

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=counter_openmp.c"></script>

:::{image} ../fig/work-sharing/work_03.png
:class: bg-primary mb-1
:height: 400px
:align: center
:::

```
