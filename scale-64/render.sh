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
printQuantity=

# script config
scriptpath="$(dirname $0)"
project="$(pwd)"
srcpath="${project}"
dstpath="${project}/dist/stl"
slcpath="${project}/dist/gcode"
configpath="${srcpath}/config"
partpath="${srcpath}/parts"
format=
parallel=
cleanUp=
slice=
renderBarriers=
renderElements=
renderGround=
renderTiles=
renderTools=
renderAll=1

# include libs
source "${scriptpath}/../lib/camelSCAD/scripts/utils.sh"

# Builds the list of config parameters.
paramlist() {
    local params=(
        "$(varif "trackLaneWidth" ${trackLaneWidth})"
        "$(varif "trackGroundThickness" ${trackGroundThickness})"
        "$(varif "barrierWidth" ${barrierWidth})"
        "$(varif "barrierHeight" ${barrierHeight})"
        "$(varif "barrierChunks" ${barrierChunks})"
        "$(varif "fastenerDiameter" ${fastenerDiameter})"
        "$(varif "fastenerHeadDiameter" ${fastenerHeadDiameter})"
        "$(varif "fastenerHeadHeight" ${fastenerHeadHeight})"
        "$(varif "printGroundUpsideDown" ${printGroundUpsideDown})"
        "$(varif "printQuantity" ${printQuantity})"
    )
    echo "${params[@]}"
}

# Renders the files from a path.
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
# @param prefix - Optional prefix added to the output file name
# @param suffix - Optional suffix added to the output file name
renderpath() {
    scadrenderall "$1" "$2" "$3" "$4" --quiet $(paramlist)
}

# Renders the files from a path.
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
renderpathall() {
    if [ "${renderBarriers}" != "" ]  || \
       [ "${renderElements}" != "" ] || \
       [ "${renderGround}" != "" ]  || \
       [ "${renderTiles}" != "" ]   || \
       [ "${renderTools}" != "" ]   || \
       [ "${renderAll}" != "" ]; then
        printmessage "${C_MSG}Rendering track elements"
    else
        printmessage "${C_MSG}Nothing will be rendered"
    fi
    if [ "${renderBarriers}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- sets of barriers"
        renderpath "$1/barriers" "$2/barriers"
    fi
    if [ "${renderElements}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- all elements"
        renderpath "$1/elements" "$2/elements"
    fi
    if [ "${renderGround}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- ground tiles"
        renderpath "$1/ground" "$2/ground"
    fi
    if [ "${renderTiles}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- full tiles"
        renderpath "$1/tiles" "$2/tiles"
    fi
    if [ "${renderTools}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- tools"
        renderpath "$1/tools" "$2/tools"
    fi
}

# Display the render config
showconfig() {
    local input="${configpath}/setup.scad"
    local output="${dstpath}/setup.echo"
    local config="${dstpath}/config.txt"
    createpath "${dstpath}" "output"
    printmessage "${C_MSG}The track elements would be generated with respect to the following config:"
    scadecho "${input}" "${dstpath}" "" "" showConfig=1 $(paramlist) > /dev/null
    sed '1d; $d' "${output}" > "${config}"
    rm "${output}" > /dev/null
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
        "b"|"barriers")
            renderBarriers=1
            renderAll=
        ;;
        "e"|"elements")
            renderElements=1
            renderAll=
        ;;
        "g"|"ground")
            renderGround=1
            renderAll=
        ;;
        "f"|"tiles")
            renderTiles=1
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
        "-q"|"--quantity")
            printQuantity=$2
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
            echo -e "${C_MSG}  b,   barriers       ${C_RST}Render the sets of barriers"
            echo -e "${C_MSG}  e,   elements       ${C_RST}Render the elements"
            echo -e "${C_MSG}  g,   ground         ${C_RST}Render the ground tiles"
            echo -e "${C_MSG}  f,   tiles          ${C_RST}Render the full tiles"
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
            echo -e "${C_MSG}  -q   --quantity     ${C_RST}Set the quantity of elements to print per set"
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

# make sure the config exists
distfile "${configpath}/config.scad"

# show the config
showconfig

# render the files
renderpathall "${partpath}" "${dstpath}"

# run a post-render script
if [ -x "${scriptpath}/post-render.sh" ]; then
    printmessage "${C_CTX}Calling the post-render script"
    "${scriptpath}/post-render.sh"
fi

# slice the rendered files
if [ "${slice}" != "" ]; then
    printmessage "${C_CTX}Slicing the rendered files"
    ./slice.sh
fi
