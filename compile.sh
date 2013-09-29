#!/usr/bin/env bash
#make -f client.mk > output`date "+%Y-%m-%d-%H-%M-%S"`.txt
./mach clobber
./mach build
./mach package
