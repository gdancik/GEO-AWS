# shinyGEO
shinyGEO is a web-based tool that allows a user to download the expression and sample data from a [Gene Expression Omnibus](http://www.ncbi.nlm.nih.gov/geo/browse/) dataset, select a gene of interest, and perform a survival or differential expression analysis using the available data. For both analyses, shinyGEO produces publication-ready graphics and generates R code ensuring that all analyses are reproducible. The tool is developed using shiny, a web application framework for R, a language for statistical computing and graphics.

**Latest updates:** *shinyGEO* now allows for caching of GEO datasets and storage of data updates using docker volumes. Caching will result in much faster run times for commonly analyzed series and platforms.

## Official Website
http://gdancik.github.io/shinyGEO/

## The preferred way of running *shinyGEO* locally is through docker:

1. Download docker from https://www.docker.com/get-started

2. Pull the docker image by running the following from your terminal (**Note:** you should do this periodically to ensure that you are using the the most up-to-date version of *shinyGEO*). 		

    ```
    docker pull gdancik/shinygeo
    ```

3. Run *shinyGEO* by using the command: 

    ```
    docker run -it -p 3838:3838 --volume shinygeo-cache:/root/shinyGEO/cache --volume shinygeo-data:/root/shinyGEO/datasets --volume shinygeo-platform:/root/shinyGEO/platform gdancik/shinygeo
    ```

4. View *shinyGEO* by opening a web browser and entering *localhost:3838* into the address bar.

5. ShinyGEO datasets can now be updated directly from the web application. Click the Update button to update the datasets (updating data sets once a month is recommended). If you use the command given in step (3), your changes will be automatically saved.

### Caching and docker volumes

When running *shinyGEO* as described above, docker *volumes* are used to store data so that data will persist from one *shinyGEO* session to the next. In particular, data downloaded from GEO is cached in the volume *shinygeo-cache*. From within *shinyGEO*, you can click on the "Cache" icon in the sidebar to view and manage the cache. The available platform and series data are now stored in the volume *shinygeo-datasets*. Data will now automatically be "saved" when clicking the update button. If you wish to delete a volume, you can use the `docker volume rm` command, e.g.,

```
docker volume rm shinygeo-datasets
```


## Contributors
- Main contributors: Jasmine Dumas, Michael Gargano, Garrett M. Dancik, PhD
- Additional contributors: Nataliia Romanenko, Ken-Heng Liao, Gregory Harper, Brandon Spratt

## Acknowledgements
This work was supported, in part, by Google Summer of Code funding to JD in 2015. MG, KHL, GH, and BS contributed as part of an independent study in Computer Science / Bioinformatics while undergraduate students at Eastern Connecticut State University, Willimantic, CT,  USA.

