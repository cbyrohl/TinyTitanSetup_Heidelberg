#!/bin/bash

# File path of the YAML file
yamltemplate_file="autoinstall_template.yaml"
yaml_file="autoinstall.yaml"

set -e

# Check if the input YAML file exists
if [ ! -f "$yamltemplate_file" ]; then
    echo "Error: File does not exist - $yamltemplate_file"
    exit 1
fi


if [[ -z "$TINYTITAN_AUTH_KEY" ]]; then
    echo "Warning: AUTHKEY not set. You will not be able to login without password."
fi

if [[ "$TINYTITAN_PASS" == "1234" ]]; then
    echo "Error: Change PASS. The machine will be accessible from the network via ssh."
    exit 1
fi

# Create or clear the temporary file
touch "$yaml_file"

# Read each line of the YAML file
while IFS= read -r line; do
    # Replace placeholders with environment variable values
    while [[ "$line" =~ (\$\{([^}]+)\}) ]]; do
        var="${BASH_REMATCH[1]}"
        name="${BASH_REMATCH[2]}"
        value="${!name}"
        line="${line//${var}/${value}}"
    done
    # Write the processed line to the temporary file
    echo "$line" >> "$yaml_file"
done < "$yamltemplate_file"

echo "Environment variables have been substituted in $yaml_file."
