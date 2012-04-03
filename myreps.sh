#!/bin/bash

if [ `cat ANSWERREP` = "Y" ]; then
	cd ~ && git clone git@github.com:jgillis/Eg.git eg
fi
