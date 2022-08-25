# PSnpBind Gromacs Docker

![GitHub top language](https://img.shields.io/github/languages/top/ammar257ammar/psnpbind-gromacs) ![GitHub](https://img.shields.io/github/license/ammar257ammar/psnpbind-gromacs) ![GitHub release (latest by date)](https://img.shields.io/github/v/release/ammar257ammar/psnpbind-gromacs) [![Dockerhub](https://img.shields.io/badge/Dockerhub-aammar%2Fpsnpbind--gromacs-green)](https://hub.docker.com/r/aammar/psnpbind-gromacs) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/aammar/psnpbind-gromacs) [![DOI](https://zenodo.org/badge/266883870.svg)](https://zenodo.org/badge/latestdoi/266883870)

This repository prepares Gromacs (for energy minimization) to be executed against multiple PDB structures in parallel as part of constructing the PSnpBind database.

This repository is part of the "Pocket SNPs Effect On Protein-Ligand Binding Affinity Project (PSnpBind)" project and it is a needed to reproduce the work as described in the main repository 

https://github.com/ammar257ammar/PSnpBind-Build

Please prepare and build the docker using the following instruction and refer back to the previous link for proper usage in the context of PSnpBind project.

### First, clone this repository.

### Second, download Gromacs

1. Download Gromacs version 2019.4 from the following URL:

   http://ftp.gromacs.org/pub/gromacs/gromacs-2019.4.tar.gz

2. Move the tar.gz file to the cloned repository folder (put it next to Dockerfile)

3. Make sure the file name is "gromacs-2019.4.tar.gz" since it is needed to build the Docker image.

4. Go to the cloned repository folder "psnpbind-gromacs" with "cd" command and follow the instructions in the next section

### Build the Docker image

docker build -t psnpbind-gromacs .

#### Now you are ready! 

#### Go back to [Main Project](https://github.com/ammar257ammar/pocket-snps-effect-binding-affinity) for proper usage of the Docker image.
