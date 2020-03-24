#!/bin/sh

Rscript -e "drake::clean(c('caseTables')); drake::r_make()"
