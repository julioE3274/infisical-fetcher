#!/bin/sh -l

echo $(infisical -v)
INFISICAL_TOKEN=$INPUT_TOKEN
INFISICAL_CLIENT_ID=$INPUT_CLIENT
INFISICAL_CLIENT_SECRET=$INPUT_SECRET
INFISICAL_PROJECT_ID=$INPUT_PROJECT
INFISICAL_PATH=$INPUT_PATH
OUTPUT_PATH=$INPUT_OUTPUT

if [ -z "$INFISICAL_TOKEN" ]; then

    if [ -z "$INFISICAL_CLIENT_ID" ] || [ -z "$INFISICAL_CLIENT_SECRET" ]; then
        echo "Error: INFISICAL_CLIENT_ID or (INFISICAL_CLIENT_SECRET and INFISICAL_CLIENT_ID) not found."
        exit 1
    fi

    INFISICAL_TOKEN=$(infisical login --method=universal-auth --client-id=${INFISICAL_CLIENT_ID} --client-secret=${INFISICAL_CLIENT_SECRET} --silent --plain)
fi

export INFISICAL_TOKEN=$INFISICAL_TOKEN

if [ -z "$INFISICAL_PROJECT_ID" ]; then
    echo "Error: INFISICAL_PROJECT_ID not found."
    exit 1
fi

TO_RUN_COMMAND="infisical export --projectId=${INFISICAL_PROJECT_ID}"

if [ -n "$INFISICAL_PATH" ]; then
    TO_RUN_COMMAND="$TO_RUN_COMMAND --path=${INFISICAL_PATH}"
fi

RESULT=$($TO_RUN_COMMAND)

if [ $? -ne 0 ]; then
    echo "Error: Command failed. Please check the provided parameters and try again."
    exit 1
fi

if [ -n "$OUTPUT_PATH" ]; then
    echo "$RESULT" > $OUTPUT_PATH
fi

echo "$RESULT" >> $GITHUB_OUTPUT
