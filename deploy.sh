#! /usr/bin/env bash

jekyll build && aws s3 sync ./_site/ s3://jeffgran.com --delete
