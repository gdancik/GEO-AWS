FROM openanalytics/r-base

MAINTAINER Garrett M. Dancik

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
#    pandoc \
#    pandoc-citeproc \
    libcurl4-gnutls-dev \
#    libcairo2-dev \
#    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
#    libmysqlclient-dev \
    libxml2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# install required packages
RUN R -e "install.packages(c('shiny','DT', 'ggplot2', 'GGally', 'reshape2', 'survival', 'shinyBS', 'shinyAce', 'RCurl', 'shinyjs', 'survMisc', 'shinydashboard', 'rvest', 'shinyFiles', 'BiocManager'), repos='https://cloud.r-project.org/')" 

RUN R -e "BiocManager::install('GEOquery')" 
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# copy the app to the image
RUN mkdir /root/shinyGEO
COPY . /root/shinyGEO

COPY Rprofile.site /usr/lib/R/etc

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/shinyGEO')"]

