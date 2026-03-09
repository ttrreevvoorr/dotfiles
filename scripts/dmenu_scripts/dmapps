#!/bin/bash
# Pick an open i3 window with dmenu (pretty labels, no IDs shown)

DMENU_ARGS=(
  -i
  -p "windows"
  -fn "JetBrainsMono Nerd Font:bold:pixelsize=24"
  -nb "#292929"
  -nf "#CCCCCC"
  -sf "#fdf6e3"
  -sb "#3a615c"
  -bw 8
  -l 15
)


icon_for_class() {
  # Lowercase class in, Nerd Font glyph out
  case "$1" in
    firefox) echo "" ;;
    google-chrome|chromium|brave-browser) echo "" ;;
    code|codium) echo "󰨞" ;;
    xfce4-terminal|alacritty|kitty|wezterm|xterm|st) echo "" ;;
    discord) echo "󰙯" ;;
    signal) echo "󰭹" ;;
    protonvpn-app) echo "󰒄";;
    reaper) echo "󰽰";;
    kdenlive) echo "";;
    obsidian) echo "";;
    pavucontrol) echo "";;
    obs) echo "󰑋";;
    qbittorrent) echo "";;
    slack) echo "󰒱" ;;
    filezilla) echo "";;
    thunar) echo "" ;;
    thunderbird) echo "";;
    lutris|mgba) echo "";;
    spotify) echo "" ;;
    vlc) echo "󰕼";;
    steam) echo "" ;;
    pcloud) echo "" ;;
    blueman-manager|blueman-applet) echo "" ;;
    nm-connection-editor|nm-applet) echo "󰤨" ;;
    docker|docker-desktop) echo "󰡨";;
    gimp) echo "" ;;
    blender) echo "󰂫" ;;
    galculator) echo "󰃬";;
    libreoffice*|soffice) echo "";;
    *) echo "󰣆" ;;  # generic app
  esac
}

while true; do
  # Build two parallel lists:
  # 1) menu labels (pretty)
  # 2) ids in same order (for focusing)
  mapfile -t IDS < <(
    i3-msg -t get_tree | jq -r '
      .. | objects
      | select(.type? == "con" and .window? != null)
      | .id
    '
  )

  mapfile -t CLASSES < <(
    i3-msg -t get_tree | jq -r '
      .. | objects
      | select(.type? == "con" and .window? != null)
      | (.window_properties.class // "unknown")
    '
  )

  mapfile -t TITLES < <(
    i3-msg -t get_tree | jq -r '
      .. | objects
      | select(.type? == "con" and .window? != null)
      | (.name // "untitled")
    '
  )

  # No windows?
  if [ "${#IDS[@]}" -eq 0 ]; then
    printf "No windows\n" | dmenu "${DMENU_ARGS[@]}"
    exit 0
  fi

  # Build labels, keeping index alignment with IDS
  LABELS=()
  for i in "${!IDS[@]}"; do
    cls="${CLASSES[$i]}"
    title="${TITLES[$i]}"

    cls_lc="$(printf "%s" "$cls" | tr '[:upper:]' '[:lower:]')"
    ico="$(icon_for_class "$cls_lc")"

    # Show class + title (no id)
    LABELS+=("${ico} ${cls} — ${title}")
  done

  # Present menu
  CHOICE="$(
    ( printf "%s\n" "${LABELS[@]}"
    ) | dmenu "${DMENU_ARGS[@]}"
  )"

  [ -z "$CHOICE" ] && exit 0
  [ "$CHOICE" = ".." ] && exit 0

  # Find selected index by exact string match
  sel_index=-1
  for i in "${!LABELS[@]}"; do
    if [ "${LABELS[$i]}" = "$CHOICE" ]; then
      sel_index="$i"
      break
    fi
  done

  [ "$sel_index" -lt 0 ] && continue

  i3-msg "[con_id=${IDS[$sel_index]}]" focus >/dev/null
  exit 0
done

