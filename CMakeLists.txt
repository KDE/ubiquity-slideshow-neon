cmake_minimum_required(VERSION 3.0)

function(LANGUAGE_FROM_PO VAR pofile)
    get_filename_component(_lang ${pofile} DIRECTORY)
    get_filename_component(_lang ${_lang} NAME)
    set(${VAR} ${_lang} PARENT_SCOPE)
endfunction()

function(TRANSLATE_HTML pofile)
    set(translated_files)

    language_from_po(language ${pofile})

    foreach(master_slide ${master_slides})
        get_filename_component(htmlname ${master_slide} NAME)
        message(${master_slide})
        message(${htmlname})
        set(translated_file ${CMAKE_CURRENT_BINARY_DIR}/${language}/${htmlname})
        add_custom_command(
            OUTPUT ${translated_file}
            COMMAND po4a-translate
                --format xhtml
                --master ${master_slide}
                --po ${pofile}
                --localized ${translated_file}
                --keep 0 # Generate the translation regardless of completion. Otherwise we'd be missing files.
            WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
            DEPENDS ${master_slide} ${pofile})
        install(FILES ${translated_file} DESTINATION /usr/share/ubiquity-slideshow/slides/l10n/${language}/)
        list(APPEND translated_files ${translated_file})
    endforeach()

    add_custom_target(translated-html-${language} ALL DEPENDS ${translated_files})
endfunction()

file(GLOB master_slides ubiquity-slideshow/slides/*.html)
file(GLOB_RECURSE pofiles po/*.po)
foreach(pofile ${pofiles})
    translate_html(${pofile})
endforeach()

install(DIRECTORY ubiquity-slideshow DESTINATION /usr/share)
