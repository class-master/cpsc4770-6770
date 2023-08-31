# Introduction to C

## 1. What is C?     

```{dropdown}

- Developed by Dennis Ritchie at Bell Labs
- First public released in 1972. 
- **The** book: *The C programming languange" by Dennis M. Ritchie and Brian W. Kernighan. 
Prentice Hall 1988. 

:::{dropdown} How to learn C (now that you already know Java)? 

- [C for Java programmers](https://www.cs.rochester.edu/u/ferguson/csc/c/c-for-java-programmers.pdf)
- [C programming vs. Java programming](https://introcs.cs.princeton.edu/java/faq/c2java.html)

:::

:::{dropdown} Scary stuff ahead ...
 
- C is much less supportive for programmers than Java.
- (Much) easier to make mistake, and (much) harder to fix. 

:::


:::{dropdown} But it is exciting ...     
 
- C requires less memory resources than Java.
- C, in many instances, runs faster than Java. 
- Knowing C will make you a better programmer overall. 

:::

:::{dropdown} Similarities (or mostly similar) between C and Java     
 
- Values, types, literals, expressions
- Variables
- Control flow (if, switch, while, for, do-while)
- Call-return: parameters, arguments, return values
- Arrays (mostly)
- Primitive and reference types
- Type casting. 
- Library usage. 

:::


:::{dropdown} Differences between C and Java
 
- C has no classes or objects (but something similar)
- C is not object-oriented. 
- C arrays are simpler:
  - No boundary checking. 
  - No knowledge of array's own size. 
- String operations are limited. 
- No collections, exceptions, or generics. 
- No automatic memory management. 
- **Pointers!!!**
:::

::::{dropdown} How Java programs run

:::{image} ../fig/intro-c/java.png
:alt: Java programs
:class: bg-primary mb-1
:height: 400px
:align: center
:::

::::
 
::::{dropdown} How C programs run

:::{image} ../fig/intro-c/c.png
:alt: Java programs
:class: bg-primary mb-1
:height: 400px
:align: center
:::

::::

```

## 2. A (very quick) introduction to Palmetto
```{dropdown}

:::{dropdown} Introduction

- Palmetto is a *supercomputing cluster*: a set of powerful computers that 
are connected to each other. It is built and maintained by Clemson University, 
and is located off campus, close to Anderson SC, in a dedicated building which 
is powered by a dedicated power plant. 

:::{image} ../fig/intro-c/palmetto_front_view.png
:alt: the Palmetto supercomputer
:class: bg-primary mb-1
:height: 300px
:align: center
:::

- The Palmetto cluster is maintained by two teams: a team of *system administrators*, 
who work directly at the cluster, and monitors its hardware and operating system, 
and a team of *research facilitators*, who work with the Palmetto users.

- The following [extensive website](https://www.palmetto.clemson.edu/palmetto/) which hosts information for Palmetto users. 

:::

::::{dropdown} Accessing Palmetto

- There are several ways to access the Palmetto cluster. The easiest 
is through a web interface called Open On Demand. To start it, open a 
web browser, and go to this website:

[https://openod.palmetto.clemson.edu](https://openod.palmetto.clemson.edu)


You will need to login with your Clemson username and password, and perform 
a DUO check. 

:::{image} ../fig/intro-c/openod_dashboard.png
:alt: Open OnDemand Dashboard
:class: bg-primary mb-1
:height: 400px
:align: center
:::

- One convenient feature of Open OnDemand is a file browser. In the top left 
corner, you will see the `Files` button, which will take you to your home 
diretory or to scratch directory. Click it and explore the files in your 
file system. You can use this feature to view, edit, and delete files. It 
is also a convenient way to upload and download the files. You can go to any 
folder that you have access to by clicking `Go to`. 

- To start the terminal, click on `Clusters`, then `Palmetto Shell Access`:

:::{image} ../fig/intro-c/openod_shell_access.png
:alt: Open OnDemand Shell Menu
:class: bg-primary mb-1
:height: 300px
:align: center
:::

- Enter your account password and do the two-factor identification. This will 
bring you to the login node of Palmetto:

:::{image} ../fig/intro-c/openod_shell.png
:alt: Open OnDemand Shell Menu
:class: bg-primary mb-1
:height: 300px
:align: center
:::

::::


::::{dropdown} The structure of Palmetto

- The computers that make up the Palmetto cluster are called *nodes*. 
  - Many *compute nodes* are used in actual computation. 
  - Several *login nodes* that work as a temporary landing zone (think a hotel lobby) 
  when users first log into Palmetto. 
  - The *scheduler* handles resource allocation (compute nodes) request from users

:::{image} ../fig/intro-c/palmetto-structure.png
:alt: Structure of the Palmetto Cluster
:class: bg-primary mb-1
:height: 350px
:align: center
:::

- To see the hardware specifications of the compute nodes, type in the following 
command on the shell and press `Enter`:

~~~
$ cat /etc/hardware-table 

PALMETTO HARDWARE TABLE      Last updated:  Fri Jul 1 2022
PHASE COUNT  MAKE   MODEL    CHIP(0)                CORES  RAM(1)    /local_scratch   Interconnect     GPUs  
BIGMEM nodes
 0a     3    HP     DL580    Intel Xeon    7542       24   1.0 TB(2)    99 GB         10ge              0     
 0b     1    Dell   R820     Intel Xeon    E5-4640    32   750 GB(2)   740 GB(13)     10ge              0     
 0c     1    Dell   R830     Intel Xeon    E5-4627v4  40   1.0 TB(2)   880 GB         10ge              0     
 0d     2    Lenovo SR650    Intel Xeon    6240       36   1.5 TB(2)   400 GB(13)     10ge              0
 0e     1    HP     DL560    Intel Xeon    E5-4627v4  40   1.5 TB(2)   881 GB         10ge              0     
 0f     1    HPE    DL560    Intel Xeon    6138G      80   1.5 TB(2)   3.6 TB         10ge              0     
 0f     1    HPE    DL560    Intel Xeon    6148G      80   1.5 TB(2)   745 GB(13)     10ge              0     
 0f     1    HPE    DL560    Intel Xeon    6148G      80   1.5 TB(2)   3.6 TB         10ge              0     
C1 CLUSTER (older nodes with interconnect=1g)
 1a   118    Dell   R610     Intel Xeon    E5520       8    31 GB      220 GB         1g                0     
 1b    46    Dell   R610     Intel Xeon    E5645      12    92 GB      220 GB         1g                0    
 2a    68    Dell   R620     Intel Xeon    E5-2660    16   251 GB      2.7 TB         1g                0     
 2c    88    Dell   PEC6220  Intel Xeon    E5-2665    16    62 GB      250 GB         1g                0
 3    149    Sun    X2200    AMD   Opteron 2356        8    15 GB      193 GB         1g                0   
 4    280    IBM    DX340    Intel Xeon    E5410       8    31 GB      111 GB         1g                0   
 5c    37    Dell   R510     Intel Xeon    E5640       8    22 GB        7 TB         1g                0   
 5d    23    Dell   R520     Intel Xeon    E5-2450    12    46 GB      2.7 TB         1g                0   
 6     65    HP     DL165    AMD   Opteron 6176       24    46 GB      193 GB         1g                0   
C2 CLUSTER (newer nodes with interconnect=FDR)
 7a    42    HP     SL230    Intel Xeon    E5-2665    16    62 GB      240 GB         56g, fdr, 10ge    0           
 7b    12    HP     SL250s   Intel Xeon    E5-2665    16    62 GB      240 GB         56g, fdr, 10ge    0           
 8a    71    HP     SL250s   Intel Xeon    E5-2665    16    62 GB      900 GB         56g, fdr, 10ge    2 x K20(4)    
 8b    57    HP     SL250s   Intel Xeon    E5-2665    16    62 GB      420 GB         56g, fdr, 10ge    2 x K20(4)    
 9     72    HP     SL250s   Intel Xeon    E5-2665    16   125 GB      420 GB         56g, fdr, 10ge    2 x K20(4)    
10     80    HP     SL250s   Intel Xeon    E5-2670v2  20   125 GB      800 GB         56g, fdr, 10ge    2 x K20(4)    
11a    40    HP     SL250s   Intel Xeon    E5-2670v2  20   125 GB      800 GB         56g, fdr, 10ge    2 x K40(6)    
11b     3    HP     SL250s   Intel Xeon    E5-2670v2  20   125 GB      800 GB         56g, fdr, 10ge    0           
11c    41    Dell   MISC     Intel Xeon    E5-2650v2  16   250 GB      2.7 TB         56g, fdr, 10ge    0           
12     29    Lenovo NX360M5  Intel Xeon    E5-2680v3  24   125 GB      800 GB         56g, fdr, 10ge    2 x K40(6)    
13     24    Dell   C4130    Intel Xeon    E5-2680v3  24   125 GB      1.8 TB         56g, fdr, 10ge    2 x K40(6)    
14     12    HPE    XL1X0R   Intel Xeon    E5-2680v3  24   125 GB      880 GB         56g, fdr, 10ge    2 x K40(6)    
15     32    Dell   C4130    Intel Xeon    E5-2680v3  24   125 GB      1.8 TB         56g, fdr, 10ge    2 x K40(6)    
16     40    Dell   C4130    Intel Xeon    E5-2680v4  28   125 GB      1.8 TB         56g, fdr, 10ge    2 x P100(8)   
17     20    Dell   C4130    Intel Xeon    E5-2680v4  28   124 GB      1.8 TB         56g, fdr, 10ge    2 x P100(8)   
C2 CLUSTER (newer nodes without FDR)
19b     4    HPE    XL170    Intel Xeon    6252G      48   372 GB      1.8 TB         56g, 10ge         0           
C2 CLUSTER (newest nodes with interconnect=HDR)
18a     2    Dell   C4140    Intel Xeon    6148G      40   372 GB      1.9 TB(13)    100g, hdr, 25ge    4 x V100NV(9)  
18b    65    Dell   R740     Intel Xeon    6148G      40   372 GB      1.8 TB        100g, hdr, 25ge    2 x V100(10)   
18c    10    Dell   R740     Intel Xeon    6148G      40   748 GB      1.8 TB        100g, hdr, 25ge    2 x V100(10)   
19a    28    Dell   R740     Intel Xeon    6248G      40   372 GB      1.8 TB        100g, hdr, 25ge    2 x V100(10)   
20     22    Dell   R740     Intel Xeon    6238R      56   372 GB      1.8 TB        100g, hdr, 25ge    2 x V100S(11) 
21      2    Dell   R740     Intel Xeon    6248G      40   372 GB      1.8 TB        100g, hdr, 25ge    2 x V100       
24a     2    NVIDIA DGXA100  AMD   EPYC    7742      128     1 TB       28 TB        100g, hdr, 100ge   8 x A100(17)
24b     1    NVIDIA DGX-1    Intel Xeon    E5-2698v4  40   512 GB      6.6 TB        100g, hdr, 100ge   8 x V100
27     34    Dell   R740     Intel Xeon    6258R      56   372 GB      1.8 TB        100g, hdr, 25ge    2 x A100(16) 
                                           
  *** PBS resource requests are always lowercase ***
If you don't care which GPU MODEL you get (K20, K40, P100, V100, V100S, V100NV), you can specify gpu_model=any
If you don't care which IB you get (FDR or HDR), you can specify interconnect=any
(0) CHIP has 3 resources:   chip_manufacturer, chip_model, chip_type
(1) Leave 2 or 3GB for the operating system when requesting memory in PBS jobs
(2) Specify queue "bigmem" to access the large memory machines
(4) 2 NVIDIA Tesla K20m cards per node, use resource request "ngpus=[1|2]" and "gpu_model=k20"
(6) 2 NVIDIA Tesla K40m cards per node, use resource request "ngpus=[1|2]" and "gpu_model=k40"
(8) 2 NVIDIA Tesla P100 cards per node, use resource request "ngpus=[1|2]" and "gpu_model=p100"
(9) 4 NVIDIA Tesla V100 cards per node with NVLINK2, use resource request "ngpus=[1|2|3|4]" and "gpu_model=v100nv"
(10) 2 NVIDIA Tesla V100 cards per node, use resource request "ngpus=[1|2]" and "gpu_model=v100"
(11) 2 NVIDIA Tesla V100S cards per node, use resource request "ngpus=[1|2]" and "gpu_model=v100s"
(12) Phase18a nodes use NVMe storage for /local_scratch.
(13) local_scratch is housed entirely on SSD
(15) phase21 has a virtually segmented GPU, available GPU is Tesla V100 with 8GB VRAM
(16) 2 NVIDIA A100 cards per node, use resource request "ngpus=[1|2]" and "gpu_model=a100"
(17) 8 NVIDIA A100 cards per node, use resource request "ngpus=[1..8]" and "gpu_model=dgxa100"
~~~

- We have more than 2,000 compute nodes. They are grouped into phases; all nodes within a phase have the same 
hardware specifications. 
  - The compute nodes in Phase 0 have very large amount of RAM, up to 1.5 Tb. 
  - The nodes in phases 1 to 6 are connected to each other with 1g Ethernet connection; 
  they have at least 8 CPUs and at least 15 Gb of RAM. 
    - **We will mostly use nodes in these phases for this course**.
  - Nodes in phases 7 and up are connected with *InfiniBand connection*, which is much 
  faster than Ethernet. They are, on average, more powerful than the 1g nodes: they have at 
  least 16 CPUs and at least 62 Gb of RAM. Most of them also have GPUs (videocards); they 
  are typically not used for video processing, but rather for some computation-heavy procedures 
  such as machine learning applications. 

- To see which nodes are available at the moment, you can type 

~~~
$ whatsfree
 
Sun Aug 28 2022 09:22:05
 
TOTAL NODES: 1746  TOTAL CORES: 33864  NODES FREE: 1217   NODES OFFLINE: 42   NODES RESERVED: 0
 
BIGMEM nodes
PHASE 0a   TOTAL =   3  FREE =   3  OFFLINE =   0  TYPE = Bigmem node 24 cores and 1TB RAM
PHASE 0b   TOTAL =   4  FREE =   2  OFFLINE =   0  TYPE = Bigmem node 32 cores and 750GB RAM
PHASE 0c   TOTAL =   1  FREE =   0  OFFLINE =   0  TYPE = Bigmem node 40 cores and 1TB RAM
PHASE 0d   TOTAL =   2  FREE =   1  OFFLINE =   0  TYPE = Bigmem node 36 cores and 1.5TB RAM
PHASE 0e   TOTAL =   1  FREE =   0  OFFLINE =   0  TYPE = Bigmem node 40 cores and 1.5TB RAM
PHASE 0f   TOTAL =   3  FREE =   0  OFFLINE =   0  TYPE = Bigmem node 80 cores and 1.5TB RAM
 
C1 CLUSTER (older nodes with interconnect=1g) 
PHASE 1a   TOTAL = 118  FREE = 117  OFFLINE =   0  TYPE = Dell   R610    Intel Xeon  E5520,      8 cores,  31GB, 1g
PHASE 1b   TOTAL =  46  FREE =  46  OFFLINE =   0  TYPE = Dell   R610    Intel Xeon  E5645,     12 cores,  94GB, 1g
PHASE 2a   TOTAL =  68  FREE =  68  OFFLINE =   0  TYPE = Dell   R620    Intel Xeon  E5-2660    16 cores, 251GB, 1g
PHASE 2c   TOTAL =  88  FREE =  88  OFFLINE =   0  TYPE = Dell   PEC6220 Intel Xeon  E5-2665,   16 cores,  62GB, 1g
PHASE 3    TOTAL = 150  FREE = 149  OFFLINE =   1  TYPE = Sun    X2200   AMD Opteron 2356,       8 cores,  15GB, 1g
PHASE 4    TOTAL = 280  FREE = 270  OFFLINE =  10  TYPE = IBM    DX340   Intel Xeon  E5410,      8 cores,  15GB, 1g
PHASE 5c   TOTAL =  37  FREE =  36  OFFLINE =   0  TYPE = Dell   R510    Intel Xeon  E5460,      8 cores,  23GB, 1g
PHASE 5d   TOTAL =  23  FREE =  23  OFFLINE =   0  TYPE = Dell   R520    Intel Xeon  E5-2450    12 cores,  46GB, 1g
PHASE 6    TOTAL =  65  FREE =  62  OFFLINE =   0  TYPE = HP     DL165   AMD Opteron 6176,      24 cores,  46GB, 1g
 
C2 CLUSTER (newer nodes with interconnect=FDR)
PHASE 7a   TOTAL =  42  FREE =   0  OFFLINE =   0  TYPE = HP     SL230   Intel Xeon  E5-2665,   16 cores,  62GB, FDR, 10ge
PHASE 7b   TOTAL =  12  FREE =   0  OFFLINE =   0  TYPE = HP     SL250s  Intel Xeon  E5-2665,   16 cores,  62GB, FDR, 10ge      
 
PHASE 8a   TOTAL =  71  FREE =   7  OFFLINE =   0  TYPE = HP     SL250s  Intel Xeon  E5-2665,   16 cores,  62GB, FDR, 10ge, K20
PHASE 8b   TOTAL =  57  FREE =   0  OFFLINE =   1  TYPE = HP     SL250s  Intel Xeon  E5-2665,   16 cores,  62GB, FDR, 10ge, K20
PHASE 9    TOTAL =  72  FREE =  64  OFFLINE =   0  TYPE = HP     SL250s  Intel Xeon  E5-2665,   16 cores, 125GB, FDR, 10ge, K20
PHASE 10   TOTAL =  80  FREE =  78  OFFLINE =   1  TYPE = HP     SL250s  Intel Xeon  E5-2670v2, 20 cores, 125GB, FDR, 10ge, K20
PHASE 11a  TOTAL =  41  FREE =  40  OFFLINE =   1  TYPE = HP     SL250s  Intel Xeon  E5-2670v2, 20 cores, 125GB, FDR, 10ge, K40
PHASE 11b  TOTAL =   3  FREE =   3  OFFLINE =   0  TYPE = HP     SL250s  Intel Xeon  E5-2670v2, 20 cores, 125GB, FDR, 10ge, Phi
PHASE 12   TOTAL =  29  FREE =  23  OFFLINE =   0  TYPE = Lenovo MX360M5 Intel Xeon  E5-2680v3, 24 cores, 125GB, FDR, 10ge, K40
PHASE 13   TOTAL =  24  FREE =   0  OFFLINE =   0  TYPE = Dell   C4130   Intel Xeon  E5-2680v3, 24 cores, 125GB, FDR, 10ge, K40
PHASE 14   TOTAL =  12  FREE =  12  OFFLINE =   0  TYPE = HP     XL190r  Intel Xeon  E5-2680v3, 24 cores, 125GB, FDR, 10ge, K40
PHASE 15   TOTAL =  32  FREE =   8  OFFLINE =   0  TYPE = Dell   C4130   Intel Xeon  E5-2680v3, 24 cores, 125GB, FDR, 10ge, K40
PHASE 16   TOTAL =  40  FREE =   0  OFFLINE =   1  TYPE = Dell   C4130   Intel Xeon  E5-2680v4, 28 cores, 125GB, FDR, 10ge, P100
PHASE 17   TOTAL =  20  FREE =   1  OFFLINE =   0  TYPE = Dell   C4130   Intel Xeon  E5-2680v4, 28 cores, 124GB, FDR, 10ge, P100
 
C2 CLUSTER (newest nodes with interconnect=HDR except for phase19b,21,22) 
PHASE 18a  TOTAL =   2  FREE =   2  OFFLINE =   0  TYPE = Dell   C4140   Intel Xeon  6148G,     40 cores, 372GB, HDR, 10ge, V100
nv
PHASE 18b  TOTAL =  65  FREE =  28  OFFLINE =   0  TYPE = Dell   R740    Intel Xeon  6148G,     40 cores, 372GB, HDR, 25ge, V100
PHASE 18c  TOTAL =  10  FREE =   0  OFFLINE =   0  TYPE = Dell   R740    Intel Xeon  6148G,     40 cores, 748GB, HDR, 25ge, V100
PHASE 19a  TOTAL =  28  FREE =  25  OFFLINE =   0  TYPE = Dell   R740    Intel Xeon  6248G,     40 cores, 372GB, HDR, 25ge, V100
PHASE 19b  TOTAL =   5  FREE =   4  OFFLINE =   0  MUSC TYPE = HPE XL170 Intel Xeon  6252G,     48 cores, 372GB,      10ge
PHASE 20   TOTAL =  22  FREE =   1  OFFLINE =   0  TYPE = Dell   R740    Intel Xeon  6238R,     56 cores, 372GB, HDR, 25ge, V100
S
PHASE 21   TOTAL =   2  FREE =   1  OFFLINE =   0  TYPE = Dell   R740    Intel Xeon  6248G,     40 cores, 372GB,      10ge      
PHASE 22   TOTAL =  16  FREE =  16  OFFLINE =   0  UNAVAILABLE  Dell C8220 Intel Xeon 6238r     20 cores, 250GB,      10ge
 
DGX NODES 
PHASE 24a  TOTAL =   2  FREE =   0  OFFLINE =   0  TYPE = NVIDIA DGXA100 AMD   EPYC  7742,      128 cores, 990GB, HDR, 25ge, A10
0
 
SKYLIGHT CLUSTER (Mercury Consortium) 
PHASE 25a  TOTAL =  22  FREE =   0  OFFLINE =   0  TYPE = ACT            Intel Xeon  E5-2640v4, 20 cores,  125GB,  1ge
PHASE 25b  TOTAL =   3  FREE =   0  OFFLINE =   1  TYPE = ACT            Intel Xeon  E5-2680v4, 28 cores,  503GB,  1ge
PHASE 25c  TOTAL =   6  FREE =   0  OFFLINE =   0  TYPE = ACT            Intel Xeon  E5-2640v4, 20 cores,   62GB,  1ge, GTX1080
PHASE 25d  TOTAL =   2  FREE =   0  OFFLINE =   0  TYPE = ACT            Intel Xeon  E5-2640v4, 20 cores,  125GB,  1ge, P100
PHASE 26a  TOTAL =  24  FREE =   0  OFFLINE =   0  TYPE = Dell R640      Intel Xeon  6230R,     52 cores,  754GB, 25ge
PHASE 26b  TOTAL =   5  FREE =   0  OFFLINE =   0  TYPE = Dell R640      Intel Xeon  6230R,     52 cores, 1500GB, 25ge
PHASE 26c  TOTAL =   6  FREE =   0  OFFLINE =   0  TYPE = Dell DSS840    Intel Xeon  6230R,     52 cores,  380GB, 25ge, RTX6000
 
C2 CLUSTER New nodes with A100 GPUs 
PHASE 27   TOTAL =  34  FREE =  28  OFFLINE =   0  TYPE = Dell   R740    Intel Xeon  6258R,     56 cores, 372GB, HDR, 25ge, A100
 
 
NOTE: PBS resource requests must be LOWER CASE.  
      Your job will land on the oldest phase that satisfies your PBS resource requests. 
      Also run "checkqueuecfg" to find out the queue limits on number of running jobs permitted per user in each queue. 
~~~

This table shows the amount of *completely free* nodes per each phase; a node which has, for example, 8 cores, 
but only 4 of them are used, would not be counted as "free". So this table is a conservative estimate. Note that 
there are a lot more free nodes in the 1g phases, compared to the InfiniBand phases. It is a good idea to run 
`whatsfree` when you log into Palmetto, to get a picture of how busy the cluster is. This picture can change 
pretty drastically depending on the time of the day and the day of the week.

::::

```



## 3. Hands-on: Getting started
```{dropdown}

- Go to Palmetto OpenOD site
- Under `Interactive Apps`, select `Code Server (VSCode)`. 
- Provide the following information then click `Launch`:
  - `Number of resource chunks (select)`: 1
  - `CPU cores per chunk (ncpus)`: 8
  - `Amount of memory per chunk (mem)`: 15gb
  - `Number of GPUs per chunk (ngpus)`: None
  - `GPU Model (gpu_model)`: None
  - `Interconnect`: any
  - `Walltime`: 01:30:00
  - `Queue`: work1
  - Leave empty the `Absolute path to working directory`
  - `Codeserver Version`: 3.10.2

:::{image} ../fig/intro-c/code-server.png
:alt: VSCode Server on Palmetto via Open OnDemand
:class: bg-primary mb-1
:height: 500px
:align: center
:::

- On top of the Coder Server page, click `Terminal` then `New Terminal`. A 
new terminal shell should appear at the bottom of the page. 

:::{image} ../fig/intro-c/code-server-terminal.png
:alt: VSCode Server's Terminal
:class: bg-primary mb-1
:height: 500px
:align: center
:::

- Create a directory named `intro-c`, then change into that directory.

~~~
$ mkdir intro-c
$ cd intro-c
$ pwd
~~~

- Find and click the `Refresh` button to see the new `intro-c` directory 
showing up in the Explore sidebar. 

:::{image} ../fig/intro-c/02.png
:alt: create intro-c directory
:class: bg-primary mb-1
:height: 250px
:align: center
:::


::::{dropdown} Hands-on: Create hello.c

- Right-click on `intro-c`, then select `New File`. 
- Type `hello.c` as the name and press Enter.  
- Select `hello.c` so that the file appears in the Editor. 
- Enter the code below into `hello.c`.

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=hello.c"></script>

- Press `Ctrl-S` (Windows) or `Cmd-S` (Mac) to save. 
- **Memorize your key-combos!**.

:::{image} ../fig/intro-c/03.png
:alt: Creating hello.c
:class: bg-primary mb-1
:height: 550px
:align: center
:::

::::

:::{dropdown} What's in the code?

- Line 1: Standard C library for I/O, similar to Java's `import`.
- Line 2-4: Function declaration/definition for `main`:
  - Line 2: 
    - return type: `int`
    - function name: `main`
    - parameter list: 
       - `argc`: number of command line arguments.
       - `*argv[]`: pointers to array of command line argument strings. 
   - Line 3: Invoke builtin function `printf` to print out  string `Hello world!`
   with an end-of-line character `\n`. This is similar to `System.out.printf`.
   - Line 4: Exit a successfully executed program with a return value of 0. 

:::

::::{dropdown} Hands-on: Simple compile and run

- Similar to `javac`, we use `gcc` to compile C code. 
- Before compile, make sure that you are still inside `intro-c` in the terminal. 

~~~
$ ls
$ pwd
$ gcc -o hello hello.c
$ ls
$ ./hello
~~~

:::{image} ../fig/intro-c/04.png
:alt: Compile and run hello.c
:class: bg-primary mb-1
:height: 350px
:align: center
:::

::::


```


## 4. Variables, addresses, and pointers
```{dropdown}

- In Java, you can manipulate the value of a variable via the program but not directly 
in memory (inside the JVM). 
- In C, you can retrieve the address of the location in memory where the variable is 
stored. 
- The operator `&` (reference of) represents the memory address of a variable.



::::{dropdown} Hands-on: Pointer

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `pointer-1.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=pointer-1.c"></script>

- `%p` is an output conversion syntax (similar to Java specifiers) for displaying memory 
address in hex format. See [Other Output Conversions](https://www.gnu.org/software/libc/manual/html_node/Other-Output-Conversions.html#Other-Output-Conversions) for more 
details.
- Compile and run `pointer-1.c`

~~~
$ ls
$ gcc -o pointer-1 pointer-1.c
$ ./pointer-1
~~~


::::

:::{dropdown} Pointer Definition

- Pointer is a variable that points to a memory location (contains a memory location).  
  - We can them *pointer variables*. 
- A pointer is denoted by a `*` character. 
- The type of pointer must be the same as that of the value being stored in 
the memory location (that the pointer points to).
- If a pointer points to a memory location, how do we get these locations?
  - An `&` character in front of a variable (includes pointer variables) denotes that
  variable's address location. 

:::

::::{dropdown} Hands-on: Pointer and Variable's Addresses

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `pointer-2.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=pointer-2.c"></script>

- Since `p_i` is a pointer variable, `p_i` contains a memory address (hence `%p`).
- Then, `*p_i` will point to **the value in the memory address contained in p_i**. 
  - This is referred to as *de-referencing*. 
  - This is also why the type of a pointer variable must match the type of data stored
  in the memory address the pointer variable contains. 
- Compile and run `pointer-2.c`

::::


::::{dropdown} Pass by Value and Pass by Reference

- Parameters are passed to functions. 
- Parameters can be value variables or pointer variables. 
- What is the difference?  

::::

::::{dropdown} Hands-on: Pass by value

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `pointer-3.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=pointer-3.c"></script>

- Compile and run `pointer-3.c`

::::


::::{dropdown} Hands-on: Pass by reference

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `pointer-4.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=pointer-4.c"></script>

- Compile and run `pointer-4.c`

::::


- In Java, do you pass by value or pass by reference?

:::{dropdown} Answer     
- Primitives are passed by value. 
- Objects are passed by reference. 
:::

```

## 5. Pointers and memory allocation
```{dropdown}

- How does C request dynamic memory when you don't know at 
compile-time exactly what you will need?
- How does C allocate memory?
  - Automatic: compile arranges for memory to be allocated 
  and initialized for local variables when it is in scope.
  - Static: memory for static variables are allocated once 
  when program starts.
  - Dynamic: memory is allocated on the fly as needed.

::::{dropdown} Dynamic memory allocation

- Unlike Java, you have to do everything!
  - Ask for memory.
  - Return memory when you are done (garbage collection!).
- C function: [`malloc`](https://linux.die.net/man/3/malloc)
  - `void *malloc(size_t size);`
  - The `malloc()` function allocates `size` bytes and returns 
  a pointer to the allocated memory. The memory is **not initialized**. 
  If size is 0, then `malloc()` returns either `NULL`, or a unique 
  pointer value that can later be successfully passed to `free()`.
- C function: [`free`](https://linux.die.net/man/3/free)
  - void free(void *ptr);
  - The `free()` function frees the memory space pointed to by ptr, 
  which must have been returned by a previous call to `malloc()`, 
  `calloc()` or `realloc()`. Otherwise, or if `free(ptr)` has already 
  been called before, undefined behavior occurs. If `ptr` is `NULL`, 
  no operation is performed.

::::


::::{dropdown} Void pointer

- When `malloc` allocates memory, it returns a sequence of bytes, with
no predefined types. 
- A pointer that points to this sequence of bytes (the address of the 
starting byte), is called a **void pointer**.  
- A void pointer will then be typecast to an appropriate type. 

::::

::::{dropdown} Hands-on: malloc and type cast

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `malloc-1.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=malloc-1.c"></script>

- What points to where:
  - `void *p = malloc(4);`: allocate 4 contiguous bytes. The address of the
  first byte is returned and assign to pointer variable `p`. `p` has no 
  type, so it is a `void pointer`. 
  - `int *ip = (int *)p;`: The address value *pointed to* by `p` is assigned
  to pointer variable `ip`. The bytes pointed to be `p` are now casted to 
  type `int`. 
- Compile and run `malloc-1.c`

::::

::::{dropdown} Hands-on: malloc and type cast with calculation

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `malloc-2.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=malloc-2.c"></script>

- Only ask for exactly what you need!
- Compile and run `malloc-2.c`

::::

::::{dropdown} Hands-on: Safety

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `malloc-3.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=malloc-3.c"></script>

- Return and free memory after you are done!
- Compile and run `malloc-3.c`

::::


::::{dropdown} Dynamic memory allocation

- Critical to support complex data structures that grow as the 
 program executes. 
- In Java, custom classes such as ArrayList and Vector provide 
such support.
- In C, you have to do it manually: How?
- Let’s start with a simpler problem:
  - How can we dynamically allocate memory to an array 
  whose size is not known until during run time?
::::
```


## 6. Array in C
```{dropdown}

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `array-1.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=array-1.c"></script>

- What is the distance between addresses? Why?
- Compile and run `array-1.c`

:::::{dropdown} Exercise

- Create a copy of `array-1.c` called `array-2.c`. 
- Change the type of `numbers` to `double`. 
- What is the address step now?

::::{dropdown} Answer    

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=array-2.c"></script>

::::
:::::

::::{dropdown} An array variable

- ... is in fact pointing to an address containing a value. 
- ... without the bracket notation and an index points to the 
corresponding address of the value at the index. 
- ... is quite similar to a pointer!
::::

::::{dropdown} Hands-on: Array as pointer (or vice versa ...)

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `array-3.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=array-3.c"></script>

- Compile and run `array-3.c`

::::
```


## 7. Command line arguments. 
```{dropdown}
- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `array-4.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=array-4.c"></script>

- In C, the command line arguments **include** the program's name. The
actual arguments start at index position 1 (not 0 like Java).
- Compile and run `array-4.c`

```


## 8. String 
```{dropdown}

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `string-1.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=string-1.c"></script>

- Compile and run `string-1.c`
- In C, string is considered an array of characters.
- How many characters were printed out on the second line in the terminal?
- Hint: Can you see all of them?

:::{dropdown} Answer     
24 
:::

::::{dropdown} Hands-on: Array of strings

- Inside the terminal, make sure that you are still inside
`intro-c`, then use `nano` to create `string-2.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=string-2.c"></script>

- Compile and run `string-2.c`

::::

```



## 9. Object in C
```{dropdown}

- C has no classes or objects. 
- Instead, it has `struct` type (think ancestor of objects) .

::::{dropdown} Hands-on: Struct in C

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `struct-1.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=struct-1.c"></script>

- Compile and run `struct-1.c`

::::

::::{dropdown} Challenge

- Modify `struct-1.c` so that it prints out the address of `origin` variable. 
- What do you learn from the printed out addresses?

:::{dropdown} Answer     
Insert `printf("The address of the origin is: %p\n", &origin);` between the existing
`printf` calls.  
:::
::::

::::{dropdown} Hands-on: Struct of structs in C

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `struct-2.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=struct-2.c"></script>

- Compile and run `struct-2.c`

::::
```



## 10. Function in C
```{dropdown}

- Almost the same as methods in Java, except for one small difference. 
- They need to either be declared, or must be defined prior to being
called (relative to written code position). 

::::{dropdown} Hands-on: Functions in C - definition and declaration

- Create three C files, `function-1.c`, `function-2.c`, and `function-3.c`,
with the source codes below:

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=function-1.c"></script>
<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=function-2.c"></script>
<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=function-3.c"></script>

- Compile and run these files. 

::::
```
