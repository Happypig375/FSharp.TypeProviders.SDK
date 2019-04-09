#!/bin/bash
# On Linux (or at least, Ubuntu), update the libunwind8 package so .NET Core can run, see https://github.com/dotnet/cli/issues/3390
if [ $(uname -s) = 'Linux' ]; then
    sudo apt-get install libunwind8
fi

which mono
which msbuild

mono .paket/paket.exe restore
exit_code=$?
if [ $exit_code -ne 0 ]; then
  exit $exit_code
fi

mono packages/FAKE/tools/FAKE.exe $@ --fsiargs -d:MONO build.fsx
