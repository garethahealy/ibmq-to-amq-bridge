#!/usr/bin/env bash

echo "Deploying code signing key..."

cd ./.travis || exit

openssl aes-256-cbc -K "$encrypted_7348c3531f15_key" -iv "$encrypted_7348c3531f15_iv" -in codesigning.asc.enc -out codesigning.asc -d
gpg --fast-import codesigning.asc

cd ../ || exit
