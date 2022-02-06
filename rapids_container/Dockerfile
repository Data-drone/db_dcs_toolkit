ARG BASE_CONTAINER

FROM $BASE_CONTAINER

# copied from rapids instead and omitted dask-sql
COPY rapids.yml /tmp/env.yml

RUN conda env update -n base_env --file /tmp/env.yml
#RUN conda create --name rapids -c rapidsai -c nvidia -c conda-forge \
#    rapids=22.02 python=3.8 cudatoolkit=11.3

# Set an environment variable used by Databricks to decide which conda environment to activate by default.
ENV DEFAULT_DATABRICKS_ROOT_CONDA_ENV=base_env
