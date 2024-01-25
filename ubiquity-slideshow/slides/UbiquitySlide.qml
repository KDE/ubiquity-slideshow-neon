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

import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml.XmlListModel

import calamares.slideshow 1.0
import org.kde.kirigami 2.4 as Kirigami
import org.kde.neon.calamares.slideshow.context 1.0

Slide {
    id: slide
    anchors.fill: parent

    property string name
    property string textColor

    // Extract the actual string out of the html. This requires all html
    // pages to have a standard div/h2 nexting and is somewhat abusing
    // the fact that xhtml and html are just about the same.
    XmlListModel {
        id: xmlModel
        query: "/div"
        source: slide.name + ".html"

        XmlListModelRole { name: "title"; elementName: "h2" }
        XmlListModelRole { name: "image"; elementName: "img; attributeName: "src" }

        onCountChanged:{
            var item = get(0)
            background.source = item.image
            header.text = i18n(item.title)
        }
    }

    Image {
        id: background
        anchors.fill: parent
        // Cropping would be nicer IMO. but it severely messes with my size
        // calculation
        fillMode: Image.PreserveAspectFit
        smooth: true
        clip: true
    }

    Item {
        id: headerContainer
        x: (background.width - background.paintedWidth) / 2.0
        y: (background.height - background.paintedHeight) / 2.0
        width: background.paintedWidth
        height: background.paintedHeight

        Kirigami.Heading  {
            id: header

            anchors.left: headerContainer.left
            anchors.top: headerContainer.top
            anchors.right: headerContainer.right
            anchors.margins: Kirigami.Units.largeSpacing

            wrapMode: Text.Wrap
            level: 1
            color: textColor
        }
    }
}
