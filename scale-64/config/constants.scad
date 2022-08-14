/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020-2022 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/rc-tracks.
 *
 * jsconan/rc-tracks is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/rc-tracks is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/rc-tracks. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for RC cars of various scales.
 *
 * Local constants for the project.
 *
 * @author jsconan
 */

// The number of fastener holes per barrier chunks
FASTENER_HOLES = 1;

// Colors applied to the elements when previewed.
// This will be used for the animations and other pictures, but this won't have effect on the ready to print elements.
COLOR_GROUND = "#444";          // Color of the ground tiles
COLOR_TILE = "#468";            // Color of the full tiles
COLOR_DECORATION = "#eed";      // Color of the ground tiles decoration
COLOR_PEG = "#aaa";             // Color of the barrier pegs
COLOR_BARRIER = "#88a";         // Color of the barriers, no matter the coordinate
COLOR_BARRIER_EVEN = "#eec";    // Color of the barriers, when placed at an even coordinate
COLOR_BARRIER_ODD = "#c24";     // Color of the barriers, when placed at an odd coordinate

// Options for the animations
ANIMATION_SCALE_FROM = vector3D(.1);                // Origin scale factor for the models when animating
ANIMATION_SCALE_TO = vector3D(1);                   // Target scale factor for the models when animating
ANIMATION_ROTATE_FROM = [-RIGHT, -RIGHT, RIGHT];    // Origin rotation angles for the models when animating
ANIMATION_ROTATE_TO = vector3D(0);                  // Target rotation angles for the models when animating
ANIMATION_TRANSLATE_FROM = [-200, 150, 150];        // Origin position for the models when animating
ANIMATION_TRANSLATE_TO = ORIGIN_3D;                 // Target position for the models when animating
ANIMATION_SLIDE_FROM = ORIGIN_3D;                   // Position to present the models
ANIMATION_SLIDE_TO = [200, 150, 150];               // Target position for the models when sliding
ANIMATION_PRESENTATION_STEPS = 2;                   // Number of steps applied to present a model
ANIMATION_ANIMATE_STEPS = 1;                        // Number of steps applied for one animation move
ANIMATION_SLIDE_STEPS = 1;                          // Number of steps applied to slide a model

// Low level configuration entries. These values will be managed internally
showConfig = 0;         // Show the config when rendering a model. The render script uses it to extract the config
showSteps = 0;          // Show the expected number of steps for the whole animation
forceFullTile = false;  // When activated, make sure all tiles are full size, otherwise tiles with ratio greater or equal to 2 are split
