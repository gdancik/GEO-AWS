# *shinyGEO* - a web-based application for analyzing gene expression omnibus datasets

*shinyGEO* (http://gdancik.github.io/shinyGEO/) is a web-based tool that allows a user to download the expression and sample data from a [Gene Expression Omnibus](http://www.ncbi.nlm.nih.gov/geo/browse/) dataset, select a gene of interest, and perform a survival or differential expression analysis using the available data. For both analyses, *shinyGEO* produces publication-ready graphics and generates R code ensuring that all analyses are reproducible. The tool is developed using shiny, a web application framework for R, a language for statistical computing and graphics.

**Latest updates:** *shinyGEO* now allows for caching of GEO datasets and storage of data updates using docker volumes. Caching will result in much faster run times for commonly analyzed series and platforms.

## Publications

If you use *shinyGEO* in your work, please cite the following *Bioinformatics* manuscript ([link](http://bioinformatics.oxfordjournals.org/content/early/2016/08/07/bioinformatics.btw519.abstract)):

Dumas J, Gargano MA, Dancik GM. shinyGEO: a web-based application for analyzing Gene Expression Omnibus datasets. *Bioinformatics*. 2016 Dec 1;32(23):3679-3681. 

## The preferred way of running *shinyGEO* locally is through docker

1. Download docker from https://www.docker.com/get-started

2. Pull the docker image by running the following from your terminal (PowerShell on Windows) (**Note:** you should do this periodically to ensure that you are using the the most up-to-date version of *shinyGEO*). 		

    ```
    docker pull gdancik/shinygeo
    ```

3. Run *shinyGEO* by copying and pasting the command to your terminal: 

    ```
    docker run -it -p 3838:3838 --volume shinygeo-cache:/root/shinyGEO/cache --volume shinygeo-data:/root/shinyGEO/datasets --volume shinygeo-platform:/root/shinyGEO/platform gdancik/shinygeo
    ```

4. View *shinyGEO* by opening a web browser and entering *localhost:3838* into the address bar.

5. If the dataset you wish to analyze does not appear in the dropdown, then you may click the *Update* button to update the available datasets. It is only necessary to update the data if the dataset of interest is not listed. Any updates will automatically be saved to a docker volume, as described below. Note that *shinyGEO* is designed to analyze only datasets whose experiment type is 'Expression profiling by array';  currently the analysis of other datasets is not supported.

### Caching and docker volumes

When running *shinyGEO* as described above, docker *volumes* are used to store data so that data will persist from one *shinyGEO* session to the next. In particular, data downloaded from GEO is cached in the volume *shinygeo-cache*. Caching the data greatly increases the speed in which previously viewed datasets or platforms are loaded. From within *shinyGEO*, you can click on the "Cache" icon in the sidebar to view and manage the cache. 

In addition, the available platform and series datasets are now stored in the volume *shinygeo-datasets*. Therefore, the available datasets will automatically be "saved" when clicking the update button. 

If for any reason you wish to delete a volume, you can use the `docker volume rm` command, e.g.,

```
docker volume rm shinygeo-datasets
```

## Alternatives for running *shinyGEO*

While using *docker* is preferred, you can also run *shinyGEO* from the web at [https://gdancik.shinyapps.io/shinyGEO/](https://gdancik.shinyapps.io/shinyGEO/).

## About

*shinyGEO* is a project of the [Bioinformatics Laboratory](https://gdancik.github.io/bioinformatics) at [Eastern Connecticut State University](https://www.easternct.edu). 

   - Main contributors: Jasmine Dumas, Michael Gargano*, Garrett M. Dancik, PhD
   - Additional contributors: Nataliia Romanenko*, Ken-Heng Liao*, Gregory Harper*, Brandon Spratt* 

An asterisk (\*) denotes an undergraduate Computer Science major from Eastern.

## Funding

This work was supported, in part, by Google Summer of Code funding to JD in 2015. 

### Page theme

This page uses a slightly modified version of the Cayman theme ([https://github.com/pages-themes/cayman](https://github.com/pages-themes/cayman))
