# ------------------------------------------------------------
# Zsh File/Folder Description System
# Add this to .zshrc file to use it permanently.
# ------------------------------------------------------------

# 1. Function to add or view a description for the current folder
desc() {
  local desc_file=".folder_description"
  
  if [ "$#" -eq 0 ]; then
    # If no arguments, show the description if it exists
    if [ -f "$desc_file" ]; then
      echo -e "\033[1;34mFolder Note:\033[0m $(cat "$desc_file")"
    else
      echo "No description set for this folder. Use 'desc \"your message\"' to add one."
    fi
  else
    # Save the description to a hidden file
    echo "$*" > "$desc_file"
    echo "Description saved."
  fi
}

# 2. The "cd" Hook: Automatically show description on directory change
# In Zsh, 'chpwd' is the built-in hook that runs after every successful 'cd'
chpwd() {
  if [ -f ".folder_description" ]; then
    # echo -e "\n\033[1;33m✨ File Description: $(cat .folder_description)\033[0m"
    echo -e "\n\033[0;3;37m✨ $(cat .folder_description)\033[0m"
  fi
}

# 3. Alternative: Manual 'cd' Override (Not usually needed if using chpwd)
# Use this only if you want to bypass the native Zsh hook system
# function cd() {
#   builtin cd "$@" && desc
# }

# 4. Custom 'ls' alias to show descriptions (Optional)
# This lists files and then checks for the folder note
alias lsd='ls -F && desc'