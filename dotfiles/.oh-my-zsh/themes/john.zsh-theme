PROMPT="
%F{green}%D{%H:%M} %F{yellow}%~
%(2L.%L>> .)%(1j.[%j] .)%(?..%F{red}:( )%f%F{green}%m %f%# "
RPROMPT='$(git_prompt_info) %f'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
