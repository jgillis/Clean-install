#!/bin/bash

if [ `cat ANSWERSAMBA` = "Y" ]; then
	cd ~ && git clone git@github.com:jgillis/Eg.git eg
fi
