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
trackLaneWidth=
trackRadius=
barrierHeight=
sampleSize=

# script config
scriptpath=$(dirname $0)
project=$(pwd)
srcpath=${project}
dstpath=${project}/output

# include libs
source "${scriptpath}/../../lib/camelSCAD/scripts/utils.sh"

# Renders the files from a path.
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
# @param prefix - A prefix to add to each output file.
# @param right - Right oriented or left oriented
renderpath() {
    rightOriented=$3
    scadtostlall "$1" "$2" "" \
        "$(varif "trackSectionSize" ${trackSectionSize})" \
        "$(varif "trackLaneWidth" ${trackLaneWidth})" \
        "$(varif "trackRadius" ${trackRadius})" \
        "$(varif "barrierHeight" ${barrierHeight})" \
        "$(varif "sampleSize" ${sampleSize})" \
        "$(varif "rightOriented" ${rightOriented})"
}

# Renders the files from a path, taking care of the curves.
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
renderpathall() {
    renderpath "$1" "$2"
    renderpath "$1/curves" "$2/left" "0"
    renderpath "$1/curves" "$2/right" "1"
}

# Display the render config
showconfig() {
    printmessage "${C_MSG}Will generates the track elements with respect to the following config:"
    renderpath "${srcpath}/config/print.scad" "${dstpath}"
}

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
        "-r"|"--radius")
            trackRadius=$2
            shift
        ;;
        "-t"|"--track")
            trackLaneWidth=$2
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
            echo -e "${C_MSG}  -r   --radius       ${C_RST}Set the radius of the track inner curve"
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
if [ "${trackSectionSize}" != "" ]; then
    if [ "${trackLaneWidth}" == "" ]; then
        trackLaneWidth=$((${trackSectionSize} * 2))
    fi
    if [ "${trackRadius}" == "" ]; then
        trackRadius=${trackSectionSize}
    fi
fi

# check OpenSCAD
scadcheck

# show the config
showconfig

# render the files
renderpathall "${srcpath}/elements/barrier-holders" "${dstpath}/elements"
renderpathall "${srcpath}/elements/samples" "${dstpath}/samples"
