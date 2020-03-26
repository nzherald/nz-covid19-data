#!/bin/sh

Rscript -e "drake::clean(c('caseTables', 'casesTable')); drake::r_make()"
