#!/bin/sh

sh scripts/zip_android_key.sh
gpg --symmetric --cipher-algo AES256 android/android_keys.zip