ISOPATH=""  # path to lubuntu iso image
AUTHKEY="" # ssh public key to use for authentification
PASS=1234 # password for 'tiny' user


export TINYTITAN_ISOPATH=${ISOPATH:-""}
export TINYTITAN_AUTH_KEY=${AUTHKEY:-""} 
export TINYTITAN_PASS=${PASS:-"1234"}  

if [[ -z "$TINYTITAN_AUTH_KEY" ]]; then
    echo "Warning: AUTHKEY not set. You will not be able to login without password."
fi

if [[ "$TINYTITAN_PASS" == "1234" ]]; then
    echo "Error: Change PASS. The machine will be accessible from the network via ssh."
    exit 1
fi

if [[ -z "$TINYTITAN_ISOPATH" ]]; then
    echo "Error: Need the path to the iso image download."
    exit 1
fi

# Check if the script is sourced or not
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script must be sourced: 'source ./set_env.sh'. Do not execute it directly."
    exit 1
fi

export TINYTITAN_CRYPTED_PASS=$(openssl passwd $TINYTITAN_PASS)
