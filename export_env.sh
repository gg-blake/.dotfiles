if [ -n "$CONDA_PREFIX" ]; then
    local env_name=$(basename "$CONDA_PREFIX")
    if [ $env_name != "miniconda3" ]; then
        conda export --from-history --name "$env_name" >~/.dotfiles/conda_envs/$env_name.yml
        echo "Environment Dependencies Saved at ~/.dotfiles/$env_name.yml"
    fi
fi
