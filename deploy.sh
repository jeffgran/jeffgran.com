#! /usr/bin/env bash
shopt -s dotglob
jekyll build && scp -r ./_site/* jeffgran.com:www/jeffgran/
