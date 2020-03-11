install() {
    rm -f "$HOME/.local/share/MangoHud/"{libMangoHud32.so,libMangoHud.so}
    rm -f "$HOME/.local/share/vulkan/implicit_layer.d/"{mangohud32.json,mangohud64.json}
    [ "$UID" -eq 0 ] || exec sudo bash "$0" install
    tar -C / -xvf MangoHud-package.tar
    ldconfig
    echo "MangoHud Installed"
}

uninstall() {
    [ "$UID" -eq 0 ] || exec sudo bash "$0" uninstall
    rm -rfv "/usr/lib/MangoHud"
    rm -fv "/usr/share/vulkan/implicit_layer.d/mangohud.json"
    rm -fv "/etc/ld.so.conf.d/libmangohud.conf"
    rm -fv "/usr/bin/mangohud"
}

for a in $@; do
    case $a in
        "install") install;;
        "uninstall") uninstall;;
        *)
            echo "Unrecognized command argument: $a"
            echo 'Accepted arguments: "install", "uninstall".'
    esac
done