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

#include <QDebug>
#include <QLocale>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQmlExtensionPlugin>

#include <KLocalizedString>
#include <KLocalizedContext>

// Simple plugin that does absolutely nothing other than make i18n available
// to QML with the slideshow translations as domain.
// i.e. use the same translations as used for the ubiquity html but in their
// gettext incarnation.
class ContextPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void initializeEngine(QQmlEngine *engine, const char *uri) override
    {
        QQmlExtensionPlugin::initializeEngine(engine, uri);
        auto l10nContext = new KLocalizedContext(engine);
        l10nContext->setTranslationDomain(QStringLiteral("ubiquity-slideshow-neon"));
        engine->rootContext()->setContextObject(l10nContext);

        // Cala only sets the QLocale default but otherwise leaves
        // everything unchanged. That means ki18n will not pick the
        // correct reference as the "system" locale is still what it
        // was. To solve this we'll build the language list manually.
        QStringList ls;
        for (auto &lang : QLocale().uiLanguages()) {
            ls << lang.replace(QLatin1Char('-'), QLatin1Char('_'));
        }
        for (auto &lang : QLocale::system().uiLanguages()) {
            ls << lang.replace(QLatin1Char('-'), QLatin1Char('_'));
        qDebug() << "language is" << ls;
        KLocalizedString::setLanguages(ls);
        }
    }

    void registerTypes(const char *uri) override
    {
        qmlRegisterModule(uri, 1, 0);
    }
};

#include "plugin.moc"
