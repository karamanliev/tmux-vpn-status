#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

vpn_status() {
	if command_exists "nordvpn" && [[ ! -z "$(nordvpn status | grep "Connected")" ]]; then
		tunnel="Connected"
  	elif is_osx && command_exists "scutil"; then
		tunnel=$(scutil --nc list | grep Connected)
	elif command_exists "ifconfig"; then
		tunnel=$(ifconfig | grep tun)
	elif command_exists "ip"; then
		tunnel=$(ip a | grep tun)
	else
		echo "Can't check connection"
		return
	fi
	if [ -n "$tunnel" ]; then
		echo "Connected"
	else
		echo "Disconnected"
	fi
}

main() {
	vpn_status
}
main
