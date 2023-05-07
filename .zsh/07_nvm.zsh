# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
if [ "$(uname)" = "Darwin" ]; then # macOS
  export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  export PATH=/usr/local/share/npm/bin:$PATH

elif [ -n "$WSL_DISTRO_NAME" ]; then # WSL
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  export YVM_DIR="$HOME/.yvm"
  [ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
 
else # Linux
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  export YVM_DIR="$HOME/.yvm"
  [ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
  
fi


