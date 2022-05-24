ARG BASE_CONTAINER

FROM $BASE_CONTAINER

## Run an update cycle to see if this fixes things
RUN apt-get update \
    && apt-get install --yes \
        gcc

# copied from rapids instead and omitted dask-sql
COPY rapids.yml /tmp/env.yml
COPY nvt.yml /tmp/nvt-env.yml

# lets try relax the strict channel priority
RUN /databricks/conda/bin/conda config --system --set channel_priority flexible

#RUN /databricks/conda/bin/conda env update -n dcs-minimal --file /tmp/env.yml
RUN /databricks/conda/bin/conda env create -n dcs-rapids --file /tmp/env.yml

RUN /databricks/conda/bin/conda env create -n dcs-nvt --file /tmp/nvt-env.yml
#RUN conda create --name rapids -c rapidsai -c nvidia -c conda-forge \
#    rapids=22.02 python=3.8 cudatoolkit=11.3

# Set an environment variable used by Databricks to decide which conda environment to activate by default.
#ENV DEFAULT_DATABRICKS_ROOT_CONDA_ENV=dcs-rapids

ENV DEFAULT_DATABRICKS_ROOT_CONDA_ENV=dcs-rapids
ENV DATABRICKS_ROOT_CONDA_ENV=dcs-rapids
