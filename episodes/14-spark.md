# Spark computing environment

## 1. What is Spark?

- A unified compute engine and a set of libraries for parallel
data processing on computer clusters. 

<img src="../fig/03-spark/01.png" alt="Spark" style="height:400px">



## 2. Design philosophy

- `Unified`: Spark supports a wide range of data analytic tasks over the same 
computing engine and a consistent set of APIs.
- `Computing engine`: Spark handles loading data from storage systems and 
perform computation on the data (in memory) rather than on permanent storage. 
To adhere to the data locality principle, Spark relies on APIs to provide a 
transparent common interface with different storage systems for all applications. 
- `Libraries`: Via its APIs, Spark supports a wide array of internal and 
external libraries for complex data analytic tasks. 



## 3. A brief history of Spark

- Research project at UC Berkeley AMP Lab in 2009 to address drawbacks of 
Hadoop MapReduce. 
- Paper published in 2010: [Spark: Cluster Computing with Working Sets](https://static.usenix.org/events/hotcloud10/tech/full_papers/Zaharia.pdf) 
- Source code is contributed to Apache in 2013. The project had more than 100 
contributors from more than 30 organizations outside UC Berkeley. 
- Version 1.0 was released in 2014. 
- Currently, Spark is being used extensively in academic and industry 
(NASA, CERN, Uber, Netflix …). 




## 4. Spark applications

- Typically consists of a `driver` process and a set of `executor` processes. 
- The `driver` runs the main function and is responsible for: 
  - maintaining information about the Spark application,
  - responding to a user's program or input, and
  - analyzing, distributing, and scheduling work across the executors. 
- The `executors` carry out the actual work assigned to them by the `driver`. 

<img src="../fig/03-spark/02.png" alt="Spark application architecture" style="height:400px">

- Spark also has a local mode (what we are using for this class), where driver 
and executors are simply processes on the same machine. 
- Spark application developed in local mode can be carried over almost `as-is` 
to run in cluster mode (one of the attractiveness of Spark).
- Spark supports the following language APIs: Scala, Java, Python, SQL (ANSI SQL 2003 standard), and R.




## 5. Hands-on: Word Count in Spark

- Open a terminal. 
- Activate the `pyspark` conda environment, then launch Jupyter notebook

~~~
$ conda activate pyspark
$ jupyter notebook
~~~ 


- Create a new notebook using the `pyspark` kernel, then change the notebook's 
name to `spark-1`. 

<img src="../fig/03-spark/03.png" style="height:250px">

- Enter the following Python code into the first cell of `spark-1`, then run 
the cell. 
- This code sets up the paths to Spark's libraries and executables. 

~~~
import os
import sys
spark_path = os.environ['SPARK_HOME']
sys.path.append(spark_path + "/bin")
sys.path.append(spark_path + "/python")
sys.path.append(spark_path + "/python/pyspark/")
sys.path.append(spark_path + "/python/lib")
sys.path.append(spark_path + "/python/lib/pyspark.zip")
sys.path.append(spark_path + "/python/lib/py4j-0.10.9-src.zip")

import findspark
findspark.init()
import pyspark
~~~



<img src="../fig/03-spark/04.png" style="height:250px">

- Enter the following Python code into the next cell, adjust `number_cores` and 
`memory_gb` based on your computer's hardware, then run the cell.
  - This code sets up the configuration for the supporting Spark cluster (in 
  local mode). 
  - `number_cores` should be one less than the total number of cores on your 
  computer. 
  - `memory_gb` should be half the amount of memory that you have, or at least
  3GB less. 

~~~
number_cores = 8
memory_gb = 16
conf = (pyspark.SparkConf().setMaster('local[{}]'.format(number_cores)).set('spark.driver.memory', '{}g'.format(memory_gb)))
sc = pyspark.SparkContext(conf=conf)
~~~


<img src="../fig/03-spark/05.png" style="height:250px">

- At this point, if you visit `127.0.0.1:4040` in another browser tab, 
you should also see the local Spark cluster up and running (with no job). 

<img src="../fig/03-spark/06.png" style="height:250px">

- Enter the following Python code into the third cell. 
- Pay attention to the strings inside `sc.textFile("A_STRING")` and `wordcount.saveAsTextFile("ANOTHER_STRING")`.
  - These strings represent the path to where the original data is located 
  (`sc.textFile`) and where the output directory to be saved 
  (`wordcount.saveAsTextFile`).
  - Take your time here to organize the directories properly. 

~~~
textFile = sc.textFile("../data/shakespeare/shakespeare-complete.txt")
wordcount = textFile.flatMap(lambda line: line.split(" ")) \
            .map(lambda word: (word, 1)) \
            .reduceByKey(lambda a, b: a + b)
wordcount.saveAsTextFile("../data/output/output-wordcount-01")
~~~


- A successful run will generate the resulting output directory 
that contain `_SUCCESS` flag file (size 0). 

<img src="../fig/03-spark/07.png" style="height:250px">



## 6. Data distribution in Spark

- Data in spark are managed as `distributed collection`: when running on a 
cluster, parts of the data are distributed across different machines and are
manipulated by different executors. 
- To allow executor to perform work in parallel breaks up data into chunks 
called `partitions`. 
- Run the following code in a cell on `spark-1`

~~~
textFile.getNumPartitions()
~~~


<img src="../fig/03-spark/08.png" style="height:200px">




## 7. Transformation

- In Spark, the core data structures are `immutable`, meaning they cannot 
be changed after creation. 
- To `change` a data collection means to `create` a new data collection that 
is a `transformation` from the old one. 
- [List of common Spark's transformations](https://spark.apache.org/docs/latest/rdd-programming-guide.html#transformations) 

- There are two types of transformation:
  - Narrow dependencies (1-to-1 transformation). 
  - Wide dependencies (1-to-N transformation). 
|                                   | MULTICS | UNIX       |  
| --------------------------------- | ------- | ---------- | 
| process abstraction               | yes     | yes        |  
| virtual memory                    | yes     | not really |  
| dynamic linking                   | yes     | not really |  
| hierarchical file system          | yes     | yes        |  
| programmed in high-level language | PL/1    | Assembly   |  
| multilevel security               | no      | later      |  
| online reconfiguration            | yes     | reboot     |  
| machine costs                     | M$      | K$         |
- We can make a copy of our `textFile` that is distributed across more 
partitions. This is still a `narrow dependencies` transformation. 
- Run the following code in a cell on `spark-1`

~~~
textFile_4 = textFile.repartition(4)
textFile_4.getNumPartitions()
~~~


<img src="../fig/03-spark/09.png" style="height:100px">

- Run the following code in a cell on `spark-1`

~~~
wordcount = textFile_4.flatMap(lambda line: line.split(" ")) \
            .map(lambda word: (word, 1)) \
            .reduceByKey(lambda a, b: a + b)
wordcount.saveAsTextFile("../data/output/output-wordcount-02")
~~~


<img src="../fig/03-spark/10.png" style="height:200px">

- There are now four resulting output files:

<img src="../fig/03-spark/11.png" style="height:300px">




## 8. Lazy evaluation and actions

- `Transformations`are logical plan only. 
- Spark will wait until the very last moment to execute the graph of 
computation instructions (the logical plan).
- To trigger the computation, we run an `action`. 
- [List of common Spark actions](https://spark.apache.org/docs/latest/rdd-programming-guide.html#actions)

~~~
wordcount = textFile_4.flatMap(lambda line: line.split(" ")) \
            .map(lambda word: (word, 1)) \
            .reduceByKey(lambda a, b: a + b)
print(wordcount)
~~~


<img src="../fig/03-spark/12.png" style="height:150px">

- There are three kind of actions:
  - Actions to view data in the console (e.g., `take`). 
  - Action to collect data to native objects (e.g., `collect`).
  - Action to write to output data sources (e.g., `saveAsTextFile`). 

~~~
wordcount.take(10)
~~~


~~~
local_words = wordcount.collect()
print(local_words[1:10])
~~~


<img src="../fig/03-spark/13.png" style="height:500px">




## 9. Hands on: Word Count workflow breakdown

- Run each of the following segments of Python code in a separate cell. 
- RDD of text file has a single item per row of collection. 

~~~
textFile_4.take(10)
~~~


- `flatMap` breaks lines into lists of words, and concatenate these lists
into a single new RDD. 

~~~
wordcount_1 = textFile_4.flatMap(lambda line: line.split(" "))
wordcount_1.take(10)
~~~


- Each item in this new RDD is turned into a (key/value) pair, with 
key is a word, and value is `. 

~~~
wordcount_2 = wordcount_1.map(lambda word: (word, 1))
wordcount_2.take(10)
~~~


- All pairs with the same key are `reduced` together using pairwise 
summation to get the final count of each key. 

~~~
wordcount_3 = wordcount_2.reduceByKey(lambda a, b: a + b)
wordcount_3.take(10)
~~~



<img src="../fig/03-spark/14.png" style="height:800px">




## Challenge 1

- Augment the mapping process of WordCount with a function to filter out
punctuations and capitalization from the unique words
- Hint: The string module is helpful for removing punctuation.

 ## Solution
 
 ~~~
 import string
 translator = str.maketrans('', '', string.punctuation)
 wordcount_enhanced = textFile.flatMap(lambda line: line.split(" ")) \
            .map(lambda word: (word.translate(translator).lower(), 1)) \
            .reduceByKey(lambda a, b: a + b)
 wordcount_enhanced.take(100)
 ~~~
 
 
{: .solution}
{: .challenge}


## Challenge 2

- Look up the [Spark Python API for filter](https://spark.apache.org/docs/latest/api/python/pyspark.html?highlight=filter#pyspark.RDD.filter).
- Augment the results from Challenge 1 to remove the empty spaces (`''`).

 ## Solution
 
 ~~~
 wordcount_filtered = wordcount_enhanced.filter(lambda x: x[0] != '')
 wordcount_filtered.take(100)
 ~~~
 
 
{: .solution}
{: .challenge}


{% include links.md %}
