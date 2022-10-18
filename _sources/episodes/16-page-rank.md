# Page Rank

## 1. Web page organization in the past

- Web pages were manually curated and organized. 
- Does not scale. 

<img src="../fig/05-pagerank/01.jpg" style="height:500px">

- Next, web search engines were developed: information retrieval
- Information retrieval focuses on finding documents from a trusted set. 

<img src="../fig/05-pagerank/02.jpg" style="height:500px">

- Challenges for web search:
  - Who to trust given the massive variety of information sources?
    - Trustworthy pages may point to each other. 
  - What is the best answer to a keyword search (given a context)?
    - Pages using the keyword in the same contexts tend to point to each other. 
  - All pages are not equally important. 
- Web pages/sites on the Internet can be represented as a graph:
  - Web pages/sites are nodes on the graph. 
  - Links from one page to another represents the incoming/outgoing 
  connections between nodes. 
  - We can compute the importance of nodes in this graph based on 
  the distribution/intensity of these links. 




## 2. PageRank: initial formulation

- Link as votes:
  - A page (node) is more important if it has more links. 
    - Incoming or outgoing?
  - Think of incoming links as votes. 
- Are all incoming links equals?
  - Links from important pages count more. 

<img src="../fig/05-pagerank/03.png" style="height:400px">

- Each link's vote is proportional to the **importance** of its
source page. 
- If page *j* with importance **r<sub>j</sub>** has **n** outgoing links, 
each outgoing link has **r<sub>j</sub>/n** votes. 
- The importance of page **j** is the sum of the votes on its incoming links. 

<img src="../fig/05-pagerank/04.png" style="height:300px">



## 3. PageRank: the flow model

- Summary:
  - A `vote` from an important page is worth more. 
  - A page is important if it is linked to by other important pages.  

<img src="../fig/05-pagerank/05.png" style="height:250px">

- Flow equations:
  - r<sub>y</sub> = r<sub>y</sub>/2 + r<sub>a</sub>/2
  - r<sub>a</sub> = r<sub>y</sub>/2 + r<sub>m</sub>
  - r<sub>m</sub> = r<sub>a</sub>/2

- General equation for calculating rank *r<sub>j</sub>* for page j:

<img src="../fig/05-pagerank/06.png" style="height:200px">

- Three equations (actually two), three unknown. 
  - No unique solutions
- Additional constraint to force uniqueness:
  - r<sub>y</sub> + r<sub>a</sub> + r<sub>m</sub> = 1
- Gaussian elimination:
  - r<sub>y</sub> = 2/5, r<sub>a</sub> = 2/5, r<sub>m</sub> = 1/5
- **Does not scale to Internet-size!**



## 4. PageRank: matrix formulation

- Setup the flow equations as a stochastic adjacency matrix M
- Matrix M of size N: N is the number of nodes in the graph 
(web pages on the Internet).
  - Let page *i* has *d<sub>i</sub> outgoing links. 
  - If there is an outgoing link from *i* to *j*, then
    - **M<sub>ij</sub> = 1/d<sub>i</sub>**
    - else **M<sub>ij</sub> = 0**  
  - Stochastic: sum of all values in a column of M is equal to 1. 
  - Adjacency: non-zero value indicates the availability of a link. 
 - Rank vector r: A vector with an entry per page. 
   - The order of pages in the rank vector should be the same as the 
   order of pages in rows and columns of **M**. 
<img src="../fig/05-pagerank/05.png" style="height:250px">

- Flow equations:
  - r<sub>y</sub> = r<sub>y</sub>/2 + r<sub>a</sub>/2
  - r<sub>a</sub> = r<sub>y</sub>/2 + r<sub>m</sub>
  - r<sub>m</sub> = r<sub>a</sub>/2

- General equation for calculating rank *r<sub>j</sub>* for page j 
with regard to **all** pages:

<img src="../fig/05-pagerank/07.png" style="height:50px">

- This can be rewritten in matrix form:

<img src="../fig/05-pagerank/08.png" style="height:20px">

- Visualization:
  - Suppose page *i* has importance *r<sub>i</sub> and has outgoing links
  to three other pages, including page *j*. 

<img src="../fig/05-pagerank/09.png" style="height:200px">

- Final perspective:
  - Also, this is why we need to study advanced math ...

<img src="../fig/05-pagerank/10.png" style="height:400px">




## 5. PageRank: power iteration

- We want to find the page rank value *r*
- Power method: an iterative scheme.  
  - Support there are `N` web pages on the Internet. 
  - All web pages start out with same importance: `1/N`. 
  - Rank vector r: r<sup>(0)</sup> = [1/N, ...,1/N]<sup>T</sup> 
  - Iterate: r<sup>(t+1)</sup> = M • r 
  - Stopping condition: r<sup>(t+1)</sup> -  r<sup>(t)</sup> < some small positive error threshold e.
- Example:
<img src="../fig/05-pagerank/10.png" style="height:400px">
<img src="../fig/05-pagerank/11.png" style="height:100px">




## 6. PageRank: the Google formulation

<img src="../fig/05-pagerank/07.png" style="height:50px">
<img src="../fig/05-pagerank/08.png" style="height:20px">

- The three questions
  - Does the above equation converge?
  - Does it converge to what we want?. 
  - Are the results reasonable? 

 ## Challenge 6.1: Does it converge: 
 - The `spider trap` problem
 - Build the stochastic adjacency matrix for the following:
 graph and calculate the ranking for `a` and `b`.  

 <img src="../fig/05-pagerank/12.png" style="height:100px">

 > ## Solution:
 > <img src="../fig/05-pagerank/13.png" style="height:100px">
 {: .solution}
{: .challenge}  

 ## Challenge 6.2: Does it converge to what we want?: 
 - The `dead end` problem
 - Build the stochastic adjacency matrix for the following:
 graph and calculate the ranking for `a` and `b`.  

 <img src="../fig/05-pagerank/14.png" style="height:100px">

 > ## Solution:
 > <img src="../fig/05-pagerank/15.png" style="height:100px">
 {: .solution}
{: .challenge}  

- The solution: random teleport. 
- At each time step, the random surfer has two options:
  - A probably of β to follow an out-going link at random. 
  - A probably of 1 - β to jump to some random page. 
  - The value of β are between 0.8 to 0.9. 
- The surfer will teleport out of the spider trap within a few 
time steps. 
- The surfer will definitely teleport out of the dead-end. 

<img src="../fig/05-pagerank/16.png" style="height:200px">

- Final equation for PageRank:

<img src="../fig/05-pagerank/16.png" style="height:200px">




## 7. Hands-on: Page Rank in Spark

- Create a file called `small_graph.dat` with the following contents:

~~~
y y
y a
a y
a m
m a
~~~


- This data file describes the graph in the easlier slides. 
- Open a terminal. 
- Activate the `pyspark` conda environment, then launch Jupyter notebook

~~~
$ conda activate pyspark
$ conda install -y psutil
$ jupyter notebook
~~~ 


- Create a new notebook using the `pyspark` kernel, then change the notebook's 
name to `spark-3`. 
- Copy the code from `spark-1` to setup and launch a Spark application. 




## 8. Hands-on: Page Rank in Spark - Hollins dataset

- Download [the Hollins dataset](https://www.cs.wcupa.edu/lngo/data/hollins.dat)
- Hollins University webbot crawl in 2004. 
- Which page is most important (internally). 




{% include links.md %}
