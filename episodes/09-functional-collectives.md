# MPI: Functional parallelism and collectives

## 1. Collective communication
```{dropdown}
- Must involve ALL processes within the scope of a communicator.
- Unexpected behavior, including programming failure, if even one process does 
not participate.
- Types of collective communications:
  - Synchronization: barrier
  - Data movement: broadcast, scatter/gather
  - Collective computation (aggregate data to perform computation): Reduce

:::{image} ../fig/collectives/01.png
:alt: collective communication patterns
:class: bg-primary mb-1
:height: 600px
:align: center
:::

```


## 2. Hands-on: MPI_Bcast
```{dropdown}
- `int MPI_Bcast(void *buf, int count, MPI_Datatype datatype, int root, MPI_Comm comm)`
  - `*buf`: 
    - If on `root`, pointer to the address containing the data elements to be 
    broadcasted 
    - If not on `root`, pointer to the address where broadcasted data to be stored. 
  - `count`: how many data elements will be broadcasted.
  - `MPI_Datatype`: `MPI_BYTE`, `MPI_PACKED`, `MPI_CHAR`, `MPI_SHORT`, `MPI_INT`, 
  `MPI_LONG`, `MPI_FLOAT`, `MPI_DOUBLE`, `MPI_LONG_DOUBLE`, `MPI_UNSIGNED_CHAR`, 
  and other user-defined types.
  - `root`: rank of the process where the original data will be broadcasted. 
  - `tag`: an integer identify the message. Programmer is responsible for managing tag.
  - `comm`: communicator (typically just used MPI_COMM_WORLD)
- Don’t need to specify a TAG or DESTINATION
- Must specify the SENDER (root)
- Blocking call for all processes
- Inside `intro-mpi`, create a file named `bcast.c` with the following
contents

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=bcast.c"></script>

- Compile and run `bcast.c`:

~~~bash
mpicc -o bcast bcast.c
mpirun -np 4 ./bcast
~~~


:::{image} ../fig/collectives/02.png
:alt: compile and run bcast.c
:class: bg-primary mb-1
:height: 300px
:align: center
:::

```


## 3. Hands-on: MPI_Scatter
```{dropdown}
- `int MPI_Scatter(void *sendbuf, int sendcount, MPI_Datatype sendtype, void *recvbuf,int recvcount,MPI_Datatype recvtype, int root, MPI_Comm comm)`
  - `*sendbuf`: pointer to the address containing the array of data elements to be 
  scattered.
  - `sendcount`: how many data elements to be sent to each process of the communicator.
  - `*recvbuf`: pointer to the address on each process of the communicator, where 
  the scattered portion will be written. 
  - `recvcount`: how many data elements to be received by each process of the communicator.
  - `root`: rank of the process from where the original data will be scattered. 
  - `comm`: communicator (typically just used MPI_COMM_WORLD)
- Inside `intro-mpi`, create a file named `scatter.c` with the following
contents

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=scatter.c"></script>

- Compile and run `scatter.c`:

~~~bash
mpicc -o scatter scatter.c
mpirun -np 4 ./scatter
~~~


:::{image} ../fig/collectives/03.png
:alt: compile and run scatter.c
:class: bg-primary mb-1
:height: 300px
:align: center
:::

**Challenge**

Modify `scatter.c` based on the following scenarios and answer the following questions

- Modify `scatter.c` so that process 2 is now the root process for MPI_Scatter. Does that 
make a difference in the results?
- Modify `sendbuf` so that it is declared/initialized only inside process 0, the root process for 
MPI_Scatter. Does that make a difference in the results?
- Modify MPI_Scatter so that we are sending out/receving 6 data elements per process. How 
does that make a difference?



```


## 4. Hands-on: MPI_Gather
```{dropdown}
- `int MPI_Gather(void *sendbuf, int sendcount, MPI_Datatype sendtype, void *recvbuf,int recvcount,MPI_Datatype recvtype, int root, MPI_Comm comm)`
  - `*sendbuf`: pointer to the address on each process of the communicator, containing 
  the array of data elements to be gathered.
  - `sendcount`: how many data elements from each process of the communicator to be sent 
  back to the root process.
  - `*recvbuf`: pointer to the address on the root process where all gathered data 
  will be written. 
  - `recvcount`: how many data elements to be received from each process of the 
  communicator.
  - `root`: rank of the process from where the original data will be gathered. 
  - `comm`: communicator (typically just used MPI_COMM_WORLD)
- Inside `intro-mpi`, create a file named `gather.c` with the following
contents

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=gather.c"></script>

- Compile and run `gather.c`:

~~~bash
mpicc -o gather gather.c
mpirun -np 4 ./gather
~~~


:::{image} ../fig/collectives/04.png
:alt: compile and run gather.c
:class: bg-primary mb-1
:height: 300px
:align: center
:::

**Challenge**

Modify `gather.c` based on the following scenarios and answer the following questions

- Modify `recvbuf` so that it is declared/initialized only inside process 0, the root process for 
MPI_Gather. Does that make a difference in the results?
- Modify MPI_Gather so that we are gathering 6 data elements per process. How 
does that make a difference?

```


## 5. Hands-on: MPI_Reduce
```{dropdown}
- `int MPI_Reduce(void *sendbuf, void *recvbuf, int count, MPI_Datatype datatype, MPI_OP op,int root, MPI_Comm comm)`
  - `*sendbuf`: pointer to the address on each process of the communicator, containing 
 the array of data elements to be reduced.
  - `*recvbuf`: pointer to the address on the root process where all final reduced 
  data will be written. 
  - `count`: how many data elements to be received from each process of the communicator.
  If count > 1, then operation is performed element-wise.
  - `op`: may be MPI_MIN, MPI_MAX, MPI_SUM, MPI_PROD (twelve total). Programmer may add 
  operations, must be commutative and associative.
  - `root`: rank of the process from where the original data will be gathered. 
  - `comm`: communicator (typically just used MPI_COMM_WORLD).
- Inside `intro-mpi`, create a file named `gather.c` with the following
contents

<script src="https://gist.github.com/linhbngo/05955842d2a7ce40c9723292a2ded118.js?file=reduce.c"></script>

- Compile and run `reduce.c`:

~~~bash
mpicc -o reduce reduce.c
mpirun -np 4 ./reduce
~~~

:::{image} ../fig/collectives/05.png
:alt: compile and run reduce.c
:class: bg-primary mb-1
:height: 300px
:align: center
:::

```



