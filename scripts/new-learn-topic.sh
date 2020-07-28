#!/bin/bash

set -o errexit -o pipefail

module=""
topic=""

prompt_for_module_name() {
    read -p "Module name (e.g., pulumi-101): " module

    if [[ ! -z "$module" && -d "content/learn/${module}" ]]; then
        return
    fi

    echo "Couldn't find a module with that name. Make sure you're using the path as listed under content/learn."
    prompt_for_module_name
}

prompt_for_topic_name() {
    read -p "Topic name (e.g., basics): " topic

    if [ ! -z "$topic" ]; then
        hugo new --kind learn/topic "content/learn/${module}/${topic}"
        return
    fi

    echo "Please give the topic a name."
    prompt_for_topic_name
}

echo "So, you want to make a new Learn Pulumi topic? Great! 🙌"
echo
echo "Step 1 of 2:"
echo
echo "What is the path of the module you want to write for?"
echo
prompt_for_module_name

echo "Step 2 of 2:"
echo
echo "Now give your new topic a URL-friendly name. For example, to create a new topic under ${module} that'll live at https://pulumi.com/learn/${module}/basics, type 'basics'."
echo
prompt_for_topic_name
