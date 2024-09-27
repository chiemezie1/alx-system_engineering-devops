#!/bin/bash

# Check if exactly one argument (directory) is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Assign the argument to a variable
directory="$1"

# Ensure the specified directory exists
if [ ! -d "$directory" ]; then
  echo "Error: Directory '$directory' does not exist."
  exit 1
fi

# Change to the specified directory
cd "$directory" || {
  echo "Error: Unable to change to directory '$directory'."
  exit 1
}

# Loop through each file in the directory
for file in *; do
  # Check if it is a regular file (not a directory)
  if [ -f "$file" ]; then
    # Check if the file has changes staged
    if git diff --cached --quiet "$file"; then
      # File has no changes staged
      echo "Skipping '$file': No changes staged."
    else
      # File has changes staged, commit with the file name as the message
      git commit -m "$file" "$file" || {
        echo "Error: Failed to commit '$file'."
        continue
      }
      echo "Committed '$file'."
    fi
  fi
done

# Print message if no files were committed
if [ "$(git status --porcelain)" ]; then
  echo "All files in '$directory' have been processed."
  git push
  echo "Pushed to origin."
else
  echo "No files were committed in '$directory'."
fi
