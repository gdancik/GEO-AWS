FROM openanalytics/r-base

MAINTAINER Garrett M. Dancik

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.0.0 \
    libmysqlclient-dev \
    libxml2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# basic shiny functionality
RUN R -e "install.packages(c('shiny','DT', 'ggplot2', 'reshape2', 'survival', 'shinyBS', 'GGally', 'shinyAce', 'RCurl', 'shinyjs', 'survMisc', 'shinydashboard'), repos='https://cloud.r-project.org/')" \

RUN R -e "source('https://bioconductor.org/biocLite.R'); biocLite('GEOquery')" \
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# copy the app to the image
RUN mkdir /root/shinyGEO
COPY . /root/shinyGEO

COPY Rprofile.site /usr/lib/R/etc

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/shinyGEO')"]

