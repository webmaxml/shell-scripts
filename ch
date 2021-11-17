path='/home/webmaxml/static/cheatsheets/cheatsheets'
folder_name=$1
file_name=$2

folder_provided () { return $(! [ -z "$folder_name" ]); }
file_provided () { return $(! [ -z "$file_name" ]); }
folder_exists () { return $([ -d "${path}/${folder_name}" ]); }
file_exists () { return $([ -f "${path}/${folder_name}/${file_name}.txt" ]); }

show_folders () { ls -1 "${path}"; }

show_files () {
  dir="${path}/${folder_name}"
  files=$(ls -1 "$dir")

  for file in $files; do
    first_line=$(head -n 1 "${dir}/${file}")
    echo $file | sed "s/\.txt$/ - ${first_line}/"
  done
}

show_folder_not_exist_message () {
  echo "No such directory - '${folder_name}', existing directories are:"
  show_folders
}

show_file_not_exist_message () {
  echo "No such file - '${file_name}', existing files are:"
  show_files
}

show_content () {
  file="${path}/${folder_name}/${file_name}.txt"
  cat $file
}

if folder_provided && file_provided; then
  if ! folder_exists; then show_folder_not_exist_message; exit 0; fi
  if ! file_exists; then show_file_not_exist_message; exit 0; fi

  show_content
  exit 0  
fi

if folder_provided; then
  if ! folder_exists; then show_folder_not_exist_message; exit 0; fi

  show_files
  exit 0
fi

show_folders

