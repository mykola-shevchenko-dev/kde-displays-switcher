#!/usr/bin/bash
export LC_ALL=en_US.UTF-8

VERSION="0.0.1"

CONFIG_DIR="~/.config/displays-switcher/"
CONFIG_FILE="config.ini"
CONFIG_PATH="${CONFIG_DIR}${CONFIG_FILE}"

SAVE_FILE="displaysswitcherrc"

DIALOG_NAME="Displays Switcher"
DIALOG_MSG="Choose preset"

show_dialog=false

# handle launch params
while [[ $# -gt 0 ]]; do
    case "$1" in
        -d|--dialog) show_dialog=true; shift ;;
        -v|--version) echo "version $VERSION"; exit 0 ;;
        -p|--preset) shift; preset="$1"; shift ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

# get presets list
presets=()
while IFS= read -r line; do
    if [[ $line =~ \[([^\]]+)\] ]]; then
        presets+=("${BASH_REMATCH[1]}")
    fi
done <"$CONFIG_PATH"

save_current_preset() {
    kwriteconfig6 --file "${SAVE_FILE}" --key "preset" "$1"
}

get_current_preset() {
    echo $(kreadconfig6 --file "${SAVE_FILE}" --key "preset")
}

get_next_preset_index() {
    index="0"
    for i in "${!presets[@]}"; do
        [[ "${presets[$i]}" == "$1" ]] && { index="$((i + 1))"; break; }
    done

    length=${#presets[@]}
    [[ $index -ge $length ]] && index="0"

    echo "$index"
}

apply_preset() {
    save_current_preset $1

    in_section=0
    while IFS= read -r line; do
        [[ $line =~ \[$1\] ]] && { in_section=1; continue; }
        [[ $line =~ ^\[.*\] ]] && { in_section=0; }
        ((in_section)) && [[ ! $line =~ ^\[.*\] ]] && kscreen-doctor "$line"
    done <"$CONFIG_PATH"
}

launch_dialog() {
    dialog_options=()
    for i in "${!presets[@]}"; do
        dialog_options+=("$i" "${presets[i]}")
    done

    echo $(kdialog --title "${DIALOG_NAME}" --menu "${DIALOG_MSG}" "${dialog_options[@]}")
}

# apply preset from launch params
if [[ -n "$preset" ]]; then
    apply_preset $preset
    exit 0
fi

# show dialog to choose preset
if [[ $show_dialog == true ]]; then
    choise=$(launch_dialog)
    if [[ -n "$choise" ]]; then
        apply_preset ${presets[$((choise))]}
        exit 0
    fi
fi

# toggle next preset
current_preset=$(get_current_preset)
next_preset_index=$(get_next_preset_index $current_preset)
apply_preset "${presets[$next_preset_index]}"

exit 0
