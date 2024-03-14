FROM bioconductor/tidyverse:RELEASE_3_18-R-4.3.1

RUN Rscript -e 'remotes::install_version("R.oo", "1.26.0")' \
    && Rscript -e 'remotes::install_version("R.utils", "2.12.3")' \
    && Rscript -e 'remotes::install_version("dplyr", "1.1.4")' \
    && Rscript -e 'remotes::install_version("ggplot2", "3.5.0")' \
    && Rscript -e 'remotes::install_version("here")' \
    && Rscript -e 'remotes::install_version("pROC", "1.18.5")' \
    && Rscript -e 'remotes::install_version("patchwork", "1.2.0")' \
    && Rscript -e 'remotes::install_version("ggpubr", "0.6.0")'

RUN Rscript -e 'remotes::install_github( \
        "chiaraherzog/WID.smk", \
        ref = "1d7af7067e3667f4e9ed949ffbf9b52b0121605b")' \
    && Rscript -e 'remotes::install_github( \
        "chiaraherzog/eutopsQC")'

RUN Rscript -e 'options(warn=2); install.packages("BiocManager")'
RUN Rscript -e 'options(warn=2); BiocManager::install(c( \
        "Biobase", \
        "BiocGenerics", \
        "ChAMP", \
        "GEOquery", \
        "Illumina450ProbeVariants.db", \
        "IlluminaHumanMethylation450kanno.ilmn12.hg19", \
        "IlluminaHumanMethylation450kmanifest", \
        "IlluminaHumanMethylationEPICmanifest", \
        "minfi" \
    ))' # Original versions: 2.58.0 0.44.0 2.28.0 2.66.0 1.34.0 0.6.1 0.4.0 0.3.0 1.44.0

ENV RSTUDIO_PANDOC=/usr/lib/rstudio/bin/pandoc

RUN git clone https://github.com/chiaraherzog/HEAP-demo.git
WORKDIR /HEAP-demo/

RUN Rscript -e "rmarkdown::render(input = 'script.Rmd')"