#!/bin/sh

rm -rv ./public/

. ./venv/bin/activate

python ./thumbnailer.py

zine release
