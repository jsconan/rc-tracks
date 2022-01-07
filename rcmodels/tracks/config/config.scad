/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/things.
 *
 * jsconan/things is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/things is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * Configures the project.
 *
 * @author jsconan
 */

 projectVersion = "0.4.1";

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the printer.
printResolution = 0.2;  // The target layer height
nozzleWidth = 0.4;      // The size of the printer's nozzle
printTolerance = 0.1;   // The print tolerance when pieces need to be assembled
printerLength = 250;    // The length of the printer's build plate
printerWidth = 210;     // The width of the printer's build plate

// The dimensions and constraints of a track element
trackSectionLength = 100;       // The nominal length of a track element: the length for straight element, or the radius for a curved element
trackSectionWidth = 400;        // The virtual width of a track lane: this will condition the outer radius for a curved element (i.e. the width used to compute the outer radius)
trackLaneWidth = 600;           // The actual width of a track lane: the distance between the barriers (i.e. the width of the physical track lanes)
trackRadius = 200;              // The radius of the track inner curve
barrierHeight = 30;             // The height of the barrier, including the holders
barrierHolderBase = 2;          // The base unit value used to design the barrier holder
barrierBodyThickness = 0.6;     // The thickness of the barrier body
sampleSize = 10;                // The size for the sample track elements
sampleBase = 1;                 // The base unit value used to design the samples
archTowerThickness = 1.6;       // The thickness of the arch tower clip
accessoryClipThickness = 0.8;   // The thickness of the cable clip
cableClipWidth = 2;             // The width of the cable clip
mastWidth = 3;                  // The width of the accessory mast
mastHeight = 70;                // The length of the accessory mast
mastFacets = 8;                 // The number of facets the accessory mast have
flagWidth = 40;                 // The width of the accessory flag
flagHeight = 20;                // The height of the accessory flag
flagThickness = 0.8;            // The thickness of the accessory flag
rightOriented = false;          // The orientation of the curved elements
printInterval = 5;              // Interval between 2 pieces when presented together
