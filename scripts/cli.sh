#! /usr/bin/env bash

# IMPORTANT
# This script should NOT be run directly.
# Run `make cli` or `make cli-local` from the root of the repository instead.

set -e

# A function to generate formatted .md files
write_to_file() {
    local cmd="$1"
    local file="$2"
    local program="$3"

    # We need to add the header and the backticks to create the code block.
    printf "# %s\n\n\`\`\`\n%s\n\`\`\`" "$program" "$cmd" > "$file"

    # Adjust the width of the help text and append to the end of file
    sed -i -e '$a\'$'\n''\n''<style> .content main {max-width:88%;} </style>' "$file"
}

CMD=./target/release/anchor

# Store all help strings in variables.
general_cli=$($CMD --help)
node_cli=$($CMD node --help)
keygen_cli=$($CMD keygen --help)
keysplit_cli=$($CMD keysplit --help)
keysplit_onchain_cli=$($CMD keysplit onchain --help)
keysplit_manual_cli=$($CMD keysplit manual --help)

general=./help_general.md
node=./help_node.md
keygen=./help_keygen.md
keysplit=./help_keysplit.md
keysplit_onchain=./help_keysplit_onchain.md
keysplit_manual=./help_keysplit_manual.md

# create .md files
write_to_file "$general_cli" "$general" "Anchor General Commands"
write_to_file "$node_cli" "$node" "Node"
write_to_file "$keygen_cli" "$keygen" "Key Generation"
write_to_file "$keysplit_cli" "$keysplit" "Key Split"
write_to_file "$keysplit_onchain_cli" "$keysplit_onchain" "Key Split (Onchain)"
write_to_file "$keysplit_manual_cli" "$keysplit_manual" "Key Split (Manual)"

# input 1 = $1 = files; input 2 = $2 = new files
files=(./book/src/help_general.md ./book/src/help_node.md ./book/src/help_keygen.md ./book/src/help_keysplit.md ./book/src/help_keysplit_onchain.md ./book/src/help_keysplit_manual.md)
new_files=($general $node $keygen $keysplit $keysplit_onchain $keysplit_manual)

# function to check
check() {
    local file="$1"
    local new_file="$2"

    if [[ -f $file ]]; then # check for existence of file
        diff=$(diff $file $new_file || :)
    else
        cp $new_file $file
        changes=true
        echo "$file is not found, it has just been created"
    fi

    if [[ -z $diff ]]; then # check for difference
        : # do nothing
    else
        cp $new_file $file
        changes=true
        echo "$file has been updated"
    fi
}

# define changes as false
changes=false
# call check function to check for each help file
check ${files[0]} ${new_files[0]}
check ${files[1]} ${new_files[1]}
check ${files[2]} ${new_files[2]}
check ${files[3]} ${new_files[3]}
check ${files[4]} ${new_files[4]}
check ${files[5]} ${new_files[5]}

# remove help files
rm -f help_general.md help_node.md help_keygen.md help_keysplit.md help_keysplit_onchain.md help_keysplit_manual.md

# only exit at the very end
if [[ $changes == true ]]; then
    echo "Exiting with error to indicate changes occurred. To fix, run 'make cli-local' or 'make cli' and commit the changes."
    exit 1
else
    echo "CLI help texts are up to date."
    exit 0
fi
