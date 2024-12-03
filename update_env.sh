if [ -n "$CONDA_PREFIX" ]; then
    local env_name=$(basename "$CONDA_PREFIX")
    if [ $env_name != "miniconda3" ]; then
        conda env update --prune --name="$env_name" --file=~/.dotfiles/conda_envs/$env_name.yml
        echo "Environment Dependencies Updated at ~/.dotfiles/$env_name.yml"
    fi
fi
