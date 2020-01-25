#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2020 Jean-Sebastien CONAN
#
# This file is part of jsconan/things.
#
# jsconan/things is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# jsconan/things is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
#

#
# Generates the STL files for the 1/24 RC track system.
#
# @author jsconan
#

# application params
heightWithFasteners=
chunkLength=
borderHeight=

# script config
scriptpath=$(dirname $0)
project=$(pwd)
srcpath=${project}
dstpath=${project}/output

source "${scriptpath}/../../lib/camelSCAD/scripts/utils.sh"

# load parameters
while (( "$#" )); do
    case $1 in
        "-l"|"--chunkLength")
            chunkLength=$2
            shift
        ;;
        "-w"|"--borderHeight")
            borderHeight=$2
            shift
        ;;
        "-i"|"--innerHeight")
            heightWithFasteners=0
        ;;
        "-o"|"--outerHeight")
            heightWithFasteners=1
        ;;
        "-h"|"--help")
            echo -e "${C_INF}Renders OpenSCAD files${C_RST}"
            echo -e "  ${C_INF}Usage:${C_RST}"
            echo -e "${C_CTX}\t$0 [-h|--help] [-o|--option value] files${C_RST}"
            echo
            echo -e "${C_MSG}  -h,  --help         ${C_RST}Show this help"
            echo -e "${C_MSG}  -l,  --chunkLength  ${C_RST}Set the length of a track chunk"
            echo -e "${C_MSG}  -w   --borderHeight ${C_RST}Set the height of the track border"
            echo -e "${C_MSG}  -i,  --innerHeight  ${C_RST}The height of the border does not contains the size of the mount fasteners"
            echo -e "${C_MSG}  -o,  --outerHeight  ${C_RST}The height of the border contains the size of the mount fasteners"
            echo
            exit 0
        ;;
        *)
            ls $1 >/dev/null 2>&1
            if [ "$?" == "0" ]; then
                srcpath=$1
            else
                printerror "Unknown parameter ${1}"
            fi
        ;;
    esac
    shift
done

# check OpenSCAD
scadcheck

# render the files, if exist
scadtostlall "${srcpath}" "${dstpath}" "" \
    "$(varif "chunkLength" ${chunkLength})" \
    "$(varif "borderHeight" ${borderHeight})" \
    "$(varif "heightWithFasteners" ${heightWithFasteners})"
