#!/bin/bash

## Job name
#SBATCH --job-name=qerm_example

## Allocations definition
#SBATCH --account=stf
#SBATCH --partition=stf

## Nodes
#SBATCH --nodes=1

## Walltime (2 hours)
#SBATCH --time=2:00:00

## Number of cores per node
#SBATCH --ntasks-per-node=8

## Memory per node
#SBATCH --mem=32G

## Set the working directory for this job.
## Directory must exist before submitting job.
#SBATCH --chdir=/gscratch/stf/jkbest/qerm597wi21/hyak

## Use email notifications
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jkbest@uw.edu

Rscript hyak.R
