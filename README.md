# README

```
     ___ _____ _   ___ _  _____ ___  ___  ___ ___
    / __|_   _/_\ / __| |/ / __/ _ \| _ \/ __| __|
    \__ \ | |/ _ \ (__| ' <| _| (_) |   / (__| _|
    |___/ |_/_/ \_\___|_|\_\_| \___/|_|_\\___|___|
    embedded.connectivity.solutions.==============
```

# Usage

Add this repo as a submodule to `${CMAKE_SOURCE_DIR}/cmake/modules` where `${CMAKE_SOURCE_DIR}` is the location of your project's top level CMakeLists.txt file.

    git submodule add  https://github.com/stackforce/cmake-modules.git cmake/modules

In your CMakeLists.txt include this line to add the modules to cmake's find path:

    list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/modules)

To use a find module package (e.g. GLib2) add a line like this to your CMakeLists.txt:

    find_package(GLib2)

Other modules like the ColorMessages one that just define some functions can be used directly:

    colormessage(MORE_IMPORTANT "Searching required external projects...")
