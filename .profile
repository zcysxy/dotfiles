eval "$(homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/Users/ce/.juliaup/bin:*)
        ;;

    *)
        export PATH=/Users/ce/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
