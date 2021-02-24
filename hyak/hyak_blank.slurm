#!/bin/bash

## Job name
#SBATCH --job-name=____________

## Allocations definition
#SBATCH --account=___
#SBATCH --partition=___

## Nodes
#SBATCH --nodes=_

## Walltime (_ hours)
#SBATCH --time=_:__:__

## Number of cores per node
#SBATCH --ntasks-per-node=_

## Memory per node
#SBATCH --mem=___G

## Set the working directory for this job.
## Directory must exist before submitting job.
#SBATCH --chdir=_____________________________________

## Use email notifications
#SBATCH --mail-type=ALL
#SBATCH --mail-user=_____________

______ _______
