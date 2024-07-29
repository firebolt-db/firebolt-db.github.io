#!/bin/bash

set -euo pipefail

SIGINT_SIGNO=$(kill -l SIGINT)

function _cleanup() {
	trap - EXIT SIGINT SIGTERM
	local root_dir="${1?}"
	local tmp_file="${2?}"
	local exit_code="${3?}"
	shift
	local compose_dir="$root_dir/scripts/docker"
	local compose_file="$compose_dir/compose.yml"
	(
		cd "$root_dir"
		if [[ "$exit_code" != 0 ]]; then
			/bin/echo -e "\n\n## Jekyll logs ##########################################\n"
			docker ps -q -a --filter "label=log-filter=firebolt-docs-staging" --latest | xargs -n 1 docker logs -t --details
		fi
		docker compose -f "$compose_file" --env-file "$tmp_file" down
		rm "$tmp_file"
	)
	if [[ "$exit_code" == $(( SIGINT_SIGNO + 128 )) ]];
		then exit 0
	fi
}

function _base_compose() {
	local root_dir="${1?}"
	shift
	local compose_dir="$root_dir/scripts/docker"
	local compose_file="$compose_dir/compose.yml"

	(
		cd "$root_dir"
		local tmp_file
		tmp_file=$(mktemp)
		cat <<EOF > "$tmp_file"
USER_ID=$(id -u)
USER_NAME=$(id -un)
EOF
		trap '_cleanup "$root_dir" "$tmp_file" "$?"' SIGINT SIGTERM EXIT
		docker compose -f "$compose_file" --env-file "$tmp_file" --project-directory "$root_dir" "$@"
	)
}

function build_all() {
	local root_dir="${1?}"
	shift
	_base_compose "$root_dir" build "$@"
}

function run() {
	local root_dir="${1?}"
	shift
	_base_compose "$root_dir" run --rm --remove-orphans "$@"
}
