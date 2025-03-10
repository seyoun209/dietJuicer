#! /bin/bash -login

## Exit if any command fails
set -e

## Load required modules
module load python/3.6.6

## Activate virtual environment
source env/bin/activate

case $1 in

    '-h' | '--help' | ' ' | '')
            echo -e '\e[31mSpecificy which workflow to unlock (i.e. alignFASTQ or buildHIC)'
            exit 2
            ;;
    
    'alignFASTQ' | 'dietJuicerCore' | 'Core')
            ## Unlock snakemake workflow
            snakemake -j 100 --unlock -s workflows/alignFASTQ --max-jobs-per-second 5 --max-status-checks-per-second 5 --rerun-incomplete --restart-times 3 -p --latency-wait 500 --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --parsable" --cluster-status ./scripts/status.py
            ;;

    'buildHIC' | 'dietJuicerMerge' | 'Merge')
            ## Unlock snakemake workflow
            snakemake -j 100 --unlock -s workflows/buildHIC --max-jobs-per-second 5 --max-status-checks-per-second 5 --rerun-incomplete --restart-times 3 -p --latency-wait 500 --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --parsable" --cluster-status ./scripts/status.py
            ;;
esac

## Deactivate virtual environment
deactivate

## Success message
echo -e "\033[0;32mDirectory unlocked, ready to rerun with sbatch dietJuicerCore.sh or sbatch dietJuicerMerge.sh"