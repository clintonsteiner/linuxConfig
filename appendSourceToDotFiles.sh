# /bin/bash

append_if_not_in_file(){
    searchStr=$1
    file=$2

    if grep "source .*$searchStr" $file
    then
        echo $searchStr already existed in file: $file, not adding source command 
    else
        cat >> $file <<EOF
source ~/$searchStr
EOF
    fi
}
append_bashrc(){
echo linuxConfig/$1
append_if_not_in_file linuxConfig/$1 ~/.bashrc
}
append_bashrc '.bashrc'
append_bashrc '.bash_custom_aliases'
append_bashrc '.bash_custom_functions'

append_if_not_in_file linuxConfig/.vimrc ~/.vimrc
