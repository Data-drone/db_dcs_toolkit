# Databricks DCS Toolkit

A set of useful primatives for making more advanced DCS containers:
See: https://docs.databricks.com/clusters/custom-containers.html
and: https://github.com/databricks/containers

## Docker Layer Architecture

Foundation: minimal_container

## Basic instructions 

```{bash}

make build-base

make build-rapids

make push-rapids

```

# Breakdown of images

`build-base` builds the base image, adds conda and installs some of the standard libs that we need to make notebooks work in databricks. Note that we may still be missing some required Python or Spark packages that normally are in a DBR release.   

`build-rapids` builds a function RAPID.ai Python container with the current (Feb 2021) release of RAPIDs.ai

This has been lightly tested on DBR 10.3.

Known Missing Features:

Ganglia
R
ssh
Repos feature in DB

still need to add back some more libs for deeplearning etc