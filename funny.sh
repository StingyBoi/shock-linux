# make sure this only runs in a interactive shell
[[ $- != *i* ]] && return


#this checks for if the shell errors
precmd() {
    local ec=$?
    if [[ $ec -ne 0 ]]; then
        shocker
    fi
}

shocker () {
    #make sure this is set to the location of the rc file
    local rc=$HOME/Projects/linuxclishock/.shockrc

    #setting local ids to make things easier
    local shockapi=$(sed -n 's/^api-key=//p' "$rc")
    local id=$(sed -n 's/^shocker-id=//p' "$rc")
    local type=$(sed -n 's/^type=//p' "$rc")
    local power=$(sed -n 's/^strength=//p' "$rc")
    local length=$(sed -n 's/^length=//p' "$rc")

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
}
