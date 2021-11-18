path='/home/webmaxml/static/cheatsheets/cheatsheets'

is_empty () { return $([ -z "$1" ]); }

show_folders () { ls -1 "${1}"; }

show_content () { less -c "$1"; }

show_files () {
  files=$(ls -1 "$1")

  for file in $files; do
    first_line=$(head -n 1 "${1}/${file}")
    echo $file | sed "s/\.txt$/ - ${first_line}/"
  done
}

name=$1
is_empty $name && show_folders $path && exit

file=$( find "$path" -type f -name "${name}.*" )
! is_empty $file && show_content $file && exit

dir=$( find "$path" -type d -name "$name" )
! is_empty $dir && show_files $dir && exit

echo "No such file - '${name}', existing directories are:"
show_folders $path

