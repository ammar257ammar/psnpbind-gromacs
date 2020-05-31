#!/bin/bash

source /usr/local/gromacs/bin/GMXRC

COMMAND=$1
KEEPIONS=$2
PDB=$3
VARIANT=$4

cd /pdb/${PDB}/output/${VARIANT}

if [ "$COMMAND" == "prepare" ]; then

	sed -i '/HOH/d'    ${VARIANT}.pdb 
	sed -i '/HETATM/d' ${VARIANT}.pdb 

	gmx pdb2gmx -f ${VARIANT}.pdb -ignh -ff charmm27 -water tip3p -o ${VARIANT}.gro -p ${VARIANT}.top

	gmx editconf -f ${VARIANT}.gro -o ${VARIANT}_boxed.gro -c -d 1.2 -bt cubic

	gmx solvate -cp ${VARIANT}_boxed.gro -cs spc216.gro -o ${VARIANT}_solv.gro -p ${VARIANT}.top

	gmx grompp -f /command/config.mdp -c ${VARIANT}_solv.gro -p ${VARIANT}.top -o ${VARIANT}.tpr -maxwarn 1

	echo 13 | gmx genion -s ${VARIANT}.tpr -o ${VARIANT}_solv_ions.gro -p ${VARIANT}.top -pname NA -nname CL -neutral

	gmx grompp -f /command/config.mdp -c ${VARIANT}_solv_ions.gro -p ${VARIANT}.top -o ${VARIANT}.tpr

elif [ "$COMMAND" == "em" ]; then

	gmx mdrun -v -deffnm ${VARIANT} -nt 12

elif [ "$COMMAND" == "export" ]; then

	echo 1 1 | gmx trjconv -f ${folder}.trr -s ${folder}.tpr -center -o ${folder}_final.pdb

fi
