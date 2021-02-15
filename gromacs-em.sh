#!/bin/bash

source /usr/local/gromacs/bin/GMXRC

COMMAND=$1
KEEPIONS=$2
PDB=$3
VARIANT=$4

cd /pdb/${PDB}/output/${VARIANT}

if [ "$COMMAND" == "prepare" ]; then

	sed -i '/P   PTR/d'    ${VARIANT}.pdb 
	sed -i '/O1P PTR/d'    ${VARIANT}.pdb 
	sed -i '/O2P PTR/d'    ${VARIANT}.pdb 
	sed -i '/O3P PTR/d'    ${VARIANT}.pdb 
	sed -i 's/ PTR / TYR /g'  ${VARIANT}.pdb
	sed -i '/HOH/d'    ${VARIANT}.pdb 
	sed -i '/HETATM/d' ${VARIANT}.pdb 

	if [ "$KEEPIONS" == "keepIons" ]; then

		sed -i 's/ZN  ZN /ZN  ZN2/g' ${VARIANT}.pdb
		sed -i 's/CA  CA /CAL CAL/g' ${VARIANT}.pdb 
		sed -i '/NA  NA/d' ${VARIANT}.pdb 

 	elif [ "$KEEPIONS" == "noIons" ]; then

		sed -i '/ZN  ZN/d' ${VARIANT}.pdb
		sed -i '/CA  CA/d' ${VARIANT}.pdb 
		sed -i '/NA  NA/d' ${VARIANT}.pdb 

	fi

	gmx pdb2gmx -f ${VARIANT}.pdb -ignh -ff charmm27 -water tip3p -o ${VARIANT}.gro -p ${VARIANT}.top

	gmx editconf -f ${VARIANT}.gro -o ${VARIANT}_boxed.gro -c -d 1.2 -bt cubic

	gmx solvate -cp ${VARIANT}_boxed.gro -cs spc216.gro -o ${VARIANT}_solv.gro -p ${VARIANT}.top

	gmx grompp -f /command/config.mdp -c ${VARIANT}_solv.gro -p ${VARIANT}.top -o ${VARIANT}.tpr -maxwarn 1

	/command/neutralize.sh ${VARIANT}

	gmx grompp -f /command/config.mdp -c ${VARIANT}_solv_ions.gro -p ${VARIANT}.top -o ${VARIANT}.tpr

elif [ "$COMMAND" == "em" ]; then

	gmx mdrun -v -deffnm ${VARIANT} -nt 12

elif [ "$COMMAND" == "export" ]; then

	echo 6 | gmx energy -f ${VARIANT}.edr -s ${VARIANT}.tpr -o ${VARIANT}.xvg
	grace -nxy ${VARIANT}.xvg -hdevice PNG -hardcopy -printfile ${VARIANT}_LJ.png -fixed 2000 2160 -log x

	echo 11 | gmx energy -f ${VARIANT}.edr -s ${VARIANT}.tpr -o ${VARIANT}_energy.xvg
	grace -nxy ${VARIANT}_energy.xvg -hdevice PNG -hardcopy -printfile ${VARIANT}_energy.png -fixed 2000 2160 -log x

	if [ "$KEEPIONS" == "keepIons" ]; then

		/command/export-with-ions.sh ${VARIANT}

		sed -i '/NA    NA/d' ${VARIANT}_final.pdb 
		sed -i '/CL    CL/d' ${VARIANT}_final.pdb 
	
 	elif [ "$KEEPIONS" == "noIons" ]; then

		echo 1 1 | gmx trjconv -f ${VARIANT}.trr -s ${VARIANT}.tpr -center -o ${VARIANT}_final.pdb
	fi

fi
