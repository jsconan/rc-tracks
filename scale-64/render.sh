#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2022 Jean-Sebastien CONAN
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
# A race track system for 1/64 to 1/76 scale RC cars.
#
# Generates the STL files for the project.
#
# @author jsconan
#

# application params
trackLaneWidth=
trackGroundThickness=
barrierWidth=
barrierHeight=
barrierChunks=
fastenerDiameter=
fastenerHeadDiameter=
fastenerHeadHeight=
printGroundUpsideDown=
printSet=

# script config
scriptpath=$(dirname $0)
project=$(pwd)
srcpath=${project}
dstpath=${project}/output
slcpath=${project}/dist
configpath=${srcpath}/config
partpath=${srcpath}/parts
format=
parallel=
cleanUp=
slice=
renderFemale=
renderMale=
renderSet=
renderGround=
renderTools=
renderAll=1

# include libs
source "${scriptpath}/../lib/camelSCAD/scripts/utils.sh"

# Renders the files from a path.
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
# @param prefix - Optional prefix added to the output file name
# @param suffix - Optional suffix added to the output file name
renderpath() {
    scadrenderall "$1" "$2" "$3" "$4" \
        "$(varif "trackLaneWidth" ${trackLaneWidth})" \
        "$(varif "trackGroundThickness" ${trackGroundThickness})" \
        "$(varif "barrierWidth" ${barrierWidth})" \
        "$(varif "barrierHeight" ${barrierHeight})" \
        "$(varif "barrierChunks" ${barrierChunks})" \
        "$(varif "fastenerDiameter" ${fastenerDiameter})" \
        "$(varif "fastenerHeadDiameter" ${fastenerHeadDiameter})" \
        "$(varif "fastenerHeadHeight" ${fastenerHeadHeight})" \
        "$(varif "printGroundUpsideDown" ${printGroundUpsideDown})" \
        "$(varif "printSet" ${printSet})"
}

# Renders the files from a path.
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
renderpathall() {
    if [ "${renderFemale}" != "" ] || [ "${renderMale}" != "" ] || [ "${renderSet}" != "" ] || [ "${renderGround}" != "" ] || [ "${renderTools}" != "" ] || [ "${renderAll}" != "" ]; then
        printmessage "${C_MSG}Rendering track elements"
    else
        printmessage "${C_MSG}Nothing will be rendered"
    fi
    if [ "${renderFemale}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- female barriers"
        renderpath "$1/barrier-female" "$2/barrier-female"
    fi
    if [ "${renderMale}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- male barriers"
        renderpath "$1/barrier-male" "$2/barrier-male"
    fi
    if [ "${renderSet}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- barriers set"
        renderpath "$1/barrier-set" "$2/barrier-set"
    fi
    if [ "${renderGround}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- ground tiles"
        renderpath "$1/ground" "$2/ground"
    fi
    if [ "${renderTools}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- tools"
        renderpath "$1/tools" "$2/tools"
    fi
}

# Display the render config
showconfig() {
    local config="${dstpath}/config.txt"
    createpath "${dstpath}" "output"
    printmessage "${C_MSG}The track elements would be generated with respect to the following config:"
    renderpath "${configpath}/print.scad" "${dstpath}" 2>&1 | sed -e '1,4d' | sed -e :a -e '$d;N;2,8ba' -e 'P;D' > "${config}"
    cat "${config}"
}

# load parameters
while (( "$#" )); do
    case $1 in
        "a"|"all")
            renderAll=1
        ;;
        "c"|"config")
            renderAll=
        ;;
        "f"|"female")
            renderFemale=1
            renderAll=
        ;;
        "m"|"male")
            renderMale=1
            renderAll=
        ;;
        "s"|"set")
            renderSet=1
            renderAll=
        ;;
        "g"|"ground")
            renderGround=1
            renderAll=
        ;;
        "t"|"tools")
            renderTools=1
            renderAll=
        ;;
        "-t"|"--track")
            trackLaneWidth=$2
            shift
        ;;
        "-w"|"--width")
            barrierWidth=$2
            shift
        ;;
        "-b"|"--height")
            barrierHeight=$2
            shift
        ;;
        "-k"|"--chunks")
            barrierChunks=$2
            shift
        ;;
        "-g"|"--ground")
            trackGroundThickness=$2
            shift
        ;;
        "-d"|"--diameter")
            fastenerDiameter=$2
            shift
        ;;
        "-hd"|"--headDiameter")
            fastenerHeadDiameter=$2
            shift
        ;;
        "-hh"|"--headHeight")
            fastenerHeadHeight=$2
            shift
        ;;
        "-u"|"--upsideDown")
            printGroundUpsideDown=$2
            shift
        ;;
        "-q"|"--printSet")
            printSet=$2
            shift
        ;;
        "-f"|"--format")
            format=$2
            shift
        ;;
        "-p"|"--parallel")
            parallel=$2
            shift
        ;;
        "-s"|"--slice")
            slice=1
        ;;
        "-c"|"--clean")
            cleanUp=1
        ;;
        "-h"|"--help")
            echo -e "${C_INF}Renders OpenSCAD files${C_RST}"
            echo -e "  ${C_INF}Usage:${C_RST}"
            echo -e "${C_CTX}\t$0 [command] [-h|--help] [-o|--option value] files${C_RST}"
            echo
            echo -e "${C_MSG}  a,   all            ${C_RST}Render all elements (default)"
            echo -e "${C_MSG}  f,   female         ${C_RST}Render the female variant of the barriers"
            echo -e "${C_MSG}  m,   male           ${C_RST}Render the male variant of the barriers"
            echo -e "${C_MSG}  s,   set            ${C_RST}Render the set of barrierss"
            echo -e "${C_MSG}  g,   ground         ${C_RST}Render the ground tiles"
            echo -e "${C_MSG}  t,   tools          ${C_RST}Render the tools"
            echo -e "${C_MSG}  c,   config         ${C_RST}Show the config values"
            echo -e "${C_MSG}  -h,  --help         ${C_RST}Show this help"
            echo -e "${C_MSG}  -t   --track        ${C_RST}Set the width of the track lane"
            echo -e "${C_MSG}  -w,  --width        ${C_RST}Set the width of the track barriers"
            echo -e "${C_MSG}  -b   --height       ${C_RST}Set the height of the track barriers"
            echo -e "${C_MSG}  -k   --chunks       ${C_RST}Set the number of barrier chunks per track section"
            echo -e "${C_MSG}  -g   --ground       ${C_RST}Set the thickness of the ground tiles"
            echo -e "${C_MSG}  -d   --diameter     ${C_RST}Set the diameter of the barrier fasteners"
            echo -e "${C_MSG}  -hd  --headDiameter ${C_RST}Set the diameter of the barrier fasteners head"
            echo -e "${C_MSG}  -hh  --headHeight   ${C_RST}Set the height of the barrier fasteners head"
            echo -e "${C_MSG}  -u   --upsideDown   ${C_RST}Flip the ground tiles to print them upside down"
            echo -e "${C_MSG}  -q   --printSet     ${C_RST}Set the quantity of elements to print per set"
            echo -e "${C_MSG}  -f   --format       ${C_RST}Set the output format"
            echo -e "${C_MSG}  -p   --parallel     ${C_RST}Set the number of parallel processes"
            echo -e "${C_MSG}  -s   --slice        ${C_RST}Slice the rendered files using the default configuration"
            echo -e "${C_MSG}  -c   --clean        ${C_RST}Clean up the output folder before rendering"
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

# defines the output format
scadformat "${format}"

# defines the number of parallel processes
scadprocesses "${parallel}"

# clean up the output
if [ "${cleanUp}" != "" ]; then
    printmessage "${C_CTX}Cleaning up the output folder"
    rm -rf "${dstpath}"

    if [ "${slice}" != "" ]; then
        printmessage "${C_CTX}Cleaning up the slicer output folder"
        rm -rf "${slcpath}"
    fi
fi

# show the config
showconfig

# render the files
renderpathall "${partpath}" "${dstpath}"

# slice the rendered files
if [ "${slice}" != "" ]; then
    printmessage "${C_CTX}Slicing the rendered files"
    ./slice.sh
fi
