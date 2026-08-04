# make sure this only runs in a interactive shell
[[ $- != *i* ]] && return

shocker () {
    #make sure this is set to the location of the rc file
    local rc=$HOME/.config/shock-linux/.shockrc

    #setting local ids to make things easier
    local shockapi=$(sed -n 's/^api-key=//p' "$rc")
    local id=$(sed -n 's/^shocker-id=//p' "$rc")
    local type=$(sed -n 's/^type=//p' "$rc")
    local power=$(sed -n 's/^strength=//p' "$rc")
    local length=$(sed -n 's/^length=//p' "$rc")
    local message=$(sed -n 's/^text=//p' "$rc")


    curl --silent --output /dev/null https://api.openshock.app/2/shockers/control \
      --request POST \
      --header 'Accept: application/json' \
      --header 'Content-Type: application/json' \
      --header "OpenShockToken: $shockapi" \
      --data "$(cat <<EOF
{
    "shocks": [
        {
        "id": "$id",
        "type": "$type",
        "intensity": $power,
        "duration": $length,
        "exclusive": true
        }
    ],
    "customName": "linuxshocker"
}
EOF
)"
    echo $message
}
#this checks for if the shell errors
if [[ -v ZSH_VERSION ]]; then
    precmd() {
        local exitcode=$?
        if [[ $exitcode -ne 0 ]]; then
            shocker
        fi
    }
fi
if [[ -v BASH_VERSION ]]; then
    PROMPT_COMMAND+=('{ exitcode=$?; [[ $exitcode -ne 0 ]] && shocker; };')
fi
