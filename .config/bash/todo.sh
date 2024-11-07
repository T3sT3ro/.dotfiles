#!/bin/bash
function todo() {
    case "$1" in
    -e | --edit) vim ~/.todo.md;;
    *) rich ~/.todo.md -y "$@";;
    esac
}
