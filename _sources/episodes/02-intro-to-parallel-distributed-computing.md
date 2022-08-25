# Introduction to paralel and distributed computing


## 1. A simple computation problem

```{dropdown} Final GPA calculation
<div class="mxgraph" style="max-width:100%;border:1px solid transparent;" data-mxgraph="{&quot;highlight&quot;:&quot;#0000ff&quot;,&quot;nav&quot;:true,&quot;resize&quot;:true,&quot;toolbar&quot;:&quot;zoom layers tags lightbox&quot;,&quot;edit&quot;:&quot;_blank&quot;,&quot;xml&quot;:&quot;&lt;mxfile host=\&quot;app.diagrams.net\&quot; modified=\&quot;2022-08-15T15:02:13.015Z\&quot; agent=\&quot;5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36\&quot; etag=\&quot;OVITLCmL3SJqykvbq5oF\&quot; version=\&quot;20.2.2\&quot; type=\&quot;google\&quot;&gt;&lt;diagram id=\&quot;sjMWB68ulFoGHRR7Z6Sr\&quot; name=\&quot;Page-1\&quot;&gt;5ZpBb9sgFMc/TaTtkMng2E6PWdp1O1SKVE07RtRgG40YD+Mm2acfjiF27MTt1lRDdi81f+Bh3g94YDJxl5vdvUBZ8sAxYRPo4N3EvZ1ACBzfVf9KZV8pXjCrhFhQrAvVwiP9TUxNrRYUk/ykoOScSZqdiiFPUxLKEw0JwbenxSLOTlvNUEw6wmOIWFf9QbFMKnXuObX+ldA4MS0DR+dskCmshTxBmG8bkns3cZeCc1k9bXZLwkrnGb9U9b5cyD2+mCCpfE0F7Nxm9IGvUrZd48VDAp3pt6m28oxYoTusuh4WDEmyvl8tPnzU7y73xiGCFykmpU1n4n7eJlSSxwyFZe5WDQGlJXLDVAqox4gytuSMi0NdFyMyj0Kl51Lwn6SR44dz8hSpHP0+REiyu9hRcHSfGneEb4gUe1VEV5hrh+/NSNLpbc0PuFpLGuwMKKSHTHy0XHtVPWjH/oWTYcfJuSyw6s3aAeuQFyIn+Vs9LbhEkvJUJac3zj+5HjEal/UZieR1SHgtFND73yjcPhSxQHioJIBtJGa9JDI0SAwzzzYMXh8GKVCah4Jmcpg0HNto3Iw1UrjWTQyzYI4uVLjQOhTdXeoIYgW8sY5D70Z24MEC+tbh6N3MDjlaQNc6Fv3b2eFGC2jdHgr0bmmHGi1AYB0Hf8TRAsyswxGMNVoA6759gPlIo4V13wNB74l7qMHCusO2MTzKWGHdeRt2z9sT6LOyu0/qIa76XQkRV51sAvF/FdxkTPPDfd5CFQCzbFdV0/nG0KfDnzGn3reyeNqKkhstD24ETK2LULB71H/zEIDBhSGwXH2/Dn/wMv/Sur5lVme2Dv4oimB4Fj/2n3zPvw7voD3l3TO84Rne/rvx7n5L6PiZpHhR3qirVMhQntOwPbWa87DhaBgcHWru0N2jIwnuXMC/6MaGm7wzXjKaIEzN9edT8+dcp1tYcXoYyRf28McZaEzkatMcEl2rBvCyoXnLkEQiJrJj6EDy2O03wO1+nBg9XL99Xm5PrdfCDdprd9vQe8Ptfu4wqyY1SyZNFaAiLONe3lhS6XVC6vnBYJbOlKfkSvuk1qoJ/O6qCYPrREmVrH+ZU6Gqf9/k3v0B&lt;/diagram&gt;&lt;/mxfile&gt;&quot;}"></div>
<script type="text/javascript" src="https://viewer.diagrams.net/js/viewer-static.min.js"></script>
```

```{dropdown} Components of a computation problem
- Computational task
- Execution framework.
- Computing resources. 
```

```{dropdown} Computational tasks should be able to ...
- Be borken apart into **discrete** pieces of work that can be solved simultaneously.
- Be solved in less time with multiple computing resources than with a single computing resource. 
```

```{dropdown}  Execution framework should be able to ...
- Execute multiple program instructions concurrently at any moment in time
```

```{dropdown} Computing resources might be ...
- A single computer with multiple processors. 
- An arbitrary number of computers connected by a network.
- A special computational component inside a single computer, separate 
from the main processors (GPU), or
- Any combintations of the above. 
```


```{dropdown} Parallelizing final GPA calculations
<div class="mxgraph" style="max-width:100%;border:1px solid transparent;" data-mxgraph="{&quot;highlight&quot;:&quot;#0000ff&quot;,&quot;nav&quot;:true,&quot;resize&quot;:true,&quot;toolbar&quot;:&quot;zoom layers tags lightbox&quot;,&quot;edit&quot;:&quot;_blank&quot;,&quot;xml&quot;:&quot;&lt;mxfile host=\&quot;app.diagrams.net\&quot; modified=\&quot;2022-08-15T15:07:52.820Z\&quot; agent=\&quot;5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36\&quot; etag=\&quot;UtWEb2qZLZBcfrriJL1C\&quot; version=\&quot;20.2.2\&quot; type=\&quot;google\&quot;&gt;&lt;diagram id=\&quot;sjMWB68ulFoGHRR7Z6Sr\&quot; name=\&quot;Page-1\&quot;&gt;7Ztdb9owFIZ/DVJ70SmxkwCXLe26XXSqVE27rExigjUTZ44psF8/p9ghxEb9gJCMcAU5duxwHh/7vEehB0ez5T1H6fSBRZj2gBMte/C2B4DrBFB+5JbV2uL3vbUh5iRSnTaGJ/IX6zuVdU4inG11FIxRQdJtY8iSBIdiy4Y4Z4vtbhNGt2dNUYwNw1OIqGn9RSIxXVsHvrOxf8MknuqZXUe1zJDurAzZFEVsUTLBux4cccbE+ttsOcI0d572y/q+rztaiwfjOBHvuSFyblPywB4TuniOrh+mwLn6fqVGeUF0rn5wDwRUjnczYXJY+dRipVwR/Jkz3XCVvYK6lh1cL5Wwbzbt8lucf0ofhnOKBH6+f7y+yMQ8kg/67LiXegb5qOtJ1v2Vl4r5AGfzJML50zuyeTElAj+lKMxbF3KxSdtUzKi8cvOnIpSOGGX89V4YITyYhNKeCc5+41JLEA7weFLM94K5wMudLnULUHKFYzbDgq9kF3UDVGhXes2q68VmpRQLeVpaJQNlQ2pxxsXIG37yi0L4AZzAwBlj8RyyOc9wdnG5n4s5E0gQlsjLq6HzKZ8jSuL8foon4jAIvEGFATQZFFzKDEBdDKCVQcxRdKII4NBvGQLPQKC3nzhFp8kAto2BbzBIOZEEBEdJFnKSipMEIVODloEA5qGgT+Dx5uz92KEP+jsO/dHjz53He2Eev+PId99x5MvRVcLoeib+yWQCQiv+KBgHfnAY3kFQOX9cC29g4R3Uxtvc/Qw/4yS6zpNjeRVSlGUkrIZWOQ5Ljgb9wqE6HYaFI3Fk5NJvurHkJt/iJW3jWGaS5GV7eJvr1AyPjLyuZB2V/WqWMPzibw+SySQpxOq+chpdGQq6bw4lEJdHvjHUK83ip+8B2NxadXARHVkkkZDmYb49ZqXIIwdKtq0LQkdYwhJ8qPx629e+Jb/uH3Uv7Z9jqxoQvpGBfzq2AtB4bA12xlZdghicriAuArE5QTw0eHZNEdt2zSMrYscKoUOSuAUMzEpf1zRxCyCYUqyTorgFJMwq3VkU1yaKga0IclRRDM+i+E1RDPyDiWLLUDUn7tAmijsOuKrM9gBcVWYNAA527th1KTN4usoMek0rM2iWUrqmzGC/8TTILHd0TJm1gIFZouiaMmsegt4Ou67MWkBi9ytJZ2V2cGUGbUr8qMrMM2sihp+7lrhXlRnsH0yZWYaqOXH3bKWWjgOuKrM9AFeVWQOAbbWVWpXZj9MVZl7QtDDzzEpK14SZN2w8CzKrHR0TZi1gYFYouibMWgDBrFB0Upi1gIRZpzgLs9qEmWcT4kcVZjrVPeftu4WZNzyYMLMMVXPe7tsqLR0HXBVmewCuCrMGANtKK5UXhVPOxhTP/t93hCthVOMrwvJy82/NNaPNf17h3T8=&lt;/diagram&gt;&lt;/mxfile&gt;&quot;}"></div>
<script type="text/javascript" src="https://viewer.diagrams.net/js/viewer-static.min.js"></script>
```

## 2. Parallel and distributed computing systems

```{dropdown} Definition
A collection of individual computing devices that can communicate with each 
other. (Attiya and Welch, 2004)
```
```{dropdown} Emphasis ...
 A collection of individual computing devices that can **communicate** with each 
 other. (Attiya and Welch, 2004)
```

```{dropdown} How do parallel and distributed computing resources evolve?
- Single site, single computer, single core
- Single site, single computer, multiple cores
- Single site, multiple computers, multiple cores
  - Cluster computing
- Multiple sites, multiple computers, multiple cores, federated domains
  - Grid computing
- Multiple site, multiple computers, multiple cores, virtula unified domain
  - Cloud computing
```

## 3. Can we just throw more computers at the problem?

```{dropdown} Definitions
- **Parallel speedup**: how much faster the program becomes once
some computing resources are added. 
- **Parallel efficiency**: Ratio of performance improvement per 
individual unit of computing resource. 
```

```{dropdown} Parallel speedup
- Given `p` processors, 
- Speedup, `S(p)`, is the ratio of the time it takes to run the program 
using **a single processor** over the time it takes to run the program
using **`p` processors**.
- The time it takes to run the program using a single processor, $t_{s}$: **sequential run time**
- The time it takes to the the program using multiple processor, $t_{p}$: **parallel run time**

$S(p) = \frac{sequential\ run\ time}{parallel\ run\ time} = \frac{t_s}{t_p}$

```

```{dropdown} Example 01
A program takes 30 seconds to run on a single-core machine and 20 seconds to run on a 
dual-core machine. What is the speedup of this program?

:::{dropdown} Solution
$t_s=30$
$t_p=20$  
$S=\frac{t_s}{t_p}=\frac{30}{20}=1.5$
:::

```

```{dropdown} Theoretical max
- Let `f` be the fraction of the program that is not parallelizable. 
- Assume no overhead. 
- Running the program using one processor will take time $t_s$.
- The parallel run time, $t_p$, can be calculated as the time it take to run 
the fraction that is non-parallelizable ($f\times t_s$) plus the remainning parallelizable
fraction ($1-f$). 
- If $p=1$, this simplifies to $t_p=f\times t_s + (1-f)\times t_s$.
- Assume no overhead, this means that we reduce the speed by half as we double the number of processor.
- And so on ...

:::{image} ../fig/intro-parallel/08.png
:alt: scaling number of processors 
:class: bg-primary mb-1
:height: 300px
:align: center
:::

```

```{dropdown} Amdahl's Law
- This brings us to Amdahl's Law, which quantifies speedup in term of 
number of processors and fraction of non-parallelizable code:  

$S(p)=\frac{t_s}{t_p}=\frac{t_s}{f\times t_s + (1-f)\times t_s}=\frac{1}{f + \frac{1-f}{p}}=\frac{p}{f \times (p-1) + 1}$

```

```{dropdown} Parallel efficiency
- The efficiency `E` is then defined as the ratio of speedup `S(p)` over the number of processors `p`.  

$E=\frac{\frac{p}{f \times (p-1) + 1}}{p}=\frac{1}{f \times (p-1) + 1}$

- E is often measured as percentage. 
- For example, `E = 0.8` means the parallel efficiency is 80%.
```

```{dropdown} Example 02
Suppose that 4% of my application is serial. What is my predicted speedup
according to Amdahl's Law on 5 processors?
 
:::{dropdown} Solution
 
 $f=0.04$

 $p=5$

 $S=\frac{p}{(p-1)f + 1}=\frac{5}{4 \times 0.04 +1}=1.9231$

:::

```

```{dropdown} Example 03
Suppose that I get a speedup of 8 when I run my application on
10 processors. According to Amdahl's Law:
 
 :::{dropdown} What portion of my code is serial?
 
 $S=8$  

 $p=10$

 $S=\frac{p}{(p-1)f + 1}$
 
 $8=\frac{10}{9f+1}$
 
 $9f + 1 = \frac{10}{8}$
 
 $f=\frac{1}{36}$
:::

:::{dropdown} What is the speedup on 20 processors?

$f=\frac{1}{36}$  

$p=20$ 

$S_{20}=\frac{p}{(p-1)f + 1}=\frac{20}{\frac{19}{36}+1} \approx 13.0909$

:::

:::{dropdown} What is the efficiency on 5 processors? 20 processors?

$E=\frac{1}{(p-1)f + 1}$

$E_5=\frac{1}{\frac{4}{36}+1} = 90\% $

$E_{20}=\frac{1}{\frac{19}{36} + 1} \approx 65.45\% $

:::

:::{dropdown} What is the best speedup that I could achieve?

$f=\frac{1}{36}$  

$S_{\infty}=\lim_{p \to +\infty} \frac{p}{(p-1)f + 1} = \lim_{p \to +\infty} \frac{1}{\frac{p}{p-1}f + \frac{1}{p}}=\frac{1}{f}$

$S_{\infty}= 36$
 
- In other word, the highest number of processors one should add to this problem is 36.
:::

```

```{dropdown} Limiting factors of parallel speedup
- Non-parallelizable code.
- Communication overhead. 
```

```{dropdown} If there is no limiting factor ...
- 0% non-paralellizable code. 
- No communication overhead.   

$S_{\infty}=\lim_{f \to 0} \frac{p}{(p-1)f + 1} = p$

$S \leq p$  

```

```{dropdown} Superlinear speedup
- The unicorn of parallel and distributed computing. 
- Poor sequential reference implementation.
- Memory caching.
- I/O blocking. 
```


## 4. Parallel and distributed computing system architectures

```{dropdown} Types of distributed computing systems
- Streaming SIMD extensions for x86 architectures.
- Shared memory.
- Distributed shared memory.
- Heterogeneous computing (accelerators).
- Message passing. 
```

```{dropdown} Streaming SIMD

:::{image} ../fig/intro-parallel/09.png
:alt: Streaming SIMD 
:class: bg-primary mb-1
:height: 400px
:align: center
:::

```

```{dropdown} Shared memory
- One processor, multiple threads. 
- All threads have read/write access to the same memory. 
- Programming models:
  - Threads (pthread) - programmer manages all parallelism. 
  - OpenMP: compiler extensions handle. 
  - Vendor libraries: (Intel MKL - math kernel libraries)

:::{image} ../fig/intro-parallel/10.png
:alt: shared memory
:class: bg-primary mb-1
:height: 400px
:align: center
:::

```

```{dropdown} Heterogeneous computing
- GPU 
- FPGA
- Co-processors
```

```{dropdown} GPU - graphics processing unit
- Processor unit on graphic cards designed to support graphic rendering (numerical manipulation). 
- Significant advantage for certain classes of scientific problems.  
- Programming models:
  - CUDA: Library developed by NVIDIA for their GPUs. 
  - OpenACC: Standard developed by NVIDIA, Cray, and Portal Compiler (PGI).
  - OpenAMP: Extension to Visual C++ to direct computation to GPU. 
  - OpenCL: Public standard by the group the developed OpenGL. 

:::{image} ../fig/intro-parallel/11.png
:alt: GPU
:class: bg-primary mb-1
:height: 400px
:align: center
:::

```

```{dropdown} FPGA - field programmable array
- Dynamically reconfigurable circuit board. 
- Expensive, difficult to program. 
- Power efficient, low heat. 
```

```{dropdown} Co-processors
- Enables offloading of computationally intensive tasks from main CPU. 
- Similar to GPU, but can support a wider range of computational tasks. 
- Intel
  - Xeon Phi processor line.
  - PCIe-based add-on cards, but could also be used as a stand alone CPU. 
  - Unlike GPU, Intel Xeon supports all programs targeted to standard x86 CPU (very minor modification if any)
```

```{dropdown} Message passing distributed computing
- Processes handle their own memory. 
- Data is passed between processes via messages. 
  - Scales well. 
  - Cluster can be built from commodity parts. 
  - Cluster can easily be expanded. 
  - Cluster can be heterogeneous.  
- Programming models:
  - MPI: standardized message passing library. 
  - MPI + OpenMP: hybrid model. 
  - MapReduce programming model for big data processing.  

:::{image} ../fig/intro-parallel/12.png
:alt: message passing
:class: bg-primary mb-1
:height: 400px
:align: center
:::

```

## 5. Benchmarking

```{dropdown} Benchmarking suites
- LINPACK (Linear Algebra Package): Dense Matrix Solver 
- HPCC: High-Performance Computing Challenge. 
  - HPL (LINPACK to solve linear system of equations)
  - DGEMM (Double precision general matrix multiply) 
  - STREAM (Memory bandwidth)
  - PTRANS (Parallel matrix transpose to measure processors communication)
  - RandomAccess (random memory updates)
  - FFT (double precision complex discrete fourier transform)
  - Communication bandwidth and latency
- SHOC: Scalable heterogeneous computing
  - Non-traditional system (GPU)
- TestDFSIO
  - I/O performance of MapReduce/Hadoop Distributed File System.   
```

```{dropdown} Ranking systems
- TOP500: Rank the supercomputers based on their LINPACK score.  
- GREEN500: Rank the supercomputers with emphasis on energy usage (LINPACK/power consumption).
- GRAPH500: Rank systems based on benchmarks designed for data-intensive computing. 
```




