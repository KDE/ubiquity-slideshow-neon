add_library(contextplugin SHARED plugin.cpp)
target_link_libraries(contextplugin
    Qt5::Qml
    KF5::Declarative
    KF5::I18n
)

install(TARGETS contextplugin DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/neon/calamares/slideshow/context)
install(FILES qmldir DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/neon/calamares/slideshow/context)
