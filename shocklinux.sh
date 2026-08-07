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

    if [[ "$power" == "range" ]]; then
        local floorpow=$(sed -n 's/^min_strength=//p' "$rc")
        local ceilingpow=$(sed -n 's/^max_strength=//p' "$rc")
        power=$(($ceilingpow + 1))  
        while [[ $power -le $floorpow ]] || [[ $power -ge $ceilingpow ]]
        do
            power=$(($RANDOM % 110))
        done
    fi
    if [[ "$length" ==  "range" ]]; then
        local floortime=$(sed -n 's/^min_time=//p' "$rc")
        local ceilingtime=$(sed -n 's/^max_time=//p' "$rc")
        length=$(($ceilingtime +1))
        #!TODO look into making this be able to have values larger then 16 bit signed int
        while [[ $length -le $floortime ]] || [[ $length -ge $ceilingtime ]]
        do
            length=$(($RANDOM))
        done
    fi

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
    echo "$message"
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
    PROMPT_COMMAND+=("{ exitcode=$?; [[ $exitcode -ne 0 ]] && shocker; };")
fi
