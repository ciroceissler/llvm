#!/bin/bash

[[ ! -d .tags ]] && mkdir .tags
cscope -b -R
mv cscope.out .tags
ctags -R .
