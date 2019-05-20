#!/usr/bin/env ruby

# Copyright 2019 Harald Sitter <sitter@kde.org>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) version 3, or any
# later version accepted by the membership of KDE e.V. (or its
# successor approved by the membership of KDE e.V.), which shall
# act as a proxy defined in Section 6 of version 3 of the license.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library.  If not, see <http://www.gnu.org/licenses/>.

if Dir.exist?('calamares')
  Dir.chdir('calamares') do
    unless system('git', 'fetch', '--depth=1')
      raise 'failed to fetch'
    end
  end
else
  unless system('git', 'clone', '--depth=1', 'https://github.com/calamares/calamares')
    raise 'failed to clone'
  end
end

p ['qmlscene', '-I', "#{Dir.pwd}/calamares/src/qml", '-geometry', '830x430', 'ubiquity-slideshow/slides/index.qml']
exec('qmlscene', '-I', "#{Dir.pwd}/calamares/src/qml", '-geometry', '830x430', 'ubiquity-slideshow/slides/index.qml')
