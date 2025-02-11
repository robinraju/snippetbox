#!/bin/sh
GIT_HOOKS_PATH=$(pwd)/.git/hooks

echo '#!/bin/sh
GOIMPORTS=$GOPATH/bin/goimports

if [ -f "$GOIMPORTS" ]; then
    FILE_WARNINGS=$(GOIMPORTS -l .)

    if [ "${FILE_WARNINGS}" != "" ]; then
        echo "Aborting commit due to bad code formatting.\n"
        echo "\t\033[0;31m${FILE_WARNINGS}\033[0m\n"
        echo "Please fix formatting in files listed above before commiting changes."
        echo "You can use \"goimports -w .\" to automatically fix these issues."
        exit 1
    fi
else
    echo "Failed to find goimports binary at ${GOIMPORTS}"
    echo "Use command below to install the binary and try again."
    echo "\n\tgo get golang.org/x/tools/cmd/goimports\n"
    exit 1
fi
' >${GIT_HOOKS_PATH}/pre-commit

chmod +x ${GIT_HOOKS_PATH}/pre-commit