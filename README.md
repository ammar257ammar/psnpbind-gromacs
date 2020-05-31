# Gromacs Docker

This repository is part of the "Pocket SNPs effect on protein-ligand Binding Affinity Prediction (PSBAP)" project and it is a submodule of the main repository 

https://github.com/ammar257ammar/pocket-snps-effect-binding-affinity

Please prepare and build the docker using the following instruction and refer back to the previous link for proper usage in the context of PSBAP project.

### First, clone this repository, then follow next! 

### Download Gromacs

1. Download Gromacs version 2019.4 from the following URL:

   http://ftp.gromacs.org/pub/gromacs/gromacs-2019.4.tar.gz

2. Move the tar.gz file to the cloned repository folder (put it next to Dockerfile)

3. Make sure the file name is "gromacs-2019.4.tar.gz" since it is needed to build the Docker image.

4. Go to the cloned repository folder "psbap-gromacs" with "cd" command and follow the instructions in the next section

### Build the Docker image

docker build -t psbap-gromacs .

#### Now you are ready! 

#### Go back to [Main Project](https://github.com/ammar257ammar/pocket-snps-effect-binding-affinity) for proper usage of the Docker image.
