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
# A race track system for 1/24 to 1/32 scale RC cars.
#
# Generates the STL files for the project.
#
# @author jsconan
#

# application params
trackSectionSize=
barrierHeight=
trackWidth=
sampleSize=

# script config
scriptpath=$(dirname $0)
project=$(pwd)
srcpath=${project}
dstpath=${project}/output

source "${scriptpath}/../../lib/camelSCAD/scripts/utils.sh"

# load parameters
while (( "$#" )); do
    case $1 in
        "-l"|"--length")
            trackSectionSize=$2
            shift
        ;;
        "-w"|"--height")
            barrierHeight=$2
            shift
        ;;
        "-t"|"--track")
            trackWidth=$2
            shift
        ;;
        "-s"|"--sample")
            sampleSize=$2
            shift
        ;;
        "-h"|"--help")
            echo -e "${C_INF}Renders OpenSCAD files${C_RST}"
            echo -e "  ${C_INF}Usage:${C_RST}"
            echo -e "${C_CTX}\t$0 [-h|--help] [-o|--option value] files${C_RST}"
            echo
            echo -e "${C_MSG}  -h,  --help         ${C_RST}Show this help"
            echo -e "${C_MSG}  -l,  --length       ${C_RST}Set the size of a track section"
            echo -e "${C_MSG}  -w   --height       ${C_RST}Set the height of the track barrier"
            echo -e "${C_MSG}  -t   --track        ${C_RST}Set the width of a track lane"
            echo -e "${C_MSG}  -s   --sample       ${C_RST}Set the size of sample element"
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

# allign values
if [ "${trackSectionSize}" != "" ] && [ "${trackWidth}" == "" ]; then
    trackWidth=$((${trackSectionSize} * 2))
fi

# check OpenSCAD
scadcheck

# render the files, if exist
scadtostlall "${srcpath}" "${dstpath}" "" \
    "$(varif "trackSectionSize" ${trackSectionSize})" \
    "$(varif "barrierHeight" ${barrierHeight})" \
    "$(varif "trackWidth" ${trackWidth})" \
    "$(varif "sampleSize" ${sampleSize})"
