#! /usr/bin/env bash

bundle exec jekyll build && aws s3 sync ./_site/ s3://jg-production-jeffgrancom-origin --delete
