#!/bin/bash

# Output file
OUTPUT_FILE="connectors.tfvars"

# Check if git is available
if ! command -v git &> /dev/null; then
  echo "git is not available. Please ensure it is installed and accessible."
  exit 1
fi

# Get the list of git tags
TAGS=$(git tag)

# Check if there are any tags
if [ -z "$TAGS" ]; then
  echo "No git tags found."
  exit 1
fi

# Empty the output file if it exists
> "$OUTPUT_FILE"

# Function to compare versions
version_gt() {
  test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"
}

# Create an associative array to store the largest versions
declare -a paths
declare -a versions

# Process each tag
while IFS= read -r TAG; do
  # Extract version (last part after the last slash)
  VERSION="${TAG##*/}"

  # Extract tag path (everything before the last slash)
  TAG_PATH="${TAG%/*}"

  # Replace slashes with underscores in the tag path
  TAG_PATH_WITH_UNDERSCORES=$(echo "${TAG_PATH//\//_}" | tr '[:lower:]' '[:upper:]')

  # Check if the tag path is already in the array
  index=-1
  for i in "${!paths[@]}"; do
    if [[ "${paths[$i]}" == "$TAG_PATH_WITH_UNDERSCORES" ]]; then
      index=$i
      break
    fi
  done

  if [[ $index -ne -1 ]]; then
    # Compare versions and keep the largest one
    existing_version="${versions[$index]}"
    if version_gt "$VERSION" "$existing_version"; then
      versions[$index]=$VERSION
    fi
  else
    # Add new tag path and version
    paths+=("$TAG_PATH_WITH_UNDERSCORES")
    versions+=("$VERSION")
  fi
done <<< "$TAGS"

# Write the results to the output file
for i in "${!paths[@]}"; do
  echo "${paths[$i]} = \"${versions[$i]}\"" >> "$OUTPUT_FILE"
done

echo "Tags have been processed and the largest versions saved to $OUTPUT_FILE."