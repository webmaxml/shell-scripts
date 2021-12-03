#!/usr/bin/env bash

[[ -z "$SCRIPTS_PATH" ]] && echo "Error: SCRIPTS_PATH is not defined" && exit 1
[[ -z "$CHEATS_PATH" ]] && echo "Error: CHEATS_PATH is not defined" && exit 1

[[ -f "${SCRIPTS_PATH}/functions/files" ]] && source "${SCRIPTS_PATH}/functions/files"

root="$1"
name="$2"

path="${CHEATS_PATH}/${root}"

if ! is_folder $path; then
  echo -e "Error: '${root}' is not a root folder, root folders are:\n"
  print_folder_content $CHEATS_PATH
  exit 1
fi

is_empty $name && print_folder_content $path && exit

file=$( find "$path" -type f \( -name "${name}.*" -o -name "${name}" \) )
! is_empty $file && print_file_content $file && exit

dir=$( find "$path" -type d -name "${name}" )
! is_empty $dir && print_folder_content $dir && exit

echo -e "No such file in ${root} - '${name}', the content is:\n" && print_folder_content $path
