#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2020-2022 Jean-Sebastien CONAN
#
# This file is part of jsconan/rc-tracks.
#
# jsconan/rc-tracks is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# jsconan/rc-tracks is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with jsconan/rc-tracks. If not, see <http://www.gnu.org/licenses/>.
#

#
# A race track system for 1/24 to 1/32 scale RC cars.
#
# Slices the STL files for the project.
#
# @author jsconan
#

# script config
configpath="config/config.ini"
configdefault="config/config-dist.ini"

# defines the config path
if [ "${configpath}" != "" ] && [ ! -f "${configpath}" ]; then
    printmessage "${C_ERR}Warning! The config for Slic3r does not exist.\nWill use the default one"
    cp "${configdefault}" "${configpath}"
fi

# redirect to the lib utils
"$(dirname $0)/../lib/camelSCAD/scripts/slice.sh" \
    --input "output" \
    --output "dist" \
    --config "${configpath}" \
    --prusaslicer \
    --recurse \
    "$@"
