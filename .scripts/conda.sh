#!/bin/zsh
ENVS=$(conda env list | sed -e '/^#.*/d' -e 's/^\([a-zA-Z0-9]*\).*/\1/')
ENV_ARR=("${(@f)${ENVS}}")
mkdir -p "${HOME}/.config/conda"

for ENV in $ENV_ARR
do
    conda env export --name $ENV > "${HOME}/.config/conda/${ENV}.yml"
done

echo "Backup complete 😀"
