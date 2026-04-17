#!/bin/bash

dir="$HOME/Pictures/screenshot"
mkdir -p "$dir"

file="$dir/screenshot-$(date +%F-%H-%M-%S-%N).png"

maim -s "$file"
