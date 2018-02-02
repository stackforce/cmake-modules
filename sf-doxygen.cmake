##
##  ___ _____ _   ___ _  _____ ___  ___  ___ ___
## / __|_   _/_\ / __| |/ / __/ _ \| _ \/ __| __|
## \__ \ | |/ _ \ (__| ' <| _| (_) |   / (__| _|
## |___/ |_/_/ \_\___|_|\_\_| \___/|_|_\\___|___|
## embedded.connectivity.solutions.==============
##
## Authors:  Patrick Weber, Adrian Antonana
##
## Function to download the STACKFORCE doxygen corporate design.
##

# Define property
define_property(GLOBAL PROPERTY PROPERTY_DOXYGEN_DOXYFILE_IN)
# Initialize property
set_property(GLOBAL PROPERTY PROPERTY_DOXYGEN_DOXYFILE_IN "")

#---------------------------------------------------------------------------------------
# Downloads the STACKFORCE doxygen corparate design from GitHub.
#---------------------------------------------------------------------------------------
macro(sf_doxygen_download_corparate_design DOXYGEN_DOWNLOADED_RESOURCES_DIR)

    # Download STACKFORCE doxygen corporate design.
    set(SF_CORPORATE_DESIGN_URL "https://raw.githubusercontent.com/stackforce/corporate-design-doxygen/master")
    message(STATUS "Download files for STACKFORCE doxygen corporate design:")

    file(DOWNLOAD
        "${SF_CORPORATE_DESIGN_URL}/cmake/DoxygenRequiredVersion.cmake"
        "${DOXYGEN_DOWNLOADED_RESOURCES_DIR}/DoxygenRequiredVersion.cmake"
        SHOW_PROGRESS
    )

    file(DOWNLOAD
        "${SF_CORPORATE_DESIGN_URL}/Doxyfile.in"
        "${DOXYGEN_DOWNLOADED_RESOURCES_DIR}/Doxyfile.in"
        SHOW_PROGRESS
    )

    file(DOWNLOAD
        "${SF_CORPORATE_DESIGN_URL}/bootstrap.min.css"
        "${DOXYGEN_DOWNLOADED_RESOURCES_DIR}/bootstrap.min.css"
        SHOW_PROGRESS
    )

    file(DOWNLOAD
        "${SF_CORPORATE_DESIGN_URL}/sf_stylesheet.css"
        "${DOXYGEN_DOWNLOADED_RESOURCES_DIR}/sf_stylesheet.css"
        SHOW_PROGRESS
    )

    file(DOWNLOAD
        "${SF_CORPORATE_DESIGN_URL}/sf_footer.html"
        "${DOXYGEN_DOWNLOADED_RESOURCES_DIR}/sf_footer.html"
        SHOW_PROGRESS
    )

    file(DOWNLOAD
        "${SF_CORPORATE_DESIGN_URL}/sf_header.html"
        "${DOXYGEN_DOWNLOADED_RESOURCES_DIR}/sf_header.html"
        SHOW_PROGRESS
    )

    file(DOWNLOAD
        "${SF_CORPORATE_DESIGN_URL}/stackforce_logo.svg"
        "${DOXYGEN_DOWNLOADED_RESOURCES_DIR}/stackforce_logo.svg"
        SHOW_PROGRESS
    )

    # Include cmake modules.
    list(APPEND CMAKE_MODULE_PATH ${DOXYGEN_DOWNLOADED_RESOURCES_DIR})
    include(DoxygenRequiredVersion)

    # Set the file path to doxyfile.in
    set(DOXYGEN_DOXYFILE_IN ${DOXYGEN_DOWNLOADED_RESOURCES_DIR}/Doxyfile.in)
    set_property(GLOBAL APPEND PROPERTY PROPERTY_DOXYGEN_DOXYFILE_IN DOXYGEN_DOXYFILE_IN)

endmacro()
