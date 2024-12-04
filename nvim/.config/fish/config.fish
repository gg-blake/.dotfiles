
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/blake/miniconda3/bin/conda
    eval /home/blake/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/blake/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/blake/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/blake/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

