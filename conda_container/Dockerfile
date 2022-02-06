ARG BASE_CONTAINER

FROM $BASE_CONTAINER

ENV PATH /databricks/conda/bin:$PATH

# updated this to conda 4.10 
# note that conda default channels require license now 
# we have not disabled default channel in this case though
RUN wget -q https://repo.continuum.io/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p /databricks/conda && \
    rm miniconda.sh && \
    # Source conda.sh for all login and interactive shells.
    ln -s /databricks/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /etc/profile.d/conda.sh" >> ~/.bashrc && \
    # Set always_yes for non-interactive shells.
    conda config --system --set always_yes True && \
    conda clean --all
