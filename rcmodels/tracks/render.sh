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
configpath=${srcpath}/config
partpath=${srcpath}/parts
showConfig=
renderAccessories=
renderElements=
renderSamples=

# include libs
source "${scriptpath}/../../lib/camelSCAD/scripts/utils.sh"

# Renders the files from a path.
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
# @param prefix - A prefix to add to each output file.
# @param right - Right oriented or left oriented
renderpath() {
    local rightOriented=$3
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
    printmessage "${C_MSG}- straight elements"
    renderpath "$1/straight" "$2"
    printmessage "${C_MSG}- left curved elements"
    renderpath "$1/curved" "$2/left" "0"
    printmessage "${C_MSG}- right curved elements"
    renderpath "$1/curved" "$2/right" "1"
}

# Display the render config
showconfig() {
    printmessage "${C_MSG}Will generates the track elements with respect to the following config:"
    renderpath "${configpath}/print.scad" "${dstpath}" 2>&1 | sed -e '1,4d' | sed -e :a -e '$d;N;2,3ba' -e 'P;D'
}

# load parameters
while (( "$#" )); do
    case $1 in
        "a"|"accessories")
            renderAccessories=1
            showConfig=1
        ;;
        "e"|"elements")
            renderElements=1
            showConfig=1
        ;;
        "s"|"samples")
            renderSamples=1
            showConfig=1
        ;;
        "c"|"config")
            showConfig=1
        ;;
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
            echo -e "${C_CTX}\t$0 [command] [-h|--help] [-o|--option value] files${C_RST}"
            echo
            echo -e "${C_MSG}  a,  accessories     ${C_RST}Render the accessories"
            echo -e "${C_MSG}  e,  elements        ${C_RST}Render the track elements"
            echo -e "${C_MSG}  s,  samples         ${C_RST}Render the samples"
            echo -e "${C_MSG}  c,  config          ${C_RST}Show the config values"
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

# default script config
if [ "${renderAccessories}" == "" ] && [ "${renderElements}" == "" ] && [ "${renderSamples}" == "" ] && [ "${showConfig}" == "" ]; then
    renderAccessories=1
    renderElements=1
    renderSamples=1
    showConfig=1
fi

# check OpenSCAD
scadcheck

# show the config
if [ "${showConfig}" != "" ]; then
    showconfig
fi

# render the files
if [ "${renderAccessories}" != "" ]; then
    printmessage "${C_MSG}Rendering accessories"
    renderpath "${partpath}/accessories" "${dstpath}/accessories"
fi
if [ "${renderElements}" != "" ]; then
    printmessage "${C_MSG}Rendering track elements"
    renderpathall "${partpath}/elements" "${dstpath}/elements"
fi
if [ "${renderSamples}" != "" ]; then
    printmessage "${C_MSG}Rendering track samples"
    renderpathall "${partpath}/samples" "${dstpath}/samples"
fi
