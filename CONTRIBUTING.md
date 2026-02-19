# Contributing

Thank you for your interest in contributing to this project!
Pixora-theme welcomes bug reports, pull and feature requests, and suggestions!

## Bug Reports

Before opening an issue: 
- Search existing issues, your problem may have already been mentioned.
- Make sure you're using the latest version.

Please include in your report: 
- Your distro (Ubuntu, Arch, Fedora... Or  any of their derivatives);
- Your DE (GNOME, KDE, XFce...)
- Theme version;
- Steps to reproduce the bug (if applicable);
- Screenshots (if applicable).

## Icon Requests

The most useful information regarding new icons is the actual icon name. You may request a new icon completely ignoring the next section, but it'd be very nice to have this information beforehand.

Check the icon name on `/usr/share/applications`, inside the application's `.desktop` file.

Example using Heroic Games Launcher .desktop file:

<pre> ini

[Desktop Entry]
Name=Heroic Games Launcher
Exec=/opt/Heroic/heroic %U
Terminal=false
Type=Application

Icon=heroic # <----------------- This is the information we want

StartupWMClass=Heroic
Comment[de]=Ein OSS-Spielelauncher für GOG, Epic Games und Amazon Games
Comment[pl]=Otwartoźródłowy launcher dla GOG, Epic Games i Amazon Games
Comment[fr]=Un lanceur de jeux open source pour GOG, Epic Games et Amazon Games
Comment[es]=Un lanzador de juegos de código abierto para GOG, Epic Games
Comment[it]=Un launcher open source per GOG, Epic Games e Amazon Games
Comment[ru]=Открытый лаунчер для GOG, Epic Games и Amazon
Comment[zh_CN]=一个用于GOG、Epic Games和Amazon Games的开源游戏启动器
Comment[pt]=Um lançador de jogos de código aberto para GOG, Epic Games e Amazon Games
Comment[pt_BR]=Um lançador de jogos de código aberto para GOG, Epic Games e Amazon Games
Comment[ja]=GOG、Epic Games、Amazon Gamesのためのオープンソースランチャー
Comment=An Open Source Launcher for GOG, Epic Games and Amazon Games
MimeType=x-scheme-handler/heroic;
Categories=Game;
</pre>

After obtaining it, open a new issue stating "[XYZ Application]  Missing Icon" + informing the icon's name.

>[!Note]
> Please refrain from adding multiple icon requests into the same issue, as this makes the workflow quite chaotic.

## Pull Requests

Please keep PRs small and focused:
- One feature per PR;
- One fix per PR;
- No unrelated changes.

## Style Guidelines

- All icons must be `.svg`;
- All icons must be first drawn on a 16x16 canvas;
- Follow the [Resurrect 32 color pallete](https://lospec.com/palette-list/resurrect-32) when making new icons;

## License Reminder
By contributing, you agree that your contributions will be licensed under the same license as the project.

