#shellcheck shell=bash
# Setup hook for checking whether Lua imports succeed
echo "Sourcing neovim-require-check-hook.sh"

# Discover modules automatically if nvimRequireCheck is not set
discover_modules() {
    echo "Running module discovery in source directory..."

    declare -A modules # Use associative array for unique module names
    while IFS= read -r lua_file; do
        if [[ "$lua_file" =~ /after/ ]]; then
            echo "Skipping file in 'after' directory: $lua_file"
            continue
        fi

        if [[ "$lua_file" =~ lua/(.*)/init\.lua$ ]]; then
            # Capture "name" from `lua/name/init.lua`
            modules["${BASH_REMATCH[1]}"]=1
        elif [[ "$lua_file" =~ lua/(.*)\.lua$ ]]; then
            # Capture full path as module name, e.g., `myplugin.utils` from `lua/myplugin/utils.lua`
            module_name="${BASH_REMATCH[1]//\//.}"
            modules["$module_name"]=1
        elif [[ "$lua_file" =~ plugin/(.*)\.lua$ ]]; then
            # Handle cases in `plugin/*.lua`
            module_name="${BASH_REMATCH[1]}"
            modules["$module_name"]=1
        fi
    done < <(find "$src" -name '*.lua')

    nvimRequireCheck=("${!modules[@]}")
    echo "Discovered modules: ${nvimRequireCheck[*]}"

    if [ "${#nvimRequireCheck[@]}" -eq 0 ]; then
        echo "No valid Lua modules found; skipping check"
        return 1
    fi
    return 0
}

# Run require checks on each module in nvimRequireCheck
run_require_checks() {
    local stop_on_first_success=$1
    echo "Starting require checks with stop_on_first_success=$stop_on_first_success"
    check_passed=false
    failed_modules=()
    successful_modules=()

    export HOME="$TMPDIR"
    local deps="${dependencies[*]}"
    set +e
    for name in "${nvimRequireCheck[@]}"; do
        echo "Attempting to require module: $name"
        if @nvimBinary@ -es --headless -n -u NONE -i NONE --clean -V1 \
            --cmd "set rtp+=$out,${deps// /,}" \
            --cmd "lua require('$name')"; then
            check_passed=true
            successful_modules+=("$name")
            echo "Successfully required module: $name"
            if [ "$stop_on_first_success" = true ]; then
                echo "Stopping on first success (discovery mode)"
                break
            fi
        else
            echo "Failed to require module: $name"
            failed_modules+=("$name")
        fi
    done
    set -e
}

# Define color codes
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m" # No Color

# Print summary of the require checks
print_summary() {
    echo -e "\n======================================================"
    if [[ "$check_passed" == "true" ]]; then
        echo -e "${GREEN}Require check succeeded for the following modules:${NC}"
        for module in "${successful_modules[@]}"; do
            echo -e "  ${GREEN}- $module${NC}"
        done
        if [ "$stop_on_first_success" = false ]; then
            echo "All manually provided modules were checked."
        else
            echo "Stopped after first success in auto-discovery mode."
        fi
    else
        echo -e "${RED}No successful require checks.${NC}"
    fi

    # Print any modules that failed with improved formatting and color
    if [ "${#failed_modules[@]}" -gt 0 ]; then
        echo -e "\n${RED}Require check failed for the following modules:${NC}"
        for module in "${failed_modules[@]}"; do
            echo -e "  ${RED}- $module${NC}"
        done
    fi
    echo "======================================================"

    if [ "${#successful_modules[@]}" -eq 0 ]; then
        return 1
    fi
}

# Main entry point: orchestrates discovery, require checks, and summary
neovimRequireCheckHook() {
    echo "Executing neovimRequireCheckHook"

    if [ "${nvimRequireCheck[*]}" = "" ]; then
        echo "nvimRequireCheck is empty; entering discovery mode"
        # Auto-discovery mode
        if ! discover_modules; then
            echo "No modules found during discovery; exiting hook"
            return
        fi
        stop_on_first_success=true
    else
        echo "nvimRequireCheck is pre-populated; entering manual check mode"
        stop_on_first_success=false
    fi

    run_require_checks "$stop_on_first_success"
    print_summary
}

echo "Using neovimRequireCheckHook"
appendToVar preDistPhases neovimRequireCheckHook
