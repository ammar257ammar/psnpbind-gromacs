# PSnpBind Gromacs Docker

This repository is part of the "Pocket SNPs Effect On Protein-Ligand Binding Affinity Project (PSnpBind)" and it is a submodule of the main repository 

https://github.com/ammar257ammar/pocket-snps-effect-binding-affinity

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
