# The demand for computational speed

## 1. How do we measure speed in computation?

```{dropdown} Floating-Point Operation per Second (FLOPS)

- Count number of floating-point calculations (arithmetic operations) per second.
- Not MIPS (millions of instructions per second) as MIPS also count non-arithmetic
operations such as data movement or condition.  

$FLOPS = sockets \times \frac{cores}{socket} \times \frac{cycles}{second} \times \frac{FLOPS}{cycle}$

- MFLOPS (megaFLOPS) = 1,000,000 FLOPS
- GGLOPS (gigaFLOPS) = 1,000,000,000 FLOPS

```

```{dropdown} Modern measurement of speed
- TFLOPS (teraFLOPS) = 1,000,000,000,000 FLOPS
  - Intel's ASCI Red for Sandia National Laboratory (DOE) was the first supercomputer in the world 
  to achieve 1 TFLOPS in 1997. 
  - ASCI Red is used for large-scale simulation in nuclear weapon development and material analysis. 
- PFLOPS (petaFLOPS) = 1,000,000,000,000,000 FLOPS
  - IBM RoadRunner for Los Alamos National Laboratory (DOE) was the first supercomputer to achieve 
  1 PFLOPS in 2008. 
  - Second faster supercomputer (June 2022) is Supercomputer Fugaku (Japan, RIKEN Center)
    - 442.01 PFLOPS. 
- EFLOPS (exaFLOPS)  = 1,000,000,000,000,000,000 FLOPS
  - Frontiner is the first supercomputer (Oak Ridge National Lab) to surpass this milestone. 
    - 1.102 EFLOPS (1102 PFLOPS)
  - Aurora (> 2 EFLOPS, end of 2022, Argonne National Lab)
  - El Capitan (> 2 EFLOPS, 2023, Lawrence Livermore National Lab)
  - China Exascale Supercomputers (in operation)
    - Not opened to public/no participation in Top500
    - TaihuLight: 1.05 EFLOPS
    - Tianhe-3: 1.3 EFLOPS
  - Subsequent update to Fugaku (first Japan Exascale computer, 2021, RIKEN Center for Computational Science)
  - Europe, India, Taiwan on track

```

```{dropdown} The bragging list (The TOP500 Project)
- List the 500 most powerful computers in the world.
- Count FLOPS by having supercomputer runs well-known computationally intensive tasks
  - Solve Ax=b, dense random matrix problem. 
  - Primarily dense matrix-matrix multiplications. 
- Updated twice a year:
  - International Supercomputing conference (June, Germany)
  - Supercomputing conference (November, US). 
- Website: http://www.top500.org

```

## 2. Why do we need this much speed?

```{dropdown} The four modern paradigms of science
- Theory
- Experiment
- Simulation
  - study things that are too big, too small, too fast, too slow, too expensive, or too dangerous.
- Data analysis
  - study data that are too big, too complex, too fast (streaming data), too noisy. 
```

```{dropdown} Faster computer gives more details
<iframe width="560" height="315" src="https://www.youtube.com/embed/cNyftYdjt-Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
```

```{dropdown} Hurricane Sandy (2012)
 - the deadliest and most destructive, as well as the strongest hurricane of the 2012 Atlantic hurricane season, 
 - the second-costliest hurricane on record in the United States (nearly $70 billion in damage in 2012),
 - affected 24 states, with particularly severe damage in New Jersey and New York,
 - hit New York City on October 29, flooding streets, tunnels and subway lines and cutting power in and around the city.

:::{image} ../fig/computational-demand/sandy.png
:alt: Forecast of hurricane sandy on October 26, 2012 
:class: bg-primary mb-1
:height: 800px
:align: center
:::

```

```{dropdown} Various forecasts of Sandy

:::{image} ../fig/computational-demand/computer_models_sandy.png
:alt: Various predictions model for Sandy 
:class: bg-primary mb-1
:height: 700px
:align: center
:::

- Geophysical Fluid Dynamic Laboratory hurricane model (National Oceanic and Atmostpheric Administration)
- Hurricane Weather Resaarch and Forecasting model (NOAA/Naval Research Laboratory/Florida State University)
- European Centre for Medium Range Weather Forecast model (ECMWF)
- Global Forecast Model (National Weather Service) 
- **Which model is closest to reality?**
```

```{dropdown} One of the contributing factors

:::{image} ../fig/computational-demand/weathercomputernw.gif
:alt: Computational powr for weather forecast in 2013 
:class: bg-primary mb-1
:height: 400px
:align: center
:::
- [Weather prediction gap](http://blogs.agu.org/wildwildscience/2013/02/17/seriously-behind-the-numerical-weather-prediction-gap/)

```

```{dropdown} Subsequent catch-up
- [NOAA Weather Computer upgrade](http://www.noaa.gov/noaa-completes-weather-and-climate-supercomputer-upgrades)
- Two new supercomputers, Luna and Surge
- 2.89 PFLOPS each for a total of 5.78 PFLOPS (previous generation is only 776 TFLOPS)
- Increase water quantity forecast from 4000 locations to 2.7 million locations (700-fold increase in spatial density)
- Can track and forecast 8 storms at any given time
- 44.5 million dollars investment
```

## 3. HPC in other areas

```{dropdown} Covid and HPC
- US HPC Consortium to contribute to Covid research
  - [Toward explaining signs of COVID symptoms](https://www.hpcwire.com/2020/07/28/supercomputer-powered-research-uncovers-signs-of-bradykinin-storm-that-may-explain-covid-19-symptoms/)
- Many other work (published in Nature) include supercomputing usages for molecular dynamic simulation/data analysis. 
```

```{dropdown} Manufacturing and HPC
- For 767 development, Boeing built and tested 77 physical prototypes for wing design. 
- For 787 development, only 11 prototypes were built.
  - Optimized via more than 800,000 hours of computer simulation. 
```

```{dropdown} Oil and Gas Expoloration improvement with HPC
- Los Alamos National Lab
- Development of large-scale data analytic techniques to simulate and predict subsurface fluid distribution, temperature, and pressure
- This reduces the need for observation wells (has demonstrated commercial success)
```

```{dropdown} Fraud Detection at PayPal
- 10M+ logins, 13M+ transactions, 300 variables per events
- ~4B inserts, ~8B selects
- MPI-like applications, Lustre Parallel File Systems, Hadoop
Saved over $700M in fraudulent transactions during first year of deployment
```


