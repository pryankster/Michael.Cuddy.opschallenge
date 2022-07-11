# this file should be in the same directory as 'id_docean'
export TF_VAR_do_token="dop_v1_xxxxxx put token here xxxxx"
# get ABSPATH to id file.
export TF_VAR_do_private_key="$(cd $(dirname $BASH_SOURCE) && pwd)/id_docean"
