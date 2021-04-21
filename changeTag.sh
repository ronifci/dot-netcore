#!/bin/bash
sed "s/tagVersion/$1/g" test-dep.yaml > test-dep.yaml-tag.yaml
