/*
    Copyright 2019 Harald Sitter <sitter@kde.org>

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 3 of
    the License or any later version accepted by the membership of
    KDE e.V. (or its successor approved by the membership of KDE
    e.V.), which shall act as a proxy defined in Section 14 of
    version 3 of the license.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import QtQuick 2.12
import calamares.slideshow 1.0

Presentation
{
    id: presentation

    property string colorPaperWhite: "#fcfcfc"
    property string colorCharcoalGrey: "#31363b"

    function onActivate() { timer.running = true }

    Rectangle {
        SystemPalette { id: systemPalette }

        anchors.fill: parent
        color: systemPalette.window
    }

    Timer {
        id: timer
        interval: 5000
        running: false
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    UbiquitySlide { name: 'kde'; textColor: colorPaperWhite }
    UbiquitySlide { name: 'neon'; textColor: colorPaperWhite }
    UbiquitySlide { name: 'plasma'; textColor: colorCharcoalGrey }
    UbiquitySlide { name: 'secure'; textColor: colorPaperWhite }
}
